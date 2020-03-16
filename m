Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E93DC0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 17:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A3720409
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 17:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAmMtcZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbgCPRSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:18:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45962 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731507AbgCPRSS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 13:18:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id z8so11497815qto.12
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=19GmWJiFzAeU9j8baLKq+RNgVhG/cgxKisJGyOKWKjU=;
        b=RAmMtcZqD7QoHtaGNQCLEbqFDKpq32WC+QhPzemhrIb42G5ROcL+tcRM9vvRtdoewo
         SvPqgc4EI+xYWiy3QRUIMVJtTeudM63nyRDWDyw6hx6NUeGofqP+AsC3AUfxmwYlVekj
         Klj9g6RR9yqULbv/qFCxeWPgc+y13T1XsbambSHCEApPfy05n+TvPUu3KeVMT43+199W
         axHyVqOqF1rYiCLU7xnb5CHz7AkK1usHCz8e75O1zazOc2Um2p8DERqvn8kdmDsm3HLW
         7zvs0MIFkCmqe+lS844++dM/UggHL8NnsPxuaz1iX7Htj5vUq1NSG3Ug11vGtMKttpL3
         hPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=19GmWJiFzAeU9j8baLKq+RNgVhG/cgxKisJGyOKWKjU=;
        b=BBoe0BGgTkL0ZhajgjoXF0F/5jekG+yheZNhF/rs5MpeMbqtcqlPsIgWWLPeUeFlAq
         0tx7EZx5bXIXWIQJy1ks/yAcgjn76TSQ2dI58TBk7pRvMpAMbZ6Z5PjPJBZISbzqOw8k
         hggQzgDKerpL1FInDb4a0XY7+3Bx4cd8ePWauRYkbhaGftABZqPiKep3FnYcjsjBj5m2
         HcDrCACLNjL4NME7Exb6AAicPK7uoIETa/x03vyXrfM9S6dQ8FTTiN2ylCSfDGpIuX4i
         nbd5ckZFOz2mI6H2GZWJ/4auZdNxTlaFl7qb8JKWZItUKibGwdUzHbI3oHo4H+tmpSj4
         hyzw==
X-Gm-Message-State: ANhLgQ2agJUQTCEB5qbUX6XJawKFHLoK3WTDvWHNQtK4jv660bRlP9lv
        ctL4Mln3TTKBOwidm5COWIk=
X-Google-Smtp-Source: ADFU+vsuJFGAiHvI2AXNWoXfxfHV8q3kPiggtyPqkTh5lbvxVmWoScvNq2jTr3/spdUbQZx0/i7ZSw==
X-Received: by 2002:ac8:5493:: with SMTP id h19mr1136559qtq.151.1584379096565;
        Mon, 16 Mar 2020 10:18:16 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 69sm147206qki.131.2020.03.16.10.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 10:18:16 -0700 (PDT)
Subject: Re: [PATCH 7/7] sparse-checkout: provide a new update subcommand
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <650db6863426ae2b324ba717f898247f44279cb8.1584169893.git.gitgitgadget@gmail.com>
 <ee9e8bc6-252f-8ac5-e769-26302f3eb1eb@gmail.com>
 <CABPp-BE=VdSAfAWR_2KivXbGOYknhJ=4sbRjVPAS+URNgjLFPQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <137d9910-452b-9c96-b3a4-2b19053f6a67@gmail.com>
Date:   Mon, 16 Mar 2020 13:18:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE=VdSAfAWR_2KivXbGOYknhJ=4sbRjVPAS+URNgjLFPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/2020 1:05 PM, Elijah Newren wrote:
> On Sun, Mar 15, 2020 at 9:24 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 3/14/2020 3:11 AM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>> +static int sparse_checkout_update(int argc, const char **argv)
>>> +{
>>> +     repo_read_index(the_repository);
>>> +     return update_working_directory(NULL);
>>> +}
>>> +
>>
>> Short and sweet! I suppose my earlier comment about whether
>> repo_read_index() was necessary is answered here. Perhaps it
>> should be part of update_working_directory()? (And pass a
>> repository pointer to it?)
> 
> Good question.  Is there a chance we want to make
> update_working_directory() available to other areas of git outside of
> sparse-checkout.c?  If so, potentially re-reading the index might not
> be friendly, but if sparse-checkout.c is going to remain the only
> caller then it probably makes sense to move it inside.

Minh had an interesting idea during side-conversations at the summit:
have a way for an in-tree description of some sparse-checkout cones.
The idea was to be able to automatically update the sparse-checkout
while moving between commits that may have different dependency
configurations. In the world of Office it would mean that there is
some file ".sparse/word" that describes the directories required to
build Word, and ".sparse/ppt" for building PowerPoint. Then, based
on local Git config, we would see that we want our sparse-checkout
cone to match the union of the directories in .sparse/word and
.sparse/ppt. As we move HEAD, we would want to automatically update
the sparse cone when those files change.

I'm working on a design document for how this idea would work,
realistically, that I plan to share here and with the Office team
to see if it is actually a helpful plan. I think it would reduce
the performance cost of the hook we plan to use for this, and
would reduce the investment needed for a project to adopt
sparse-checkout.

All that is to say, yes we may want to add other callers to
update_working_directory() outside of the sparse-checkout
builtin. With that in mind, perhaps its name should reflect
the fact that we are only updating it according to the sparse
cone?

Thanks,
-Stolee

