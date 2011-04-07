From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 9/9] sparse: Fix argument number/type warnings caused by the
 main() macro
Date: Thu, 07 Apr 2011 19:51:13 +0100
Message-ID: <4D9E07A1.4000707@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:55:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7uMt-0006YJ-Ji
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 20:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638Ab1DGSzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 14:55:42 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:39247 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756564Ab1DGSzl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 14:55:41 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Q7uKx-00076P-l5; Thu, 07 Apr 2011 18:53:48 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171077>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

 compat/mingw.h       |    4 ++--
 fast-import.c        |    3 ++-
 git.c                |    3 ++-
 test-chmtime.c       |    2 +-
 test-index-version.c |    2 +-
 test-parse-options.c |    3 ++-
 6 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 62eccd3..ddcf365 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -316,8 +316,8 @@ void free_environ(char **env);
  */
 
 #define main(c,v) dummy_decl_mingw_main(); \
-static int mingw_main(); \
-int main(int argc, const char **argv) \
+static int mingw_main(c,v); \
+int main(int argc, char **argv) \
 { \
 	extern CRITICAL_SECTION pinfo_cs; \
 	_fmode = _O_BINARY; \
diff --git a/fast-import.c b/fast-import.c
index 65d65bf..7ba98c5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3247,8 +3247,9 @@ static void parse_argv(void)
 		read_marks();
 }
 
-int main(int argc, const char **argv)
+int main(int argc, char **av)
 {
+	const char **argv = (const char **) av;
 	unsigned int i;
 
 	git_extract_argv0_path(argv[0]);
diff --git a/git.c b/git.c
index ef598c3..31fc678 100644
--- a/git.c
+++ b/git.c
@@ -507,8 +507,9 @@ static int run_argv(int *argcp, const char ***argv)
 }
 
 
-int main(int argc, const char **argv)
+int main(int argc, char **av)
 {
+	const char **argv = (const char **) av;
 	const char *cmd;
 
 	startup_info = &git_startup_info;
diff --git a/test-chmtime.c b/test-chmtime.c
index 92713d1..8532743 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -56,7 +56,7 @@ static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
 	return 1;
 }
 
-int main(int argc, const char *argv[])
+int main(int argc, char *argv[])
 {
 	static int verbose;
 
diff --git a/test-index-version.c b/test-index-version.c
index bfaad9e..05d4699 100644
--- a/test-index-version.c
+++ b/test-index-version.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	struct cache_header hdr;
 	int version;
diff --git a/test-parse-options.c b/test-parse-options.c
index 4e3710b..925704c 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -27,8 +27,9 @@ static int number_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-int main(int argc, const char **argv)
+int main(int argc, char **av)
 {
+	const char **argv = (const char **) av;
 	const char *prefix = "prefix/";
 	const char *usage[] = {
 		"test-parse-options <options>",
-- 
1.7.4
