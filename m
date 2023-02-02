Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F7AC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjBBJyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjBBJxt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:49 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207F72BF1C
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:13 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so3766792wmq.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmmHrGWZmIzw3znsYKxDzhLVGs5tHLKflSJSBmxcG6A=;
        b=HHGSmpbCL4dWLYmCv828m6B96XJf/ZHza0Jd+SP5f7rhtWrLMYpY+tH7ke6IS60+KT
         oaihdew+EX9ZW8TzwfcP3Lu1FuCEbX/0bs0MCFHPDrHX6P++3Hr6+gVB0f/sg9X95iqT
         PlaTXdlZ99R/kVBLu8weY/Hr4K+ZhS3aJcBRh52Ct7JXgZ/5JJlad+fjthJFp7hhctNZ
         gTSclCzx71olIFe99VROFZpRr+ifweKY/4MLkKIsuIutS29nDYepqXPEcQ8G58SGsuDD
         V+sOvMnUkIpA0MM6gqE4SbTGye9IPjfb2Jx6b98ghMjkOfSrRdAYUCoGQdtCuOn8gcBx
         xfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmmHrGWZmIzw3znsYKxDzhLVGs5tHLKflSJSBmxcG6A=;
        b=TC6SyH4U8Nu8Zhf4em8UejnXeYo3fpwgs0LMqlrBARvwa613RFkNpaQdooIvwcAUlR
         VBXsB0nbrPf+lGWwyuCTaA0zCJnnAaLc2UPcrGnGQAKhO0TrCCWF7Hsu2afbqMxIQ705
         cCjgxdsjSx6xXDmeiG0bY68ijhKwjRGzFmSTEODg0j2crujFWI7T6OVk3XajalXSzy8u
         gNiAPyi90nrwvgRd/qESbTDvZcsyk05qn9f/ZCLdrewbM4+I6aJFBqexvylSXFCp0Cbc
         iCTcKFMbFrYeQP39B/+C3Ih2+xepbrpcBAb/66Nigs/O2oEol0QpU1AnGHx2agx/0ghQ
         4mRQ==
X-Gm-Message-State: AO0yUKVVUrT0s3jkpEQoN0IVrdfiZRDLK2VVA7sua5DUEmpDMjhPfvXu
        JRE1h6Mc6OOwaiWGnzhIaWkfSgmHkEseNN6J
X-Google-Smtp-Source: AK7set//Jg8iCKvjZJOrvKBzGMtDnhftmr7StGQpaX2xxoN+tMf1JzeOdrVfk5w2Zq4f35m4+8So6w==
X-Received: by 2002:a05:600c:548d:b0:3db:114:a67f with SMTP id iv13-20020a05600c548d00b003db0114a67fmr5205514wmb.17.1675331591973;
        Thu, 02 Feb 2023 01:53:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 15/19] grep.c: refactor free_grep_patterns()
Date:   Thu,  2 Feb 2023 10:52:46 +0100
Message-Id: <patch-v6-15.19-aa51668b70d-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the free_grep_patterns() function to split out the freeing of
the "struct grep_pat" it contains. Right now we're only freeing the
"pattern_list", but we should be freeing another member of the same
type, which we'll do in the subsequent commit.

Let's also replace the "return" if we don't have an
"opt->pattern_expression" with a conditional call of
free_pattern_expr().

Before db84376f981 (grep.c: remove "extended" in favor of
"pattern_expression", fix segfault, 2022-10-11) the pattern here was:

	if (!x)
		return;
	free_pattern_expr(y);

While at it, instead of:

	if (!x)
		return;
	free_pattern_expr(x);

Let's instead do:

	if (x)
		free_pattern_expr(x);

This will make it easier to free additional members from
free_grep_patterns() in the future.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index 1687f65b64f..f8708e1fd20 100644
--- a/grep.c
+++ b/grep.c
@@ -769,11 +769,11 @@ static void free_pattern_expr(struct grep_expr *x)
 	free(x);
 }
 
-void free_grep_patterns(struct grep_opt *opt)
+static void free_grep_pat(struct grep_pat *pattern)
 {
 	struct grep_pat *p, *n;
 
-	for (p = opt->pattern_list; p; p = n) {
+	for (p = pattern; p; p = n) {
 		n = p->next;
 		switch (p->token) {
 		case GREP_PATTERN: /* atom */
@@ -790,10 +790,14 @@ void free_grep_patterns(struct grep_opt *opt)
 		}
 		free(p);
 	}
+}
 
-	if (!opt->pattern_expression)
-		return;
-	free_pattern_expr(opt->pattern_expression);
+void free_grep_patterns(struct grep_opt *opt)
+{
+	free_grep_pat(opt->pattern_list);
+
+	if (opt->pattern_expression)
+		free_pattern_expr(opt->pattern_expression);
 }
 
 static const char *end_of_line(const char *cp, unsigned long *left)
-- 
2.39.1.1392.g63e6d408230

