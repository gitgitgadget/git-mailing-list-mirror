Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393FDC2D0E0
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 07:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0462C21D43
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 07:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRIwpjPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgIHHR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgIHHRW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 03:17:22 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F916C061755
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 00:17:22 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so16028592ioo.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lkwjp7UPMKhHgzBK6XefuplR6y5wKQ/6ezJQMP9ZDc=;
        b=fRIwpjPiivZfcPyelEPlsc/DzRvcyXu8z0A0ww8zRCHa6yKUZpbXUcjYMXFJfQ9tb+
         rqt0CZHEKc/z0x70WO864Gk6+wOqnOsJ2FDAmPfwvmnQl59YNSOXfAtA+58OvFkcUBZL
         Hch4n574rp/gD3Af0OjiQ32yADlqMJeDwJS/3ImbEJJGUCl12sOYOdUv51IQEi3x7mrU
         m/OQcz0J++IhnkZqdDuzPEQkHCMYKkKHVQrBcwxltLwbV9m5QZXLfEHGn2IKABcX/Gum
         1U42pV4zUIZE9IY1cdoVi/+7P1PaLUc7EesBVQt5qcLcW1osuh4emPndJKuMcs3TOvjg
         sFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2lkwjp7UPMKhHgzBK6XefuplR6y5wKQ/6ezJQMP9ZDc=;
        b=FWZw6z2UW2Ea65gHLi+pGGswn6hTPhKNiHqJsTSpPBPao1qAF8I6etWJhPdroXlNsX
         4uBitupVqHAbVV5KSylYt/Tk7Uf6c68Wv/zG22a5sWYotrV8dLfwWuHbaBowoUgviPeO
         5IQGGAHbDxS3ZqCYlfcSQlj2IjfuGaV+vXgcpPVkUh0GZQSTY9lnMsnG6JC6tmbxPADj
         lPV369rGRJyo/d+ENkKOLVUqdmC4f36Z1uArJt2YVvpSIQ3rZBvvK/UlIigjD0wUe8OE
         xbpnA7aX9KUFgGxN7rXeH+icN82BAqQkFR8Ai4LJzz49hxw1VTDwutYw3a3RB6M27hhc
         HIhg==
X-Gm-Message-State: AOAM533hGF7LHuVM9PXvk/Dv5+9iX/EbGp/gxJEEo3A53kGP0wcO/4lo
        sABqxYggezteXY9xBGJSzKvrRd2+qTg=
X-Google-Smtp-Source: ABdhPJxai6FhCJTLi+U/Uu+05XoFvGJl0SE4HWpAUGlGT2dG+NTd62dsq1nCso6T9bkAzJZL71vCuw==
X-Received: by 2002:a5e:dc08:: with SMTP id b8mr19568611iok.13.1599549441263;
        Tue, 08 Sep 2020 00:17:21 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id m18sm9587778iln.80.2020.09.08.00.17.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 00:17:20 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] format-patch: use 'origin' as start of current-series-range when known
Date:   Tue,  8 Sep 2020 03:16:10 -0400
Message-Id: <20200908071610.16714-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <20200908071610.16714-1-sunshine@sunshineco.com>
References: <20200908071610.16714-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When formatting a patch series over `origin..HEAD`, one would expect
that range to be used as the current-series-range when computing a
range-diff between the previous and current versions of a patch series.
However, infer_range_diff_ranges() ignores `origin..HEAD` when
--range-diff=<prev> specifies a single revision rather than a range, and
instead unexpectedly computes the current-series-range based upon
<prev>. Address this anomaly by unconditionally using `origin..HEAD` as
the current-series-range regardless of <prev> as long as `origin` is
known, and only fall back to basing current-series-range on <prev> when
`origin` is not known.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    Suggested by Junio[1] during review.
    
    I had some difficulty composing the commit message and am not
    convinced that it does a good job of explaining the change or
    justifying it. If anyone can suggest improvements, I'd appreciate
    the help.
    
    I'm also not sure if this change deserves a test. If it does, it
    isn't clear to me exactly how to craft one. So, again, assistance
    would be appreciated.
    
    [1]: https://lore.kernel.org/git/xmqqva93t4u7.fsf@gitster-ct.c.googlers.com/

 builtin/log.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 37177b3e7f..f79b2b8775 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1595,16 +1595,20 @@ static void infer_range_diff_ranges(struct strbuf *r1,
 				    struct commit *head)
 {
 	const char *head_oid = oid_to_hex(&head->object.oid);
+	int prev_is_range = !!strstr(prev, "..");
 
-	if (!strstr(prev, "..")) {
+	if (prev_is_range)
+		strbuf_addstr(r1, prev);
+	else
 		strbuf_addf(r1, "%s..%s", head_oid, prev);
+
+	if (origin)
+		strbuf_addf(r2, "%s..%s", oid_to_hex(&origin->object.oid), head_oid);
+	else if (prev_is_range)
+		die(_("failed to infer range-diff origin of current series"));
+	else {
+		warning(_("using '%s' as range-diff origin of current series"), prev);
 		strbuf_addf(r2, "%s..%s", prev, head_oid);
-	} else if (!origin) {
-		die(_("failed to infer range-diff ranges"));
-	} else {
-		strbuf_addstr(r1, prev);
-		strbuf_addf(r2, "%s..%s",
-			    oid_to_hex(&origin->object.oid), head_oid);
 	}
 }
 
-- 
2.28.0.618.gf4bc123cb7

