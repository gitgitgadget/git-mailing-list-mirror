Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49121C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2657360E8D
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbhHEBzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhHEBzk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:55:40 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54450C061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:55:26 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id em4so2196068qvb.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pb/mPaUHxrCst6b+SqZTniU48GdYC7yhbyMdKDlzpv4=;
        b=FzhPRofgwEZuZSDDQZnoJbz2ShVy6rj5JsZd4IN9WyO+SOknl4/2zVkoOqYP3JMmYg
         Kl6OWE45Mxq+drii5UsUzeDro/dnGGCxnvR7cNPqOkDqXW7dn2Ims1zJ9D11jXWepX/x
         PuTL+SwMYOzr45qizeVONwug6aI2cYQyby1ZOJRdNj95De2P8bVuisZb6ZZYDzJY9urg
         9x5h3k2Q43D26rEDw2DspQIB5+jlgYq/nDz3M4TNbskJJeJJWoY2hxKDNKuro0eQOgoO
         c/23nHR4wDr4qItEWbILPIozBMpiqIOnBEWDZpEBzg6Q18rEBqhVg2/bJg+ayKpfh370
         SR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pb/mPaUHxrCst6b+SqZTniU48GdYC7yhbyMdKDlzpv4=;
        b=e2Et9utHGPNX7GseBfs+6kibQj8aV1nsC+Smq4vfqokR1+ho9igOUF7qywR1BnWfeM
         6aLJUN3mUlheYZkXzYQ5vc2Gbl6IRIFgUUCLqbYXft69DceEHIQ4JSHw0F6fSQqmYZ24
         XQZq/YCQodP1EYIOSEYNRxwGinYS544P+KDqhPuDqZ02587onwxYIyzCjQLDFwds2LR1
         gQ9u6YuPgP0pfwV65liZKWFpPRtpmkvcpfast4R12/P+tkYxxLZzVkPKRKglqDCuYaqu
         oV7EnX7Ic38ftwXyK2xmBzVJpcAqeL2RQ5IYve83r7CpIHeGDZrCIYwfyYz1uBJoPkdO
         bHdA==
X-Gm-Message-State: AOAM533Xc+3+SVBd3+Twam3w9AO6CGT5beF6Ltx8gudwenWSR3VETcK4
        P4np144bMjjfsQ3cQ5EitRk=
X-Google-Smtp-Source: ABdhPJzQ4B5euZ5lbv4b2Sua4FNuHV6GgnZ3Bi9yJxUWm4HcqrUVI9V7SDofkAI2ugpK582C53/Fow==
X-Received: by 2002:a05:6214:10c4:: with SMTP id r4mr2639028qvs.58.1628128525341;
        Wed, 04 Aug 2021 18:55:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d4ee:e00e:38d0:2baf? ([2600:1700:e72:80a0:d4ee:e00e:38d0:2baf])
        by smtp.gmail.com with ESMTPSA id n10sm1549239qtk.89.2021.08.04.18.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 18:55:24 -0700 (PDT)
Subject: Re: [PATCH 2/2] sparse-checkout: clear tracked sparse dirs
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
 <9212bbf4e3cab20fe49ab8e6dd4ac0277c4f2805.1627579637.git.gitgitgadget@gmail.com>
 <CABPp-BGbRbyCYYS+NcYrC-T4hJf7BCoLE2HsXFM4K51A0wSgcg@mail.gmail.com>
 <76639e16-204d-7812-d4c5-56c70e280bed@gmail.com>
 <CABPp-BE1aKAsp6yKAzM-djRHuiP=GHC_Q7xZxMWPJ=f28bOeUg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <53d1b6ac-76a0-034b-109c-df2835c8fad6@gmail.com>
Date:   Wed, 4 Aug 2021 21:55:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE1aKAsp6yKAzM-djRHuiP=GHC_Q7xZxMWPJ=f28bOeUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/2/2021 12:17 PM, Elijah Newren wrote:
> On Mon, Aug 2, 2021 at 8:34 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 7/30/2021 9:52 AM, Elijah Newren wrote:
>>> On Thu, Jul 29, 2021 at 11:27 AM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
> ...
>>>> +                */
>>>> +               if (S_ISSPARSEDIR(ce->ce_mode) &&
>>>> +                   repo_file_exists(r, ce->name)) {
>>>> +                       strbuf_setlen(&path, pathlen);
>>>> +                       strbuf_addstr(&path, ce->name);
>>>> +
>>>> +                       /*
>>>> +                        * Removal is "best effort". If something blocks
>>>> +                        * the deletion, then continue with a warning.
>>>> +                        */
>>>> +                       if (remove_dir_recursively(&path, 0))
>>>> +                               warning(_("failed to remove directory '%s'"), path.buf);
>>>
>>> Um, doesn't this delete untracked files that are not ignored as well
>>> as the ignored files?  If so, was that intentional?  I'm fully on
>>> board with removing the gitignore'd files, but I'm worried removing
>>> other untracked files is dangerous.
>>
>> I believe that 'git sparse-checkout (set|add|reapply)' will fail before
>> reaching this method if there are untracked files that could potentially
>> be removed. I will double-check to ensure this is the case. It is
>> definitely my intention to protect any untracked, non-ignored files in
>> these directories by failing the sparse-checkout modification.

This is _not_ true, and I can document it with a test.

Having untracked files outside of the sparse cone is just as bad as
ignored files, so I want to ensure that these get cleaned up, too.

The correct thing would be to prevent the 'git sparse-checkout
(set|add|reapply)' command from making any changes to the sparse-checkout
cone or the worktree if there are untracked files that would be deleted.
(Right? Or is there another solution that I'm missing here?)

>>> My implementation of this concept (in an external tool) was more along
>>> the lines of
>>>
>>>   * Get $LIST_OF_NON_SPARSE_DIRECTORIES by walking `git ls-files -t`
>>> output and finding common fully-sparse directories
>>>   * git clean -fX $LIST_OF_NON_SPARSE_DIRECTORIES
>>
>> I initially was running 'git clean -dfx -- <dir> ...' but that also
>> requires parsing and expanding the index (or being very careful with
>> the sparse index).
> 
> `git clean -dfx -- <dir> ...` could also be very dangerous because
> it'd delete untracked non-ignored files.  You want -X rather than -x.
> One of those cases where capitalization is critical.

Good point. I'd like to avoid using `git clean` as a subcommand, if
possible, that way we have one fewer thing to do before integrating
the `git sparse-checkout` builtin with the sparse index.

Thanks,
-Stolee
