Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A166C77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 20:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbjDZUjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjDZUju (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 16:39:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC49115
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 13:39:49 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b78b344d5so6080402b3a.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682541589; x=1685133589;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYR3i2DsHiehgqY5Jfk1ePPkPvokw4tttp4sfnqbmZ8=;
        b=Wl9x5e5fpSp0CX6+k4NKfOYVxUn3A149tahrXLJQColMxSnNlEp7o98nf/h/pVEeKJ
         9ZyFnHQWm3Kdw2hXaLH1jxy7NZw2f4NKV6wF8GkAk73e1vaCRY+ODlDeFyaBHKutsmOc
         mqPJHgP929zV2gSst4NRrxUDFLEp2mW3mnL4FCx12eSteUxmUfXZV0NWIH/TtEBa/RAX
         I0T1SSrVEotOJ0E+OqKBzmkAiTSvCrVZ7TPo+s4zI+0vr7eYy85wP9p55L0ou1yWz4x9
         zh7pVd9MQZDNJ72qoptpJpHzzS3yI+gCTxy9XYOSsdSfxH91QQzHAUwnXj2hqsyXlIB2
         ywrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682541589; x=1685133589;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yYR3i2DsHiehgqY5Jfk1ePPkPvokw4tttp4sfnqbmZ8=;
        b=LOTsnP/p1egRAxA8J1iOiYSld119jd5v2Sgjx/rOJpFv7IiMG21E3dVTqTrDxgktns
         ND6/PtFblCANVRbH+FNOjSSaSN7j4JYPLB4aehE6qCsrLWGk4lLPtquPP4IrSffXLo0A
         6TEjg8WYtqoFOpwzWGqou/AVBVkYVdssyc+PlJi8343XZo4ZuiF9oAyICf9BuwO2dLGz
         ev6mgqi38EM4RtR1uvOP8t66Fl4rJ7RpdrdfTAYwsPOxxSvOljvFGTNbEoQ75pFT9hm3
         0ce8kSnOEE8GHreaBs0awlJhC/nf2CHF4N5WYhCK8G9mBGeyu1YG0MBzvOeYtwAFv2Bl
         FE0Q==
X-Gm-Message-State: AAQBX9cdfgMrfgz1aIy1ZZnzAXsJrm2+6CL0A0C9lzcjtCGzYx2k4Hm7
        nGCxt0ps9VjR2LsKTP6e2FQ=
X-Google-Smtp-Source: AKy350YJLd7xJY0V6+2hrxwW7TSDN+eG6vPBMQ5pSsnQcfyKjvPVmfHOLk0LoqrpCKwUpz6VjV5D8A==
X-Received: by 2002:a17:903:41cd:b0:1a9:6d25:b2d2 with SMTP id u13-20020a17090341cd00b001a96d25b2d2mr14546359ple.67.1682541589306;
        Wed, 26 Apr 2023 13:39:49 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id mh16-20020a17090b4ad000b0024781f5e8besm12012764pjb.26.2023.04.26.13.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 13:39:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Erik Cervin Edin <erik@cervined.in>,
        Jeremy Morton <admin@game-point.net>,
        Chris Torek <chris.torek@gmail.com>, <git@vger.kernel.org>
Subject: Re: Proposal: tell git a file has been renamed
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
        <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com>
        <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net>
        <CA+JQ7M-1YvZFzE_CtBQa5_eEXa1sPqK4xsTxdwpAQo_YcmW+-A@mail.gmail.com>
        <91dab444-5f65-31ae-c0c6-0b84313bcd94@game-point.net>
        <CA+JQ7M_Lv1acopOpPoHxp7mPwWMFj-7wwwDPpV7KUbwFsjpoxA@mail.gmail.com>
        <6446d78fbbe82_cd61294e5@chronos.notmuch>
        <c7bb292d-903b-692e-885b-524b6bb113ee@intel.com>
Date:   Wed, 26 Apr 2023 13:39:48 -0700
In-Reply-To: <c7bb292d-903b-692e-885b-524b6bb113ee@intel.com> (Jacob Keller's
        message of "Wed, 26 Apr 2023 12:08:26 -0700")
Message-ID: <xmqqwn1yqsx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> The alternative would be something like Junio suggested where we have a
> separate rename storage database which is computed ahead of time (kind
> of like commit graph storage) and which could be overridden manually.
> This doesn't "bake" anything into the objects, but obviously requires
> manually keeping up to date and adds some difficulty in sharing such
> updates across remotes.

I think originally the recorded rename mechanism was dreamed up to
be a cache.  Unlike commit-graph that requires precomputation, it
would be populated incrementally when you run "git log -M" in a part
of the history that you haven't done so.  Sharing it would just be
as hard as sharing notes, once we point the rename cache with a ref,
I would think.

I cannot take credit for the idea, though.
