Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5E0C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 15:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7094F206F0
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 15:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAcTKZoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgA2Pkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:40:53 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42001 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgA2Pkx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 10:40:53 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so13514685qtq.9
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 07:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HD3cB0bGO30okjZ0MFOsGCidz0s+0+qlamuvkL/9jyI=;
        b=YAcTKZoNbIwIuKRoyNTqwmtJIlopHdJofFQOuXSfiLr98wrQtbR/Rj7WeOgvVrhBLP
         22+SRAW5cdNswgkr4m83tOppwSf5eaURMJ6xVJ+DZSvmuoZbrAGARpGOrU0bapjj/Tj5
         NrrroJ1O+xKijrpfhz/GV0UHzo8whgZT94sKTQ/3KhI/vEi3kXLYlNjo0qjmLuFUOoS+
         +h0/r+9HVA0WppbQliyF6Kw8INV9RS329u5X7Pm+NlW4WE02FVK649B2TaAXyXYqva1b
         GTNJ/Ti1frvHmjYAuNBdmsclVFjA6UjLy5Ev2yJQjq0Jj4ddtVK+FvzfRqj1q6ffz21Q
         XqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HD3cB0bGO30okjZ0MFOsGCidz0s+0+qlamuvkL/9jyI=;
        b=IGrVH6lYQf9wwKFV891vvGBgynB+a96Q3lpB8/lYzy24ppdbaSsl5fFV+6O59x7XM/
         Z04W3ha9R6pFJ3nKP/VT2Snibjk8qr6myIcanhEHry3Rs7hr73JYHM7Gt4iisnWqqlQl
         JvIl8au6Cdg94aaDHOpQIBWBBxg520DKaIGiP8JmewpiDFkWcbDXbvwigH77J2bweLw+
         v+flrWgbVL9s1w4RSnRrCmrDcFTrBDuvQXN3kVtESDwOR8HZy/Ae+Ylg+/+9Dgjd4NjC
         0QnlBHxA3wJYV4DKFiPhcHE7Qhn3F5e+mgl2zIFvZfwoQoxpkayUitbg/tf0ASNeqi71
         QouA==
X-Gm-Message-State: APjAAAULx3d7H1st6WJlwiwRtucYaT8gSCeUXOMvkB2H+FHztOYUxOhN
        wyMI9SmHfkZk5Jg5kslqb3DJvbpWSzw=
X-Google-Smtp-Source: APXvYqyBo2BkHWhZ0hazdDlTHRDPkiOJGrmdzkAKzRR6a6A4TWQM2BJc1jrS5YY5x4Mf2a19D8WMWQ==
X-Received: by 2002:ac8:5208:: with SMTP id r8mr27647936qtn.131.1580312451968;
        Wed, 29 Jan 2020 07:40:51 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:90b6:a0a:46b8:addb? ([2001:4898:a800:1010:41ec:a0a:46b8:addb])
        by smtp.gmail.com with ESMTPSA id e64sm1253696qtd.45.2020.01.29.07.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 07:40:51 -0800 (PST)
Subject: Re: Sparse Checkout Trouble (2.5.0)
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
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <60b34188-d05d-6753-7116-a34793592227@gmail.com>
Date:   Wed, 29 Jan 2020 10:40:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2001291626550.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2020 10:30 AM, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 28 Jan 2020, Derrick Stolee wrote:
>> I made some progress, at least, in root-causing the issue.
>> The problem bisects down to 4dc42c6c1 (mingw: refuse paths
>> containing reserved names, 2019-12-21) [1]. CC'ing Dscho.
>>
>> That commit updates is_valid_win32_path() to fail on these
>> paths. We were _already_ calling this method even for paths
>> outside the sparse cone, but the method didn't fail for these
>> examples.
>>
>> This means the fix is probably even more complicated: we need
>> to not call this method when traversing paths that have the
>> skip-worktree bit enabled. This may lead to some tiny
>> performance gains when hydrating a very small fraction of a
>> very large index.
> 
> Hmm. I am actually not sure that this would be a fix. It is all too easy
> for a skip-worktree entry to become checked out (think e.g. a merge
> conflict in a cherry-pick, during a three-way merge of a file that is not
> in the cone but still needs to be handled).

This is a very good point, and something worth investigating.

> My preferred solution for this issue would be for the files/directories to
> be renamed using `git -c core.protectntfs=false mv <reserved-name>
> <non-reserved-name>`.

One thing that I realized after root-causing the issue is that now the
Linux kernel repository cannot be checked out _at all_ on Windows due to
the existence of an aux.c file. Git complains that the path is invalid
and does not write a single file to the working directory.

At least we _could_ allow someone to create most of the working directory
(as we did before) by allowing invalid paths outside the sparse cone.
 
> I think if we try to play extra games with the skip-worktree bit, we risk
> opening a vulnerability again.

I agree that we need to be _very_ careful with this.

Thanks,
-Stolee
