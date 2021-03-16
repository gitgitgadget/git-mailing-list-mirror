Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A060AC433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 08:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F94C64FFC
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 08:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhCPIkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 04:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbhCPIkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 04:40:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6C4C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 01:40:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id p7so59402551eju.6
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=y5Xf+bd9dJGepDepixV8XZL7UGx9ikG7p99H0abpAS4=;
        b=vePuwm4nbqU3pCqcdQeYrHDkXUxgr/WyxHW7jCrFjmkuoG0lozevB8MW8Hjn3slAEF
         qqG7rkCS+OfgNHvVysnXyCwhSbgJ0mWpc3wzS2Xab6NovJ6ZiD3lBEdbAlYHhpyOj3NH
         0lDsjtJC75zeiaPRFPkd2MLvT5q9Q7J76fRatFFytMSvWdG+5DrpX4iiyV5/yPh+mfip
         +z+zpGTARrjLUDhpiFRaEXH4OdxRAlVTVSc5ruQzS0nlgjJzMmT+GUQR5qlOmD0Xczev
         oNhkwvgiZaVKxOpO5/wdBmLoP9GF0IExQIjtqeCerme1Sihtg6j4uYYitVn+xa6w0hr0
         mxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=y5Xf+bd9dJGepDepixV8XZL7UGx9ikG7p99H0abpAS4=;
        b=Nj7n7HSV/dEGXEg9kOZ0dheqP0gili8C5IR/OqEqTqc6BWVmTK2zICGMiXsXnlzidr
         awheLk8P/0tx/xhc1sAD0VKk4zHRjDxzd+xmhBPQkwahuEof36WGyWx6bi0gimiOTviO
         O8az5ILsroXbzimBoL2UkSRHWRD3jMTu7q0cbIIkCcIsWxaLsiUqN+4aFsJyx3QOS8A7
         DLEAXpRr35ik7p8QEKQOIzVscCtPXtBa+w9tEK3LV8hR5JIXMyPkfmCSdWGFSn27uuY/
         9Uz7QmYBeWODQVWEm45hPcRLFxxRe1sT221TUsIXsotoD76pRrcC4aryONU2+QX3VMT1
         i0bg==
X-Gm-Message-State: AOAM531MujmJ+jG6UeBkgFH5prwWegXSbWrF9pQgHZXT6XhbAjiB24Tn
        EzxxFDo0F1t33UgwHefSjrBNcEHE62G3nw==
X-Google-Smtp-Source: ABdhPJyF3uDVNLqg4NLuXJ4Stbyv4FmTfWmeiA0W0D5WrpHr1qW0d35PZq4isa4yeBKU52UwHgXRXw==
X-Received: by 2002:a17:906:7384:: with SMTP id f4mr28481797ejl.196.1615884009521;
        Tue, 16 Mar 2021 01:40:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y24sm9925850eds.23.2021.03.16.01.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 01:40:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     David Turner <David.Turner@twosigma.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: slow object packing during push
References: <38b99459158a45b1bea09037f3dd092d@exmbdft7.ad.twosigma.com>
 <87eegohvwi.fsf@evledraar.gmail.com>
 <d23fa1d9c0a24241a1b9fe33744cf7eb@exmbdft7.ad.twosigma.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <d23fa1d9c0a24241a1b9fe33744cf7eb@exmbdft7.ad.twosigma.com>
Date:   Tue, 16 Mar 2021 09:40:07 +0100
Message-ID: <878s6nfq54.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 15 2021, David Turner wrote:

> On 3/9/21 9:14 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Mar 09 2021, David Turner wrote:
>>
>>> I have a large, funny repository that has very slow pushes unless I
>>> set pack.usebitmaps=3Dfalse to false.
>> Good to see you on-list again! :)
>
> Thanks!
>
>>> First, a description of the repo: it's about 175GB, and was created by =
combining about 40,000 smaller repositories.  Historically, these repos wer=
e submodules of one meta repository[2].  I have stitched together the submo=
dules, and this is the repository in which the stitching was done - that is=
, it contains all of the objects from the smaller repos, plus all of the ob=
jects from the meta repository, plus the newly-created trees & commits for =
the stitched repositories.  As new commits come into the meta repository (w=
hich have gitlinks to new submodule commits), we fetch from the meta reposi=
tory (8s - it would be 2s if we were fetching into a normal clone without a=
ll of the other stuff), and the submodules (up to 10s per and embarrassingl=
y parallel). Then we stitch (~0s), and push to the stitched "unity" reposit=
ory (~2 minutes!!!).  The entire repo fits in RAM (yes, all 175G) and is in=
 fact in the disk cache (I prewarmed the cache before testing anything).=20=
=20
>>>
>>> The vast majority of the time appears to be spent in git pack-objects, =
and in particular in the stack trace in [1].  If I set pack.usebitmaps=3Dfa=
lse, the push only takes 10s.   This seems like pack bitmaps are a severe p=
essimization for my purposes.  This is true even immediately after a repack=
 (that is, almost all of the objects are in one giant pack, except the newl=
y-fetched ones).  I also tried setting up pack islands - one for each small=
er repo, one for the stitched commits, and one for commits from the meta re=
po.  I'm not sure if this is necessary, but it's definitely not sufficient =
(my current config has it turned on, because I didn't feel like repacking a=
gain after testing it, and I tested it before testing pack.usebimaps).=20
>>> [snip]
>> Without having carefully re-read it, I believe this issue is the same as
>> what I reported here in 2019, and I think you'll find the resulting
>> discussion intresting:
>> https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/
>>
>> Having skimmed it, I think you're probably omitting that this is a bare
>> repo you're pushing from, and thus you're running into the combination
>> of repack.writeBitmaps being true by default on bare repos, and
>> pack.useBitmaps being true everywhere (but having no effect by default
>> unless you have a bare repo, unless you manually make bitmaps blah
>> blah).
>>
>> One of the semi-conclusions from the above thread was that we mostly
>> turned this on thinking that bare ~=3D server that accepts pushes, and
>> bitmaps are known to be worse (but not always!) for when you're pushing
>> *from* your repo.
>
> Thanks, that does explain it.  We should probably consider a default
> that bitmaps aren't used on pushes.

I think that would be a good move. Again, I haven't re-read that thread
+ the preceding discussion, but my recollection is that the performance
numbers were solid on the "accepts pushes" case, but the "does pushes"
wasn't much thought about / not seen as that worth dealing with.

So I think between my report and yours it would make sense to just do as
you suggest with a "this is probably a better default for this case than
not" patch.

I was about to submit such a thing, should be easy, right?

The problem is that it would be easy if we had one config variable in
play.

But in this case there's a default that causes the bitmaps to be written
on bare repos, and then it's just picked up as part of the general "do
we have a bitmap? use it!" default.

At that point we don't know how our bitmap came to be created, is it
because of this default that could probably be sensibly flipped for the
"not_set && is_bare && doing-push" case, or was it manually created by
someone's custom gc/repack script after careful testing of bitmaps (also
for pushes)?

So with that and Jeff King's note that it *does* help some of the time
even in that case I'm not sure what the best way forward is.

The best I can come up with now is:

    if (!have_bitmap_write_config && !have_explicit_use_bitmaps_config &&
        is_bare && doing_push)
        advice(blah blah maybe this is bad for you?);

Which sucks, but would have have helped both you/me find the root cause
quickly, so maybe it's not such a bad idea.

What do you think we should do?

There's also digging into the perf problem itself & fixing that of
course...
