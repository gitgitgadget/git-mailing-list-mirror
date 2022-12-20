Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92835C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 06:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiLTGBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 01:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiLTGBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 01:01:31 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD80195
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 22:01:30 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u5so11351799pjy.5
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 22:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUz5y1s1InuBFk/MVXhKlCdkzgxVXVknND4kZhd30X8=;
        b=gcZQBK4iqIvIXxiGa5QOI52P2kEsuhniuVcfdkX51JOTT4+v+QHtWRqenetr9DaSUk
         ImQ7ZVWJ5wQlR5Vd2l4KTpnrpkzYhszWWZwiF5r2oqbP2kt/OCJTEwbv9C1PnY8JN0dR
         LUnzCh+jIxznlDXRCK/T0sK3Okwxw4/4BbisLLv03ZFk6dj2Scu6L7Li3Sfc1lbzw1v3
         SSyJKEqXnjdeTPXDtiItuf5iqF6jS5Fo/IPG850H2NEKFbNQSjaUo0kgoAyFxaFfyc/G
         2gLPT3K96zOdVi9+s1HOsipNMtAjZVZDzQxQqEalG2XtqDNdDT5Dx64Wwl+Rp4us5wTA
         N2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUz5y1s1InuBFk/MVXhKlCdkzgxVXVknND4kZhd30X8=;
        b=x6+481ARpHghfS0NhQmogI/bw52ebvPJzJ6+llcntpN6WgfGdCpOXVlURY4JfN04Nd
         ko+GbXjtJ+uybYi2yGnrgLUC0r7pAbVh+0mLmunT0nVhbBMI05tOZJTQr/mqS7ho93lG
         Io/rav/uoRG6ZPJmFhN35/X4VI7LSEF13A7Vz5k7AfuSYz0f0aYaxPVWxWoFSeykW73s
         FI3Sm28nlB7MXWh+wyVcX56MM49a2QvmJh+i00GXuyQ+qVwKDuwdrHP+7+VA8qy1r0yI
         M5ACHPxr0AcUSRa6jHL1Vulk2ucWENlUn+LWD93qIJh67WA7jyMF7e8ZOMxIXRTwSbXS
         Bawg==
X-Gm-Message-State: AFqh2koUWG1CMyEAYsYMbcspHwJdDUyHrVaWvYQrLjg2qawUDj3sFJUY
        3SfWpqxtpldhwqDFj8dphpt92PHVMb4wKg==
X-Google-Smtp-Source: AMrXdXuSx4zEXJEmSvLCQooTHfMiaAb/zYPqNgVEtm++MN4/5E8BJooymvDqUOjEH1l/aumNqA8G6Q==
X-Received: by 2002:a17:90b:4f43:b0:219:d999:770d with SMTP id pj3-20020a17090b4f4300b00219d999770dmr13643613pjb.43.1671516089484;
        Mon, 19 Dec 2022 22:01:29 -0800 (PST)
Received: from HB2.. ([223.177.27.192])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090a0d0f00b0021358bd24b9sm10211041pja.21.2022.12.19.22.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 22:01:29 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v7 1/2] cat-file: add mailmap support to -s option
Date:   Tue, 20 Dec 2022 11:31:12 +0530
Message-Id: <20221220060113.51010-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.39.0.97.g8305148718
In-Reply-To: <20221220060113.51010-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221220060113.51010-1-siddharthasthana31@gmail.com>
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
2.39.0.97.g8305148718

