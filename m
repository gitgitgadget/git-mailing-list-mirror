Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF85C55189
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 12:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D5A20781
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 12:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfxaS4Bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgDVMIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726110AbgDVMIj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 08:08:39 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB8C03C1A8
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 05:08:39 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k12so1399714qtm.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 05:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TaNX8IQey+k6yZSDWPnvLvIcVzViwk/A6HxiFv3sLy4=;
        b=lfxaS4BleRqAPQUYkFUbsTF2wC9do9wdrsZ3PY3+ML6+8ovrWguMbEYIK0uVItpksz
         t0XnFaBSICRGCAXgLgEV982g6+Z4SovT+BX2DQqIipMZTFGCmEmdbViLd4Zhf7xz/hoE
         xz4zNiBSJR8O5VF4mmrouQaRjy0WrFtsZ2SbhhqG3KQiiMh7eD1hFDaKRo49GHEEzmoM
         BX4deKkZXQHb4FmUivisUExye1voamuAx7S7nanTlf2ayoM329d6B5ewkuf4qHpVlUZT
         Xa0iEoG6AT8kgcBA6U5ZA27BX0VVmY93X2NTRL/k+ROT9vijP5EFmqKBA78wt7c/3x07
         E1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TaNX8IQey+k6yZSDWPnvLvIcVzViwk/A6HxiFv3sLy4=;
        b=EKPdSQnjVx4XmH5btM+sFy0Z1aPk2LJvI65NJPuAGPVBmoIc/+rWBgsbADG/w2BY7y
         rI6R6PO7/2whNp6D/Dj2BtU/miHfJkmf6QDHNgZPv0GEJM6URpeoNaCuHJl3CIO2WkLB
         kf4qQZ7oQxZi+aNaEjEjecFARhnZxgtypyejC2rcR/Dimkzxxv//WcrhyK2CS1xz1Zz1
         PX1hIo2ygPFd3QFADXXatYBd/FLOfmOWkIOzgTtAXsIiqsj0wGY5jeUyf7/yxj1+oRNA
         juPFw317OeaASz51S4ZYJdUEiRrUtsd6yhoBAncZiQdxHosZEIAoiaz7V6Un0hzlcWKw
         mZYg==
X-Gm-Message-State: AGi0PuarbQmUErseoYuby0l6iYnPRNIo7qa9d+zQOr/Y9obDGFE2eGNm
        KsLfDKpGE9Wj9OjL/b7OmKE=
X-Google-Smtp-Source: APiQypJDG0CfBCAwptFZlkSTfvFLZnIrLxD7XFiQeLW/YT0kNl8IYCLFMugv0fpOwaJueU8Q2CxhEg==
X-Received: by 2002:aed:3e87:: with SMTP id n7mr26511371qtf.301.1587557317940;
        Wed, 22 Apr 2020 05:08:37 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z18sm1948480qts.27.2020.04.22.05.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 05:08:37 -0700 (PDT)
Subject: Re: [RFC PATCH 2/3] grep: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BHbrGGjV_22kwTERn19RaWk73_Y6tzWnjwO9u4isCRpVg@mail.gmail.com>
 <CAHd-oW7yfD74ymARoOHXUqB==RcS36S-8D4M8ysAoVcC6GBR9A@mail.gmail.com>
 <CAHd-oW6PQNC-ZFj6ydbHFzfL4KpSwXVSd8s3H429tOiRgSra8A@mail.gmail.com>
 <CABPp-BGUf-4exGW23xka1twf2D=nFOz1CkD_f-rDX_AGdVEeDA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <29d261cf-0a19-455b-3bbb-ef7f87e4f779@gmail.com>
