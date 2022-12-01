Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2D3C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 15:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiLAPzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 10:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiLAPzY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 10:55:24 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D57B0DF8
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 07:55:22 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so4457629pjt.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 07:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udXHvFkyQ0YXY8dmM/NJJn93DFgDlnFXD8i0ORTr6LY=;
        b=n73PA/68HyOV1yzXin0R91XMQvqGSex6oKtFL8YfI6XARF2lcjx2m0M5nEFmJLJA2R
         +owjCrnRcOKXfmdSwIkYbQ3xMBwUdm9Tl3xcJ08L21GC9kZDSLZhwjYf5WZKwRjszXAM
         0sii907ysapzGnaTDZ4LSLH+FZmfCV+8a9UOLAbi1Exw5YNxcx6qFKY+tUU4a9PNu7Nd
         sLNkfV223+xjb1qAFa7whUd3Kwdhm5c96jybfCFbw/E31dwTsuUvYxxSlUS8jxCfszW9
         qAazlUUi4wptiB7aK7YiRnWkoFaCWkhTib66FgoPCuxRdXESxEqd6pkuOPiOJkCEjTpH
         OpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udXHvFkyQ0YXY8dmM/NJJn93DFgDlnFXD8i0ORTr6LY=;
        b=STyDcdrEFmvyPyRXZQgvm3EaKAD+oq8p7TSENc19tQ3QZqTumAlNj0JxEIqoixcdCS
         utl/yU6mea7h7P3D00vtWoTxs1/fZ/2RNeZhbgDI3n0hZEAETzE8WNFPq2ms9SvnQB8G
         SW1mjugvmLzBMByDzYbZTsBzIOH/aVbFG6+dBEWvKUlCd+bWQG86kltuahFVcpCYY966
         buMJxJ4m3JWccZHre5Q8fGsASJHrfv1KEhGlPmxoAjSyZACPbMfYt4m22hHae6wCNIMH
         /lJXE5xEXkU3xCxaHLYlMZU7YzYOM2eK/x35ZcT/I26BIv1cen0adplculW60mBot9aA
         OMrg==
X-Gm-Message-State: ANoB5pn4zz/J+50LNL65mBwq67Rl5oGJFuiiD84lsvWd+MNjHt+lKxfs
        ToJBeR/wzSx1g+s/lv93PeYPdCSt4PQvKQ==
X-Google-Smtp-Source: AA0mqf6ArpyWYrcIX1B4X0vVUF3gN9BVLjpbIXIKmYu6OSe4zU5eVKzNeQqLQbon/aC3LmU/XoSMnQ==
X-Received: by 2002:a17:90a:588b:b0:219:c40:e5f with SMTP id j11-20020a17090a588b00b002190c400e5fmr34204922pji.49.1669910121851;
        Thu, 01 Dec 2022 07:55:21 -0800 (PST)
Received: from HB2.. ([2401:4900:36ac:5594:1695:30e6:556:ccb7])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0056c349f5c70sm3405290pfr.79.2022.12.01.07.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 07:55:21 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v6 1/2] cat-file: add mailmap support to -s option
Date:   Thu,  1 Dec 2022 21:25:03 +0530
Message-Id: <20221201155504.320461-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.6.g86692db720
In-Reply-To: <20221201155504.320461-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221201155504.320461-1-siddharthasthana31@gmail.com>
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
 t/t4203-mailmap.sh             | 29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

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
index b3be58b1fb..dde8dbeacd 100644
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
index cd1cab3e54..b8ec5e0959 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1022,4 +1022,33 @@ test_expect_success '--mailmap enables mailmap in cat-file for annotated tag obj
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	git cat-file commit HEAD >commit.out &&
+	echo $(wc -c <commit.out) >expect &&
+	git cat-file --use-mailmap commit HEAD >commit.out &&
+	echo $(wc -c <commit.out) >>expect &&
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
+	git cat-file tag v3 >tag.out &&
+	echo $(wc -c <tag.out) >expect &&
+	git cat-file --use-mailmap tag v3 >tag.out &&
+	echo $(wc -c <tag.out) >>expect &&
+	git cat-file -s v3 >actual &&
+	git cat-file --use-mailmap -s v3 >>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.39.0.rc1.6.g86692db720

