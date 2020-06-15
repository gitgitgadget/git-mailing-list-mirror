Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80EBC433E1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E6E2068E
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFHA5ixc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgFOK5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOK5r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 06:57:47 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58ADC05BD43
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:57:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l12so16887603ejn.10
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ys7JCnvFddE1wvDhlwniEryMIRtC7M06qJVLnlbHum0=;
        b=QFHA5ixcZ+5BmDZGVFpeeUdceQlPcEbnJGbFo3oro80mrI65IEVKUBJPS1Zq9BoB4x
         0L/FSkzZCQs9he1n2kUxuJoR49dC+0D19FjF5BoYBEG4iQvFVGlI4pb6FdUAXbRo/iVX
         +ZUcepkT0Aur+eSDmz1dG10TFQH/oV+puJBGbWPYTP0/Fxdt1PWRyT+rFGY8phLbgJYf
         x3PQLm12hg5KWF5f8QWSmtZNy27KMK3p3M+hxVIVk2CuuXlxFcdb+3RtBY610YhxIjME
         wyHBsHzzemCx7z64xn5vjrMRofvoOhhcOF3Us74kelq7LLlAe+W/gb+LH2Qv2RryfO6f
         sxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ys7JCnvFddE1wvDhlwniEryMIRtC7M06qJVLnlbHum0=;
        b=Tlyfc2NFC9rY5t23MMdISHGy2ewoNOfiemBaVw3q8MuCxspBjGBXbIlECfochL7ETn
         aoDGIl/Ft3YOuIQ35FI5GZcY7XbTICfAiDvTNd9JLvBfwURShQTnphBkeSA/TgUuDcFU
         Gp1MsptzqoCx6pRgOYE15VjPXKEmjKbH6TnvkNmXWQMtH8x+6bkGIxOm8wfYftSEHFmh
         SujWnQxDCioqxqz1zo6hjbIDtpHJOWsOadu4z2Xd1qgRzbUvDmIKVce+EGpn7ldxPdjm
         D8lJtiIq0t4Z+xBVq6u9rhKYEL3nlNhJqNutXfwqyEffD4qjw85S324hxiyR4HYJCEEO
         6VSw==
X-Gm-Message-State: AOAM53201SeuhJETmELJ2EJF2iKQtAin3b/Ofa8nzWap6H2A4Lm59rRS
        aKMy2bz6l0nUrLL2T+Tbfvmd81AR
X-Google-Smtp-Source: ABdhPJyw9/+Nu55o1X8quTvxa6EX2a4xSEDV2E8IEZx8/2oWX8DJIEDHw3ieZ8DM3xKTLtE6ePvbwg==
X-Received: by 2002:a17:906:8253:: with SMTP id f19mr25710240ejx.470.1592218665366;
        Mon, 15 Jun 2020 03:57:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y64sm8164484eda.33.2020.06.15.03.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 03:57:44 -0700 (PDT)
Message-Id: <1c01de3d79bfc9a971e1539b114ba27a89c4004d.1592218662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.658.git.1592218662.gitgitgadget@gmail.com>
References: <pull.658.git.1592218662.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 10:57:39 +0000
Subject: [PATCH 2/5] revision: add `use_ref_filter` in struct rev_info
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

Add a use_ref_filter flag in struct rev_info, to make it easier to
manipulate behavior at certain places according to the newly added
log.usereffilter config option.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 builtin/log.c | 1 +
 revision.h    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4eb13d1ef88..2634c520847 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -155,6 +155,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
 	rev->show_signature = default_show_signature;
+	rev->use_ref_filter = log_use_ref_filter;
 	rev->encode_email_headers = default_encode_email_headers;
 	rev->diffopt.flags.allow_textconv = 1;
 
diff --git a/revision.h b/revision.h
index 93491b79d47..8acf9b918bf 100644
--- a/revision.h
+++ b/revision.h
@@ -210,7 +210,8 @@ struct rev_info {
 			missing_newline:1,
 			date_mode_explicit:1,
 			preserve_subject:1,
-			encode_email_headers:1;
+			encode_email_headers:1,
+			use_ref_filter:1;
 	unsigned int	disable_stdin:1;
 	/* --show-linear-break */
 	unsigned int	track_linear:1,
-- 
gitgitgadget

