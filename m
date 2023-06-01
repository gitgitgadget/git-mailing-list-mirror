Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE37C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 06:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjFAGGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 02:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAGGh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 02:06:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4125E2
        for <git@vger.kernel.org>; Wed, 31 May 2023 23:06:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d4e4598f0so623668b3a.2
        for <git@vger.kernel.org>; Wed, 31 May 2023 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685599596; x=1688191596;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cb0BM+cazAYVIcjyiq4IjE4IjjBllxJi/W1wHq9wTw4=;
        b=FJib4JqmRhEEJ5cMH4XKmSV7/8aXiQNzS+vNcR/ZRzs+TYtAmTGD2JzkzeRWCZS4X3
         PzKILQz5c3ZrCau+M0n8buMEghkEd0vW+DVGlSzIWCubDoQOdOWj21uSXJZbC9rR2krd
         5mOYSE65ayUKrspvBlYfhqNJwxNAoQ09gki51BtceM0ZgIeKeQqBx1ZU1s4mb9tuxXof
         jN9NZoyk3ay1sIuPQyNzHJLvoCJi0XlCs6LrXLyY5mnGXFDLgCL8ca8JRuoAh0lBeV1n
         +sex1OEdQE2e2oIwwydbsIb8EKN4QvqHQIEOvsR4/TDXO61HZrQKFBR3DQda4/J3tduI
         6GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599596; x=1688191596;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cb0BM+cazAYVIcjyiq4IjE4IjjBllxJi/W1wHq9wTw4=;
        b=iHAzNj1RH8Ek7K8XonbofYN877zbSRAQPGGNCJHhczT1X9l+QtQ2BnGFDQLAzSMtee
         qk2HJFn7RPe7aIgrt1gKGP31sbP2QM1lknBevM25HF0nRQi5lm8SRMSgmTs314vzlvDm
         WfSffY66alDyecFzItxvIaLPhwhGlP9bwyLx2OJTT1Ntn0fFZVRQ0096n/CXo7Fmsp7l
         5RtdP5nrv81gyX/CehjiVpvyG4ABml2rtt3nmED7DcApDkvQcv3T2kz3j3VJmMuU2h73
         I4B0JpzYlkod2xnGTSFkeRYQa1ExS4SYWRKVezlALOSD6Lv2FHkv9JMQJ80R+SweUEox
         euvw==
X-Gm-Message-State: AC+VfDz21iWih7yX8Zir2sF/DcRHI+yj8AIR1RVXwjdVyp4Btremke1x
        9a/WsTqRkjAQF8FnUFpQbMk=
X-Google-Smtp-Source: ACHHUZ4QvhUt9vtxvxim/fQmuxzlZ+wIhsWXJ7v6L5+RpdUnS5iJXxPWj+sV62Kfe0oaI+2fsK40Nw==
X-Received: by 2002:a05:6a00:1254:b0:647:3de:c0ff with SMTP id u20-20020a056a00125400b0064703dec0ffmr8127435pfi.30.1685599596206;
        Wed, 31 May 2023 23:06:36 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7928d000000b006372791d708sm4237862pfa.104.2023.05.31.23.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 23:06:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub Wilk <jwilk@jwilk.net>
Cc:     <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-clone.txt: document -4 and -6
References: <20230527123849.5990-1-jwilk@jwilk.net>
Date:   Thu, 01 Jun 2023 15:06:35 +0900
In-Reply-To: <20230527123849.5990-1-jwilk@jwilk.net> (Jakub Wilk's message of
        "Sat, 27 May 2023 14:38:49 +0200")
Message-ID: <xmqq1qivd8d0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Wilk <jwilk@jwilk.net> writes:

> These options were added in c915f11eb4 ("connect & http: support -4 and
> -6 switches for remote operations").
>
> Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
> ---
>  Documentation/git-clone.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

The patch is not _wrong_ per-se, but there are other options that
are common among the "fetch" family of commands.  I counted at least
these should be shared between "fetch" and "clone", by splitting
them out of "fetch-options.txt" into a new file, and including that
new file from "fetch-options.txt" and "git-clone.txt".  Those marked
with (?) are described in different phrasing between "clone" and
"fetch", and may fall into the "let's keep them separate, because
they mean different things" category (later):

 * --jobs
 * --upload-pack
 * --quiet (?)
 * --verbose (?)
 * --progress
 * --server-option
 * --ipv[46]

Note that these happen to share the same name, but to "clone" and
"fetch" they different things, so leaving them separate is the right
thing to do.

 * --no-tags
 * --recurse-submodules

Thanks.
