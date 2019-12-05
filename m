Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7B3C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 20:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BB624670
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 20:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA4z4QR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfLEUrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:47:12 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42628 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbfLEUrM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 15:47:12 -0500
Received: by mail-qv1-f67.google.com with SMTP id q19so1832167qvy.9
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 12:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hPktZcw4AZZ5vBAulq29p+69TCHUFaMX6BViYQUEyLs=;
        b=BA4z4QR/HCDFhoszYU1jZxrX7KkcxESmSux2IGQ1SK4d80VKzhPUC99Oo9fr/ubG+8
         PnqyKYmxKMSC17vrx9cAUmYhF2fzX7tb79ZK5NR2S2rIoBEDtNPtjokipMZErj6Aet4m
         ZHVXbYoV+XNQrcaoC9oliJ7NUgE5DZRJkakUqd+5r9trwnB3rIG2EvBy9yhR+vZiTdNK
         0sfuOmMk2fiHni+jadXdP7rtSNlzR2FtSnfq4FLzwk/iqAqMX3Q79HKXahCZ4aE3HOoz
         P9tHsLmScIqhQsTZTJGjjQ2CD8dCvfAL8zdmSnstMgL2iPXkCdYCKHvVbitffOSExrfp
         zUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hPktZcw4AZZ5vBAulq29p+69TCHUFaMX6BViYQUEyLs=;
        b=WpBy3O7qOO2AGCzwOD7l3nOaVw9/UK+Xd5Ktlyl8ftYNLJLIY8zY0dupoYABzrr5Uc
         qmFPFdEKnlkmjMcvE1UuHi64aZNcOVImKcBPyGL/jAp8gQ2xw+Hs9CuEV1kEk7+8F/7j
         DtbW7EvgOxee4fEZU2f9e7EDizefi9ht9zJFCx2PESMtQbcOf/L8o73hUlKatTk7BRW9
         rGczScOGZ4WaQ6Tle3M+/eImFAfVaFSZKrju1lxza2hahI71ukzRtKAN/tiA1Sb3l7yN
         SEUdMrMAZUhjfuoXIX6vfpvIVJ9aWbjBTan5k4KxJSyZ66Vw/vTKCHLgBeqLPHCodp2H
         3jpA==
X-Gm-Message-State: APjAAAVlqfUk7iZynCx3WRNJtEPbU7pnyPnIF2l/fAnhJ1+mPJagp2Le
        8mInXZ1EsfIFBZfy+F3ZrfE=
X-Google-Smtp-Source: APXvYqw8J/QQ//+iVlVjIKCZcyBoVLyHmKGzxj3syyC0B/p1RIm1zMh7hNfrFx1U1WNYBUdtvIoOYA==
X-Received: by 2002:a0c:8c0f:: with SMTP id n15mr7934205qvb.218.1575578830940;
        Thu, 05 Dec 2019 12:47:10 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id n198sm5221886qke.0.2019.12.05.12.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 12:47:10 -0800 (PST)
Subject: Re: [PATCH v4 00/11] git-p4.py: Cast byte strings to unicode strings
 in python3
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <CAE5ih7-6EbEM4z5BtY87=82H_tLypiOPq4WY5mm3190QExTZWQ@mail.gmail.com>
 <be2a6839-aa73-dbf8-de19-823d3ae5265a@gmail.com>
 <20191205185138.GA85549@generichostname>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <4dca4aaf-4fe5-974a-bab0-67f75896d8ab@gmail.com>
Date:   Thu, 5 Dec 2019 15:47:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205185138.GA85549@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/5/2019 1:51 PM, Denton Liu wrote:
> On Thu, Dec 05, 2019 at 11:16:27AM -0500, Ben Keene wrote:
>> On 12/5/2019 4:54 AM, Luke Diamand wrote:
>>> On Wed, 4 Dec 2019 at 22:29, Ben Keene via GitGitGadget
>>> - There are some bits of trailing whitespace around - can you strip
>>> those out? You can use "git diff --check".
>>
>> Is there a way that I can find out which branches I need to remove white
>> space from now that they have been committed?
> I'm assuming you mean commits? You can run
>
> 	git log --check master..
>
> and git will highlight the whitespace errors.
Yes, that's exactly what I meant.  Thank you.
