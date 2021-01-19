Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85026C43603
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 14:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D73823135
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 14:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405069AbhASOwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389777AbhASNFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 08:05:30 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A696C061574
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 04:56:11 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id e17so4411683qto.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 04:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7nGJ9gclwrN5O2vQquguIPZxQ5T+j/twBUnxDeHBpvE=;
        b=ceC8LLfZVH4KwA/pBSLSbG6EvXlj/5CEMxx1gjumlJJqhQxYQUO4wRlwHjOrpBXIr/
         +pqBBgGvY3hLdCmBeADT9AW3q3bRFatUG85bB+F/ri7xpsy/CIRbYkOExjBdz03HaT/E
         LnGDL5IS5vC/U9OJId7a0Z/rs5ZHqKKSGzbQt5BAsmn+g2359KtXtKT23FkRgCHqRuQ+
         BdFpS7ntPf4IFwhVuTq+59h8Wx42IkZdxmkEYKu6z4zthbyzTLfTv7MUc4h7D0BZmGFB
         dUg/QPrLbC4gVb0SjASQVH3EUKfMiMIrfC8mucwROzY/pbThgNoXHIEmAIsEFWG6UKEY
         ZjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7nGJ9gclwrN5O2vQquguIPZxQ5T+j/twBUnxDeHBpvE=;
        b=qFpoEhWVipBJ45HPnW/GclRZVIgH7Oe6qCOIVNId7ZnRfL6jgy/f0ITvL3zWjMJZx4
         4P2IrlnNDJfnfihUtl/uOGULur0XckpKohqoFHVJLboUUXNAdqGGlxxaIp6kI5AUFmjs
         dp03loxIctnT+v7Dq1S6xSIV1Rl8epkmlZIjvWDhUxvji9v0YMuqNe/ctsJsk7x4IaIS
         5ajokH5UVipLvlWcxyLcezwnAvC1G6e2wNEky510VFRw0PyHpgs5pW6YQPWNLGZ0Rc1J
         osMpPmHEevA7K3UV3DJvfBKvK923My8/c6LBKqLd5tMqQs7y/157IayBkmE4sExlyvpn
         Bkbw==
X-Gm-Message-State: AOAM531+ei9qKEnFSKuL8pGDZbz+MUdsrOpyRCNRJW/qV5lvhG4I/bAQ
        cv8HMZ+iqF9ShTx+FHqRDMA=
X-Google-Smtp-Source: ABdhPJzkrxsbKj4IEIA6ncNss5ejvUXedktFlx7JW+Go67hnkit/6SDFsvTsRT9IwouVTf70zO6Urw==
X-Received: by 2002:ac8:6758:: with SMTP id n24mr4061426qtp.258.1611060970663;
        Tue, 19 Jan 2021 04:56:10 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c079:252a:4324:9b45? ([2600:1700:e72:80a0:c079:252a:4324:9b45])
        by smtp.gmail.com with UTF8SMTPSA id u7sm12728771qke.116.2021.01.19.04.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 04:56:09 -0800 (PST)
Subject: Re: RFC on packfile URIs and .gitmodules check
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net
References: <20210115234300.350442-1-jonathantanmy@google.com>
 <xmqqim7xraeo.fsf@gitster.c.googlers.com> <YAJcDr0EPkKk0aR/@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d2ca2fec-a353-787a-15a7-3831a665523e@gmail.com>
Date:   Tue, 19 Jan 2021 07:56:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YAJcDr0EPkKk0aR/@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/2021 10:22 PM, Taylor Blau wrote:
> On Fri, Jan 15, 2021 at 04:30:07PM -0800, Junio C Hamano wrote:
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> Someone at $DAYJOB noticed that if a .gitmodules-containing tree and the
>>> .gitmodules blob itself are sent in 2 separate packfiles during a fetch
>>> (which can happen when packfile URIs are used), transfer.fsckobjects
>>> causes the fetch to fail. You can reproduce it as follows (as of the
>>> time of writing):
>>>
>>>   $ git -c fetch.uriprotocols=https -c transfer.fsckobjects=true clone https://chromium.googlesource.com/chromiumos/codesearch
>>>   Cloning into 'codesearch'...
>>>   remote: Total 2242 (delta 0), reused 2242 (delta 0)
>>>   Receiving objects: 100% (2242/2242), 1.77 MiB | 4.62 MiB/s, done.
>>>   error: object 1f155c20935ee1154a813a814f03ef2b3976680f: gitmodulesMissing: unable to read .gitmodules blob
>>>   fatal: fsck error in pack objects
>>>   fatal: index-pack failed

I'm contributing a quick suggestion for just this item:

>>> This happens because the fsck part is currently being done in
>>> index-pack, which operates on one pack at a time. When index-pack sees
>>> the tree, it runs fsck on it (like any other object), and the fsck
>>> subsystem remembers the .gitmodules target (specifically, in
>>> gitmodules_found in fsck.c). Later, index-pack runs fsck_finish() which
>>> checks if the target exists, but it doesn't, so it reports the failure.
>>
>> Is this because the gitmodules blob is contained in the base image
>> served via the pack URI mechansim, and the "dynamic" packfile for
>> the latest part of the history refers to the gitmodules file that is
>> unchanged, hence the latter one lacks it?
> 
> That seems like a likely explanation, although this seems ultimately up
> to what the pack CDN serves.
>> You've listed two possible solutions, i.e.
>>
>>  (1) punt and declare that we assume an missing and uncheckable blob
>>      is OK,
>>
>>  (2) defer the check after transfer completes.
>>
>> Between the two, my gut feeling is that the latter is preferrable.
>> If we assume an missing and uncheckable one is OK, then even if a
>> blob is available to be checked, there is not much point in
>> checking, no?
> 
> I'm going to second this. If this were a more benign check, then I'd
> perhaps feel differently, but .gitmodules fsck checks seem to get
> hardened fairly often during security releases, and so it seems
> important to keep performing them when the user asked for it.

It might be nice to teach 'index-pack' a mode that says certain
errors should be reported as warnings by writing the problematic
OIDs to stdout/stderr. Then, the second check after all packs are
present can focus on those problematic objects instead of
re-scanning everything.

Thanks,
-Stolee
