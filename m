Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3FBC2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 16:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BB6206F0
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 16:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYASUpSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgA2Qbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:31:43 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38082 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgA2Qbn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 11:31:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id c24so13684740qtp.5
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 08:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wrGJG9vflx0/lUOFjy+3nN9qWFhDmkWl81KGn8GZaqQ=;
        b=iYASUpShTTVGX1GTzFieXjokiHfKWwqGyCi0qmjioXsFdeCzmmnke1PuHVsd91jIVH
         iju/2Zymv/X1MiVuuLabPU9qZeIlyLhfIRwrqHO5vrMporcu9NYcg5G5Kkrtmtqtnk9k
         fvwS3SN2qDPgrifvGdnW7J1ErR/8ok3m8IFjcC8iiCHtMMC7K3OV5BTSm2RXlYHuHVNw
         I+sSs9dN6z0vOTV24Q0TvOepTjmg3TnhR3i5NJFSXsnhkAB/b+YgvnakD8pOzux9g1S7
         TH59Mz71JyQqypkr9/WyFkRfvqbykz/JfZ8yOw+xHom7paqhA4+axCuYJrhaj2a/rilG
         BP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wrGJG9vflx0/lUOFjy+3nN9qWFhDmkWl81KGn8GZaqQ=;
        b=JYtzosfoHg+SuSnEyOtAgp7nUxE+MdI3fVp7gRVW9Sp8fcMPNnJeqj6FUoGp4ganTa
         20UWkGxtqjQP1ZLJFL/0j/N5SGZ0eNE3hLLIWhQrwb3lvN3d7NJvNxsq5bUNZP7fw6r9
         vZAowOno2HhE/ZUaT3aELpDdb30M2ZpQFuBSB+0wrDFjySugK0vWBIwn3WUI9jjf5CEo
         NOYqbQEHKhbeJg/ZQpacl0xwbsHth4aJGSt5TAqZbGrJAq8xNlrpHsu9fl2yVEZ1x/5W
         v5/7WFG4k2jeTi/rD/GyWeHhABhlfQA/ZZyrqTQ9KwTDxGB58eJa0ebecfT6DyhisGae
         ovMw==
X-Gm-Message-State: APjAAAWEBQeWD6c9eEy//feAcMddjm45z8ZVJQKA+uZFxNLH8iUEEU+D
        jvPqU2u0fPsk+Ily72uEaPvRlx2aOwo=
X-Google-Smtp-Source: APXvYqywyOLLXdu8urSc4S8vd1P0+PvtSvyhoLuOJnGq1U8QP4YsCdvDC0ChfwJg8pQqPoTwjf9InQ==
X-Received: by 2002:aed:2a86:: with SMTP id t6mr1218660qtd.81.1580315501378;
        Wed, 29 Jan 2020 08:31:41 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:90b6:a0a:46b8:addb? ([2001:4898:a800:1010:41ec:a0a:46b8:addb])
        by smtp.gmail.com with ESMTPSA id 135sm1209193qkj.55.2020.01.29.08.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 08:31:40 -0800 (PST)
Subject: Re: Sparse Checkout Trouble (2.5.0)
From:   Derrick Stolee <stolee@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        JunkYardMail1 <JunkYardMail1@frontier.com>,
        Git Mailing List <git@vger.kernel.org>
References: <062301d5d0bc$c3e17760$4ba46620$@Frontier.com>
 <d4056731-c13b-c89d-dfd2-e6235e29fed6@gmail.com>
 <405d83bd-cd50-49c5-a068-6d3ce102f669@gmail.com>
 <CABPp-BFB3pN1arWb9Acj7La1aX7j=axANnSWV8f7SmW_KuqD0g@mail.gmail.com>
 <de300697-baba-62a6-ea4c-c5bd472954c2@gmail.com>
 <CABPp-BHRAA71LmfYb61N+qAgwhtii7TSEVJksiAGnnO-4bk2dQ@mail.gmail.com>
 <e4bb20e9-ad90-3e9b-7ed2-c7793cb8cb22@gmail.com>
 <nycvar.QRO.7.76.6.2001291626550.46@tvgsbejvaqbjf.bet>
 <60b34188-d05d-6753-7116-a34793592227@gmail.com>
Message-ID: <a180c7a5-2406-0384-9355-be9db05a16fd@gmail.com>
Date:   Wed, 29 Jan 2020 11:31:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <60b34188-d05d-6753-7116-a34793592227@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2020 10:40 AM, Derrick Stolee wrote:
> On 1/29/2020 10:30 AM, Johannes Schindelin wrote:
>> Hi,
>>
>> On Tue, 28 Jan 2020, Derrick Stolee wrote:
>>> I made some progress, at least, in root-causing the issue.
>>> The problem bisects down to 4dc42c6c1 (mingw: refuse paths
>>> containing reserved names, 2019-12-21) [1]. CC'ing Dscho.
>>>
>>> That commit updates is_valid_win32_path() to fail on these
>>> paths. We were _already_ calling this method even for paths
>>> outside the sparse cone, but the method didn't fail for these
>>> examples.
>>>
>>> This means the fix is probably even more complicated: we need
>>> to not call this method when traversing paths that have the
>>> skip-worktree bit enabled. This may lead to some tiny
>>> performance gains when hydrating a very small fraction of a
>>> very large index.

After digging into this more, at the place where we call
verify_path() and create this warning, all cache entries have
the same ce_flags  (0x0209_0000):

* 0x0200_0000: CE_NEW_SKIP_WORKTREE
* 0x0008_0000: CE_ADDED
* 0x0001_0000: CE_UPDATE

So, at this point there is no way to differentiate between
paths that will be written to disk or paths that will not.
That decision appears to be made at another time, and connecting
these decisions at a distance is ripe for unintended behavior.

>> My preferred solution for this issue would be for the files/directories to
>> be renamed using `git -c core.protectntfs=false mv <reserved-name>
>> <non-reserved-name>`.
> 
> One thing that I realized after root-causing the issue is that now the
> Linux kernel repository cannot be checked out _at all_ on Windows due to
> the existence of an aux.c file. Git complains that the path is invalid
> and does not write a single file to the working directory.
>
> At least we _could_ allow someone to create most of the working directory
> (as we did before) by allowing invalid paths outside the sparse cone.

Of course, as you say, setting core.protectntfs=false allows the Linux
kernel to be checked out as before, but without the safety valve.
  
>> I think if we try to play extra games with the skip-worktree bit, we risk
>> opening a vulnerability again.
> 
> I agree that we need to be _very_ careful with this.

After my investigation, and your workaround, I'm content to settle
this situation "as designed" and to leave it at that.

Thanks,
-Stolee
