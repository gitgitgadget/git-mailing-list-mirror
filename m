Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D01C48BE0
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB7F613F1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhFJNUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhFJNUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:20:16 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6926AC0617A6
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 06:18:11 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id h9so2077463oih.4
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 06:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=lScrQQ7rYQUunJaHSfDin3cGmG6Y+fRgB4dT7Upxe8g=;
        b=cFdF4UZOtwd7uf5uYhSwn6GoO1k90lA0+AZ28PhMoquplwtjSIFhudfIL6iFgX0TUh
         QDL7LVjEFBlb2MLlv9L8M27PrxE9XrUkOCJEWX4XTnq8dcuMiBdwpkv5MpkDzXM9IF27
         HcZC5CgCdWCt6imifnNoadzxDke1ft/d+S28qrRQnWWyIIO9k2uvOcox4FiCikzHLY+c
         aoVjypw5HixPfr8+yMgDlSN8F4za04VIuA2YVTGlIuFYMhUNrU6On4FYrSZSdisKIQb5
         pMWJPkxBCEXmvtqjLxGHh7Hpp8uDuqcIPdrqr/fDYKT5GAE6qY+QKAX8S3jT/21albNl
         ScbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=lScrQQ7rYQUunJaHSfDin3cGmG6Y+fRgB4dT7Upxe8g=;
        b=A/2WpP8lfoM/1E8iqT+r+wxADNDBl8dbSf2a3iA++JU2h1BzYVAHsZhNX5gFNZoP1t
         fMF1ggCFzIN75Q4SK5S13i6a7SqUj0wk7Bx911AD7khi9iSwrtV9BvSo9dv2tjYzkgZG
         ieukguFi7irV/xrYH4uhqIgeN0uWEG2W1XDr5gKKzkn/bzuwfFrbvqKDRWKRJrQQitDJ
         DzNNVTBC1Ra0RIHN3Et8azqy2xOjdWc2yM8eBvSTJTS8lP7mDRV5s/Dqw30i7cUFDw+5
         +ctr6JmCnudg03zS4kKDCHFx+d5MeJsCFwG2NttSzN+e1fPRIqTGr7qutyGR9ZJ8QKay
         Re8w==
X-Gm-Message-State: AOAM530k3q+BLnR7wpA6MoG5bKMQ/9gT1Xdpy/I9ap7NjY5T5W3hR/oR
        mPViUcZEMv4VnboRNP3XPcQ=
X-Google-Smtp-Source: ABdhPJyP+k8f5RMPdEoZo+PKDXdwy5oT+HuulkeIxpKeTFqRuwpIA0vr8T5e7oqmJmYe8fJr94UvWw==
X-Received: by 2002:a54:4e10:: with SMTP id a16mr10496989oiy.48.1623331090225;
        Thu, 10 Jun 2021 06:18:10 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id t1sm115558otm.72.2021.06.10.06.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 06:18:09 -0700 (PDT)
Date:   Thu, 10 Jun 2021 08:18:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Message-ID: <60c21110a2e68_b25b12085a@natae.notmuch>
In-Reply-To: <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:
> Am 09.06.21 um 21:28 schrieb Felipe Contreras:
> > Virtually everyone is using it, and it's one of the first things we
> > teach newcomers in order to resolve conflicts efficiently.
> > 
> > Let's make it the default.
> 
> I tested diff3 style the VERY FIRST TIME the other day and was greated
> with the below. Needless to say that this change is a no-go from my POV.

"I found a bug" is not a valid reason not to do approach X.

The bug gets fixed and the approach continues.

Cheers.

-- 
Felipe Contreras
