Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CF4C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB4061428
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhEMGgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 02:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhEMGgE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 02:36:04 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8869C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:34:54 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n184so24440511oia.12
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=sxnH8WIrz0uGP83O/X4IGFMCO+O4qBxGTDn3Woa1XSQ=;
        b=MP4fLjCWSHUAQbzMjSHa6ViO7D8Z9il7zIukp9HWl6/a/yIG1x40B2CLAaQVLYcpSW
         hZhywV0w6JJaHuo+3mB28BC00nJuvyEDI6cPxStAoyq2aELbf/EQ91jPToXbjKcNAiKW
         Tzjn04AZdqQfAlQJGRRGWVJA8yw7HSVMob43YenYw95bS3oy4PB2klMcjSjF2P9f5xLf
         3XBxMpSntBxJd+n4fQWygVW7U4mb7/L7fTPzstNzM5jmTm79atJFc7mL8r0tZL6FkJ1U
         U8KHUcjomsxwMp/rcqPU/p+9TQtj5oP+W+MxlAmubYH9BjdzSq3DzOOBjf07pTM9GvGt
         5+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=sxnH8WIrz0uGP83O/X4IGFMCO+O4qBxGTDn3Woa1XSQ=;
        b=F8zlT4tw/IoUCdMjAtZlzFS46Ktlou9OWC/tv+KwXoK5d2p6ZYd31vEfsuqkOUa5Ey
         3bWGDuWaS82zL1lE/b4W/f2WPWcBYsQqa6trQtSFdyy3qTKv8i8gKweVGmKw2wV2APPI
         Nt8KYml2mbQ71jDRn00d0WBK/kpd0DDA4UBMBhU6uFGxJBvs8TUjUUvYc7XsnAMYNBeN
         OzeJBtSOWfOKhokLMpf0MqOiGgeZRT0zRnPFmor/OTaWGscRTHOA6XhtNyh0/SHSoQPU
         DILcSkYBTxy+hC3l5ZSBLWfVP9Ig2nrXceyNgv4Dh5b9NJOC+7nDrvR5zl8vx4URGdc2
         5QAA==
X-Gm-Message-State: AOAM530SFMPDau9j4vjp7onSrSiwFbNDl1qgGoX+3UvDhfvMhHFyd0Oh
        xpDSKjESOstc1bazpljVn8c=
X-Google-Smtp-Source: ABdhPJwWWozIew2sJ5CYSMkuwm7/reVxY1bHltSorydg/sp+lC/eHO6Vk+udyVgLEdcBIIt/zqE/mQ==
X-Received: by 2002:aca:3ec6:: with SMTP id l189mr28715885oia.8.1620887694010;
        Wed, 12 May 2021 23:34:54 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 88sm473613ott.51.2021.05.12.23.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 23:34:53 -0700 (PDT)
Date:   Thu, 13 May 2021 01:34:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, felipe.contreras@gmail.com,
        gitster@pobox.com, stefanmoch@mail.de, philipoak@iee.email,
        bagasdotme@gmail.com, sunshine@sunshineco.com, avarab@gmail.com
Message-ID: <609cc88947e4a_329320899@natae.notmuch>
In-Reply-To: <20210512233412.10737-1-dwh@linuxprogrammer.org>
References: <20210512031821.6498-2-dwh@linuxprogrammer.org>
 <20210512233412.10737-1-dwh@linuxprogrammer.org>
Subject: RE: [PATCH v3] doc: writing down Git mailing list etiquette
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby wrote:
> +[[proper-use-of-to-and-cc]]
> +== Proper Use of To and Cc

Always make sure the mailing list is included.

...

> +[[proper-use-of-subject]]
> +== Proper Use of the Subject

...

I think this is more importan than the point above.

> +[[use-interleaved-style]]
> +== Use Interleaved Style in Replies
> +
> +> A: Because it messes up the order in which people normally read text.
> +> Q: Why is top-posting such a bad thing?
> +> A: Top-posting.
> +> Q: What is the most annoying thing in email?

You need to explain this is top-posting, and it's an example of what not
to do.

...

> +[[do-not-use-mail-followup-to]]
> +== Do Not Use Mail-Followup-To

...

This should be the last point.

> +[[enable-plain-text-mode]]
> +== Enable Plain Text Mode
> +
> +The Git mailing list software rejects email sent in text/html format. It is
> +important that your email client is set to create text/plain emails to ensure
> +delivery.

This is more important than other points.

IMO the order should be:

 1. Enable plain-text mode
 2. Proper use of subject
 3. Use interleaved-style
 4. Proper use of To/Cc
 5. Do not use mail-followup-to

> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -433,7 +433,7 @@ help you find out who they are.

...

> +[[patches-that-receive-no-response]]
> +== Patches that Receive No Response

I would put this in a separate patch.

Cheers.

-- 
Felipe Contreras
