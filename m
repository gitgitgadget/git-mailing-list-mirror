Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E36C433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 01:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963C464EC7
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 01:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBSBJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 20:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhBSBJa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 20:09:30 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F84C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 17:08:50 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ly28so8674631ejb.13
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 17:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jpopKaAot4j/IwjIey9/aSstBFqBiJ7kY8iAehERHGo=;
        b=OEbIQzlWhCrPVe34rnQPeUspFTlP8GSDUQ46ia/Q+e6vSKOq6OH3GqteO819Ct0Yo6
         hIUzdqHNYi1xrDibG62V0QDOTFDP+vOb4LJlkKclG50DjW0edVxkd4Dl+oyjinbDHlZ2
         luVUkjZN8ERh4Uf6W6EE6Fso9L2fDKYkJrlXcU0ut7dzpNd8Ny603zij42K/Mud8DTxT
         5dm5oz7V85J9uBX8PnpQqAZh/sH4MXJnfJBFqxEoO3/AUCCz7qFosrfQcxzQX1P8X92a
         OI+8j+bnZjfX7s+ysvOjA1NDIUIJoCwHnNHDqe/nsaW9n3cLDYBf2U7bePRgtjU1uCcr
         twow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jpopKaAot4j/IwjIey9/aSstBFqBiJ7kY8iAehERHGo=;
        b=Oew7RcwhTxc0WsnrWey2OUtK5alwko5+PPiGWzFRgVHEsB01QmGFUoQF8WYSCU0euT
         Az9Mp4bZIO26SJUvk//iR/Qx0uHRoceh7ctbXcstgkpws0i2BE7A7JRopmzVKy0rE/u0
         TYGJzNdU7hkFPJPUAsGpDGp33BpbzFNjMXu3NdJV+PuDjqq+ehAA6jWRB4/KE+NG8hoE
         hwmqbNeS3GtURviL01585PsT++KyQfTPYhQkpUo9q/UV0/99vap5+x9qxyLVO9Y8I01Y
         vskeFzCTDMTVBJnC+jfW2PsXFhK5+rFvU+exWIISEpX4FiE7AQWADKl2bH5xrKHvcSaU
         VgyQ==
X-Gm-Message-State: AOAM530DGn11yc8ztvvQaO7hEIBOi0JrBmVvqh4QyazYdbltK5oN2CpV
        jq9Spm6UbRikeJ+kUeSlXXs=
X-Google-Smtp-Source: ABdhPJxUpsV2MbbTrshhMSwmFr7YFZFC+Y3Tj/fMJrx7X61w9E/OAYcjJBPco30cx8wEYu+2wvVOoQ==
X-Received: by 2002:a17:906:1389:: with SMTP id f9mr6594877ejc.442.1613696928759;
        Thu, 18 Feb 2021 17:08:48 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id z12sm1778801ejf.15.2021.02.18.17.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 17:08:48 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] Check .gitmodules when using packfile URIs
References: <20210115234300.350442-1-jonathantanmy@google.com>
 <cover.1611455251.git.jonathantanmy@google.com>
 <xmqqzh01ar2s.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqzh01ar2s.fsf@gitster.g>
Date:   Fri, 19 Feb 2021 02:08:47 +0100
Message-ID: <87im6o984g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 19 2021, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> This patch set resolves the .gitmodules-and-tree-in-separate-packfiles
>> issue I mentioned in [1] by having index-pack print out all dangling
>> .gitmodules (instead of returning with an error code) and then teaching
>> fetch-pack to read those and run its own fsck checks after all
>> index-pack invocations are complete.
>>
>> As part of this, index-pack has to output (1) the hash that goes into
>> the name of the .pack/.idx file and (2) the hashes of all dangling
>> .gitmodules. I just had (2) come after (1). If anyone has a better idea,
>> I'm interested.
>>
>> I also discovered a bug in that different index-pack arguments were used
>> when processing the inline packfile and when processing the ones
>> referenced by URIs. Patch 1-3 fixes that bug by passing the arguments to
>> use as a space-separated URL-encoded list. (URL-encoded so that we can
>> have spaces in the arguments.) Again, if anyone has a better idea, I'm
>> interested. It is only in patch 4 that we have the dangling .gitmodules
>> fix.
>
> This seems to have been stalled but I think it would be a better
> approach to use a custom callback for error reporting, suggested by
> =C3=86var, which would be where his fsck API clean-up topic would lead
> to.
>
> If it is not ultra-urgent, perhaps you can retract the ones that are
> queued right now, work with =C3=86var to finish the error-callback work
> and rebuild this topic on top of it?  Thanks.

If my vote counts for something I think it makes sense to have
Jonathan's series go first and just ignore my fsck API improvement
patches (well, the part of my v1[1] which conflicts with his work).

I'm also happy to help him queue his on top of a v1 version of my
series.

But the end result of doing so (shown after the "--" in [1]) is just a
small re-arrangement of code to get a cleaner fsck API use, it doesn't
actually matter to anyone using git.

Whereas his patches actually do, we have in-the-wild server/repo/clone
setups that are getting on-clone errors, and the window for 2.31 is
getting closer.

We can always do the small API use refactoring later. My interest in
barking up that tree was just that I've been poking at that part of the
fsck API and have some follow-up work that hasn't made it onto the list
yet that makes other use of the fsck API.

So in the longer term I wanted us to think about not needing N special
cases like "print_dangling_gitmodules" if we could help it, but in the
shorter term having it is a non-issue.

1. https://lore.kernel.org/git/20210217194246.25342-1-avarab@gmail.com/
