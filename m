Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C9BC636C9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AED613C7
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhGORWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhGORWM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:22:12 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F64BC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:19:19 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so6971953oti.2
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ktbUrJCBlm/xyc7Nwa/oL2/Ymk/nTO5NBb1ZS15+O74=;
        b=UR7/p+5H7oE8HNPdquNTQyKgnMJYwK5uUdvmGSE4FKJV5HN+F578+AOF+XkNgd1Gw2
         X4XSfmEKBo4naIzJCJC6Duzhx0eNS4f3RYybvIF54ZxXg//uexjPnxhg4eke6+WNKOie
         nTz/olLhx2UsiaQgWoY6jUiBfdEHIfPkLn1339k5Ho0dl3zf7EUG3TNvWtb9nkCj5PZ1
         E/i/5j4bIP5wQqoM3iIeqsif4kM4+BZY8gXcNFHcz9lsoI/2Sbq4LLOFljfDbU/bf97W
         voRhnVPAwjdaIwby7UJHm86suiN9CR1diIXmFCXSI1y4sabfqOdwxyBPaERHRCt/u1ef
         gbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ktbUrJCBlm/xyc7Nwa/oL2/Ymk/nTO5NBb1ZS15+O74=;
        b=PACkUPCPfKwEbYUpJDOW84D0J1hPMzSzthF28803FpEkOZaehO+eKWtl9fvzI4jlKd
         QVc1xrYZi/CMuBT2U15W+AYlLJNcC+TVAfi3X+h95Dp3zOj7cX5eGyMfuHxloKeXSSWC
         39VxNg4S9BrYzjanIkRqilIN9Wm6Hafo552qp+8mBMGrSfPpCKfgLodAzon3pim2QhD/
         28trHB5sWYPIoJLjUZxNYjI4rjgok0lPubhx2JlWN5l6Yo2wUWdtFD3E5T35wzTRjBG4
         /Te9KlGDvsmcv0jzABs2XhKhgfMg7idd7Q9zM41KHEkvKitYHvYXxzUyL9REJ3FPgbCf
         Jh3Q==
X-Gm-Message-State: AOAM531dUJI4Icz9NlQ2Yv2Sh4hj/Oiy4K/LfPqtHsmQKqBoZmRUvtOn
        8rrRyV+IJPw7C1vabkPgUNc=
X-Google-Smtp-Source: ABdhPJwj4evlpsC4Mb51g20kAP37KHSK+Ffx/qavn7rajfdk/4OC0u0y6OhE08MDtJ2jLy68jbuUNg==
X-Received: by 2002:a05:6830:3493:: with SMTP id c19mr1529705otu.300.1626369558740;
        Thu, 15 Jul 2021 10:19:18 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2? ([2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2])
        by smtp.gmail.com with ESMTPSA id w64sm1234776otb.45.2021.07.15.10.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 10:19:18 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] merge-ort: restart merge with cached renames to
 reduce process entry cost
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
 <7133f0efa520b3d0cadb059151daa12484fdb003.1626204784.git.gitgitgadget@gmail.com>
 <d91ed8a0-b37b-7dfa-10bf-e068f30e9691@gmail.com>
 <CABPp-BF+gR8WtpWt_DVDoWe16R4B65h-59zGOZ5j4vUJKp_Nuw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9260bd3d-2325-fde7-bfa2-081700f6a731@gmail.com>
Date:   Thu, 15 Jul 2021 13:19:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF+gR8WtpWt_DVDoWe16R4B65h-59zGOZ5j4vUJKp_Nuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/2021 12:53 PM, Elijah Newren wrote:
> On Thu, Jul 15, 2021 at 8:10 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 7/13/2021 3:33 PM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
...
>>> +              * The exact number isn't critical, since the code will
>>> +              * work even if we get the factor wrong -- it just might be
>>> +              * slightly slower if we're a bit off.  For now, just error
>>> +              * on the side of a bigger fudge.  For the linux kernel
>>
>> super-nit: s/linux/Linux/
> 
> Yeah, I tend to refer to projects by the name of their repository
> instead of their proper name.  (I do it with git too.)  Bad habit.
> Will fix.  That is, I will fix this instance.  Not sure I can fix the
> habit.

If you had written it as torvalds/linux, then I wouldn't have batted
an eye, because that is clearly a repo name (at least, clear to me).

>>> +              * testcases I was looking at with massive renames, the
>>> +              * ratio came in around 50 to 250, which clearly would
>>> +              * trigger this optimization and provided some *very* nice
>>> +              * speedups.
>>
>> This bit of your testing might be more appropriate for your commit
>> message. This discussion of a test made at a certain point in time
>> is more likely to go stale than the description of how this factor
>> does not change correctness, only performance.
> 
> The commit message does include discussion on how this factor only
> changes performance, not correctness.  I left this comment in the code
> because I figured it looked weird and magic and deserved an
> explanation without resorting to git-log or git-blame.  Granted, I
> wrote this comment and the commit message at much different times (I
> wrote the comment first, then the commit message many months later)
> and thus summarized a bit differently.  But I thought I had the same
> relevant content in both places.
> 
> Are there pieces you feel are missing from the commit message?  Should
> I trim this comment down in the code and just let people look for the
> commit message for more details?

I meant to say "these kinds of details are better for the commit
message instead of comments" and not say "your commit message
doesn't have enough."

I don't feel strongly about this being present in the comment or
not, but it seems like something that could be dropped from the
comment without loss of information.

Thanks,
-Stolee
