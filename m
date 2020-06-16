Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D3C433E2
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891CF21532
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocO5nSxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbgFPP7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbgFPPxb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 11:53:31 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8171C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 08:53:30 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id e16so15850075qtg.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EG528eK0ey47OXJwHGD/9/0zabqmu40SK1OQK4shTFI=;
        b=ocO5nSxRodYrEkoOyfqH5LrBcufGVUTS9be+/uJCgRA4AcAOOtFu4VLuEbQGb/jsOk
         XkRqvaadfRxr88j6GSKtj7cYs1sTF/4TvET1i6BPha8BP0NTwGwz4iqhyJuKbeBfen8O
         ivtBoKg0OXAQQTDaQu2Ax8eBxdob+xzRnQmscrNU2qAZ1c5ZglXPnyknrOcCmlBZyZNF
         RTY86j7HyDq2bQ4WN+mK58K2Kyu5RgD1Pn2puFEvc1WiNJq8meagu6tqArqJ2YIleuUY
         5KxvsdO4YA7eF06ca9hAI4CuUnqRGusb6Hoy6f51DFuwY2xq5sUsuneN1jD2XL0G2Sgu
         qJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EG528eK0ey47OXJwHGD/9/0zabqmu40SK1OQK4shTFI=;
        b=GP9okxC45FyM4kA2irS1+AsqRZCTwsIZJAfwJMrLuOl1ZpuldcP5sMlrNsVhD5+2wv
         tKE7uicL/RjOjPgRGt5UNCrrmGDI5DPkbqJzn+lcDf8k2EbDIAsTMzk1PLBgurzRlo/s
         muZw8atUO2xm2y52jFvpVLRG/EpDDfbtMj7TY9LliKj48eV99JjiUgt+s7LNvxipOH/J
         qE17yXV1MeDq8ToGfeFpjMc//iHXXCwvhV1wfpQSGVTOSO6BoyyTPZP3RpaePBTsS37K
         drZ5Jow9VcKfHKMdAAHonEjxeuPwA88xkWAoELoYC+4irPHRFoAeugFk4vyP1EM+V0qj
         CH1w==
X-Gm-Message-State: AOAM533Y5R0mldKt2L4JwjtsxxiUMsCpKavAGla9PfBpwDjbkBPWAvHI
        7dtPt+kjBd69ubK2EdA9nX/08T/Zcps=
X-Google-Smtp-Source: ABdhPJzFtXX8sMJmgrspGzFp9RKll14x7us9qS+21Cel/+cOoXSDybNQ+eI40mGIvyJd4/yl31H88w==
X-Received: by 2002:ac8:440b:: with SMTP id j11mr21500567qtn.134.1592322809657;
        Tue, 16 Jun 2020 08:53:29 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id g185sm14519555qke.122.2020.06.16.08.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 08:53:29 -0700 (PDT)
To:     konstantin@linuxfoundation.org
Cc:     ethanpet113@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
        simon@bocoup.com
References: <20200616125415.xnnxp5jnlkszorum@chatter.i7.local>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <84e99d71-ce9a-9762-60a0-18958eddc099@gmail.com>
Date:   Tue, 16 Jun 2020 12:53:26 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616125415.xnnxp5jnlkszorum@chatter.i7.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Why do you keep pivoting this around the setting that allows to change 
the default? The whole issue is changing the default from master to 
something else. You are being intellectually dishonest.

