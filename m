Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CB0C636C9
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 01:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8585C613C9
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 01:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhGPBen (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 21:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhGPBem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 21:34:42 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12576C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 18:31:48 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q190so7195462qkd.2
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 18:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IDLKLDnvjQwUE9JMfjS7jo3br+SKMyxcD1ECz9EdCbo=;
        b=fysadMgMwNWvhGHXwJGhAVaNICacRfEQyeHm/JtAX4VbcVcwX4+XWMk02Sj07/vjhA
         ax+MKKvZbkwewxnWnBGd+tUiFrX04CLpDFKKA4anmPgA5WeihztiZUhfn1GwUHXBDHQK
         sjs/YOtezKrc7oN0eHHd6JBXo/UwUw84VoIQXxw9p+BZZv1PJ5z/MADj1HmEHoglkCen
         D+wNFzJumr2of1ARFrs04vUL6aZfH18SXTJAHiCRqntITW3ueD9EFjzLCu9alhHLdhcZ
         YXlfEh5DwBVpK5p54b9G07uz/YwvGOkjWZosCoREhD6tPsI5FFSwuuVdJxbsEKYwpGGM
         F/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IDLKLDnvjQwUE9JMfjS7jo3br+SKMyxcD1ECz9EdCbo=;
        b=LBJRoBfIgz6lu/Ykf3+m6NGp1oVBPbxdvp2B+3rKwWn1U4RYqfol4qU1s9NpOKtA2T
         n2wy/39y+tCmGvKfadB7u62DgIFWdz8i6QbhMx8nFk/1sSwnPmrZeyRI7Pp4J/om84mG
         OduBSF1OvcDPrO/1joGPWwLL6s1qUumekXQ8fjM52gnS7hWvaAlhOemB7kt9rWODBwnb
         iu0bpssEVuPMdkRU8N22Qz3rl9ALOl4WUXKbQ5IpfgzdZypJZajH3MYin4PcbxvflA4p
         C8nF69+vFbEFo8uRRLOpPwZSzHVHB3kAIfBMOHIe5E0+JiGTnCjadMxhjrHfWQVtYhJ2
         s57w==
X-Gm-Message-State: AOAM533Uvhvd/tP8ta0R8hA2qlfDWB1K+aJgTb7XDGXbQcnRaiEzUQT2
        mK9kv9fs0rcftZ7bEKP+sqE=
X-Google-Smtp-Source: ABdhPJwq+fo6ZCa0FZUHOEG7zHQvdNAqLaf04J/N4eNaTtiVJZAid0uwMkgmqafAhBI5M4AsZ4vCTA==
X-Received: by 2002:a37:b586:: with SMTP id e128mr7039693qkf.43.1626399107239;
        Thu, 15 Jul 2021 18:31:47 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id u6sm3381933qkp.49.2021.07.15.18.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 18:31:46 -0700 (PDT)
Subject: Re: [PATCH] parse-options: don't complete option aliases by default
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bwilliamseng@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.996.git.1626353925051.gitgitgadget@gmail.com>
 <8735sfzgkg.fsf@evledraar.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <1f41f94a-ebe1-69f0-7631-864cbbd1e1a0@gmail.com>
Date:   Thu, 15 Jul 2021 21:31:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8735sfzgkg.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Le 2021-07-15 à 12:16, Ævar Arnfjörð Bjarmason a écrit :
> 
> 
> I'm a bit biased here since I like --recursive better, but let's not
> drag that whole argument up again. I don't find the argument in
> bb62e0a99fc (clone: teach --recurse-submodules to optionally take a
> pathspec, 2017-03-17) convincing enough to have moved such a prominent
> use-case to a longer option name.
> 
> But, water under the bridge. Aside from that:
> 
> For me a Google search for "git clone --recursive" is ~40k results, but
> "git clone --recurse-submodules". The former links to various
> discussions/docs/stackoverflow answers, often --recurse-submodules isn't
> mentioned at all or as an aside.
> 
> I think it's unfortunate that we:
> 
>   1. Conflate whether something shows up in completion v.s. the
>      help. Given its prominence and that "git clone -h" is ~50 lines why
>      not note --recursive there.

As far as I understand (and tested), '--recursive' was listed in the short help but not the completion
before bb62e0a99f (clone: teach --recurse-submodules to optionally take a pathspec,
2017-03-17). At the time the completion did not use '--git-completion-helper'
and only '--recurse-submodules' was listed (since 5f072e0017 (completion: add option
'--recurse-submodules' to 'git clone', 2016-07-27)).

Starting from bb62e0a99f, it was not listed in the short help (because of PARSE_OPT_HIDDEN)
nor the completion (because it was still not listed).

Then starting from 5c387428f1 (parse-options: don't emit "ambiguous option"
for aliases, 2019-04-29), it started being listed in the short help AND
the completion again; in the short help because of the new code in usage_with_options_internal
and in the completion because of the way preprocess_options is implemented,
and at that time '--git-completion-helper' was used for '_git_clone'.

After my patch, it would still be listed in the short help, as "alias of --recurse-submodules",
but would not be listed by the completion (unless GIT_COMPLETION_SHOW_ALL is set).

> 
>   2. Don't have the completion aware of these aliases, i.e. "git clone
>      --rec<TAB>" before your chance offers a completion of both, that sucks,
>      we should fully complete the non-alias instead.

Indeed. That's my main motivation.

> 
>   3. Making it PARSE_OPT_HIDDEN "solves" #2 at the cost of hiding it in
>      "git help -h", and now this won't work, but did before:
> 
>          git clone --recursi<TAB>
> 
>      I.e. even if we didn't want to do #2 *and* wanted to hide it in the
>      usage output surely completing an unmbigous prefix is better, even
>      if it's a hidden option?

I agree that with my patch 'git clone --recursi<TAB>' does not complete to '--recursive'
(unless you've set GIT_COMPLETION_SHOW_ALL). But I'm not sure it's that big of
a deal (after all if you typed this far you only have two letters left :P)
But '--rec' will be sufficient to complete to '--recurse-submoduele', so
it's even less letters to type.

But this has nothing to do with PARSE_OPT_HIDDEN ('--recurse-submodules' is
not hidden and aliases are not hidden either). So I'm not sure what you mean...

> 
> Per-se none of this is a blocker or "we must fix this first" for this
> particular change, we have this in many existing cases.
> 
> I daresay there's no other alias that's in as wide a use in the wild, so
> we should think about this one particularly carefully though.
> 
> It's not fully clear from your commit message which of 1-3 you're aiming
> for, I think it's more of the "discourage its use".

As I wrote it's mainly #2, I'll update the commit message to be clearer.

> 
> Sure, fair enough, but PARSE_OPT_HIDDEN is not a 1=1 mapping to that,
> and can often lead to more user confusion.
> 
> E.g. the user has used --recursive for years, but can't even find it in
> -h (I also think it's a mistake to have entirely removed it from the
> docs, even if one agrees with its "deprecation" I'd say we should keep
> some "used to be called --recursive" note there).
> 

Yeah, maybe it should have stayed in the docs. Again, my patch does not remove
it from the short help.

Thanks for you comments!:)

Philippe.
