Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B6AC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DA5207CD
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APTSIlSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHUVGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgHUVGU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:06:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA0C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:06:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so3137588wrl.4
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=77R6AbXmTWZ77DHsAKLZQxMyUU7oRKoPASjgKoSLD3A=;
        b=APTSIlShcXv1jDIh3btZlBF4xK4dDK8ew7iAE09ElFBFjJukD40lQFPSfFYZ4RYKRS
         qy3eMAf8yGGHaGZqBtniGDrdwQmloSEdn3w8jN+cHjo8nsjVEOHzajIQzwAzanA4i1+W
         vGYwezA68SZA7btCWoSNyRsgr/jn1bqbYIBGrQcCAkuoEV31JnaWbqYaTNxdOCutoyw/
         DDUcUHP/hJqnPt1FrEWJ8heNv8VIFTozYeSH9AWLBMwbFWKRmRIENLsxO4u8BRcaeFbO
         31ujj5s2BVFMJZvlVyK6dS9A63qtg0bidQDf2D62KxYwMMSF+lJAVtDPWgfI2awP14mQ
         00hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=77R6AbXmTWZ77DHsAKLZQxMyUU7oRKoPASjgKoSLD3A=;
        b=FiDYFkxm3nP5+KNRssrgsW3wLH9EkTCtwS/p53eVfDUKZwUo+OVM73zruQByw9h00p
         Z3kjcbsuKjAQj68Yg7WKmCs0hUJHjgmSUDO9F6hNLn/+pXEoIrEM+ynRuKKaN2TDB/p8
         4ieGqbR9Zj0ixWI1e3PvOrGxN/kO0+VtLB1la5tbOaS6qPjtz6bYh0EWdyzhAqE4EPTZ
         O13fUinfR2GzSH8z0IcicpI/iULKgpk64z4W+LC17xBSJ3Hye9U9OKydxDAlrk5F1d5O
         K9qdCRjDTh+k1O17YHpGbnsKOaT+XHaBZ5xTzitheia+YqmtJFOvAxdezjibhRTj2KUr
         CPww==
X-Gm-Message-State: AOAM531NiJc0F3gIiGQUrxBZxGGi5ova3XvJR7zvIcifL1f+SLLDB3DV
        KuF1b+EnjJlXYkWplFZs/KfaEK+CTDU=
X-Google-Smtp-Source: ABdhPJznPevUipy1rPG/mWqnFZjCv8MC2kF16l6szyUBdTfg+NpK/TZbUO6wJXszbfU0T+xI5CkTwA==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr4107887wre.286.1598043978952;
        Fri, 21 Aug 2020 14:06:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g70sm8861976wmg.24.2020.08.21.14.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:06:18 -0700 (PDT)
Message-Id: <659b9835dcd0b38ac3972eb19c08c3bf26dccc80.1598043976.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.707.v3.git.1598043976.gitgitgadget@gmail.com>
References: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
        <pull.707.v3.git.1598043976.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:06:14 +0000
Subject: [PATCH v3 2/4] ref-filter: 'contents:trailers' show error if `:` is
 missing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

The 'contents' atom does not show any error if used with 'trailers'
atom and colon is missing before trailers arguments.

e.g %(contents:trailersonly) works, while it shouldn't.

It is definitely not an expected behavior.

Let's fix this bug.

Acked-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c            | 8 +++++---
 t/t6300-for-each-ref.sh | 8 ++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ba85869755..8ba0e31915 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -345,9 +345,11 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
 		atom->u.contents.option = C_SUB;
-	else if (skip_prefix(arg, "trailers", &arg)) {
-		skip_prefix(arg, ":", &arg);
-		if (trailers_atom_parser(format, atom, *arg ? arg : NULL, err))
+	else if (!strcmp(arg, "trailers")) {
+		if (trailers_atom_parser(format, atom, NULL, err))
+			return -1;
+	} else if (skip_prefix(arg, "trailers:", &arg)) {
+		if (trailers_atom_parser(format, atom, arg, err))
 			return -1;
 	} else if (skip_prefix(arg, "lines=", &arg)) {
 		atom->u.contents.option = C_LINES;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0570380344..fdf2c442c5 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -823,6 +823,14 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'if arguments, %(contents:trailers) shows error if semicolon is missing' '
+	cat >expect <<-EOF &&
+	fatal: unrecognized %(contents) argument: trailersonly
+	EOF
+	test_must_fail git for-each-ref --format="%(contents:trailersonly)" 2>actual &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
-- 
gitgitgadget

