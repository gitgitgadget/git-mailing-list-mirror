Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEC2C4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 07:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiKTHtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 02:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKTHtO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 02:49:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502DCA3410
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 23:49:12 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h14so7968212pjv.4
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 23:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW1afaK8MNcQSXRqY8dLKLjOs0f8TaMuqx8SyIk1pCw=;
        b=lOH2/r+yjoyj9BcU2JEeqkMxwjvFY5oEavBWAru8NM/vga+9VVT4YUaq+H1+CU1TJ0
         yFkQ6Ml6Ai+K82cCGcHKwJz3/ITz36V3yoDP51BCojOwa0+M6NPP2DYUyK5087so5AtE
         CLdhvPTtKU+Ry8PUbB+BPiJaT2kA1d6iOetMSrMDFT63tkjarvfOF5sQdty1FAJWZUt6
         DFWgyz3NSWKtJ43HQmyZQX97Wicnij8VwCMf+x4AJ5RsJG1ea78/79GIJfKJIeXCOegq
         CYGusn3PtNWIHBwaIj7mjNHcSULjEFIszVzTVjjuiO36Z8rp4BWBHwdmJ+SiRSrUPw2p
         kTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW1afaK8MNcQSXRqY8dLKLjOs0f8TaMuqx8SyIk1pCw=;
        b=LIWxXqPkREOsIdOQ8bHkutHSOou1GJKe4AHoQhRafcp74I2y2bFn3e4Zao8F6npFor
         gHoKiGpicUX1qf4S+7mQzTJ6tyFAE1QyERNemRYR7MFomDBVmBVQUfY4kNabpG9eg2eC
         jpDImBIEe7dtO8hEpVDHSO7/YjBL5s/SnafqdTZvBZ0/ap++ZQBnOdp+BQMXbBhRQj4L
         ZMYF5JiFyLe4sG8uUJjv7E6zpCY5gpLtsnT8ifVoiVcmYJzQoSZwA915XPtgzVuySP1m
         DUEh+gfCRiaVBuqsanH8PYr+urRxy5wuwz6RiRb3QQUN+9URJR9quN7bjTDODRMnCsQG
         wODg==
X-Gm-Message-State: ANoB5pnp2bD7ANeQ5TgkAMZYlLSkDLBa3+5XXq4vwXW/lgh+7b0nW+hl
        JzS0cf8O4oL83EytPTxXatV0JW+B7c+IVQ9q
X-Google-Smtp-Source: AA0mqf6ohlXCodrUtXXobW/suYmBf4fJK887vqqUiQuStCSgK6lBC7eUWr4J4D8PzxngCwTWJI1Cxg==
X-Received: by 2002:a17:902:b101:b0:188:abb9:288 with SMTP id q1-20020a170902b10100b00188abb90288mr6563218plr.123.1668930551195;
        Sat, 19 Nov 2022 23:49:11 -0800 (PST)
Received: from HB2.. ([2409:4081:9e01:f9e1:b435:9ad:e08d:a7fb])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b001871461688esm6988645plg.175.2022.11.19.23.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 23:49:10 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 1/2] cat-file: add mailmap support to -s option
Date:   Sun, 20 Nov 2022 13:18:51 +0530
Message-Id: <20221120074852.121346-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.1.438.gd2340c8913
In-Reply-To: <20221120074852.121346-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221120074852.121346-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though the cat-file command with `-s` option does not complain when
`--use-mailmap` option is given, the latter option is ignored. Compute
the size of the object after replacing the idents and report it instead.

In order to make `-s` option honour the mailmap mechanism we have to
read the contents of the commit/tag object. Make use of the call to
`oid_object_info_extended()` to get the contents of the object and store
in `buf`. `buf` is later freed in the function.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt |  4 +++-
 builtin/cat-file.c             | 13 +++++++++++++
 t/t4203-mailmap.sh             | 25 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index ec30b5c574..f82d702d6b 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -45,7 +45,9 @@ OPTIONS
 
 -s::
 	Instead of the content, show the object size identified by
-	`<object>`.
+	`<object>`. If used with `--use-mailmap` option, will show
+	the size of updated object after replacing idents using the
+	mailmap mechanism.
 
 -e::
 	Exit with zero status if `<object>` exists and is a valid
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index fa7bd89169..8a6e2343ec 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -132,8 +132,21 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 's':
 		oi.sizep = &size;
+
+		if (use_mailmap) {
+			oi.typep = &type;
+			oi.contentp = (void**)&buf;
+		}
+
 		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
+
+		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
+			size_t s = size;
+			buf = replace_idents_using_mailmap(buf, &s);
+			size = cast_size_t_to_ulong(s);
+		}
+
 		printf("%"PRIuMAX"\n", (uintmax_t)size);
 		ret = 0;
 		goto cleanup;
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index cd1cab3e54..87b77fc5c9 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1022,4 +1022,29 @@ test_expect_success '--mailmap enables mailmap in cat-file for annotated tag obj
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	git cat-file commit HEAD | wc -c >expect &&
+	git cat-file --use-mailmap commit HEAD | wc -c >>expect &&
+	git cat-file -s HEAD >actual &&
+	git cat-file --use-mailmap -s HEAD >>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file -s returns correct size with --use-mailmap for tag objects' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	Orig <orig@example.com> C O Mitter <committer@example.com>
+	EOF
+	git tag -a -m "annotated tag" v3 &&
+	git cat-file tag v3 | wc -c >expect &&
+	git cat-file --use-mailmap tag v3 | wc -c >>expect &&
+	git cat-file -s v3 >actual &&
+	git cat-file --use-mailmap -s v3 >>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.1.438.gd2340c8913

