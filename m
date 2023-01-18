Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B56C38159
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjARMra (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjARMqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:24 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E9F917C3
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id v6so39707988ejg.6
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+BUcbwSdm8pyvoCjUjcaG+1v3Vw0KRT8qqUiTgW6/o=;
        b=cof2GB0B1Kw8paj1EF+ycDo0t+aXRYTD2YFIQV87VbeEXPxMkjiUVjVHrDX6gpDC3W
         DiTMJRSWfT31uZb0q//UCBJk2djX5YO2W4RLf+zBuH08K4SoW1KyHz+HWKvLk3Rs1/XN
         KCujIA1ZJYXjOP3qpojBPdflJWILVJglEgPlSHMKptRQ2Na1/Ijv8/TM2iITzKJ0mbLj
         m9Kt/vi3rvnIXC/BLbO35/ipKUWONtD9C/tI63kFTToq8q1525x4HC+dTF/rrJi3UxY1
         F2RrSINvAbMVB187C26SZC60YzQBwIvlbNYtJMEFeISRdU3HzuCbZIooGrthL0kSIhQT
         uvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+BUcbwSdm8pyvoCjUjcaG+1v3Vw0KRT8qqUiTgW6/o=;
        b=YOXHNUeC8MTm0SlT+IHuyFtpdE0owQyVUVhTDFPjVLqLhBN4PytfFSDZvs3YopOn6N
         qp4jGrAooZnwmJzcfC0VNfRr5EqAwwVMZfVcedte9rWlmXU/hHeSIjkCs9LVC1plLY9W
         0H9WNde4aUDI79a4UvjVbqwDjvBofsckuCuR0G6UcNkwfHm8V6jAN3pWOEC0yBp2TPpw
         OKY6DFXl7kWjM93ERNpFkjhVvKWGC3VDfsvxq95AsC7cP3mSQocf558SwznMNL0XFo4T
         uK2QSa9KSfCsE3pane+eTE+umnP13TNWFVG2gc/SLZ+88Cu60yG45qsd+d34C5As9h5u
         KgKA==
X-Gm-Message-State: AFqh2kqMDkiKU39o86vrg91Q4R/dKQXwhfSAVbTnJQNKhwQQ71nqoqrc
        aku6Y2gRA1Dc/wmyJbwgAdIQBAEQQq2cFg==
X-Google-Smtp-Source: AMrXdXsA0iYGPUmBtzljzjifzuH5oLfX8bA+P9nKoH8MUdGGpQM5qtcNOU1kfLQSY/rgPDT9bDRmRA==
X-Received: by 2002:a17:906:80cd:b0:86d:b50f:6b00 with SMTP id a13-20020a17090680cd00b0086db50f6b00mr6028851ejx.43.1674043728960;
        Wed, 18 Jan 2023 04:08:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 16/19] grep.c: refactor free_grep_patterns()
Date:   Wed, 18 Jan 2023 13:08:29 +0100
Message-Id: <patch-v5-16.19-10959760dfc-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the free_grep_patterns() function to split out the freeing of
the "struct grep_pat" it contains, right now we're only freeing the
"pattern_list", but we should be freeing another member of the same
type, which we'll do in the subsequent commit.

Let's also replace the "return" if we don't have an
"opt->pattern_expression" with a conditional call of
free_pattern_expr().

Before db84376f981 (grep.c: remove "extended" in favor of
"pattern_expression", fix segfault, 2022-10-11) the pattern here was:

	if (!x)
		return;
	free(y);

But after the cleanup in db84376f981 (which was a narrow segfault fix,
and thus avoided refactoring this) we ended up with:

	if (!x)
		return;
	free(x);

Let's instead do:

	if (x)
		free(x);

This doesn't matter for the subsequent change, but as we're
refactoring this function let's make it easier to reason about, and to
extend in the future, i.e. if we start to free free() members that
come after "pattern_expression" in the "struct grep_opt".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index 06eed694936..a4450df4559 100644
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
2.39.0.1225.g30a3d88132d

