Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADBBC433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB75722517
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 00:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgLXAPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 19:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgLXAPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 19:15:09 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A407DC06179C
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 16:14:29 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id o5so142333oop.12
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 16:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ncSCUZP/7d5/gndcdvmY8h8UEGA7wQogS/5zvtES8O8=;
        b=nd7x9T2vOUtVh0PulWPqOsmzV8eYhhTcKsDQS/9VWL91vt+mIDyKPK2pfujrdB/Evy
         MiJ7QeHKFIwiLSrQTkDH5zlkkvlXJypkZxmXAnqIsRRofyHcOLxS5M032WWyk37Z/KxH
         YPUu8IV/uRG/DWoqozsEfgJqxEISFK+1FF+/uqNvxb03GlIs6WiAG25C09rA8gvxKwkQ
         LwM8rRxDEcJps5HbyH0XbWppSc7vOYyuqRZATLipQb92hz2dFJjyesG7mg15bBF6lcIu
         HpTCLSWT/E98+6QpIfGuk1fQEDvmNrsDOkekwuDZP9QdrWK345cd6pnBhuqFf1DOLg2H
         GQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ncSCUZP/7d5/gndcdvmY8h8UEGA7wQogS/5zvtES8O8=;
        b=eSh0E6cAVmhTd3HgH1rvLW1Wn4iglfRgxva7ciRulASEajt06E7k1+H6HoDuRyWrLE
         0Z3CMHILOlq6q1TiVWsQa4MMDVzCja5OqUnkQ2WFYQIOjvqWDlYA7yNNg0R0yLCPy8vo
         3DEVHWoPV33R5SM78SMG6mHF3PgNYkSfydCZ0Qj56ar11dUNZOFmfjofeToV2msT/x9t
         OVvNWlIIqmKAZQ1Q7CTik8MGZEx3e6lh1A1fr1+Tw+GbQVCDIwCBckpLx38gt2p6kTRc
         Pmb+gxA1Gven6mzfZiZLOplGau3juP6R/GXOxgooxK/SQpojkxDbNq3agR8803uL3dop
         bEOg==
X-Gm-Message-State: AOAM531MtgMGLpLBDKOa9VHJDyt45PobpHrkijVe3D0G2DKt1Ii0TO9l
        zyUE77NduHleLpI1T55mb/s=
X-Google-Smtp-Source: ABdhPJwrlwzN436xy1OvvInYnl+TLEY6lGuJYTJ0XYm+Hiby28gLzK9LVXtZyhTkrjngHh55UPKtCg==
X-Received: by 2002:a4a:e14f:: with SMTP id p15mr20044694oot.25.1608768868826;
        Wed, 23 Dec 2020 16:14:28 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id a24sm6096183oop.40.2020.12.23.16.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 16:14:27 -0800 (PST)
Date:   Wed, 23 Dec 2020 18:14:26 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Message-ID: <5fe3dd62e12f8_7855a2081f@natae.notmuch>
In-Reply-To: <xmqqblek8e94.fsf@gitster.c.googlers.com>
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
 <20201223045358.100754-2-felipe.contreras@gmail.com>
 <xmqqblekabof.fsf@gitster.c.googlers.com>
 <5fe352e3968f6_198be2083@natae.notmuch>
 <xmqqblek8e94.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v5 1/1] mergetool: add automerge configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> > +auto_merge () {
> >> > +	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
> >> > +	if test -s "$DIFF3"
> >> > +	then
> >> 
> >> We do not want to ignore the exit status from the command.  IOW, I
> >> think the above wants to be rather
> >> 
> >> 	if git merge-file ... >"$DIFF3" &&
> >> 	   test -s "$DIFF3"
> >> 	then
> >> 		...
> >
> > That doesn't work.
> >
> > "git merge-file" always returns non-zero status when it succeeds (it's
> > the number of conflicts generated).
> 
> Ah, I forgot about that one.  I think "the number of conflicts" was
> a UI mistake (the original that it mimics is "merge" from RCS suite,
> which uses 1 and 2 for "conflicts" and "trouble") but we know we
> will get conflicts, so it is wrong to expect success from the
> command.  Deliberately ignoring the return status is the right thing
> to do.

I agree. My bet is that nobody is checking the return status of "git
merge-file" to find out the number of conflicts. Plus, how can you check
the difference between 255 conflicts and error -1?

But that's the situation we are in now.

> > What if the original file does have these markers?
> >
> > Which is probably something we should be checking beforehand and not
> > attempt an automerge in those cases.
> 
> Yes, that is a much better approach to avoid unnecessary work.
> 
> When we made the conflict marker length configurable, we were hoping
> that we no longer have to worry about the cases where payload files
> (original or ours or theirs) have lines that are confusingly similar
> to the conflict markers, but because we are interfacing external tools
> that are unaware of the facility, it probably would not help us in
> this case all that much.
> 
> FWIW, we use a fiarly large size for our own files in t/ and
> Documentation/ directories ourselves, and it does help topic branch
> merges somewhat frequently.

We could do something like --marker-size=13 to minimize the chances of
that happening.

In that case I would prefer '/^<\{13\} /' (to avoid too many
characters). I see those regexes used elsewhere in git, but I don't know
how portable that is.

If we wanted to make sure none of those markers remain it's not enough
to check for '^[<|=>]{13}', what follows up should be a space, or some
delimiter, not another < for example. So maybe '^[<|=>]{13}[^<|=>]'?

So, do we want those three things?

 1. A non-standard marker-size
 2. Check beforehand the existence of those markers and disable
    automerge
 3. Check afterwards the existence of those markers and disable
    automerge

Cheers.

-- 
Felipe Contreras
