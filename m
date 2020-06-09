Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635C6C433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 17:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A912207ED
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 17:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgFIRiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:38:23 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:34112 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgFIRiW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 13:38:22 -0400
Received: by mail-wr1-f53.google.com with SMTP id r7so22300225wro.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 10:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Flyu1QJaap3tt8L0GjAltyPmgoFliun5PzJ7RwmjtIw=;
        b=TVtoG2IZ98dYrgC6a5ws9BQ7GaaJqOVxDiHzR2R8Jsbs4jtAEn1IJwYJ8HW3sXn1ld
         vQhKM9yIQ28lkYVEc5oMXZ/qL0YxTAMXrFQbrme7tyae20SjvzF2vaDdOlHTBalN9RTp
         3ZQlR8mgmzpl9HZEipsslcmaP+xRZdPRAeQQzmkrF7YPlfMLwqp78XD1HHn8eL8Vn55i
         kWumzhxey6C5RjWRZf04wS82gUpnIPKautCy8Q/LawC1U/Xf9TvOhFoMtgN1I3rZqbqh
         8r4rss+f2PwrTzM2zdzV2fmmxMHQ44KGnXKY7fp7RG4Phc+k9ry8KFEhWpiCecP6cO1u
         NHMw==
X-Gm-Message-State: AOAM532UpM4sOyGXXLnfuFsmssrGR8dmx4xGbd7EZAhl7bf5Oh8YLrbe
        KSjwtXQlfkz9lh2dy4MCCZHwZ2cjyc0R1/pG06TspbT1
X-Google-Smtp-Source: ABdhPJwOx62hkeLF3yQECZQfvy5vK/D0YbSfPprVShnk+SwSTHGa5mT8q0IttY+NnQIhFaowpQDugLYFWGphGddSBIE=
X-Received: by 2002:adf:fd48:: with SMTP id h8mr6098295wrs.226.1591724300787;
 Tue, 09 Jun 2020 10:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200608062356.40264-1-sunshine@sunshineco.com>
 <20200608062356.40264-7-sunshine@sunshineco.com> <xmqqmu5djk1s.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu5djk1s.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 9 Jun 2020 13:38:09 -0400
Message-ID: <CAPig+cSbwRXeuuk1nOTbVtbQ+cf3Z3+ouCDVBONSMq0htxS48w@mail.gmail.com>
Subject: Re: [PATCH 6/8] worktree: prune linked worktree referencing main
 worktree path
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Jonathan_M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 8, 2020 at 5:59 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > +     /* paths same; main worktee (util==0) sorts above all others */
>
> And the reason why prune_cmp() tiebreaks entries with the same .string
> (i.e. "path") so that the primary worktree comes early is because ...
>
> >       prune_dups(&kept);
>
> ... deduping is done by later entries with the same path as an
> earlier one, keeping the earliest one among the ones with the same
> path.  We want the primary worktree to survive, or we'd be in deep
> yoghurt.
>
> That reason is more important to comment in prune_cmp() than the
> hint that !util is for primary worktree.  IOW, "why do we sort the
> primary one early?" is more important than "by inspecting .util
> field, we sort primary one early" (the latter lacks "why").

I'll update the comment to explain this.

Thanks for the review.
