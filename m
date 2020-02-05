Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC05C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 02:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155C72082E
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 02:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx7g7EgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgBECA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:00:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36372 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbgBECA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 21:00:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so498230otq.3
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 18:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5aWXohA1GAmMAconAqc2Btwcl+0u/uSnEpUg2lKkPTs=;
        b=Yx7g7EgX6pvRa+y6pBD6nxosx0h8jX9n7r/PiDVvGdjh60dnL+CxCD7pI38ga0YGUF
         bcfUscfb646yusYvwALhTwHsEvmQAsqQFA7YrJNZKF/qPTC3X2CiTbw7RiUTr4rMlu3E
         HjaWmjQYxo2twV8wtbWLmtNaCW7flA+eA5hNPtUWIm5raSSrwb2YDlTTctU7bxaN7HOg
         zoHypzzWwmwYnSnyy0CN9/0bOaxO0HvmXUDlL2boz8be6hljrjq+Wybemh1j5u2HHLk7
         J2mEHmO1Ym/CP/gXI1MSC+PqHWuayj+1Whic8fmQeB+lzn9iljX+2z4RTtkmWWDGTYM0
         lrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5aWXohA1GAmMAconAqc2Btwcl+0u/uSnEpUg2lKkPTs=;
        b=XsxdE5dLFKoTbpxCGNsg0rgYTp71lppf6aPsjNdwiSNIho2ZDwsSVrO3VUcy3IBvOi
         shu4PYD/LCwcRyl5ZPvAmBd9JMihZko90xUB5bbMikvyrubTJzE8mZsogvIuKK/Kx01n
         AKlT81qPDLj+aZuRJ8+4hEPoTYl1o26Cpp6FLm3TaeNpjN+ja7llaxj9KPIuF+F+qUQA
         mBCZY0gSivFzUY/2yI9FVZJjdE1W9MeOcpayYvzvbFeb955owvbpXMw26IQRuT5a/Vhw
         axl9/GYc820Rm8aG9jAf7I0CDjaZU+SpmaXCd0ZrVJ4BiI+aIFkTvOOFQ9ghHG9Wa+UB
         QUuA==
X-Gm-Message-State: APjAAAW7M3J+zy+Dt0WCzNsde2PGp5ozOX0DlYJ/oDvcOa72i8xylUrP
        30W7VU6gXLGhJbh0xNgVLGmfyg4gMqY=
X-Google-Smtp-Source: APXvYqwx8n6U9p/XYAdOeuUinq1MI7xZxm0kCHew1VaL/nQynIvczALmM1gA5R3Uver8hT40N+/GMg==
X-Received: by 2002:a9d:7c9a:: with SMTP id q26mr25338362otn.206.1580868026098;
        Tue, 04 Feb 2020 18:00:26 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k192sm6824324oib.55.2020.02.04.18.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 18:00:25 -0800 (PST)
Subject: Re: [PATCH 01/10] name-rev: rewrite create_or_update_name()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
 <b8f6a47e-1cbe-b2c7-cdde-ff2dc28af2b2@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f0e0ab6c-afde-307e-bbf0-823c576d67ca@gmail.com>
Date:   Tue, 4 Feb 2020 21:00:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <b8f6a47e-1cbe-b2c7-cdde-ff2dc28af2b2@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2020 4:14 PM, René Scharfe wrote:
> This code was moved straight out of name_rev(). As such, we inherited
> the "goto" to jump from an if into an else-if. We also inherited the
> fact that "nothing to do -- return NULL" is handled last.
> 
> Rewrite the function to first handle the "nothing to do" case. Then we
> can handle the conditional allocation early before going on to populate
> the struct. No need for goto-ing.

I read this carefully and agree it is functionally equivalent.

Since you are removing a goto and rearranging if/else blocks, I thought
this response needed to be explicit, at least more than usual. Good work.

Thanks,
-Stolee
