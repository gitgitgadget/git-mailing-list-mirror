Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF8AC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjAQRMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjAQRMK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:12:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5272545218
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:40 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y19so12433326edc.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+BUcbwSdm8pyvoCjUjcaG+1v3Vw0KRT8qqUiTgW6/o=;
        b=BWJ2f+/AK4VnG03qZll1Vj7gbXG2CoFnA+kY+qNY0p4jykN9xortheJ89rN+1sL3e4
         jpwXUrkiXt3ziUDk4fV4QeNdnkDUmMY+MhtqNnYddDJ9LTfAA+2p1oris09WpwrncIe8
         Myf9N+Sa525mS8DsM03wazA/MSrDgR6R1IXLL+gUokfIaZIBdHGh8heewAIs7aIQAN/O
         aEBy+byQD4AXb8DKHrw9gi0LahJ3TBuFjMXgO+vwiVlzobB7Mhm1avi8pELo3a0E+i87
         WDbt290uxXZa2jKPz3CCQjXcONSDrWMYfLBuP3myqpKnObfyTFiN/tLRTrca2G0r39mW
         F8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+BUcbwSdm8pyvoCjUjcaG+1v3Vw0KRT8qqUiTgW6/o=;
        b=KFny2VrZLhosn+kBGXCIHbJtDMNpksGB0hwEkN4dUDgpZsbM9gX3Apg/4J+VEKESrZ
         Vca/JvjcqFAqtEuczDayFMpVggLdCaMfBVem9PuYpJu0TrB+F4c1MZJnjY51+KKYrogb
         5WIgvnwzDmhQlieJd7O6clxlxVTzDt3pxm8tdd/3YyFPZPIe168DWsHAH16TWFTyyYZA
         ntUfsCCA9CVpRSkxA2I1cwau/JlYyOkdhJSNjB4EppuZY1H/RZCHmE/kxW/W8lZhQEK7
         7H5peXc57B6N85h3eAMwiD/7L2t49PfojUw049kx+Zs1gmgrzG4+oKDaXicYNGrLfCCR
         kfxw==
X-Gm-Message-State: AFqh2kr80S1rtRuHGeSgDB1xBr95ncxpPO2yIYCRUTjn59xq6YMgI4MJ
        EK4vv6EDw/tWegqwSJ0no5lpVtTq5K+pNw==
X-Google-Smtp-Source: AMrXdXt9xxq1eRuAoej//hnuLaAsUC9hf3hZ8imcSoSLWabeWra7ZgzI97hWWoF+aqIvVAuCOLh9Dg==
X-Received: by 2002:a05:6402:40a:b0:499:1ed2:6456 with SMTP id q10-20020a056402040a00b004991ed26456mr3846038edv.22.1673975499310;
        Tue, 17 Jan 2023 09:11:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 16/19] grep.c: refactor free_grep_patterns()
Date:   Tue, 17 Jan 2023 18:11:21 +0100
Message-Id: <patch-v4-16.19-52744d9690f-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
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

