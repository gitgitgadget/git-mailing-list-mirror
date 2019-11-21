Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1336DC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 15:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3552068E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 15:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsVl4ksm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKUPpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:45:47 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:45350 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUPpr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 10:45:47 -0500
Received: by mail-pf1-f175.google.com with SMTP id z4so1861156pfn.12
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 07:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RJzS/Jfys81i7iy/bZt+syH20m1WHqhmLfSN/WyiSDA=;
        b=OsVl4ksmUYQvsG3GpIOZe1L7zx1dZbGkV3gLgEoHmetr7No/jE7/1e3T1FPD6PSK5L
         c39e5LUQi9BvZk8ZUOF/EUFvWD4YGleqTk5Wg+bzjKz7WJ+c6HYhXIuSCEDG9b3g8G0C
         Q5D9L+BrLSZg5+QtqssFpyEtlKZOfoxLTXBwaxUolJsY+S0Hay/M0NkTuRADp4Wn6Foz
         +d+hA43q7/irAtt+DHtekYtVyY3gMVe2J9/NlmarfJBISEfXL6TjLUuTOi0yN0oGCFuR
         KBiTDbbshaZiOjnbJrZJz15C82ATiZYKtl/JLJiOmi/+TnV/FPs1/TrtidVQzcXq140R
         C1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RJzS/Jfys81i7iy/bZt+syH20m1WHqhmLfSN/WyiSDA=;
        b=BFVYq17nUWwNNbMeYjBrxTti4t0dxEXb3Z9KQeqxoLR2YwCBeCV8O7mwk0klxeMs3R
         Y98oSloGxO2/nqW0tn9ZqxOf1QA1xLbw/PeYxn/lJnLt2F0SSLAUPl4x+aBxfqkesWwy
         cTWoSibuLRwf+YQtB7bqIaCILHYmJXASwM/a6V1X222xwyjMN92vHsznbCcD89eFZBos
         bSckc3PJJ+QXXi1PZvK+2aNWoaDiUe7o62Oyh8vlxJtOsrwHsuCvyJpyMSpU65uQ5eK7
         /V1aytTmfFUqVE7u3f9SF/t2WgdsjlupkCJ6SDiu6gxBSewdRTzzeqPGRK8pQrqm5kp+
         qp9g==
X-Gm-Message-State: APjAAAVFs+la3k09hQzevy2ZCouWBIfE48je9d95sSKgdT2hojQ0WKM7
        +BoPkN2T9b1fPpzF6NrC/nw=
X-Google-Smtp-Source: APXvYqzM+Sj/j8R0mWNPFqstrJRLSEg6gTwYWtTNCxeU2LACShy9NXAljuue+HoIEJIqw+ix+SpV1g==
X-Received: by 2002:a65:678a:: with SMTP id e10mr10262063pgr.258.1574351146769;
        Thu, 21 Nov 2019 07:45:46 -0800 (PST)
Received: from [128.18.14.225] ([128.18.241.12])
        by smtp.gmail.com with ESMTPSA id i2sm3600308pgt.34.2019.11.21.07.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:45:46 -0800 (PST)
Subject: Re: GitAttributes feature export-ignore works, but -export-ignore
 (with dash) should also work
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, picevio <picevio@gmail.com>
References: <01e0a4ab-d809-d968-5671-b731438c2bc4@gmail.com>
 <20191121075837.GA30966@sigill.intra.peff.net>
From:   M Lewis <picevio@gmail.com>
Message-ID: <1e9e3272-f97b-9944-817f-778deec2e65c@gmail.com>
Date:   Thu, 21 Nov 2019 07:45:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191121075837.GA30966@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff,

Thank you for taking this on. I tried your suggestion copied below. The 
'needed_a' (and _b) directories appear in the archive but unfortunately 
they are empty. We need the contents of the directories in the archive.

On 11/20/2019 11:58 PM, Jeff King wrote:
> Instead, if you write it like this:
>
>    /mostly_unuseful/**        export-ignore
>    /mostly_unuseful/needed_a -export-ignore
>    /mostly_unuseful/needed_b -export-ignore
>
> ... And given that there's already a
> solution using `**`, it might not be worth it.
>
