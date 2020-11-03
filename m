Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D94CC2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 13:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F9A2224E
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 13:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpCmlYPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgKCN5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 08:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbgKCN5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 08:57:18 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F20C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 05:57:18 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so11561888qte.11
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 05:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lGIkjWwoAI3A8/9Gu1I6sRJPl4GGJDN9cnb379ZeEUo=;
        b=SpCmlYPsdrlacoy/WctvUGvXtJlmFtmBjJAdnv1FYp5Q57pXJ6a5J+rl6py06W3i7a
         ebojGabiUlxKg7t5QI80lmrLGkr+nosmSHnkXuBMPh/866c3YRz1vMAuS/9MA2FzVSt6
         2nTNOFrK2Zkl6LnGT8BXc0XVQ5yLTHqgXkW7aTH7286f4S3IKcI19s91FxEUr/u9u978
         OxpMlKgGuHMaUK5dX4xUX1cyASy4UCfZiXxH8++lwnHVpMmdR9iuqS7DiGrNWYp00L76
         eDTZTvSAOj9WbP3VqDhKWqyykysiWbCtwaXyV/R57uswEKeIXaytpQJrxy/ZDK5RcaCk
         i/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lGIkjWwoAI3A8/9Gu1I6sRJPl4GGJDN9cnb379ZeEUo=;
        b=exEybKr/VAzGiSK5At/jvoQxZZmU91DKJphEzsZyhk1fONiiIfJc2dOs1kcMFA6YPx
         GWwxlbUbnXetvSOuc4v1Bn2gj8YD6LQsTf/T2RMZYDGDBHjOD9rrZ14+gx80BDlpOh6h
         ZYG3qYwsyfT4bnjGFbdYpF4ys2CBqBI70ba6PN0xX7z0irn9Py1b+mCCfhqtSvAFRLPA
         39qVr847J0gMGgwvy4h9uUW0SMYnJpmv/0sa4GIMM3ZGTyX7k7bsE+UmUFeJZft++fYE
         RkDNOIsB4AP9MmVw5c6xB3FMnOZWtqIOSuLreCNPtEGhGxpGpN5v04/FJDiHHXzuXKlz
         wrmA==
X-Gm-Message-State: AOAM530G4o2nvsflQzGJ0I22NX/AYRP6MtYrRXzyox4teympLiSEbBjy
        Aor8KcZJ5i+uT+tH0FcpCUNGPqCRXUM1xg==
X-Google-Smtp-Source: ABdhPJzwlypzRifyLoqIlnAxso0/TpzpQNejdjg7/NKxKnwmtBEt3hFCcGu3Hupc+gddmqDxt3nT5Q==
X-Received: by 2002:a05:622a:347:: with SMTP id r7mr18599934qtw.335.1604411836946;
        Tue, 03 Nov 2020 05:57:16 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id q3sm10437475qkf.24.2020.11.03.05.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 05:57:16 -0800 (PST)
Subject: Re: [PATCH 2/4] push: teach --base for ssh:// and file://
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1604362701.git.jonathantanmy@google.com>
 <148e39960a2185d2355cdfe34f8856e708fb1b80.1604362701.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1ccd47dc-0470-39de-b26e-5e2f896bb0fe@gmail.com>
Date:   Tue, 3 Nov 2020 08:57:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <148e39960a2185d2355cdfe34f8856e708fb1b80.1604362701.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 7:26 PM, Jonathan Tan wrote:
> For the ssh:// and file:// transports, teach push the "--base"
> parameter, which indicates an ancestor of the commits to be pushed that
> is believed to be known by the server.

Looking at this patch, I don't see any reason why this couldn't be
a multi-valued parameter that populates a string_list on the client
and the server translates into a list of object_ids. Converting from
the current single-base model to a multiple-base model would probably
be just as big of a patch as this one, so perhaps jump straight to
that capability instead of pausing at the single-base model here?

Thanks,
-Stolee
