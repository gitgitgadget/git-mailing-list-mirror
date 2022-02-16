Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0000C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 09:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiBPJo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:44:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiBPJoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 04:44:25 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF36296918
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:44:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w3so2889904edu.8
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MNr+x/70q4QPu0fFk7U/0fsXCrMTQSQJuovssV14gKU=;
        b=lZAsmduj87KgVdRHSupLUh7+t7iVK4ynYho1rvwN4nSF9sc4vYUlz+Ud8/eAuFibWa
         ale7PL4Ltk18zi0wuOHdq3ncWxX1AXU+eE1IDukfk9UQSKgswJuGXuwqNPeDLy88JzY5
         PoJP6fk8cBbljD7ChCZo0Y6DuMczZep0Lc69X8tVhi2ijnv3fevFRYCtAIUUJpSAGv1t
         DIjT0Q/QgF1qoUCcCP2DXBlGxmn5R3Ynm914zZPHncyrFjwpo4IRnjl6GRL+J+gdiMkx
         UMIgwAP5nXW476gdDEHuJyx8vO1TEazYoGZSYNjOsK7XRECzUXizIDDxkX6UkYuIr34I
         IXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MNr+x/70q4QPu0fFk7U/0fsXCrMTQSQJuovssV14gKU=;
        b=ixtL8EhaO+a9GXdvWAUAgDGVDxz20pDjSiGRiJAEiJ95XoCBs1xv2fVCkN/aGiGoXv
         yiJa3e1U4IxynNZR+yGWljkFgytU+nq7d8Ewi/E6XjuohVtbDoeB4x52RLniATHvjfhh
         hXdPUpBPQZ7QctJeV6ECzUQ07qz8c/tZWem5NOGZvAegE2p9v2TV3vRjJbOBSuynlL4C
         wROZSnWjRYjdEQgsIfjMENRhOpIGKRFrhOU9wR63oNtQDm7wYyxYWMn0ktGeY1fEtYOJ
         i58yTAB9jpJcT73dTBQpQwm1kFUSfHCwIihK3Qi+lQ37sSfLTBwfbpx4/9u5RWYlkBEd
         yifA==
X-Gm-Message-State: AOAM530xf++AiyjwQMDMforKAlaYzZlf7gHbxJUGDUChBLXv6rY+wsyg
        jhEd9/WLJUkEsMBwnVEfszk=
X-Google-Smtp-Source: ABdhPJws14E2anVqTUEO1teHSJIcp5b/ajNftSur/ehbZhLzT732Zwjldu9ahUEx5QjjXWaZ+NUAfw==
X-Received: by 2002:a50:aac8:0:b0:410:ae77:c484 with SMTP id r8-20020a50aac8000000b00410ae77c484mr1961478edc.431.1645004651707;
        Wed, 16 Feb 2022 01:44:11 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v23sm12898797ejy.177.2022.02.16.01.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 01:44:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKGr4-003AR1-99;
        Wed, 16 Feb 2022 10:44:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/9] fetch: fetch unpopulated, changed submodules
Date:   Wed, 16 Feb 2022 10:39:14 +0100
References: <20220215220229.1633486-1-jonathantanmy@google.com>
 <kl6lr1835poe.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lee435g72.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <kl6lee435g72.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220216.86bkz7uowl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Glen Choo wrote:

> Glen Choo <chooglen@google.com> writes:
>
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> Glen Choo <chooglen@google.com> writes:
>>>> +	# Create new superproject commit with updated submodules
>>>> +	add_upstream_commit &&
>>>> +	(
>>>> +		cd submodule &&
>>>> +		(
>>>> +			cd subdir/deepsubmodule &&
>>>> +			git fetch &&
>>>> +			git checkout -q FETCH_HEAD
>>>> +		) &&
>>>> +		git add subdir/deepsubmodule &&
>>>> +		git commit -m "new deep submodule"
>>>> +	) &&
>>>> +	git add submodule &&
>>>> +	git commit -m "new submodule" &&
>>>
>>> I thought add_upstream_commit() would do this, but apparently it just
>>> adds commits to the submodules (which works for the earlier tests that
>>> just tested that the submodules were fetched, but not for this one). I
>>> think that all this should go into its own function.
>
> I'm testing out a function that does exactly what these lines do, i.e.
> create a superproject commit containing a submodule change containing a
> deepsubmodule change. That works pretty well and it makes sense in the
> context of the tests.
>
>>> Also, I understand that "git fetch" is there to pick up the commit we
>>> made in add_upstream_commit, but this indirection is unnecessary in a
>>> test, I think. Can we not use add_upstream_commit and just create our
>>> own in subdir/deepsubmodule? (This might conflict with subsequent tests
>>> that use the old scheme, but I think that it should be fine.)
>
> We can avoid the "git fetch" if we first need to fix an inconsistency in
> how the submodules are set up. Right now, we have:
>
>   test_expect_success setup '
>     mkdir deepsubmodule &&
>     [...]
>     mkdir submodule &&
>     (
>     [...]
>       git submodule add "$pwd/deepsubmodule" subdir/deepsubmodule &&
>       git commit -a -m new &&
>       git branch -M sub
>     ) &&
>     git submodule add "$pwd/submodule" submodule &&
>     [...]
>     (
>       cd downstream &&
>       git submodule update --init --recursive
>     )
>   '
>
> resulting in a directory structure like:
>
> $pwd
> |_submodule
>   |_subdir
>     |_deepsubmodule
> |_deepsubmodule
>
> and upstream/downstream dependencies like:
>
> upstream                             downstream            
> --------                             ----------
> $pwd/deepsubmodule                   $pwd/downstream/submodule/subdir/deepsubmodule (SUT)
>                                      $pwd/submodule/subdir/deepsubmodule
>
>
> So we can't create the commit in submodule/subdir/deepsubmodule, because
> that's not where our SUT would fetch from.
>
> Instead, we could fix this by having a more consistent
> upstream/downstream structure:
>
> $pwd
> |_submodule
>   |_subdir
>     |_deepsubmodule
>
> upstream                             downstream            
> --------                             ----------
> $pwd/submodule/subdir/deepsubmodule  $pwd/downstream/submodule/subdir/deepsubmodule (SUT)
>
> This seems more convenient to test, but before I commit to this, is
> there a downside to this that I'm not seeing?

Won't this sort of arrangement create N copies of e.g. a zlib.git or
some other common library that might be used by N submodules.

But I haven't read all the context, I'm assuming you're talking about
how we store in-tree a/b and x/y/b submodules now, we store those in
.git/ both as .git/modules/b.git or whatever? I can't remember ... :)

Whatever we do now I do think the caveat I've noted above is interesting
when it comes to submodule design, e.g. if both git.git and
some-random-thing.git both bring in the same sha1collisiondetection.git
from the same github URL should those be the same in our underlying
storage?

I think the answer to that would ideally be both "yes" and
"no".

I.e. "yes" because it's surely handy for "git fetch", now you don't need to
fetch the same stuff twice in the common case of just updating all our
recursive submodules.

And also "no" because maybe some users would really consider them
different. E.g. the you may want to "cd git/" and adjust the git.git one
and create a branch there for some hotfix it needs, which would not be
needed/wanted by some-random-thing.git.

Hrm...
