Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C60FC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 20:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6895B20707
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 20:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA2YmWI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfLEUXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:23:43 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36235 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfLEUXn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 15:23:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id k11so4817783qtm.3
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 12:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IgwygAx+OHINIGnl7dThycL3koqmbhZ5DfVFpW2jcw0=;
        b=iA2YmWI18jOUvpinYs0uOFmqFWG5Pz7XSf9cwRoDRx6Q+7PZmzsnkF7XhbvbrsC28d
         Hmg0oqvkkHGaWce68V/244IxEdWhOO3AybqoLrMrqO7LBxd4+irFqpvmNxoXLip/UkRv
         Xj+JPUhWmrlQIt2olRWf3N34xgo0mKiY3jbpUiD8lZd4rpYB3A+OiYsRkeBIUUL+FgxQ
         vUWc05E9bCNBb2lLOe9BtecdK3ULYB1O1c1ZwSdLmaXJUoSbOWj98IDt+1vJhARQFbup
         sW9Yi8weE0l50KPElWDi2Z6H034JJokdxbA2ucXdhgE5g4FPoymiMt9StkWSGrVRpbZn
         qqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IgwygAx+OHINIGnl7dThycL3koqmbhZ5DfVFpW2jcw0=;
        b=LQkL2uXdSj2/s5mzlvXamzkZD/tbRWofcxzAgID3f6sFykYgRevL/FRPeOEsmsBnj5
         fd6qWcp028WJSC7+2BCbd3Avncvaya3zNMoyyp42fbxWlN3Hlr3dSkE8yTm7ObOCFOXI
         PGp1qoDXVnDdX9u4CtaFCU101GxTZatkIuOBdEzJtYZO19LXNhazMQFesrbHAftm5fPr
         zSN470qGaJTH8mKLFTDPsbXzCMF0mUdg7cTyUCyv7M7/FA9Au5gEi7U66TWH+9RrDtqm
         M/+ulC9dsPkLYVxKrB+jciU4wO43XNmQurcEkSJcn87par49PJXLBEp9gd+zqX3R5N3b
         lbyA==
X-Gm-Message-State: APjAAAU4rvibT9bKZmaXJKxow5eXtCz2AjETPI7khVpr0cuAy71uHtUU
        vDUGGI4QsLVjYnD6zGba15ASZ29Pjao=
X-Google-Smtp-Source: APXvYqwKpNgFA9VeI6A/zulReKDuFl6yIOWTLGhpIzn97eRtr72T0M68ipPiVy1HciyRIBXRLMLyCw==
X-Received: by 2002:aed:212e:: with SMTP id 43mr9640593qtc.25.1575577421973;
        Thu, 05 Dec 2019 12:23:41 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id n198sm5202637qke.0.2019.12.05.12.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 12:23:41 -0800 (PST)
Subject: Re: [PATCH v4 08/11] git-p4: p4CmdList - support Unicode encoding
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <e1a424a955071414a634a703a85f1969f968bb0f.1575498578.git.gitgitgadget@gmail.com>
 <xmqqk17a27y5.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <e1df7518-07ae-4e24-7fc0-749c94c8a25c@gmail.com>
Date:   Thu, 5 Dec 2019 15:23:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqk17a27y5.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/5/2019 8:55 AM, Junio C Hamano wrote:
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Ben Keene <seraphire@gmail.com>
>>
>> The p4CmdList is a commonly used function in the git-p4 code. It is used to execute a command in P4 and return the results of the call in a list.
> Somewhere in the midway of the series, the log message starts using
> all-caps AS_STRING and AS_BYTES to describe some specific things,
> and it would help readers if the first one of these steps explain
> what they mean (I am guessing AS_STRING is an unicode object in both
> Python 2 and 3, and AS_BYTES is a plain vanilla string in Python 2,
> or something like that?).

I rewrote almost the entire commit message. Hopefully this will clarify 
the code.

>> Change this code to take a new optional parameter, encode_data that will optionally convert the data AS_STRING() that isto be returned by the function.
> s/isto/is to/;
>
> This sentence is a bit hard to read.
>
> This change does not make the function optionally convert the input
> we feed to the p4 command---it only changes the values in the
> command output.  But the readers cannot tell that easily until
> reading to the very end of the sentence, i.e. "returned by the
> function", as written.
>
> We probably want to be a bit more explicit to say what gets
> converted; perhaps renaming the parameter to encode_cmd_output may
> help.


I renamed the parameter as suggested.


>> Change the code so that the key will always be encoded AS_STRING()
> s/key/key of the returned hash/ or something to clarify what key you
> are talking about.
>
>> Data that is passed for standard input (stdin) should be AS_BYTES() to ensure unicode text that is supplied will be written out as bytes.
> "Data that is passed to the standard input stream of the p4 process"
> to clarify whose standard input you are talking about (iow, "git p4"
> also has and it may use its standard input, but this function does
> not muck with it).
>
