Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE86C433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 10:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ2KZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 06:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJ2KZR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 06:25:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552EC41987
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 03:25:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y13so6793558pfp.7
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fc/fdtyyVI6NU/QMBBUT6AeW6TArN4XOQvq3S+p0CT0=;
        b=mO46LnRw0HQO4HxBlxtyYc1kqDFBJdbA3x/9LtE/G2B+h1XKZZUrHt0pzXWhlDcvp7
         bMNiHoqFg/TAAZ/Nv4pv2FaDksU5zEwf++0yNrP7SHGiwX7G71VOrlUspWiOQWGsadLY
         5Lpk6ErtqFR6K1Rn6gCrjjoEzFLo9r41R0KgSZ89nHUQKFLedca8+IpqxJL9hLvOE6tu
         QQiQey0zp2x6WhFg3CXWShpFwSGJQvULf6zooLgUBeUIqIoDqJC6DCTqw1CHPrT7FUGU
         CvC9WzTy/S1PWgyDfghtyIYoKMV8guihkO3q66taJBhyDMMiMF0j68xCrHhA+UbUgF3a
         GsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fc/fdtyyVI6NU/QMBBUT6AeW6TArN4XOQvq3S+p0CT0=;
        b=bGgRkhTr1EfcXQH1sTBhf5+3FTEEcHFY35X1GNVDfp1NH5gTNKPfm+dWSRn7isjNvc
         AmGiop/VXMmfk/mDqk/pX52/i8FUqLkjwNSjAgD7rNKUHIRzjB3CtpTJdxHwUPnsQzjX
         i9ikTMzI1tgVTW0ZtW36o+EaeOb5+OKGduDJhtG3tG3BcuFAUZJhkSDJm7xU/8CbdKzG
         oO3IGkH49Y6bLxx/K9Qt3LBo+yOj1lLz1zi2omBR/mLAaBjiYvOMmtb/NkuszMnB7IbZ
         sL6SeW3n5/3LoojOHcikIYOk/gDNJPRq4WXrUVv1YPdMKzFN5uqRwfbv1bfIUgg1hBw7
         PQ0A==
X-Gm-Message-State: ACrzQf0/8O9mf0RLYY3ok+9FZS735s6nwOYlGdhgy5nTXa7e771xQ6AA
        IJAethLzhvVSLvrmTd/flZ2EfipfnTFZGQ==
X-Google-Smtp-Source: AMsMyM4ZRS14wAahvsHIX5yLECBRc/LZsrcqE74bHtNh8rht5epqT/OzeXBGW9UJiTGYC+0vGIdafg==
X-Received: by 2002:a05:6a00:1149:b0:53e:62c8:10bc with SMTP id b9-20020a056a00114900b0053e62c810bcmr3903054pfm.49.1667039115316;
        Sat, 29 Oct 2022 03:25:15 -0700 (PDT)
Received: from HB2.. ([223.190.251.111])
        by smtp.gmail.com with ESMTPSA id e10-20020aa798ca000000b0056286c552ecsm902449pfm.184.2022.10.29.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 03:25:14 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 1/2] cat-file: add mailmap support to -s option
Date:   Sat, 29 Oct 2022 15:54:58 +0530
Message-Id: <20221029102459.82428-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.1.282.g2e87897fbb
In-Reply-To: <20221029102459.82428-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221029102459.82428-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
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
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt |  4 +++-
 builtin/cat-file.c             | 13 +++++++++++++
 t/t4203-mailmap.sh             | 29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index ec30b5c574..594b6f2dfd 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -45,7 +45,9 @@ OPTIONS
 
 -s::
 	Instead of the content, show the object size identified by
-	`<object>`.
+	`<object>`. If used with `--use-mailmap` option, will show the
+	size of updated object after replacing idents using the mailmap
+	mechanism.
 
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
index cd1cab3e54..b500b31c92 100755
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
+	cat >expect <<-\EOF &&
+	209
+	220
+	EOF
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
+	cat >expect <<-\EOF &&
+	141
+	130
+	EOF
+	git cat-file -s v3 >actual &&
+	git cat-file --use-mailmap -s v3 >>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.1.282.g2e87897fbb

