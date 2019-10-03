Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6C6B1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388650AbfJCU1Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:27:25 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:33985 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCU1X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:27:23 -0400
Received: by mail-pl1-f182.google.com with SMTP id k7so2052052pll.1
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPxq0xCDR0YGeHuIUddKZh5KzJnCYRYH327zQ62XhHw=;
        b=lgMjcs2x2071nE7lSlazzlpAfEk5A0ArIqUw/09o08P5d0iQaJXFuMt8v7iYUDQcys
         fO07ZZgaVE8+JIVZLrGn4q2w/LzULfrO35FJcp4qWsXES88p0pW9/xmn5I73OVKVkl4H
         H0F4RoXvq+5ybzg+hsiSbNFC5putebvAfmO0fO5Cd2Ekl/Zs3pltLvNHHVwn65A6tGdi
         N85bO/llJB2qGV7KQFURkski3JA9OFDiH9XbyjIESbUeicO08oAHEKJyUY2D4DI2noUb
         nZz5V/MHfDEq1Egyda9QA3dOU02N1FeXWDHFfAfWGGuo6JNDSFJdysMijc7UyBsZL91C
         uYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPxq0xCDR0YGeHuIUddKZh5KzJnCYRYH327zQ62XhHw=;
        b=H3XZGLT1upKiRHUNFxaNo8+5WA2AvN3ZkZ4fUY7LChJMVIolQtLnA0QiKtoqbCyUpM
         EY1yUKwGJmJ12w+9JPvhRHTrqcfvqyfQtlyPBcdDF2qyPwwfBDl0SD/ublL6gBiB41Yy
         vownmHfvBv5LrpgOc5HoA1ZOHLSuqgNy0n1aQdcNCKwZc324idwWikvq0gEVkSv4n8y7
         IrXLWMD3KFkUYkuuLZw1b3teH+A7mnA/uf62ZCA5i6oKh2MduV3e2enzl3xWxO0uVFsU
         i1d9pfA7C3vYdV8GG5s8P6zMW8nVMNfo579QfVIy3KFqp7bdGbP8PiuzP3jBnyzUdxkQ
         A9BA==
X-Gm-Message-State: APjAAAUhD3r6GSM9fEYrHCBejTUuWTlRGu50CtXSR5UHm4YSnsooKBMb
        WaqLbK85X5i5t3tTes/Xl/M=
X-Google-Smtp-Source: APXvYqzxzlPMCmF7VHH7a8ywTFlOughGEoqoN2LsXpvALGRi8Le5Qa7R1F6kneFOmLJ45QkKi9WyDA==
X-Received: by 2002:a17:902:144:: with SMTP id 62mr11442740plb.283.1570134442168;
        Thu, 03 Oct 2019 13:27:22 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id c64sm4055498pfc.19.2019.10.03.13.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Oct 2019 13:27:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH -v3 6/8] fast-export: allow user to request tags be marked with --mark-tags
Date:   Thu,  3 Oct 2019 13:27:07 -0700
Message-Id: <20191003202709.26279-7-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.g3b9f7f2fc6
In-Reply-To: <20191003202709.26279-1-newren@gmail.com>
References: <20190930211018.23633-1-newren@gmail.com>
 <20191003202709.26279-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new option, --mark-tags, which will output mark identifiers with
each tag object.  This improves the incremental export story with
--export-marks since it will allow us to record that annotated tags have
been exported, and it is also needed as a step towards supporting nested
tags.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-export.txt | 17 +++++++++++++----
 builtin/fast-export.c             |  7 +++++++
 t/t9350-fast-export.sh            | 14 ++++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index cc940eb9ad..c522b34f7b 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -75,11 +75,20 @@ produced incorrect results if you gave these options.
 	Before processing any input, load the marks specified in
 	<file>.  The input file must exist, must be readable, and
 	must use the same format as produced by --export-marks.
+
+--mark-tags::
+	In addition to labelling blobs and commits with mark ids, also
+	label tags.  This is useful in conjunction with
+	`--export-marks` and `--import-marks`, and is also useful (and
+	necessary) for exporting of nested tags.  It does not hurt
+	other cases and would be the default, but many fast-import
+	frontends are not prepared to accept tags with mark
+	identifiers.
 +
-Any commits that have already been marked will not be exported again.
-If the backend uses a similar --import-marks file, this allows for
-incremental bidirectional exporting of the repository by keeping the
-marks the same across runs.
+Any commits (or tags) that have already been marked will not be
+exported again.  If the backend uses a similar --import-marks file,
+this allows for incremental bidirectional exporting of the repository
+by keeping the marks the same across runs.
 
 --fake-missing-tagger::
 	Some old repositories have tags without a tagger.  The
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 575e47833b..d32e1e9327 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -40,6 +40,7 @@ static int no_data;
 static int full_tree;
 static int reference_excluded_commits;
 static int show_original_ids;
+static int mark_tags;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
 static struct refspec refspecs = REFSPEC_INIT_FETCH;
@@ -861,6 +862,10 @@ static void handle_tag(const char *name, struct tag *tag)
 	if (starts_with(name, "refs/tags/"))
 		name += 10;
 	printf("tag %s\n", name);
+	if (mark_tags) {
+		mark_next_object(&tag->object);
+		printf("mark :%"PRIu32"\n", last_idnum);
+	}
 	if (tagged_mark)
 		printf("from :%d\n", tagged_mark);
 	else
@@ -1165,6 +1170,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			 &reference_excluded_commits, N_("Reference parents which are not in fast-export stream by object id")),
 		OPT_BOOL(0, "show-original-ids", &show_original_ids,
 			    N_("Show original object ids of blobs/commits")),
+		OPT_BOOL(0, "mark-tags", &mark_tags,
+			    N_("Label tags with mark ids")),
 
 		OPT_END()
 	};
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index ea84e2f173..b3fca6ffba 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -66,6 +66,20 @@ test_expect_success 'fast-export ^muss^{commit} muss' '
 	test_cmp expected actual
 '
 
+test_expect_success 'fast-export --mark-tags ^muss^{commit} muss' '
+	git fast-export --mark-tags --tag-of-filtered-object=rewrite ^muss^{commit} muss >actual &&
+	cat >expected <<-EOF &&
+	tag muss
+	mark :1
+	from $(git rev-parse --verify muss^{commit})
+	$(git cat-file tag muss | grep tagger)
+	data 9
+	valentin
+
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'fast-export master~2..master' '
 
 	git fast-export master~2..master >actual &&
-- 
2.23.0.264.g3b9f7f2fc6

