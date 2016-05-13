From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 1/2] bisect--helper: `bisect_log` shell function in C
Date: Sat, 14 May 2016 01:32:16 +0530
Message-ID: <1463169737-12701-1-git-send-email-pranit.bauva@gmail.com>
Cc: christian.couder@gmail.com, chriscool@tuxfamily.org,
	larsxschneider@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 22:04:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1JKG-00039r-BP
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbcEMUEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:04:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34278 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932211AbcEMUEk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:04:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id 145so10038687pfz.1
        for <git@vger.kernel.org>; Fri, 13 May 2016 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Z2UlqXDxDMDNC9NVyAKlS28gED7/0argpvFmNb8bVhE=;
        b=hmvLpcLJKA3gbEdP5/3pp+Ujqf3Rrod+mTur4q3o5S6Sp+4YCyw4mdj+iQ+dnRC/d7
         zCaoKHkdNQGdzWSlkTH122gPe69UNWEnKkbCPl6vf6/UCCMcLdaZSJCchlU8ztaYAl8U
         cg5GLs0VnjE9nG7NOU0C0ok4cx+Xes/aXoI2LqsPLnMWY9U4wVSlcueZ1h8BlJujYwP3
         h3az7PIPcl4N3TAPwQmHM6xaFlZwJ3ZOf/xf0mJB4rZmUzJRMj4NeEsHMNvlP9/58zaP
         +2wxI3q82R8B2luy99bzPNQLOjivWW+8vp7D1vCu/UE+7eyQUX+S4F9F06+0mSg2/WW1
         s+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z2UlqXDxDMDNC9NVyAKlS28gED7/0argpvFmNb8bVhE=;
        b=NLuutePVk8iwtUSICKYdK14966LE6c7V3iSCpkMp4reJeN9Y4qBxvxfHolVRq5q1qB
         ffwRe3+Gr/wFuuAGlf9zrghmfUvzCmluP0ehJtJFNmYcHVU67fWFTKlshOBX2HXU9MXy
         kIoTVFD2+lPUtEGcz8TwEU/2ovCYNDAH74Bd9fIrIc34xwv7zmETfVLN5gHnyC6WXoav
         0N1QCQrMxDSq7Z8qp4ZL68KRPM7PyxD554Ha0oO052K6F5SGh+nNGrU5OFW5Ciw0SefR
         bwocSyQ96nsnw/UiCpjR8eA1ZdSbi/1uBHQUAGzV8Ngz1o1CDFhf0lHr+dWi14WeNHv/
         N7sA==
X-Gm-Message-State: AOPr4FUU0uQan1KwI0MxOqk483bjtO1mk6DemW1tTNHeB+tr858AYIwEFPMmUjzhvezzBg==
X-Received: by 10.98.74.218 with SMTP id c87mr25640665pfj.78.1463169879559;
        Fri, 13 May 2016 13:04:39 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id g77sm29308345pfg.78.2016.05.13.13.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 May 2016 13:04:39 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294571>

Reimplement the `bisect_log` shell function in C and add a
`--bisect-log` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-log` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other method.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
This can be applied on the pb/bisect branch

 builtin/bisect--helper.c | 22 +++++++++++++++++++++-
 git-bisect.sh            |  7 +------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 2b21c02..87764fe 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -7,6 +7,7 @@
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
+	N_("git bisect--helper --bisect-log"),
 	NULL
 };
 
@@ -79,11 +80,26 @@ int write_terms(const char *bad, const char *good)
 	strbuf_release(&content);
 	return (res < 0) ? -1 : 0;
 }
+
+int bisect_log(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (strbuf_read_file(&buf, ".git/BISECT_LOG", 256) < 0)
+		return error(_("We are not bisecting."));
+
+	printf("%s", buf.buf);
+	strbuf_release(&buf);
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
-		WRITE_TERMS
+		WRITE_TERMS,
+		BISECT_LOG
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -91,6 +107,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
+		OPT_CMDMODE(0, "bisect-log", &cmdmode,
+			 N_("output contents of .git/BISECT_LOG"), BISECT_LOG),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -109,6 +127,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			die(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
+	case BISECT_LOG:
+		return bisect_log();
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 2dd7ec5..612a9c5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -542,11 +542,6 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 	done
 }
 
-bisect_log () {
-	test -s "$GIT_DIR/BISECT_LOG" || die "$(gettext "We are not bisecting.")"
-	cat "$GIT_DIR/BISECT_LOG"
-}
-
 get_terms () {
 	if test -s "$GIT_DIR/BISECT_TERMS"
 	then
@@ -651,7 +646,7 @@ case "$#" in
 	replay)
 		bisect_replay "$@" ;;
 	log)
-		bisect_log ;;
+		git bisect--helper --bisect-log ;;
 	run)
 		bisect_run "$@" ;;
 	terms)
-- 
2.8.2
