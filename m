Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71505C77B7A
	for <git@archiver.kernel.org>; Tue, 23 May 2023 04:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjEWEma (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 00:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjEWEm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 00:42:28 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F96FA
        for <git@vger.kernel.org>; Mon, 22 May 2023 21:42:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae79528d4dso45464565ad.2
        for <git@vger.kernel.org>; Mon, 22 May 2023 21:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684816947; x=1687408947;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtuSw3Wy8coc5jNkvnp7wslXGxhKIqTOIrtSDhs+j0Q=;
        b=DkOSAfPGdkWMezyVYc+HBxqGE8cGkNbS9zeGAoWEsHan6OdYrlL5o0yrDN6Ai6986K
         UUVgYOQ1V1UFJS1pByBMtKualGvQErFaA+n50ylG534OtIASnxG9rx4LtdyzhvTDSHMi
         ZOzn8MNub9cCwdFW7DwqenAJ+/MpRbLLBY/bhpjRkCn9G5t9qWm/KTHMw0Gx8mfAbcLL
         Md/0pN5KgSolCxoSkK9M7eELrQLhX5wdrXxG95S1TYTZZk0inbTrCrfLjbfEgxBzF38c
         o2R9Wd9yqRDLZ8tbbbn76FKgSJTUcz49XpsapWYh4NjazhH/MhHMSL3gGnhKWBopaJYG
         0gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684816947; x=1687408947;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rtuSw3Wy8coc5jNkvnp7wslXGxhKIqTOIrtSDhs+j0Q=;
        b=cSgr2P38GmGaBw0dhfrVq/KyV5RQ90J0v78AIlIa6sMO6u2ZY/4cEHyZJRbCaA81gc
         2a2+nAOK0hinPffmf/2+RJFnUUdD5WdG5DbFEVpF13cMzhl74SNJySI3cN2Htfc2XfUZ
         +ZmT/VgOoGGBxZpklAU+lcjKW35dK0yfCOt2jIzPnV+OEJDdpU3cWhASXs5j9uJDwKE+
         nVm1Md4ECyfSOcnzYJjQcDcdmFsVoPC+bdPvpp0Yh+N88HMQnw7M/wvlxDYqD3WgeAbQ
         mu2ZQ4BhCG6BsLrwd4ZsZpasOcYJiPtEQ1SKYwjHNnbKo7wrENFmvZKDyl+RxthOw0u9
         OEvw==
X-Gm-Message-State: AC+VfDxm8eO1qRTuGY9+KXWepyALwGhrtymm36OSXwW2VdL2lDHY89U+
        Fp4yV1YLowwUjIyQcLSc0HP4piH7RJVJEA==
X-Google-Smtp-Source: ACHHUZ6PAgIsrf2IuxF+NtdqVwpIBoGfe8nKxqrzdKjo4vsL4OL+Lgq0tdXxdBnjxgOQ3EjMdQGF9Q==
X-Received: by 2002:a17:902:7683:b0:1ac:637d:5888 with SMTP id m3-20020a170902768300b001ac637d5888mr12028223pll.43.1684816946967;
        Mon, 22 May 2023 21:42:26 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001acaf7e22bdsm5692335plc.14.2023.05.22.21.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 21:42:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH 0/2] Changed path filter hash fix and version bump
References: <cover.1684790529.git.jonathantanmy@google.com>
Date:   Tue, 23 May 2023 13:42:26 +0900
In-Reply-To: <cover.1684790529.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 22 May 2023 14:48:05 -0700")
Message-ID: <xmqqttw3irpp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Following the conversation in [1], here are patches to fix the murmur3
> hash function used in creating (and interpreting) changed path filters,
> and also to bump the version number to 2.

Wonderful.  Thanks for a quick update.  Will take a look when I come
back to the keyboard (I'm on half-vacation right now).

>
> This is I think the simplest way to do this (invalidating all existing
> changed path filters). The resource-consuming part of creating a changed
> path filter is in computing the changed paths (thus, reading trees and
> calculating changes), and to check if a changed path filter could be
> reused, one would need to compute the changed paths anyway in order to
> determine if any of them have high-bit strings, so I did not pursue this
> further. Server operators might be able to reuse changed path filters
> if, for example, they have a more efficient way to determine that no
> paths in a repo have the high bit set, but I think that this is out of
> scope for the Git project.
>
> In patch 2, I couldn't figure out how to make Bash pass high-bit strings
> as a CLI argument for some reason, so I hardcoded the string I wanted
> in the test helper instead. If anyone knows how to pass such strings,
> please let me know.
>
> [1] https://lore.kernel.org/git/20230511224101.972442-1-jonathantanmy@google.com/
>
> Jonathan Tan (2):
>   t4216: test wrong bloom filter version rejection
>   commit-graph: fix murmur3, bump filter ver. to 2
>
>  bloom.c               | 14 +++++++-------
>  bloom.h               |  9 ++++++---
>  commit-graph.c        |  4 ++--
>  t/helper/test-bloom.c |  7 +++++++
>  t/t0095-bloom.sh      |  8 ++++++++
>  t/t4216-log-bloom.sh  | 36 +++++++++++++++++++++++++++++++++---
>  6 files changed, 63 insertions(+), 15 deletions(-)
