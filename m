From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] tests: avoid unnecessary use of GIT_TRACE in repo-setup
 tests
Date: Tue, 25 Jan 2011 19:01:47 -0600
Message-ID: <20110126010147.GD11230@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-2-git-send-email-pclouds@gmail.com>
 <20110126004915.GA11230@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 02:02:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phtln-0004Yk-PF
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 02:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab1AZBB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 20:01:56 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59107 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab1AZBBx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 20:01:53 -0500
Received: by vws16 with SMTP id 16so219841vws.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 17:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3zMU1iYt1ipQy1CJPhxMs5MFQAN6PWS08IVODx/0YOI=;
        b=OZCoAk4lY7o4DEvrcD+OnIDbewrJHcC3yYracLW4AtnpmlNu1inuvKjxNpSnk6YTLe
         HmdCEQ4v+pSiSX/qTzoeoQxyP7GRfRoLhjov/9f4DYSsJ2pL4PNrraq7WdIwzI1B9aC0
         OD6zBR/alPTWzFJeVrlcZGF1NN+aNZmhwgi/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OmKqhp9AEgogc4V7CrKuM+wIErdDynE8ftxNieXrdgXU2fZ/ZLL0zLJXzNWmiGrQK2
         +wdSfY/xpdopKKTI08wj2B3XNFQkkIOXZ9AJ6nX/yNoQMEb/csAh5A+E3yE7fs5fACu8
         OmZJzi6crtWkJ6zWkO++0/2Pj1/5F4qhI6ysI=
Received: by 10.220.159.67 with SMTP id i3mr1824411vcx.246.1296003712869;
        Tue, 25 Jan 2011 17:01:52 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id u4sm4896742vch.36.2011.01.25.17.01.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 17:01:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110126004915.GA11230@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165494>

Now that the startup info is printed by a separate helper, there
is no need to mark that output with "setup: " or use an environment
variable to request it.

While we're changing the test-repo-setup output format, stop quoting
newlines to give the tests a chance of passing when $TEST_DIRECTORY
contains a newline or backslash.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 t/t1510-repo-setup.sh |   12 +++++-------
 test-repo-setup.c     |   40 ++++++----------------------------------
 2 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index c2edf6f..a8cb445 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -56,9 +56,7 @@ test_repo () {
 			GIT_WORK_TREE="$3" &&
 			export GIT_WORK_TREE
 		fi &&
-		rm -f trace &&
-		GIT_TRACE="$(pwd)/trace" test-repo-setup &&
-		grep '^setup: ' trace >result &&
+		test-repo-setup >result &&
 		test_cmp expected result
 	)
 }
@@ -105,10 +103,10 @@ setup_env () {
 
 expect () {
 	cat >"$1/expected" <<-EOF
-	setup: git_dir: $2
-	setup: worktree: $3
-	setup: cwd: $4
-	setup: prefix: $5
+	git_dir: $2
+	worktree: $3
+	cwd: $4
+	prefix: $5
 	EOF
 }
 
diff --git a/test-repo-setup.c b/test-repo-setup.c
index 3b66237..72d35fe 100644
--- a/test-repo-setup.c
+++ b/test-repo-setup.c
@@ -1,52 +1,24 @@
 #include "cache.h"
 
-static const char *quote_crnl(const char *path)
-{
-	static char new_path[PATH_MAX];
-	const char *p2 = path;
-	char *p1 = new_path;
-
-	if (!path)
-		return NULL;
-
-	while (*p2) {
-		switch (*p2) {
-		case '\\': *p1++ = '\\'; *p1++ = '\\'; break;
-		case '\n': *p1++ = '\\'; *p1++ = 'n'; break;
-		case '\r': *p1++ = '\\'; *p1++ = 'r'; break;
-		default:
-			*p1++ = *p2;
-		}
-		p2++;
-	}
-	*p1 = '\0';
-	return new_path;
-}
-
 static void trace_repo_setup(void)
 {
-	const char *git_work_tree;
+	const char *git_work_tree = get_git_work_tree();
 	const char *prefix = startup_info->prefix;
 	char cwd[PATH_MAX];
-	char *trace = getenv("GIT_TRACE");
-
-	if (!trace || !strcmp(trace, "") ||
-	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
-		return;
 
 	if (!getcwd(cwd, PATH_MAX))
 		die("Unable to get current working directory");
 
-	if (!(git_work_tree = get_git_work_tree()))
+	if (!git_work_tree)
 		git_work_tree = "(null)";
 
 	if (!prefix)
 		prefix = "(null)";
 
-	trace_printf("setup: git_dir: %s\n", quote_crnl(get_git_dir()));
-	trace_printf("setup: worktree: %s\n", quote_crnl(git_work_tree));
-	trace_printf("setup: cwd: %s\n", quote_crnl(cwd));
-	trace_printf("setup: prefix: %s\n", quote_crnl(prefix));
+	printf("git_dir: %s\n", get_git_dir());
+	printf("worktree: %s\n", git_work_tree);
+	printf("cwd: %s\n", cwd);
+	printf("prefix: %s\n", prefix);
 }
 
 int main(int argc, char **argv)
-- 
1.7.4.rc3
