Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73322C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 10:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DFD60234
	for <git@archiver.kernel.org>; Wed, 19 May 2021 10:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245634AbhESKnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 06:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243621AbhESKnL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 06:43:11 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F1EC06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 03:41:51 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so11357295otp.4
        for <git@vger.kernel.org>; Wed, 19 May 2021 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=g5GIMRDimOL4CjYynCrs2lCH2HK/K42VElakvp16hKc=;
        b=TGJr8dhhfhmNkZrxxg+PVo3VqrO/LUKnR8+yxZp0BdwppjMEHIsSP/Sy9HWPTs6hUu
         zDXxlHg2oC10iprbNOLxmm4KScqLughTyZ8IxiDMQYW0RnlL02+wV2AKNNmvnUJla8ro
         V7x/JRyckj+s/+nxf+4py64uHnCp6EHuvJJTzg+ljO4r6zEJ9grUN+ESIJPeAnkSGV+l
         RQYvFECNo79kWeBxSn9t/yZ6HaSzobXfDT2SNfLkCJKAOj528TGTmLRMfu4WWDhVEN5O
         DjsAAQ8PHEE1/skeM7H55RA5jBudk2odv2eoG7XmXceGEny/RNzpRLZAFMcHXnQcKrlQ
         fDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=g5GIMRDimOL4CjYynCrs2lCH2HK/K42VElakvp16hKc=;
        b=AGG3LN7Ngromn+avhk3Fjs9/NRDilapCIvwPIq7jkEsunhkES03MoI5ymYQVP+s39s
         W+O5+lQIX3LIHGUL6s82d6+tJ1Vnw0kj5I/+d6GQs+WK4XsF1KRLo2UsDWcVqXjJixrt
         16aGSBcdAWZBEsMAE97WR4AeL+hCt3axmP9OAJWdzGYsepjqyiG38k3XdyO4tFdvfumE
         iL9zZvGCz/N9JlKG1MNR+EshratE5FgmldFhOCI5d9Y9pCCTd2CLene3wRXL7gPaHs5/
         hLwrXKayhpzq0pRGxtsAEPYoVLPkNJf0x0SWQyNC7SolsKtjUrqVCe8Wsl8Bb5EnHFUU
         jqog==
X-Gm-Message-State: AOAM530TArzXx1aBQLKG8MR07W1AxqKGszMVMgSgLz/PVIiUq2BKCJe4
        eY1jvh4eTiCgRux6gEEKYVD1zEHT+kGJbg==
X-Google-Smtp-Source: ABdhPJx3Y3dIHBmw/zRypkG7tgKnMCKngQweCHiWjUhFTFDUejUgo7Vo+MriUYSO8I5Vwtks7VHIiw==
X-Received: by 2002:a9d:6081:: with SMTP id m1mr8557234otj.226.1621420911014;
        Wed, 19 May 2021 03:41:51 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x65sm4385471otb.59.2021.05.19.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 03:41:50 -0700 (PDT)
Date:   Wed, 19 May 2021 05:41:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60a4eb6d58c05_86a8208af@natae.notmuch>
In-Reply-To: <YKTXlTjwOUi4W+R8@coredump.intra.peff.net>
References: <YKTXlTjwOUi4W+R8@coredump.intra.peff.net>
Subject: RE: [PATCH] doc: explain the use of color.pager
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
> index d5daacb13a..e05d520a86 100644
> --- a/Documentation/config/color.txt
> +++ b/Documentation/config/color.txt
> @@ -127,8 +127,9 @@ color.interactive.<slot>::
>  	interactive commands.
>  
>  color.pager::
> -	A boolean to enable/disable colored output when the pager is in
> -	use (default is true).
> +	A boolean to specify whether `auto` color modes should colorize
> +	output going to the pager. Defaults to true; set this to false
> +	if your pager does not understand ANSI color codes.

This sounds correct to me, short, and complete. I like it.

Acked-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
