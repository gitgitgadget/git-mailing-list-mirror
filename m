From: Bertram Scharpf <lists@bertram-scharpf.de>
Subject: Hook "post-merge" does not get executed in case of confilicts
Date: Thu, 21 Aug 2014 20:51:41 +0200
Message-ID: <20140821185141.GA93319@becker.bs.l>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 20:51:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKXSf-00088u-OO
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 20:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbaHUSvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 14:51:45 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:63866 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbaHUSvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 14:51:44 -0400
Received: from becker.bs.l (e180019161.adsl.alicedsl.de [85.180.19.161])
	by mrelayeu.kundenserver.de (node=mreue007) with ESMTP (Nemesis)
	id 0M6K5P-1WRRav0zG7-00yTYA; Thu, 21 Aug 2014 20:51:42 +0200
Received: from bsch by becker.bs.l with local (Exim 4.82_1-5b7a7c0-XX (FreeBSD))
	(envelope-from <lists@bertram-scharpf.de>)
	id 1XKXSX-000OLF-AU
	for git@vger.kernel.org; Thu, 21 Aug 2014 20:51:41 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V02:K0:/vKGJVfsPEcLqes++Uk686yMInSjUQmIcdftcp1itVD
 ZZlClxyeOZCOu/dTcEBpxXv7hakevTY7WJ3AGs6mhnSGASzvnJ
 LuoOONRfmcApPymp87ZBvVS8yKuMzJy4RJjYT1RvUAPmLvglmA
 FYVfDwqPCDA8r2uhaFzw4gHDO5EJlBfeBl1gPRsKp+lmyXuWZ3
 HfY04EAPtCiECU22RcYMHi2jaumd3pOBs5iGZcSoRveJTU0VpA
 MWGzOeRNecsfyhekikR6SYYTNgwhzumEWP09fr6zuM/AqGEHV+
 pnErdO60o+Sx4eityYWJEPdDqcruuXfFIPG8K5GFYUIQCz4avo
 +Xgn2rsuTMlcUDhswTrmuHLGUeojs41ZDaeuyHVEu
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255632>

Hi,

today I wrote a port-merge hook. Then I just detected that it only gets
executed when the merge is immediately successful. In case there is a
conflict, I have to finish the merge using the command "git commit".
This will not call the post-merge hook.

I think the hook should be reliable to be executed on _every_ non-failed
merge. Therefore I propose the below extension.

Bertram


diff --git a/builtin/commit.c b/builtin/commit.c
index 5ed6036..6a8ee2d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1783,6 +1783,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	rerere(0);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
+	if (whence == FROM_MERGE)
+		run_hook_le(NULL, "post-merge", "0", NULL);
 	if (amend && !no_post_rewrite) {
 		struct notes_rewrite_cfg *cfg;
 		cfg = init_copy_notes_for_rewrite("amend");


-- 
Bertram Scharpf
Stuttgart, Deutschland/Germany
http://www.bertram-scharpf.de
