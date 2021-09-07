Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A8DC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4ED60E52
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbhIGK7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343848AbhIGK7m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12195C0613C1
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g135so6501856wme.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcQHzjc/F8Zn+ZhPENdKj+31A4m8CQ2KxoXa2PuB48k=;
        b=gD3hmScaMlhB12aLRD6MvIbmpxHGsk3hNaZrDawuKsbIP2F8RG7D7gE6OvTI3RZ6n7
         ZRHXUyr3PU8W0uBehWyHmOpW6RZ5GjFlpjxaH0qAcrzIaXYw05HeEvOhmsHyOtcxwEzQ
         Z8dCklxY0q0aVZTfR3/Ff8pDJUHwsvtXOZ/O/pAESl0nO6LpcarXIMXMRU7/axYRXlRr
         kXTikomNj+OLIxnN6ZhLiHT/qjSSR1SNXyCC9MWgjyE+6Y7UfXKUims3GBCpRY/ywE5C
         2KgkZVqUP52eYnC12fbAdqH4vB7kiYnMPZ7uIM03ZhZIMUlvHpm3lrU96Db2xBGSu6n8
         zWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcQHzjc/F8Zn+ZhPENdKj+31A4m8CQ2KxoXa2PuB48k=;
        b=JFy2Ngl1QyOSNrJ7MAoSIBrSOwVpXj5l6zTtp9FoCNczrXGfNyOetOLh0NkCs5SK/5
         842kihuDL4MDkmptYeRyb3GQKNvWUSl/gdCzohwYw9TRdBdorcO+AyLd/8riW5ngFDr+
         QcQsBSczNYst2pBlIQKuyO+wEcIk4k9mXKuLi5AnunyY58YdS5gU/xsQX8OvHOCx+LN8
         pIWHrUivz1UwlSurz583f6ozeYGpTTT7N2WFZBWwYTyTiYuKvTqkGhNaUh3ykz/QZKuh
         0Av8/iEnEAUakUqpm3YdWuFBESmMf/jDhBmXfu+7IrcqBvOdpi6UyYAc9bKk3DJ/Md28
         hryw==
X-Gm-Message-State: AOAM531MS46x+DwwzgVxw8yBdHQEYRqkmq5IbDHBT9+Kdny3zWBfbjvq
        sL2sMM4k6yj18qRFELZv0BBc9F0J60IVKw==
X-Google-Smtp-Source: ABdhPJyVwlgPTdXT2aMfc/RgZ1lVmwJ/8bfXvTxaaXfWurjPLPQ6DK+wVQ6+h4BLWV1x9nfof3JJEQ==
X-Received: by 2002:a1c:4d10:: with SMTP id o16mr3339898wmh.60.1631012310417;
        Tue, 07 Sep 2021 03:58:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 07/22] cat-file tests: test for current --allow-unknown-type behavior
Date:   Tue,  7 Sep 2021 12:58:02 +0200
Message-Id: <patch-v6-07.22-22ab12c2282-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more tests for the current --allow-unknown-type behavior. As noted
in [1] I don't think much of this makes sense, but let's test for it
as-is so we can see if the behavior changes in the future.

1. https://lore.kernel.org/git/87r1i4qf4h.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8f3516db188..98729f1edfc 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -361,6 +361,46 @@ test_expect_success 'die on broken object under -t and -s without --allow-unknow
 	test_must_be_empty out.actual
 '
 
+test_expect_success '-e is OK with a broken object without --allow-unknown-type' '
+	git cat-file -e $bogus_sha1
+'
+
+test_expect_success '-e can not be combined with --allow-unknown-type' '
+	test_expect_code 128 git cat-file -e --allow-unknown-type $bogus_sha1
+'
+
+test_expect_success '-p cannot print a broken object even with --allow-unknown-type' '
+	test_must_fail git cat-file -p $bogus_sha1 &&
+	test_expect_code 128 git cat-file -p --allow-unknown-type $bogus_sha1
+'
+
+test_expect_success '<type> <hash> does not work with objects of broken types' '
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type "bogus"
+	EOF
+	test_must_fail git cat-file $bogus_type $bogus_sha1 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'broken types combined with --batch and --batch-check' '
+	echo $bogus_sha1 >bogus-oid &&
+
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+
+	test_must_fail git cat-file --batch <bogus-oid 2>err.actual &&
+	test_cmp err.expect err.actual &&
+
+	test_must_fail git cat-file --batch-check <bogus-oid 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'the --batch and --batch-check options do not combine with --allow-unknown-type' '
+	test_expect_code 128 git cat-file --batch --allow-unknown-type <bogus-oid &&
+	test_expect_code 128 git cat-file --batch-check --allow-unknown-type <bogus-oid
+'
+
 test_expect_success "Type of broken object is correct" '
 	echo $bogus_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
@@ -372,6 +412,27 @@ test_expect_success "Size of broken object is correct" '
 	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
 	test_cmp expect actual
 '
+
+test_expect_success 'the --allow-unknown-type option does not consider replacement refs' '
+	cat >expect <<-EOF &&
+	$bogus_type
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	test_cmp expect actual &&
+
+	# Create it manually, as "git replace" will die on bogus
+	# types.
+	head=$(git rev-parse --verify HEAD) &&
+	mkdir -p .git/refs/replace &&
+	echo $head >.git/refs/replace/$bogus_sha1 &&
+
+	cat >expect <<-EOF &&
+	commit
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
 bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
 bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
-- 
2.33.0.815.g21c7aaf6073

