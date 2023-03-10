Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A9BC6FD19
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 21:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjCJVlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCJVlP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 16:41:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD2012EAC7
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:41:14 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so6383172pja.5
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678484474;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RbYWXHqKWZEptU3hKHmRan5+U4B5UAJnhNU2XLGhak=;
        b=MB/FAuu+r8u043lHAlgjRfXCsimxDHVm9jsdTzIxzSR/Ua0vRyj3itdtpKKJ8hh2MV
         /0EseZwYNYjo1yfxgIZBWPgRclOfNWwnfsw43fP4ya8T/AFqxJqEPViWFNCNJujyJADe
         sv/nOvyWvWap8bUC58gY9U6hVsLh4B6B5tflf1YFm4mqFM9PX3jGUNkeLglBB8889hSS
         lEyu4ch2/sZcZMBXZJqU/YQciPvCJYxKigpTTZtRmmRLSEBM6TgqZ/cEv5w+GnSzzseb
         Td82P5gX3zudaFptfmuxjfk/un8nkEa9o6itoOhLyikAuB0/Rb0cSUrnwCXSS8eBTHNF
         6wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484474;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4RbYWXHqKWZEptU3hKHmRan5+U4B5UAJnhNU2XLGhak=;
        b=VI5AWXx8hkeU94nQNxzLLvsvIbrPqWWhjEKkW4brDGCulBnxllyEBPfOqSdQoFoIws
         vjQKz5RYLRicPdkS8OJ738bIp91AUFpx4X/ewn/xXn3wdAf/vGMmWmf4pLLClv93oM1X
         IWULu32EIXKZWUihfRggr2U5lIA7xzivXEIXbH7B454s0GralD46VviG3owA/49umlIJ
         TcRLu0QBHguA7hKsxrv33dKYDRVkBUiHq0NBKgzdsu1HoHocgzTJyvR2XACxMKnw9/Kc
         X2+S2uv7fOMMR63W9/t8U3I9qD3Qnqu2GaJGiNN0SypWzLP8ZxY3zR8UQqklC2PX8IJg
         nQ6w==
X-Gm-Message-State: AO0yUKWzkxdagqyeA3Z590SaWLGpE2sogzY45QjWz6jDj1YsQXQurSwe
        nrqxcZhW4dm53QczVJ5JjAhNiOKASEY=
X-Google-Smtp-Source: AK7set8GhR4mokA9CXyLzwNkcxWxDvZii/Z2xbeSTxb/nWgf8aAKgfKfpUiWYzJ679TxcBEkdPIkoA==
X-Received: by 2002:a17:902:ab82:b0:19b:da8:1ce6 with SMTP id f2-20020a170902ab8200b0019b0da81ce6mr21738378plr.55.1678484474062;
        Fri, 10 Mar 2023 13:41:14 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 21-20020a630715000000b0050336b0b08csm347640pgh.19.2023.03.10.13.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:41:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] index-pack: remove fetch_if_missing=0
References: <20230310211321.4135748-1-jonathantanmy@google.com>
Date:   Fri, 10 Mar 2023 13:41:13 -0800
In-Reply-To: <20230310211321.4135748-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 10 Mar 2023 13:13:21 -0800")
Message-ID: <xmqqttys4746.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> > Hence, use has_object() to check for the existence of an object, which
>> > has the default behavior of not lazy-fetching in a partial clone. It is
>> > worth mentioning that this is the only place where there is potential for
>> > lazy-fetching and all other cases are properly handled, making it safe to
>> > remove this global here.
>> 
>> This paragraph is very well explained.
>
> It might be good if the "all other cases" were enumerated here in the
> commit message (since the consequence of missing a case might be an
> infinite loop of fetching).
>
>> OK.  The comment describes the design choice we made to flip the
>> fetch_if_missing flag off.  The old world-view was that we would
>> notice a breakage by non-functioning index-pack when a lazy clone is
>> missing objects that we need by disabling auto-fetching, and we
>> instead explicitly handle any missing and necessary objects by lazy
>> fetching (like "when we lack REF_DELTA bases").  It does sound like
>> a conservative thing to do, compared to the opposite approach we are
>> taking with this patch, i.e. we would not fail if we tried to access
>> objects we do not need to, because we have lazy fetching enabled,
>> and we just ended up with bloated object store nobody may notice.
>> 
>> To protect us from future breakage that can come from the new
>> approach, it is a very good thing that you added new tests to ensure
>> no unnecessary lazy fetching is done (I am not offhand sure if that
>> test is sufficient, though).
>
> I don't think the test is sufficient - I'll explain that below.

I admit I haven't thought about it any longer than anybody who
touched this topic, but should "fetch_if_missing=0" really be
treated as "it was a dirty hack in the past, now we do not need it,
as all callers into the object layer avoids lazy fetching when they
do not have to, so let's remove it"?  It looks to me more and more
that the old world-view to disable lazy fetching by default and have
individual calls to the object layer opt into fetching as needed may
give us a better resulting code, or is it just me?  The possible
error modes in new code that fails to follow the world-view with and
without this change are:

 * If the lazy fetching is disabled by default (i.e. without this
   patch), a new code can by mistake call has_object(), which does
   not lazy fetch, when it does need to have the object and should
   be using something like has_object_file_with_flags(), and dies
   loudly.

 * If the lazy fetching is enabled by default, on the other hand, a
   new code can by mistake call has_object_file_with_flags(), which
   does lazy fetch, when it does not need to have the object.  It
   does not die, it just lazily fetches objects it does not need.
   The (performance) "bug" will stay hidden until somebody complains.

In short, the world-view of the current code seems to give us
tighter control over what gets lazy fetched, simply because we do
not allow lazy fetching without thinking.

Do we have other uses of fetch_if_missing (i.e. disable lazy
fetching)?

    $ git grep -l fetch_if_missing
    Documentation/technical/partial-clone.txt
    builtin/fetch-pack.c
    builtin/fsck.c
    builtin/pack-objects.c
    builtin/prune.c
    builtin/rev-list.c
    cache.h
    midx.c
    object-file.c
    revision.c

As the default is 1, all these hits (outside the header, doc, and
object-file.c) are to disable lazy fetching.  Judging from the list
of "family" that want tighter control over what gets fetched, I have
a feeling that pack-index may want to stay to be in the family.

Or am I missing some big picture goal to eventually getting rid of
this mechanism and always allowing lazy fetching?

Thanks.

