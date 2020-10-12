Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DA1C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 12:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB122173E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 12:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNtZjLDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbgJLMui (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 08:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgJLMui (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 08:50:38 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B8CC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 05:50:37 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id de3so8299513qvb.5
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4sYRCpaBpCMTP/pb5FHVMOpCuWDTNzRzz2Zy3FWRM18=;
        b=NNtZjLDgohfKvBowEDJdIWpjoaa9UcZShVr09U0yjqJ6b3pge7XDzzDQnfjJR2BNGr
         tJ4Fp42QFrhiUsLf43aA/rhMkzK7cic189No1+S45RGim60fAp1j8NZ+kDoviCLCm637
         dIJ1Evi/NHtZaEoTZ82gN9CHB2rix6WwW0sqI8kkfEY53TeW4t82MfpGtJ63CBRZHkVj
         fA4vB9+cc0i65EoTP1W/GXisJpkYypoPQfVLwnzAsiODJDBl3sqbcKmW0Lo4S87fEsye
         2Lk3R8mHjC97TsAQQjRHNwhpiVSqTTVzxQbL5CacpcDNfRYbGoESHWfIMxxq7jRm3lPB
         N6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4sYRCpaBpCMTP/pb5FHVMOpCuWDTNzRzz2Zy3FWRM18=;
        b=X4d1Ou4lDuiy8z2vC15cqIeCmfmP4MTF13F44b/WTRr+RtibzNe7vft7Zp5zzDgmm5
         IX+vzilqa2RjMtkfEr5fF56zH/7p0ByPxvDKY7lOAi7nl0XfAmk0eaZQmT2xBg1g3K7Z
         aA//Hzav/DCTBZe6gihYzmpp+x8WpM9a//t2c+8C45ouORStk6rjHLYviRSsU5WvVF/g
         GUvLqRa0fenJIArUcrKjym+gjQRZNPb2hJlVKp1810HiMZvW3tyHWE02cVa8q4L1BfDi
         keVd7KFYPM0z1Vnxaa1Sp5IjH/3czCwI2BbZVlL5tekdxLX2tX7uFf/lKNkZfYDvx0XM
         JU6w==
X-Gm-Message-State: AOAM5322qVNfORHWv9yOjCmPAMzWU38u1QM6GfyLSSntK63J8zbC3cRY
        WNBVOosEy///ePQ83/O2dM9QrhjIlWKkVg==
X-Google-Smtp-Source: ABdhPJxgbg5ZduxvPVIjqMnTXYXwI+lO2ggCd0aSv9pS6ns4vU8E58q+NgfsawCpgM20nmGVBcqqDw==
X-Received: by 2002:a0c:fe49:: with SMTP id u9mr24849929qvs.40.1602507036404;
        Mon, 12 Oct 2020 05:50:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3d:4a4e:50ef:41? ([2600:1700:e72:80a0:3d:4a4e:50ef:41])
        by smtp.gmail.com with UTF8SMTPSA id k20sm12607532qtm.44.2020.10.12.05.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 05:50:35 -0700 (PDT)
Subject: Re: [RFC PATCH] log: add log.showStat configuration variable
To:     Robert Karszniewicz <avoidr@posteo.de>
Cc:     git@vger.kernel.org
References: <20201008162015.23898-1-avoidr@posteo.de>
 <bec999ef-5f9c-0ca1-ddd9-70b54b8c51b1@gmail.com> <20201011095916.GA14933@HP>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1f53a7d8-6aa5-e1c7-ecb9-b99a37500034@gmail.com>
Date:   Mon, 12 Oct 2020 08:50:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20201011095916.GA14933@HP>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/2020 5:59 AM, Robert Karszniewicz wrote:
> On Thu, Oct 08, 2020 at 02:12:50PM -0400, Derrick Stolee wrote:
>> On 10/8/2020 12:20 PM, Robert Karszniewicz wrote:
>>> Changes default behaviour of `git log` and `git show` when no
>>> command-line options are given. Doesn't affect behaviour otherwise (same
>>> behaviour as with stash.showStat).
>>> ---
>>> I've wanted to have `show` and `log` show --stat by default, and I
>>> couldn't find any better solution for it. And I've discovered that there
>>> is stash.showStat, which is exactly what I want. So I wanted to bring
>>> stash.showStat to `show` and `log`.
>>
>> I'm wondering: why should this be a config setting instead of just
>> a configure alias?
> 
> I answered this in the reply to Junio C Hamano.
> 
> Actually, the first thing I tried, was make an alias named after the git
> command, like so:
> 
>   git config --global alias.show "show --stat"
>   git config --global alias.log "log --stat"
> 
> But that didn't work. Why, actually? We're used to it from our POSIX
> shells, and other places I can't think of, but it feels familiar.
> Perhaps this would be a good way to enable changing default behaviour of
> each git command without having to change anything about config
> handling? Would this be difficult to do?

You can't replace a builtin with an alias, because that creates a
recursive loop. Note that I changed the name to "slog" for my example.

If you are going to customize it, then you need to remember your new
name. But this is something you can do right now without needing to
patch Git.

>> If this is something we want to do as a config instead of alias,
>> I'm wondering if it is worth expanding the scope and thinking about
>> these other arguments (like --graph, --oneline, etc.) and how they
>> could be incorporated into a coherent config system.
>>
>> I worry that this initial step leads us down a road of slowly adding
>> one-off config settings for each option when:
> 
> I worried about that, too. But I think the initial step was already in
> 2015, when stash.showStat and stash.showPatch were added. No flood of
> options happened since then? I was actually surprised about it, too,
> that it took so long until someone wanted to have showStat for show and
> log, too.

I'm not sure these examples will help your case.

Does 'stash' have more things that would be beneficial to show
every time? If no, then 'stash' is much more specialized than
'show' and 'log' which have many more options. If yes, then this
is exactly what we want to avoid happening: an incomplete set of
config options that are tailored to a small subset of options.

While my stance is still "an alias should suffice," perhaps it is
worth investigating the "status.*" config options, which include
this kind of behavior:

* status.aheadBehind can disable some output normally there by
  default. (This was created for performance implications.)

* status.showStash enables --show-stash

* status.showUntrackedFiles enables --untracked-files

* status.submoduleSummary interacts with --ignore-submodules

Thanks,
-Stolee
