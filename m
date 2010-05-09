From: Pete Harlan <pgit@pcharlan.com>
Subject: [PATCH/RFC] clone: have progress report mention top level dir, not
 git dir
Date: Sat, 08 May 2010 18:23:21 -0700
Message-ID: <4BE60E89.8010709@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 09 03:34:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAvP2-0005iI-I8
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 03:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805Ab0EIBX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 21:23:29 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:40455 "EHLO
	swarthymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751065Ab0EIBX3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 May 2010 21:23:29 -0400
Received: from [192.168.0.119] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	by swarthymail-a2.g.dreamhost.com (Postfix) with ESMTP id B2BC8EE813
	for <git@vger.kernel.org>; Sat,  8 May 2010 18:23:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146689>

"git clone foo bar" currently reports "Cloning into
/path/to/bar/.git".  Change this message to "Cloning into bar" to more
closely match the user's expectation.

Signed-off-by: Pete Harlan <pgit@pcharlan.com>
---

This changes a progress message introduced a few weeks ago in
28ba96ab2.  Unless there's a particular reason to report the .git dir
instead of the top level dir, seeing the top level dir feels more
natural to me.

(Or printing nothing.  For a local clone, silently succeeding seems
like a reasonable default.  And for a nonlocal clone there's enough
noise that the user is comforted that something is happening.)

For a --bare clone the current message prints the top level dir
(because that is the git dir), so one could argue in favor of the
current message because it confirms for the user whether their
checkout was bare or not.  But that's only if the user is aware of how
it would appear in both cases; I doubt that the existing code intended
to make that distinction clear, and in practice I expect most users
(a) trust git to do what they asked and (b) wouldn't notice that
"Cloning into /path/to/bar" meant that it was a bare checkout.

 builtin/clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0bedde4..306aacf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -464,7 +464,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	set_git_dir(make_absolute_path(git_dir));
 
 	if (0 <= option_verbosity)
-		printf("Cloning into %s...\n", get_git_dir());
+		printf("Cloning into %s...\n", dir);
 	init_db(option_template, INIT_DB_QUIET);
 
 	/*
-- 
1.7.1.14.gcafbfa
