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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD441F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbfI3VKb (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:10:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36352 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732637AbfI3VKb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:10:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so6303529pfr.3
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4iMS/AKmnHMXzVmbj6TkOuwaH/sOX0DzGJ6qcjJNKU=;
        b=fAvsNC36iXVp3bK+nKh6QiDG1XWQmO2N5nQChhuhTXMwne3O9PibIURG3IW7h6RjAF
         Wxn8ihorIRvy7lhAemdPQNM5xqOkNFHMPqf5phNvXxdlCFM7xHt94BEP7rMyv+0EDCPL
         Myw5vJjul/5SNKB2bf9ahq1Upq3sDDv7Uxp6Ib7UVQ4jahMWEdWdsWJa/yJGKJh6jlj8
         camYTAJCVU1hFl5xw2wR43KA05OKOaX/bprXhMxYmrDRKWSe72g76IEJyuBfS4eUFm/H
         Z9h5hmGOkQu2Q8gbMK1Lwk3WCAgUONrCpN7GLNGV0In6jWHcVpezNAifF15oKvvERs0F
         nokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4iMS/AKmnHMXzVmbj6TkOuwaH/sOX0DzGJ6qcjJNKU=;
        b=Jwm79/MRk71zpBWB9IpuCRpuRX8tITTyWep7G2VmDieICkGZ1WUjNBk8wWqrSi8Eaa
         B/dIvK1zlea4sPk39k5eINwwFaVU9/9sZOad2+ZhmqQVUg9KrsfJU8VPtz4YBdJLLzVB
         OPaRyUn7F0EalUBtRj4pFCz2SNxlecrAZQOZt/SqKkqXt5ZcxSkPeZIR//dQ+lPumcBA
         evqh/CtGYWb4oLMOUWmdWElaw8iHh1ETOy56oiSURcdOz6TynsrCQAmi8okbnMqtMXRl
         3yvgJdlGUMC+nwwcnrPjLm/1h8cs6YGGTrRJCIibdqvY/Tep7b6q2Bo9YW6rQiGPMaE5
         L4Sg==
X-Gm-Message-State: APjAAAXlB9jOS2YNHwv7enEZVqGvVl9dFpLN5BUhTSbDZYWa0WdiIVqJ
        Ir+p/PCA15wo6VkjOeBmhd8Tm9A+QfE=
X-Google-Smtp-Source: APXvYqyVJ8Z1Dx1oSW/PIddJHG+ENkccI1sKG0iRkd0hpol5INx3hRKDGK8xCRhf0+Wj85tqv/Xi6w==
X-Received: by 2002:a17:90a:e017:: with SMTP id u23mr1298797pjy.55.1569877829431;
        Mon, 30 Sep 2019 14:10:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id w11sm13404609pfd.116.2019.09.30.14.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 14:10:28 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 6/8] fast-export: allow user to request tags be marked with --mark-tags
Date:   Mon, 30 Sep 2019 14:10:16 -0700
Message-Id: <20190930211018.23633-7-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.gac739dbb79
In-Reply-To: <20190930211018.23633-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
 <20190930211018.23633-1-newren@gmail.com>
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
2.23.0.264.gac739dbb79