Date:   Wed, 22 Apr 2020 08:08:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGUf-4exGW23xka1twf2D=nFOz1CkD_f-rDX_AGdVEeDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2020 11:08 PM, Elijah Newren wrote:
> On Mon, Apr 20, 2020 at 7:11 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
>>
>> Hi, Elijah, Stolee and others
>>
>> On Tue, Mar 24, 2020 at 7:55 PM Matheus Tavares Bernardino
>> <matheus.bernardino@usp.br> wrote:
>>>
>>> On Tue, Mar 24, 2020 at 4:15 AM Elijah Newren <newren@gmail.com> wrote:
>>>>
>>>> On Mon, Mar 23, 2020 at 11:12 PM Matheus Tavares
>>>> <matheus.bernardino@usp.br> wrote:
>>>>>
>>>>> Something I'm not entirely sure in this patch is how we implement the
>>>>> mechanism to honor sparsity for the `git grep <commit-ish>` case (which
>>>>> is treated in the grep_tree() function). Currently, the patch looks for
>>>>> an index entry that matches the path, and then checks its skip_worktree
>>>>
>>>> As you discuss below, checking the index is both wrong _and_ costly.
>>>> You should use the sparsity patterns; Stolee did a lot of work to make
>>>> those correspond to simple hashes you could check to determine whether
>>>> to even walk into a subdirectory.
>> [...]
>>> OK, makes sense.
>>
>> I've been working on the file skipping mechanism using the sparsity
>> patterns directly. But I'm uncertain about some implementation
>> details. So I wanted to share my current plan with you, to get some
>> feedback before going deeper.
>>
>> The first idea was to load the sparsity patterns a priori and pass
>> them to grep_tree(), which recursively greps the entries of a given
>> tree object. If --recurse-submodules is given, however, we would also
>> need to load each surepo's sparse-checkout file on the fly (as the
>> subrepos are lazily initialized in grep_tree()'s call chain). That's
>> not a problem on its own. But in the most naive implementation, this
>> means unnecessarily re-loading the sparse-checkout files of the
>> submodules for each tree given to git-grep (as grep_tree() is called
>> separately for each one of them).
> 
> Wouldn't loading the sparse-checkout files be fast compared to
> grepping a submodule for matching strings?  And not just fast, but
> essentially in the noise and hard to even measure?  I have a hard time
> fathoming parsing the sparse-checkout file for a submodule somehow
> appreciably affecting the cost of grepping through that submodule.  If
> the submodule has a huge number of sparse-checkout patterns, that'll
> be because it has a ginormous number of files and grepping through
> them all would be way, way longer.  If the submodule only has a few
> files, then the sparse-checkout file is only going to be a few lines
> at most.
> 
> Also, from another angle: I think the original intent of submodules
> was an alternate form of sparse-checkout/partial-clone, letting people
> deal with just their piece of the repo.  As such, do we really even
> expect people to use sparse-checkouts and submodules together, let
> alone use them very heavily together?  Sure, someone will use them,
> but I have a hard time imagining the scale of use of both features
> heavily enough for this to matter, especially since it also requires
> specifying multiple trees to grep (which is slightly unusual) in
> addition to the combination of these other features before your
> optimization here could kick in and be worthwhile.
> 
> I'd be very tempted to just implement the most naive implementation
> and maybe leave a TODO note in the code for some future person to come
> along and optimize if it really matters, but I'd like to see numbers
> before we spend the development and maintenance effort on it because
> I'm having a hard time imagining any scale where it could matter.
> 
>> So my next idea was to implement a cache, mapping 'struct repository's
>> to 'struct pattern_list'. Well, not 'struct repository' itself, but
>> repo->gitdir. This way we could load each file once, store the pattern
>> list, and quickly retrieve the one that affect the repository
>> currently being grepped, whether it is a submodule or not. But, is
>> gitidir unique per repository? If not, could we use
>> repo_git_path(repo, "info/sparse-checkout") as the key?
>>
>> I already have a prototype implementation of the last idea (using
>> repo_git_path()). But I wanted to make sure, does this seem like a
>> good path? Or should we avoid the work of having this hashmap here and
>> do something else, as adding a 'struct pattern_list' to 'struct
>> repository', directly?
> 
> Honestly, it sounds a bit like premature optimization to me.  Sorry if
> that's disappointing since you've apparently already put some effort
> into this, and it sounds like you're on a good track for optimizing
> this if it were necessary, but I'm just having a hard time figuring
> out whether it'd really help and be worth the code complexity.

My initial thought was to use a stack or queue. It depend on how
git-grep treats submodules. Imagine directories A, B, C where B is a
submodule.

If results from 'B' are output between results from 'A' and 'C', then
use a stack to "push" the latest sparse-checkout patterns as you
deepen into a submodule, then "pop" the patterns as you leave a
submodule.

If results from 'B' are output after results from 'C', then you could
possibly use a queue instead. I find this unlikely, and it would
behave strangely for nested submodules.

Since "struct pattern_list" has most of the information you require,
then it should not be challenging to create a list of them.

Hopefully that provides some ideas.

Thanks,
-Stolee


