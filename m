Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765751F454
	for <e@80x24.org>; Mon, 11 Nov 2019 06:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKKGE3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 01:04:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34469 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKKGE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 01:04:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id n13so9974188pff.1
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 22:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZHxC5Ua8ccYpp2cg/AlwK2JrwY5nooQ++rrEZQics7o=;
        b=ZJYvaPGlT0XTY4HjPsVDf/f8NEApj5gtxmYB7NMXhhS2DcffrJLGsOH2KumsP0PR+v
         PenGb7VYQ7wnaKvacnouURHFBDdI9SCxT5idPK3Ch9lYwnEqnqpYDonctdTSwrhXCK5g
         ff03ilMhXtbOka4Xm/0Yi9egX3bKJWm4f3wWHqdsnpqDKpZ+EHYrpSWYNozoKGXQQwW+
         q+OanQQcEoyklfOJBQWQ950n776XRg7QduxlJ5zZfkDhuQRzmZrx83Kx+KYeKqqGyC/6
         Uz9Xi98tgEN/T53EGhfxm7jBpQGl6bqviKJiXRKOWik5tjErL4k3UrOuf0SutruzT7gD
         XmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHxC5Ua8ccYpp2cg/AlwK2JrwY5nooQ++rrEZQics7o=;
        b=mXjHe2SrNUYG+z4CqBYoR2u6b+AWkDncSoBFLXD6j79GdblUU9pO/z0p74almscIFr
         PKcba3g2D0WwH3uFZ3XFdv4KJ8+wHq+ZxYejvtA77nP/UfylfE2vIBwGuKSz9XBVf8n2
         ePWds/+QtK1/gUEjgVvaYRJc+Dk/HAQ/LzOD3oSPxweoioweWGRQi1aIL54xqrD8ZaaC
         Sg0wC9wGr69hvHFxtOK+qrRl56yGVv+Xuoddix8XnZpUUH4o2fxgVACxMFCgn+W601rX
         K1MY7ERce/FJefrqflA5nIZK9m4756rSbF9Op3T0Rqoxppo8jbjeFMB1118ga8u2osuq
         fWOA==
X-Gm-Message-State: APjAAAUklYg9y0ZYwEo/VCjWvFvTazmIdoqCoxLWBpWWaJ970oxAvdvG
        1nH4vQlvS1c8m3pPGUrh4LdxbsZd
X-Google-Smtp-Source: APXvYqwkHj/AyUiF72Mcj8qEZiChrGwD+ugybU9buYtWHYx3AWtV4PRlJbnIYCASb9IzFkpuaz0aAg==
X-Received: by 2002:a63:d70f:: with SMTP id d15mr27503363pgg.424.1573452267708;
        Sun, 10 Nov 2019 22:04:27 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id v16sm15112315pje.1.2019.11.10.22.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 22:04:27 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v6 9/9] sequencer: fallback to sane label in making rebase todo list
Date:   Mon, 11 Nov 2019 13:03:42 +0700
Message-Id: <78daf050de8c0cdc81fed4adc8fef92d1768c63a.1573452046.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.164.g78daf050de.dirty
In-Reply-To: <cover.1573452046.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573452046.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later stage of rebasing, we will make a ref in
refs/rewritten/<label>, this label is extracted from the subject of
current merge commit.

If that subject has forbidden character for refname, git couldn't create
the rewritten ref. One such case is the merge commit subject has
a multibyte character encoded in ISO-2022-JP.

Provide a sane fallback in order to help git-rebase works in such case

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c            | 11 +++++++++--
 t/t3434-rebase-i18n.sh |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 2f32b44f52..f664ba727e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4560,6 +4560,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	while ((commit = get_revision(revs))) {
 		struct commit_list *to_merge;
 		const char *p1, *p2;
+		const char *hex_oid;
 		struct object_id *oid;
 		int is_empty;
 
@@ -4607,9 +4608,15 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			if (isspace(*p1))
 				*(char *)p1 = '-';
 
+		hex_oid = oid_to_hex(&commit->object.oid);
+
+		if (check_refname_format(label.buf, REFNAME_ALLOW_ONELEVEL) < 0) {
+			strbuf_reset(&label);
+			strbuf_addf(&label, "label-%s", hex_oid);
+		}
+
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s -C %s",
-			    cmd_merge, oid_to_hex(&commit->object.oid));
+		strbuf_addf(&buf, "%s -C %s", cmd_merge, hex_oid);
 
 		/* label the tips of merged branches */
 		for (; to_merge; to_merge = to_merge->next) {
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index 4b5b128cd6..c7c835cde9 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -45,7 +45,7 @@ test_expect_success 'rebase --rebase-merges update encoding eucJP to UTF-8' '
 	compare_msg eucJP.txt eucJP UTF-8
 '
 
-test_expect_failure 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP' '
+test_expect_success 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP' '
 	git switch -c merge-eucJP-ISO-2022-JP first &&
 	git config i18n.commitencoding eucJP &&
 	git merge -F "$TEST_DIRECTORY/t3434/eucJP.txt" second &&
-- 
2.24.0.164.g78daf050de.dirty

