Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88251C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2BE60EBC
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhG2Otk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhG2Otk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 10:49:40 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED8C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:49:36 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o13so6177856qkk.9
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ypi0QDN/olawj0/h1iQ/cqx5/qTv0H2YW+9cLg3+3sw=;
        b=e2LQK04BE3m/LX+mTVLd6QglHz4GSdM1nneX1NMK+mrELt2LniOMTnVfkWWLYwyn+v
         hy58AZXXUMspUePDD+vWSKUWbOSCOsDerQ9PQMRkE3jGOSiol7fjIkM/VcN9pfTS630/
         iZGLOAc6Z4rDIUFmIphXOz2IuKxb4sAtWyGfvJFWtruFFv5ozb6IpFpzckHwZyIH1+ki
         zr64Y22JW0edp4kW8W71B2cBFw2NnNCZiJNgEshKt/lcs2OUHmvapBIFpsPgfmKNQlHy
         2NYFLQXGevc7F75EJvWOuD60ZP82Z9GirthFdTVuHsYDdstK81y/uNdGFDVLjOcNojWg
         1Htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ypi0QDN/olawj0/h1iQ/cqx5/qTv0H2YW+9cLg3+3sw=;
        b=m9y8V1u7el9CBpFWKapMLE+ypZH1sQW2s+7iLLeuXGYP1qqJgYj+JzO+VilNcP+aFf
         zAboxZCSGTV5TjHk1kCVflJ6AII2RpiS6ndLQCeEePLG+40bB44eCqFyXxEe1/239jEf
         kQvMJ6XqRrfzy26//35pvxHZn2dCR54zT3cJlrAf4Bnq3c9AVpLOBC73+EQUMVlS49g6
         +wFIPrKxe3f4fSyVWvcXWrhk97FqxLoDRfkQyUw0JGuGQGyeEyvQWrPH5TEGJkQsA5+Q
         A+PvGaLW7MMpCGAh0wKj9vI+3qswlsMNe69c4obH7ldnmK0j2Tgf6mfM3hXHS0EIu3Uv
         dyww==
X-Gm-Message-State: AOAM531wWg51kPyzKRkn2GRdtJQ8MCNtqDOFhMl8+4kNqsaP9f2a3nOO
        NEggwJfUQurpxIu+rFfsNlU=
X-Google-Smtp-Source: ABdhPJyy+sLX1W0kO/kDT70JYu74LRJ34aDIXPMXqkw0yjWpAG+gkm1/dDeREsO2GVQN2YGknwWuAw==
X-Received: by 2002:a05:620a:749:: with SMTP id i9mr5713599qki.307.1627570175173;
        Thu, 29 Jul 2021 07:49:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:444a:5a21:a4e5:7d54? ([2600:1700:e72:80a0:444a:5a21:a4e5:7d54])
        by smtp.gmail.com with ESMTPSA id s14sm1927219qke.1.2021.07.29.07.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 07:49:34 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Sparse Index: Integrate with 'git add'
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
 <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
 <CABPp-BHnvEPuYahFAoVSF58k99t__N2-M4OKKHDAAK2qrhY3WQ@mail.gmail.com>
 <6a63736a-feb8-b74b-ef68-73cc71009e1d@gmail.com>
 <CABPp-BGUTg=GarkhP0MwjWKWmDyRJiEL2J75wFz52y2xi_50mw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2a24488f-d0c8-d1f4-7115-36ac0745658d@gmail.com>
Date:   Thu, 29 Jul 2021 10:49:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGUTg=GarkhP0MwjWKWmDyRJiEL2J75wFz52y2xi_50mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/28/2021 10:57 PM, Elijah Newren wrote:
> On Wed, Jul 28, 2021 at 8:03 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 7/28/2021 7:13 PM, Elijah Newren wrote:
>>> On Mon, Jul 26, 2021 at 9:18 AM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>> ...
>>>>  * a full proposal for what to do with "git (add|mv|rm)" and paths outside
>>>>    the cone is delayed to another series (with an RFC round) because the
>>>>    behavior of the sparse-index matches a full index with sparse-checkout.
>>>
>>> I think this makes sense.
>>>
>>> I've read through the patches, and I like this version...with one
>>> exception.  Can we mark the test added in patch 1 under
>>>
>>>      # 3. Rename the file to another sparse filename and
>>>      #    accept conflict markers as resolved content.
>>>
>>> as NEEDSWORK or even MAYNEEDWORK?
>>
>> I have no objection to adding a blurb such as:
>>
>>         # NEEDSWORK: allowing adds outside the sparse cone can be
>>         # confusingto users, as the file can disappear from the
>>         # worktree without warning in later Git commands.
>>
> 
> Sounds great to me other than the simple typo (s/confusingto/confusing to/)
> 
>> And perhaps I'm misunderstanding the situation a bit, but that
>> seems to apply not just to this third case, but all of them. I
>> don't see why the untracked case is special compared to the
>> tracked case. More investigation may be required on my part.
> 
> The possible cases for files outside the sparsity patterns are:
>   a) untracked
>   b) tracked and SKIP_WORKTREE
>   c) tracked and !SKIP_WORKTREE (e.g. because merge conflicts)
> 
> From the above set, we've been talking about untracked and I think
> we're on the same page about those.  Case (b) was already corrected by
> Matheus a number of releases back; git-add will throw an error
> explaining the situation and prevent the adding.  The error tells the
> user to expand their sparsity set to work on those files.  For case
> (c), you are right that those are problematic in the same way (they
> can disappear later after a git-add)...but we're also in the situation
> where the only way to get rid of the conflicting stages is to run git
> add.  So, in my mind, case (c) puts us between a rock and a hard
> place, and we probably need to allow the git-add.

I appreciate this additional context. Thanks.
 
>>>  I'm still quite unconvinced that it
>>> is testing for correct behavior, and don't want to paint ourselves
>>> into a corner.  In particular, we don't allow folks to "git add
>>> $IGNORED_FILE" without a --force override because it's likely to be a
>>> mistake.
>>
>> I agree about ignored files, and that is true whether or not they
>> are in the sparse cone.
> 
> Yes, and...
> 
>>> I think the same logic holds for adding untracked files
>>> outside the sparsity cone.
> 
> In my opinion, "outside the sparsity cone" is another form of "being
> ignored", and in my mind should be treated similarly -- it should
> generally require an override to add such files.  (Case (c) possibly
> being an exception, though maybe even it shouldn't be.)

I don't hold that same interpretation. I think of it instead as
"hidden" files, but they still matter. I also think that advising
one to adjust their sparsity patterns might be dangerous because
not all users know the ramifications of doing that. They might
accidentally download an enormous amount of data to correct a
single file.

Having an override seems like the best option, and we can hopefully
make it consistent across all the cases and commands.

...

> Trying to get out of a corner we paint ourselves into with
> sparse-checkout would be massively harder, which is why I keep harping
> on this kind of thing.  I'm very concerned it's happening even despite
> my numerous comments and worries about it.
...
> I'm totally fine with such changes not being part of this series.  I
> just don't want a test_expect_success that checks for behavior that I
> consider buggy unless it comes with a disclaimer that it's checking
> for existing rather than expected behavior.

I understand your perspective. I'll send a v3 soon that adds a
comment on top of the entire test signalling the things we talked
about here: this is a documentation of behavior, not an endorsement,
and we should probably change it because users can get confused.

Thanks,
-Stolee
