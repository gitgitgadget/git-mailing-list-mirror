Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E173A20437
	for <e@80x24.org>; Fri, 13 Oct 2017 19:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbdJMTtd (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 15:49:33 -0400
Received: from smtp.mail.umich.edu ([141.211.125.12]:52258 "EHLO
        maleficent.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752454AbdJMTtc (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Oct 2017 15:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2016-05-12; t=1507924169;
        bh=nic441PQ2H4CKBE3kD23cn7Xp68oUM8c1ELMGi+dBWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bq7IvdzOMvUQ/lzCveofuk61gI+8XfZEtuXhxQGL8oOfEWOStJApN5Hy2q4KFBGl7
         JW/a5fLmUQ3MGAO5OQxTFq7z1IXalb/pY8VyUSUJwimq/q4tAm/qVlWCeDDPaU6s1T
         vIYJAqd3yGWTNaFBp90f/t+ZZ13Lfr68nKJdfK+8e37A2lZBsWGo1bAlta88bHXQdh
         gwfVh+XqhtPOy10M3DuGCRwl84ByXXIhOJf8b1Hlq3IxYkrdOrhBzqyv0nzXFRhjGE
         oxGjw5bFfCLGvoE9PZb18C+zGpcfjyf50DcmAU42sOhicg17GZsUXVyBctF2PX28rH
         2pf10Cx6rBrRA==
Authentication-Results: maleficent.mr.itd.umich.edu;
        iprev=permerror policy.iprev=4.14.106.2 (unknown);
        auth=pass smtp.auth=asottile
Received: FROM asottile-VirtualBox.lyft-corp.net (unknown [4.14.106.2])
        By maleficent.mr.itd.umich.edu ID 59E118C8.C3D1A.1901;
        Authuser asottile;
        Fri, 13 Oct 2017 15:49:28 -0400
From:   Anthony Sottile <asottile@umich.edu>
To:     git@vger.kernel.org
Cc:     Anthony Sottile <asottile@umich.edu>
Subject: [PATCH v2 2/2] diff: finish removal of deprecated -q option
Date:   Fri, 13 Oct 2017 12:49:16 -0700
Message-Id: <20171013194916.4617-2-asottile@umich.edu>
X-Mailer: git-send-email 2.15.0.rc1.2.ge430ed6
In-Reply-To: <20171013194916.4617-1-asottile@umich.edu>
References: <20171013194916.4617-1-asottile@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Functionality was removed in c48f6816f0 but the cli option was not removed.

Signed-off-by: Anthony Sottile <asottile@umich.edu>
---
 builtin/diff-files.c | 2 --
 builtin/diff.c       | 2 --
 diff.h               | 4 +---
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index e88493f..b0ff251 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -37,8 +37,6 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 			rev.max_count = 2;
 		else if (!strcmp(argv[1], "--theirs"))
 			rev.max_count = 3;
-		else if (!strcmp(argv[1], "-q"))
-			options |= DIFF_SILENT_ON_REMOVED;
 		else
 			usage(diff_files_usage);
 		argv++; argc--;
diff --git a/builtin/diff.c b/builtin/diff.c
index f5bbd4d..96513e8 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -227,8 +227,6 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 			revs->max_count = 2;
 		else if (!strcmp(argv[1], "--theirs"))
 			revs->max_count = 3;
-		else if (!strcmp(argv[1], "-q"))
-			options |= DIFF_SILENT_ON_REMOVED;
 		else if (!strcmp(argv[1], "-h"))
 			usage(builtin_diff_usage);
 		else
diff --git a/diff.h b/diff.h
index aca150b..c9d71e1 100644
--- a/diff.h
+++ b/diff.h
@@ -65,7 +65,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_BINARY              (1 <<  2)
 #define DIFF_OPT_TEXT                (1 <<  3)
 #define DIFF_OPT_FULL_INDEX          (1 <<  4)
-#define DIFF_OPT_SILENT_ON_REMOVE    (1 <<  5)
+/* (1 << 5) unused */
 #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
 #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
 #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
@@ -374,8 +374,6 @@ extern void diff_warn_rename_limit(const char *varname, int needed, int degraded
  */
 extern const char *diff_aligned_abbrev(const struct object_id *sha1, int);
 
-/* do not report anything on removed paths */
-#define DIFF_SILENT_ON_REMOVED 01
 /* report racily-clean paths as modified */
 #define DIFF_RACY_IS_MODIFIED 02
 extern int run_diff_files(struct rev_info *revs, unsigned int option);
-- 
2.7.4

