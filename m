Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CB8C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEC761164
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhFGQEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:04:25 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:34558 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhFGQEY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:04:24 -0400
Received: by mail-ej1-f52.google.com with SMTP id g8so27580762ejx.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KFjlqySg+VEXh94xbySqXcO4PWSPfDabhrEv9aumi4I=;
        b=l+UBJ4IXOW0H6aaWNAjYfgeb0nADuB7KrYKlz6LqsZTp8bRhJlvSTeEle8H04CG7EM
         uelPKtZLdG/pwki7bQwUM5H3w1lcRuvcTGAu+WmKj447KQp2PQEtOqpMQ/ZEyTJgZCzJ
         KhbsAZxjNU3lgRll7KTmhVvWRMvqJ9/PLvTkLbBH8Qb1osa4ZMn6NokzW3ExcJDJLa2o
         /lgG12QA26K871UggOwkRdMlLGHXehg5N73B2272V0Jc+uiOnsq6xVt2jHw/H9GfSUSq
         oiXPQd3Rd/o+DC1hIesVdpmvQwbjRW2/ia2HfTqk2POKv8Eb05EAeOEzc6LwjYFq2EHm
         AzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KFjlqySg+VEXh94xbySqXcO4PWSPfDabhrEv9aumi4I=;
        b=m8bT3AsE7He8Uw4WlxeHWRBQ7MAKLduEfubQ3gE4jlZ+Pipe2CbAeWu+28c09OUJVJ
         nkAe0DB7FU/S6pq3xXbHeB4U5BGrfGLccQirTiru7V3z9mAV2mJ2cboG+Z4f2qybQXm2
         S3NrNNe4TR1tgux+/xImGz3Ymf04xxGjfGPYFtgc92clezsGMMbpV1E8dHy0InOXizwj
         rutEiETCn2uKeT+RzduY6Z6BCF+4RMDUGYaDfUQCqgKC5sNqecBSs5bduKCOCJTkW0b4
         U4onyzdZD1rjZRLmX9lSYmVYnPSZ71sPZrIfD78h/yCUotfF1kcAoiyi5mCi46GQZMB9
         uimA==
X-Gm-Message-State: AOAM533VfGzgbpvUWyaxrH4u4CG4IttLcwr2hP9xz4TxPX+mYIofq3ri
        htj1whnbrpiKpqaNRHolvPO9C7HB6HqkFw==
X-Google-Smtp-Source: ABdhPJw9DrDGVZFZ3Iykyc19G5me0OvIwZNkmMtmcqUP6DaumW25nl5iG7b53Cz/frGrc5HpYNlNfQ==
X-Received: by 2002:a17:906:22c8:: with SMTP id q8mr18061822eja.12.1623081678815;
        Mon, 07 Jun 2021 09:01:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v26sm6676475ejk.70.2021.06.07.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:01:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
Date:   Mon, 07 Jun 2021 17:58:23 +0200
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
 <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
Message-ID: <87k0n54qb6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 07 2021, Derrick Stolee wrote:

> On 6/7/2021 10:43 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix a potential incorrect display of the number of items (off by one)
>> and stalling of the progress bar in refresh_index().
>>=20
>> The off-by-one error is minor, we should say we're processing the 1st
>> item, not the 0th. This along with the next change also allows us to
>> remove the last display_progress() call outside the loop, as we'll
>> always have reached 100% now.
>
> This "pre-announce the progress" seems correct and is unlikely
> to have a user sitting at "100%" while the loop is actually doing
> work on that last cache entry.

I guess pre-announce v.s. post-announce is a matter of some philosophy,
for O(n) when can we be said to be doing work on n[0]? We entered the
for-loop and are doing work on that istate->cache[i] item, so I'd like
to think of it more as post-announce :)

In any case, I'm changing this to the established pattern we use in most
other places in the codebase, this one was an odd one out.

Thanks for the review of this.
