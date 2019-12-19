Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE6AC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 16:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFDD2053B
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 16:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVr3AnvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLSQed (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:34:33 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44137 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSQed (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 11:34:33 -0500
Received: by mail-qv1-f67.google.com with SMTP id n8so2440639qvg.11
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 08:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iN8qSfnFU0fMk5nkbw4BvPdm7h5pZWx+7SnG/o63lWE=;
        b=jVr3AnvLoYQ33ZDvrCJXXxns8g89/WFkOz5ZIbwSesZlLtgHUZQ+jva17ypxJA8SbC
         q6hByhH2HZdQYAfmLDdgDxrKznQBHSkZgBufCLhRMboaY1kWWAdjnRLyM0A98jpZi/gQ
         Qb3W+oAT4B7bdPHPOZ+BEyNZSL9O606HxUTNuUWkNS6Zhl8DIEU6k1BP3Nf1iecau3GB
         lMBuS9ghRJabSEOjNKWbbPvuXMfZjJUIdGT+HguhKqlI4oT1WX9rbdTyqDtalV1htLxb
         3YJ5xKWz76cZFuwR7wXcEMcqAiALw+iLOD5oS7IZYF2DLAe7teN+I8D29D8nvX9Rvwxf
         RAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iN8qSfnFU0fMk5nkbw4BvPdm7h5pZWx+7SnG/o63lWE=;
        b=JFuqZNU0CSC2TsNVceLEaXdw+zeLkv4HXc6eZvYLNM6ZIExkZ4xT5YG5ARmvRyVUBT
         ZTJvOhfsvAL9HdebsLE7/MT+05dMSBD8svF4OwZoV9Z+PKoLWLree2+4177ypcapzJTi
         iLr20BaKp9phsVlu7N9LRS9VKMZo640iUBhd+VW1YYUnEwQw4VChczsZtAP+lG01tvjr
         zQx61jVrHOh5iulJECW4oruOsk2N8vLmizYjEFnx+v7E+NP3KPFTQE/GkQZfSHLrffNC
         SXBkPPmoU55HDUg6Rc9wm6kQYqvFXEYPwzNeKOITrSW3rrFovN7KRmWWNPZR2Qg4RkD+
         4pSA==
X-Gm-Message-State: APjAAAX98beTmkieKT+yJ2H7pZmHUKG3PPjPLHfksPmej746IQgJVTTW
        W3aKKJ9NQBgH2JTXWVg2zXc=
X-Google-Smtp-Source: APXvYqxswLX+aZ9hx9O9P8DX0BPGaPVgJsU6wXqP8qwVctjNTVa3EagYP7vPofLTXcn3D0fmvHgsqg==
X-Received: by 2002:ad4:580e:: with SMTP id dd14mr8500500qvb.84.1576773272257;
        Thu, 19 Dec 2019 08:34:32 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9531:dc6a:5092:36e0? ([2001:4898:a800:1012:4665:dc6a:5092:36e0])
        by smtp.gmail.com with ESMTPSA id r6sm1975744qtm.63.2019.12.19.08.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 08:34:31 -0800 (PST)
Subject: Re: [PATCH] sparse-checkout: improve OS ls compatibility
To:     Ed Maste <emaste@freebsd.org>
Cc:     Eric Wong <e@80x24.org>, git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <20191219015833.49314-1-emaste@FreeBSD.org>
 <20191219024518.GA3411@dcvr> <c4fef89a-2275-b4bc-b5c2-7bc647cd9bf6@gmail.com>
 <CAPyFy2AV2NG66LqBJr_Wb1_V5XhKnM+44m0H8FYa_3K4XupLow@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c68de4d3-c5b6-fc70-a233-9702e9552d94@gmail.com>
Date:   Thu, 19 Dec 2019 11:34:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <CAPyFy2AV2NG66LqBJr_Wb1_V5XhKnM+44m0H8FYa_3K4XupLow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19/2019 11:15 AM, Ed Maste wrote:
> On Thu, 19 Dec 2019 at 08:56, Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 12/18/2019 9:45 PM, Eric Wong wrote:
>>> This goes on top of your patch:
>> ...
>>> +     ( cd "$1" && for i in *; do echo "$i"; done )
>>
>> Could we drop the "cd" and "echo" processes with this line instead?
>>
>>         for i in "$1"/*; do printf "$i\n"; done
> 
> That would output repo/a, but we could do something like:
> for i in "$1"/*; do echo "${i#$1/}"; done
> 
> echo's a builtin on any /bin/sh I'm aware of - do you have a /bin/sh
> with builtin printf but not echo?

I guess I am misremembering the benefits of printf over echo. Carry
on with your approach.

Thanks,
-Stolee

