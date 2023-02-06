Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C86C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjBFXI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjBFXIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:39 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0239230EA6
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:24 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so38773644ejc.4
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Dn+3L6O0etYxRe0KAHTZz8bWV/0dtUxBSOtfhLBO1E=;
        b=XSHXJStihuo2TKNY1icRnizs0G3vJBsI5yk4obwvpe3EPtjKyznK0dp2REkt/2ABJS
         56NAtF4bzns3b4ESt+htA0I/c34lLKFhrV/eY1VXhpg5cQ7BYwqUB1H+gYx+vAMVXWqH
         nm1viu6+mR4qMTIX8QiV5+zU5w/2mNwpNTW6MIx4eOlT91N1B6iWnxmuI/1XH3QyicRG
         evzfdbTwHM5pnBAaE5PRHIOG3Lqov10n77LJd75TVub4GnIiSzpGU4SU46vv2eEqX50q
         CwJdqp8s841m2s4zeLYDLwPsBSQGhiS4Q6Q609EToxwbsMRqjZUrwlLdc/5Scq1mS7oF
         u+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Dn+3L6O0etYxRe0KAHTZz8bWV/0dtUxBSOtfhLBO1E=;
        b=dp0nrBAXRd1VvudXfnxetmd3tnO/XZOFcc+X4otIQk2sSXcQWTks1hW/jajOucFO/w
         cvgnK6u6ag2HV3qYLjLFXxYA4xEKrkYzsYD0ka1CCOSV3eMny/cy9y0jYy7blqC51CH6
         czJSvuBZNAklW7mqcYQ+xh+PBir0uJYQy/VShd4CT8M9MzM3sKhAcI5ZTGqKF/LCQ6lB
         Crn9p6NZYKrZAsrILBrkI6dwgiDWZvzaGQm180yD8e0cBTGRm3OEmAEJTxIXBwliLEIk
         r+VhzH/XIF6jHIMf6CN06gODcGB8pato43/vqHEpM0yIsbcPjNhkEPNddeHI8LBBqnqF
         8xmw==
X-Gm-Message-State: AO0yUKUGpTW2ln8RohysLxzaqCauEyB1ks6M1xlJAn1vLPW2gPmoEFJL
        kzPnKBNEBiuA4ow7f6n8msNeHVH8b7neebYF
X-Google-Smtp-Source: AK7set+6z9eBEGKg03h8IQixpSYJbs4tiE648YOGiKtYlUvk4BFgqIIG6GVn59NW8cnYxyNKGg1qtA==
X-Received: by 2002:a17:906:3a8f:b0:88f:a236:69e6 with SMTP id y15-20020a1709063a8f00b0088fa23669e6mr1131728ejd.7.1675724903921;
        Mon, 06 Feb 2023 15:08:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 15/19] grep.c: refactor free_grep_patterns()
Date:   Tue,  7 Feb 2023 00:07:50 +0100
Message-Id: <patch-v7-15.19-e2bf3245dd0-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

