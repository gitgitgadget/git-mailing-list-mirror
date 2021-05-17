Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15A0C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 22:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19E0611BF
	for <git@archiver.kernel.org>; Mon, 17 May 2021 22:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbhEQWpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 18:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344049AbhEQWpk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 18:45:40 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFC6C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 15:44:23 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so6972472otp.11
        for <git@vger.kernel.org>; Mon, 17 May 2021 15:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=auweyNb+9glgaU+zXRnjm70pq0CtuGXYAOu+8O53QU0=;
        b=uT+jvVp9iKDQfBvykHX8KSUSwNTdLACl1ZQBrm53pemmyESc+hWbHKs8RHC5NJ6sMo
         SvqD1a4lRQdlFNP1mSM1+FKpDzsBu8E7RIIrDp6Xq54B/3p2gdilTFJrqjyqPS3YsLnz
         sdoV2p+mtWjh4cKwRT76bvuGGXhK5QJ3EUHVX2XYHi2POUWIxOOWZD+NP599/oTe5fgQ
         Xii+reF/qevamis6FXjQvmWv+mh+uFtP2lrIoW+fvWNdD+gcqo7RcoWhvhCdNkmvBzTa
         9litjmg3Zs6D3u/uaWApnNWAgzj7/9kIhIYEzmHHkyNB2A2l8LOtTFwvSqLqmXKTALnp
         iuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=auweyNb+9glgaU+zXRnjm70pq0CtuGXYAOu+8O53QU0=;
        b=TwMfzTNwT49yjeNCYxsvdFCK2sizJLxz1b6gKTFlFWv3zqplzAsvtJwvFDafp+CdPP
         Z/9quAOBqI0fqIj8zseyZ5EfATRS6SuTtQfokAxFW5mn2vYKLBCiPW+Wxs6KdiDd3Czl
         JYXaHtSC6EwtoQoNarTRgSA4+9hiTzfogGXL7PF1EG9K5QgfsD1SS2iXgl9SRqK4AmU4
         /hWWGE+cV5zKx2Yfr9QYt0d0vqp0B9CYQDR9leh7OAZWJy8nLT6kFGt6ZOxh3gaN5WUG
         Y2JwPDoYFltjO9rGqt6899Ed3BCSIX/34gHceY0gOIt7u+hfhP9VafDuR1//hQMapk9V
         Sipw==
X-Gm-Message-State: AOAM530UMaURRbrpldTqfOYsi2sxmntLLvHj1Ewi5cQH9TIw2fVS30Ie
        7UAMYADpWw6N0Vu6uBVLGSU=
X-Google-Smtp-Source: ABdhPJw8LTo/IAz9DMRFzOTqcWPSYdCNi7Zzxwz/AqY8bb3unVIMNXs+cf7cVxbLcUUJh6RzGocvzw==
X-Received: by 2002:a05:6830:40a4:: with SMTP id x36mr1529854ott.342.1621291462562;
        Mon, 17 May 2021 15:44:22 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i17sm2786029otp.14.2021.05.17.15.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 15:44:22 -0700 (PDT)
Date:   Mon, 17 May 2021 17:44:20 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <60a2f1c4cab0d_13c3702083a@natae.notmuch>
In-Reply-To: <xmqqlf8d6ty5.fsf@gitster.g>
References: <60a046bd83001_f4b0f20861@natae.notmuch>
 <87tun1qp91.fsf@evledraar.gmail.com>
 <xmqqlf8d6ty5.fsf@gitster.g>
Subject: Re: Man pages have colors? A deep dive into groff
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> =

> > This looks much better.
> >
> > I wonder a good follow-up (hint, hint! :) would be to have
> > exec_man_man() and exec_man_cmd() in builtin/help.c set this dependin=
g
> > on color.ui (so we'd do it by default with "auto").
> >
> > Then e.g. "git help git" would look prettier than "man git".
> =

> As long as color.man.ui can be used to override the blanket
> color.ui, I think it is a good idea.

Why not use color.pager?

-- =

Felipe Contreras=
