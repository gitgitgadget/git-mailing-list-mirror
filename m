Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20711C2D0C0
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 20:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E488820748
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 20:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP9mRFxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfL2UPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 15:15:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33595 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfL2UPf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 15:15:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so31103184wrq.0
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 12:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ojTyYq0q/9PE8Fbaq2kwnG1roTyfK5i9cg7l9wQgCqU=;
        b=NP9mRFxzWuDMnLaCQofgyhYUkgy6a57fe5asQN6tHyiR5kw2FUmCZzDscfCL9/k0kT
         8ZE+OgtJiFMkpMuSISYt+VLyLnIh7Trstm3PxXKx/tJJhV01JfHSIMsIJpWJATtLx6gE
         zqMvC6WeanCSr3VtHaLqNa9l5Ra/bwNQrQdN7WZ1qCnY6eW/zHucoqhLxaYMveUuvKwK
         ip2GWL5jBplUNHPVQL9bFXC5X8a4GlWmc+luyV1aR2JM3+1xfvgS2GytlscSNWU+jGmq
         g5nIG9KqElCuh2vb1IZ9/sYbEOTYINpvWM6aZzPmIq4XPhznv7Kd9THf2T2bLZVfJGac
         afLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ojTyYq0q/9PE8Fbaq2kwnG1roTyfK5i9cg7l9wQgCqU=;
        b=kNRiUUvJkfUlBvgS8AOgXQ1LOer7q83HZrFTEBkTY6+O7lTZrowFBss3E+RJxaSuue
         EyQHVq1YrHT946d1HSv2lEsd6ojPhnApNYO/EybSXWp9IvtcovYACvFpgAqCsNtd/LZs
         C31047nFKKrpfoQh6sLpch1xJVPh942BvhBlzuMtg+1VqmI1Gi59piHJuEvZhpFei37b
         OJyl8B/GdFiPRbhcyUNzWimG8CknuKMnqD/HdENbcst/GegcXuvCZ0f6W8VBH51WhbEp
         JgaMQjh8iKIED6xfJ+e79ayNHPQVd3pgrIbZOAO1qjFY4S46pKGUIdK1gK8AG5XMBLDF
         939g==
X-Gm-Message-State: APjAAAXmhjwOoeXYoZlM92gbJ6m+bDC4x02HJWAGscp/A8n4u8dj1C1C
        kV0F/VaXJvxM7vRQ/i/Npv6K91VR
X-Google-Smtp-Source: APXvYqyXDvcaGdTxqVbBV0gxeYq0Aqc1SAv5huBH362OdzWqY0N0xsQwe6KdzFJUv9bjUjd0Wdl3/Q==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr60848725wrm.324.1577650533423;
        Sun, 29 Dec 2019 12:15:33 -0800 (PST)
Received: from [192.168.0.108] ([188.173.146.22])
        by smtp.gmail.com with ESMTPSA id t190sm18360020wmt.44.2019.12.29.12.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 12:15:32 -0800 (PST)
From:   =?UTF-8?Q?Zoli_Szab=c3=b3?= <zoli.szabo@gmail.com>
Subject: Re: Re: [PATCH 1/1] git-gui: add possibility to open currently
 selected file
To:     Junio C Hamano <gitster@pobox.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
References: <pull.499.git.1577386915.gitgitgadget@gmail.com>
 <fce80f1b95f83915076640ca0be01aa473744777.1577386915.git.gitgitgadget@gmail.com>
 <20191227193418.36uzeizs37nv7ywb@yadavpratyush.com>
 <xmqqy2uxiemt.fsf@gitster-ct.c.googlers.com>
Message-ID: <ee041086-3579-190d-e607-1973bcc94c23@gmail.com>
Date:   Sun, 29 Dec 2019 22:15:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <xmqqy2uxiemt.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2019.12.28 00:32, Junio C Hamano wrote:

> The phrasing on the title is a bit awkward.  "add possibility to do
> X" is better spelled "allow doing X", no?

Thank you, Junio, for the hint. Updated the commit message accordingly 
(PATCH v2).

