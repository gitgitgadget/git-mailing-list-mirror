From: =?ISO-8859-1?Q?Jo=E3o_Carlos_Mendes_Lu=EDs?= <jonny@jonny.eng.br>
Subject: Unix root dir as a work tree
Date: Sun, 07 Feb 2010 23:31:29 -0200
Message-ID: <4B6F6971.6000106@jonny.eng.br>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040803000905070203040801"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 02:42:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeIdw-00052q-19
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 02:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127Ab0BHBmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 20:42:09 -0500
Received: from roma.coe.ufrj.br ([146.164.53.65]:58764 "EHLO coe.ufrj.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754942Ab0BHBmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 20:42:07 -0500
X-Greylist: delayed 632 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Feb 2010 20:42:07 EST
Received: from localhost (localhost [127.0.0.1])
	by coe.ufrj.br (Postfix) with ESMTP id 904181FA1E1
	for <git@vger.kernel.org>; Sun,  7 Feb 2010 23:31:32 -0200 (BRST)
X-Virus-Scanned: amavisd-new at coe.ufrj.br
Received: from coe.ufrj.br ([146.164.53.65])
	by localhost (roma.coe.ufrj.br [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cRFawt7M6X-o for <git@vger.kernel.org>;
	Sun,  7 Feb 2010 23:31:29 -0200 (BRST)
Received: from home.jonny.eng.br (unknown [187.14.9.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coe.ufrj.br (Postfix) with ESMTPSA id CF34A1FA080
	for <git@vger.kernel.org>; Sun,  7 Feb 2010 23:31:29 -0200 (BRST)
User-Agent: Thunderbird 2.0.0.22 (X11/20090625)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139270>

This is a multi-part message in MIME format.
--------------040803000905070203040801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

    Sorry if this is a FAQ, but I could not find any reference.

    I have been using CVS as a version control system for unix 
configuration files for a long time.  I know it has some limitations, 
and I know git also has its.  But I expect to work around all of them 
using etckeeper.

    The problem is that etckeeper was created with /etc only in mind, 
and I want to keep track of important files everywhere, not only below 
/etc (think /opt, /usr/local).  The obvious solution appear to create 
the repository at the system root, and not at /etc, but it did not 
work.  I think, because of a bug.

   Now, I have a patch that appears to work, but since I am a beginner 
to git, I don't know if this is the best way to implement it, if it has 
any side effects, or even if it works for other operating systems 
(probably they don't even have the bug).  Would any git wizard care to 
look at it, check if it is ok, and maybe commit in HEAD or give me any 
advice against my patch?

    Please, don't give me any answers like "don't use your root as a 
repo".  I am a system admin for a long time, and I know what I want and 
what are the risks and benefits involved.

    Thanks in advance,

       Jonny


--------------040803000905070203040801
Content-Type: text/x-patch;
 name="git-1.5.5.6-setup-work_dir-root.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-1.5.5.6-setup-work_dir-root.patch"

--- a/setup.c	2010-02-07 22:50:40.000000000 -0200
+++ b/setup.c	2010-02-07 22:51:56.000000000 -0200
@@ -413,7 +413,12 @@
 	inside_git_dir = 0;
 	if (!work_tree_env)
 		inside_work_tree = 1;
-	git_work_tree_cfg = xstrndup(cwd, offset);
+	if ( cwd[0] == '/' && offset == 0 ) {
+		git_work_tree_cfg = xstrndup(cwd, 1);
+	}
+	else {
+		git_work_tree_cfg = xstrndup(cwd, offset);
+	}
 	if (check_repository_format_gently(nongit_ok))
 		return NULL;
 	if (offset == len)

--------------040803000905070203040801--
