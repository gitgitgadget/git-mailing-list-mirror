Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745C41F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeGVKyW (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36485 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeGVKyR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:17 -0400
Received: by mail-io0-f195.google.com with SMTP id r15-v6so7034980ioa.3
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8ehJGdX3+z6ZbWCQMszTyVpHO+ZIFO8DL0VGALrflA=;
        b=RfJVyDCxj54iX+B5Z/RdEsycT7Gx7sQtiBH6Stxlw0QH+6qWTl46NHgAqVeNm6U1nJ
         HE6J1m0cSuU7Msa7rRd0P1aX/FNdGt8KLReSDJXrxWfycYDEbpW3xp16uJnHcrBYOeaT
         PU3tpC4l7KuD+1hKDoCAoGpVsNBv5KlaMeu+tAZh436Wk0HUBnFvSEVLP9KiNs2miQO+
         1OvbBIdZlutbECOiv0NM5brJ8GmC6wGar1Dunu8mBg4RK1CQPLf/CPXbEN7AlQh3uKzf
         NFTQ5A1NmGJ2Hgr8LoGltS5AvUY2WDWLQA5F4tqFY49ssxjkZta27dTQjcK7VsmBHAo3
         Hq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=o8ehJGdX3+z6ZbWCQMszTyVpHO+ZIFO8DL0VGALrflA=;
        b=Aguhl+a0Z8qFzJBELIl8B+I/ZRN98RXrKTIDmKj5rTSIvbA/gedECQrr7TYud3xLRE
         1lKawAFUvmkCLqknCu0/wHSjVorG1+sBh5ddHO1jtVHbwDnflQz1cQhtRc1GyZs37j6a
         SRwYUAPOoulQGozINaNWAYAgabOsuF27e3FqMis/KlY0//6Dx4OxgkWGBubEDnes5o95
         xH6N1FoqgXRF5rDxBRVQ/UWLR8piawJc2gWdjOSkn4vh0MldVPHm3YNvpkPT9xe79SDi
         oF9u4dWzIbiwmK9Y4i7jMjaRlRuYXhrmbU//mSRVBc8N41DMnZatlOagBL317yFL5fAL
         c4OA==
X-Gm-Message-State: AOUpUlHMTWPPL9bmojEiZ+ChZCle6ktiwQvD/hj39bDmcWHjjm6L4NfI
        tsn3lh7U/SwTUJX2wKf4HCzRwb0K
X-Google-Smtp-Source: AAOMgpdwv40Z9dAahPK0wCBRATXoMDQg18EhaS0WEmmf6+fQvE/MvCFkOxtgLvT8s7ece3QK8ZoPuA==
X-Received: by 2002:a6b:f612:: with SMTP id n18-v6mr7100463ioh.259.1532253486377;
        Sun, 22 Jul 2018 02:58:06 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.58.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:58:05 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 11/14] format-patch: extend --range-diff to accept revision range
Date:   Sun, 22 Jul 2018 05:57:14 -0400
Message-Id: <20180722095717.17912-12-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
References: <20180722095717.17912-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When submitting a revised a patch series, the --range-diff option embeds
a range-diff in the cover letter showing changes since the previous
version of the patch series. The argument to --range-diff is a simple
revision naming the tip of the previous series, which works fine if the
previous and current versions of the patch series share a common base.

However, it fails if the revision ranges of the old and new versions of
the series are disjoint. To address this shortcoming, extend
--range-diff to also accept an explicit revision range for the previous
series. For example:

    git format-patch --cover-letter --range-diff=v1~3..v1 -3 v2

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-format-patch.txt |  8 +++++---
 builtin/log.c                      | 16 +++++++++++++---
 t/t3206-range-diff.sh              |  2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index e7f404be3d..425145f536 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -243,10 +243,12 @@ feeding the result to `git send-email`.
 	As a reviewer aid, insert a range-diff (see linkgit:git-range-diff[1])
 	into the cover letter showing the differences between the previous
 	version of the patch series and the series currently being formatted.
-	`previous` is a single revision naming the tip of the previous
-	series which shares a common base with the series being formatted (for
+	`previous` can be a single revision naming the tip of the previous
+	series if it shares a common base with the series being formatted (for
 	example `git format-patch --cover-letter --range-diff=feature/v1 -3
-	feature/v2`).
+	feature/v2`), or a revision range if the two versions of the series are
+	disjoint (for example `git format-patch --cover-letter
+	--range-diff=feature/v1~3..feature/v1 -3 feature/v2`).
 
 --notes[=<ref>]::
 	Append the notes (see linkgit:git-notes[1]) for the commit
diff --git a/builtin/log.c b/builtin/log.c
index d6e57e8b04..4f937aad15 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1447,12 +1447,21 @@ static const char *diff_title(struct strbuf *sb, int reroll_count,
 static void infer_range_diff_ranges(struct strbuf *r1,
 				    struct strbuf *r2,
 				    const char *prev,
+				    struct commit *origin,
 				    struct commit *head)
 {
 	const char *head_oid = oid_to_hex(&head->object.oid);
 
-	strbuf_addf(r1, "%s..%s", head_oid, prev);
-	strbuf_addf(r2, "%s..%s", prev, head_oid);
+	if (!strstr(prev, "..")) {
+		strbuf_addf(r1, "%s..%s", head_oid, prev);
+		strbuf_addf(r2, "%s..%s", prev, head_oid);
+	} else if (!origin) {
+		die(_("failed to infer range-diff ranges"));
+	} else {
+		strbuf_addstr(r1, prev);
+		strbuf_addf(r2, "%s..%s",
+			    oid_to_hex(&origin->object.oid), head_oid);
+	}
 }
 
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
@@ -1801,7 +1810,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (!cover_letter)
 			die(_("--range-diff requires --cover-letter"));
 
-		infer_range_diff_ranges(&rdiff1, &rdiff2, rdiff_prev, list[0]);
+		infer_range_diff_ranges(&rdiff1, &rdiff2, rdiff_prev,
+					origin, list[0]);
 		rev.rdiff1 = rdiff1.buf;
 		rev.rdiff2 = rdiff2.buf;
 		rev.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index dd854b6ebc..3d7a2d8a4d 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -142,7 +142,7 @@ test_expect_success 'changed message' '
 	test_cmp expected actual
 '
 
-for prev in topic
+for prev in topic master..topic
 do
 	test_expect_success "format-patch --range-diff=$prev" '
 		git format-patch --stdout --cover-letter --range-diff=$prev \
-- 
2.18.0.345.g5c9ce644c3

