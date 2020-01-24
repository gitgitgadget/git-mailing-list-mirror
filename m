Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE0CC35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F2822522
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gP2vKs7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgAXD3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:29:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33007 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAXD3M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:29:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so308729pgk.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gs+8QAnK7uvaZX2ANTVK3SMbh/tunQRo2JOlZRSHwAY=;
        b=gP2vKs7V6t/qnFqEEHmLN+pFTGoJ37VRXKH61jF7dmNSxZqszdH+L1sxOPFEvMjlOC
         w2kzq2U0q+kRXp8UbM89ygDNEic2ZYev+rENaUoUdcIGRLTNeHzcLm9H2Uzf2YMQR0DY
         NIUthR6se7m2EfcdHXzMMNKaesCtRo3/vSaZUbMPb3/41GF254KxXpmWlIg+hbQSxikG
         sMngaBkNKtqAP5LOKsC9/QRpeLE7Q5msTI6BQ/aKANa9KJ+DG/6z5Hg9CYim9cf+tNtM
         6+1aeG1tCR/3JgniITs0vAnnom+8bIt0w511GbN317XJGNl4hogUbEABQgDwwJW8nICG
         ED2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gs+8QAnK7uvaZX2ANTVK3SMbh/tunQRo2JOlZRSHwAY=;
        b=DTSM1Vk75YjOI51Ww+pBgp09e7O7Yz9M0YjSFX8iAf2iP0a7snevZ77aWetuR5/hu3
         wccryFDMwHGtcA/IhQw5yRmoPUNuHbWBfbfMBRkt0NKU4TYykInyYWk7XARNl9WUR7tx
         Gi6DW9orIT30kp6CqUUi7FjA5ctWnCdKHsfmr0X4+G51chzzeXWTiA0BTEB0d5mfZEaY
         8wX1qrCwH6yEnYqSDh/2t0BWo2I5KPNbufRl9K6YgCAeDQiHbCKTZ8nCD7MUxM83154D
         mMMLWAGFJu5j4tYYUgKfKJfWrSD6SrVvxduNMplK/iNbMzPdWNwVvWw7mEh9chRmC152
         6OoQ==
X-Gm-Message-State: APjAAAW/LVY8kW5EvXZ8OAUKMbq1O4asYvT043hBLvljinOn07r3mdHs
        rT1id/crbGteSYVJB6d5UzNqXY/x5Xc=
X-Google-Smtp-Source: APXvYqymmeal0+gnvh8jZuBzUQJ15Sha0IcEOkKMzXjvqqIdlf+4vH1FaSVG55YO1xQaYKby5hlGJQ==
X-Received: by 2002:a63:4d4c:: with SMTP id n12mr1829430pgl.212.1579836551435;
        Thu, 23 Jan 2020 19:29:11 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b15sm4079518pft.58.2020.01.23.19.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 19:29:10 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:29:05 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 10/15] bugreport: add config values from safelist
Message-ID: <20200124032905.GA37541@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-11-emilyshaffer@google.com>
 <xmqq4ky3j3w4.fsf@gitster-ct.c.googlers.com>
 <20191216234036.GK135450@google.com>
 <xmqqfthij1ac.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfthij1ac.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 09:43:23AM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> >> But that is too simple-minded.  If we wanted to safelist foo.*.bar,
> >> where '*' can be anything, walking on the list of safe variables
> >> would not work.  We must have a hash table that knows "foo.*.bar" is
> >> allowed, and while walking all the configuration keys, when we see
> >> foo.a.bar, we consult "foo.*.bar" as well as "foo.a.bar" to see if
> >> it is whitelisted, or something like that.
> >
> > ...unless we want to use wildcards like you suggest.
> >
> > But I'm not sure it's a good idea. I envision someone writing another
> > Git add-on, which offers someone to specify "user.password" ...
> 
> Wildcarding the leaf level of two (or for that matter three) level
> names like "user.*" in your example is of course a nonsense way to
> use the safelist.  But think about three-level names where the
> second level is designed to be used for user-supplied token to give
> things of similar nature a name the user can use to distinguish
> things.  If remote.origin.url is worth reporting, wouldn't
> remote.upstream.url also be?  Shouldn't remote.*.url be the way to
> say "the URL field for each and every remote is a safe thing to
> report" in the safelist?

Bah, somehow this mail slipped through the cracks for me.

When you put it that way, I see how it can be useful. Although I admit
to fatigue on this patchset and now I'm hesitant about feature creep. :)

I'm going to send the reroll for v5 as I have it, not having seen this
mail, and think more about how I'd approach wildcarding in the middle
like this. I want to take a look at the other configs which use a middle
level as a user token and try to reason about whether we ought to be
collecting them. I'll hope to report back sooner (or later).

 - Emily
