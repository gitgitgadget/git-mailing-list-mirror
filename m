Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F6AC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 15:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLOPrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 10:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiLOPq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 10:46:56 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D115FF3
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:46:55 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id d14so27549895edj.11
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A7CcwHqx1MGN1A9mVBe2so7yl3UoKlGOv4z8qk1xp9U=;
        b=Ehp6zGXn1ZhC5OMzgOS8hfcIGXOo4C2813WLRhG4KZIgzXbO/bEK3D61Lf2VLtEICd
         Prj+udXZTc5DudrFuwcO6GrK6071ufdY4mCu+TXK8A5JRrIk/OmJ5J19C6CBWGv47llp
         CPNNq1HxjaFFJjNqxLPw2Y7YcJEOwBQmFAfM98qYqmcyJIjelwMiqHek7u8+Bd/ShdE7
         IQ1vNjGLjByvElghFA2xdrDKbiuS6ODKsCufICaaLxGMLCNrybzFAjWD86t8cOyQPueo
         jHshr8T+UHdmNTDefwrTvbdXTQB7VTcBEp/zjnHiVgZ7qQb5ign+NJFHT+lFV9Pl3qq+
         1hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7CcwHqx1MGN1A9mVBe2so7yl3UoKlGOv4z8qk1xp9U=;
        b=ZfzgTizhoQpNYKYqfVwd+JlOeNIbqBxTOrKaUEseim9MS0VnIU57vbkpgyAhEDClTh
         WPGrV9k5QvRtzHS7yoyi+hJvoXZXx/9Kx8ygU21GulSSQbUE3izoErUaGUnU2TqCEwp6
         3Q8R2D0f1OLYAwy8Gi1DyW6Ti6Gx1yjYb936H7DmONKSrjy2EJEw4rmqx9yEjqxqq/y7
         cfRhO5hu0RgWQj29k0LSWnlF+CXDeThwt46GqWoQwIo67QEGpa/CbLMmi40Or4l29bCV
         ThikPvmQSrG5wKMz7YCORQVqbBfhHvGox2GU1hK/N17DtrJpAkbkhOJzPXfgYrTirSHu
         L7aA==
X-Gm-Message-State: ANoB5pktit4p1GjqSEcuIXpJlgFScC12Mzi+YzZIOjylcTuBnn7OjTTL
        S2RMlFMxcEdazjNA7dijm5GyVVoNdVsFIg==
X-Google-Smtp-Source: AA0mqf4geRdZQ2AWJypnpF+S8fUwf8Jj5H55yO+RZM9uhK3mCTuc3U7NFJKDzUIVCItL2+nFRvraDw==
X-Received: by 2002:a05:6402:eaa:b0:462:c7ed:7b41 with SMTP id h42-20020a0564020eaa00b00462c7ed7b41mr22950447eda.21.1671119214089;
        Thu, 15 Dec 2022 07:46:54 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ca15-20020aa7cd6f000000b0046bd3b366f9sm7602272edb.32.2022.12.15.07.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 07:46:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p5qRh-006MvP-0F;
        Thu, 15 Dec 2022 16:46:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alban Gruin <alban.gruin@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: ag/merge-strategies-in-c (was: What's cooking in git.git (Dec
 2022, #05; Wed, 14))
Date:   Thu, 15 Dec 2022 16:32:48 +0100
References: <xmqqiliewbje.fsf@gitster.g>
        <221215.865yed3tzv.gmgdl@evledraar.gmail.com>
        <c9c2c979-82b3-8be1-1edb-343661cf4b32@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <c9c2c979-82b3-8be1-1edb-343661cf4b32@dunelm.org.uk>
Message-ID: <221215.86a63o3c0i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 15 2022, Phillip Wood wrote:

> On 15/12/2022 09:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Wed, Dec 14 2022, Junio C Hamano wrote:
>>=20
>>> * ag/merge-strategies-in-c (2022-08-10) 14 commits
>>>   . sequencer: use the "octopus" strategy without forking
>>>   . sequencer: use the "resolve" strategy without forking
>>>   . merge: use the "octopus" strategy without forking
>>>   . merge: use the "resolve" strategy without forking
>>>   . merge-octopus: rewrite in C
>>>   . merge-recursive: move better_branch_name() to merge.c
>>>   . merge-resolve: rewrite in C
>>>   . merge-one-file: rewrite in C
>>>   . update-index: move add_cacheinfo() to read-cache.c
>>>   . merge-index: add a new way to invoke `git-merge-one-file'
>>>   . merge-index: drop the index
>>>   . merge-index: libify merge_one_path() and merge_all()
>>>   . t6060: add tests for removed files
>>>   . t6060: modify multiple files to expose a possible issue with merge-=
index
>>>
>>>   An attempt to rewrite remaining merge strategies from shell to C.
>>>
>>>   Tired of waiting for too long.
>>>   source: <20220809185429.20098-1-alban.gruin@gmail.com>
>> I submitted a v9 of this during Taylor's maintainership, but it fell
>> between the cracks. I've submitted a rebased-on-master v10 now (there
>> were some conflicts):
>> https://lore.kernel.org/git/cover-v10-00.12-00000000000-20221215T084803Z=
-avarab@gmail.com/
>> It's just the "prep" patches, the real meaty part is converting the
>> merge drivers, which will come after. Some of the performance numbers
>> for those are really impressive...
>
> I think splitting this in two is a good idea as there were only a
> couple of outstanding issues with the first half of Alban's V8. When
> you posted V9 I looked at the range-diff hoping to see a couple of
> localized changes addressing those issues. Instead it looks like
> you've rewritten most of the patches that people have already spent a
> considerable time reviewing. I don't think it is a good use of
> reviewers' time to essentially start reviewing again from scratch.

What do you consider a good way to turn this comment into something
actionable?

To have a minimal re-submission of the v8 which simply fixes the
semnatic & textual merge conflicts we've had on "master" in the interim?

I think such a re-submission would need to address the issues I noted in
the v9 CL[1]. E.g. that in over-libifying merge-index its behavior was
changed, e.g. emitting N error() instead of die()-ing on the 1st
one. Addressing that is going to need to require around the same code
changes.

This is also a case where the range-diff looks overly scary, aside from
such specific fixes the end result is substantially the same, but I did
split up (and mostly not rewrite) the existing patches to:

* Cleanly separate those bits that were changing behavior, from those
  that were not (and precede them with tests to assert that)

* Make the eventual libification change as small as possible, now it
  really benefits from the diff rename detection.

If you have some more specific suggestions for how to move forward I'm
all ears.

1. https://lore.kernel.org/git/cover-v9-00.12-00000000000-20221118T110058Z-=
avarab@gmail.com/
