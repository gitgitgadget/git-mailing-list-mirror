Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B5EC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516F064EB8
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhBAMyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 07:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhBAMx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 07:53:57 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB033C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 04:53:16 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id l12so19430597ljc.3
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 04:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzuKuWBAQ6addo4jvHvv0BX75uYbuyIw88dBG5g35iE=;
        b=vTg7ljFhD42QygTBxZiyOLHOW56OTGE1M1qoMDecCh3c0VIEVXcPrF7SIQlZqeE5aZ
         xVPkFAqXkXEk8fi5DGEmSYWWtf/FEvMZXwb0pV0x0pld8DlfnKXzPR07c3BqU64NK8N4
         dN4nqLI6dSVJoeOjnYc6NRHoivx4moeyHUBn+nSm9jtXfbUR8hZUpTBsEpGSI9tjJeOl
         oW7mLApZrWn0DBoss/xQ8H/w0mojyhrch/HsdUOX06xy2CmX+So30J75Eo510R/NWkB+
         rg6xZWOfORn5vIFk0PaT4EpOY7m3SZitfJYh5zeRGYsTSSAMcsyHfd7ooc8ZtK8+mi9u
         RN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzuKuWBAQ6addo4jvHvv0BX75uYbuyIw88dBG5g35iE=;
        b=V9PmA8CtE4Kr4wWQJ1NystU0YpHF6NUAvrUAbtZp0+I0g1WiuR6bOHgZaDp8KNsk28
         9RbTxf6Cj6TAPeJvRellOWydnnZBPDLrnQegv9FKsw6fjVp1mQuc2pgZT+YN2+a59cmK
         5XdSuIWJz2gr7aK13ahBIUHL/+RcIx3Q8CugcpD7YGCEcXFP/vgj44GC3OKuf9JzSx9R
         SbY60CsEVK+BmcaDWc87IjeXU05gg1yVMzmScidu+TOp36rEwzep5EvJodrGg4QgVh5U
         3Lq9pek9rySyzGXsDuaO7waGsJdlJje46tlkK1S2fuP4O7OB1dsVm3iabKp6waZ0ec7Q
         plrw==
X-Gm-Message-State: AOAM5302qbjF2hZivIZGNRrPHU6rYQqvcOcoE7M7mP0cTBIBXkHdrdbG
        SCnD7re1aYsIVj2p1TAetA8aLNsJ0bkFu5u84W0=
X-Google-Smtp-Source: ABdhPJx75+XLP8YckoD9j0cZ7f84Pn0YR2c+SWhFml4M8DyAYqpKFmgZA7a5qsf2LtkVn5foMWV2WWMb/dN3MnzkNms=
X-Received: by 2002:a2e:7812:: with SMTP id t18mr6257813ljc.168.1612183995207;
 Mon, 01 Feb 2021 04:53:15 -0800 (PST)
MIME-Version: 1.0
References: <YAG/vzctP4JwSp5x@zira.vinc17.org> <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org> <87o8h4omqa.fsf@evledraar.gmail.com>
 <20210201103429.GT623063@zira.vinc17.org> <CAPx1Gvf92eCnSCZJLeqwyL-SprCxmnfi4w=d0-MHddY38DzADg@mail.gmail.com>
 <20210201123635.GA24560@zira.vinc17.org>
In-Reply-To: <20210201123635.GA24560@zira.vinc17.org>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 1 Feb 2021 04:53:03 -0800
Message-ID: <CAPx1Gverh2E2h5JOSOfJ7JYvbhjv8hJNLE8y4VA2fNv0La8Rtw@mail.gmail.com>
Subject: Re: git fails with a broken pipe when one quits the pager
To:     Vincent Lefevre <vincent@vinc17.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 1, 2021 at 4:36 AM Vincent Lefevre <vincent@vinc17.net> wrote:
> In general, repositories have more than 64k log.

Please don't focus on the exact size.  Some system might
have a multi-gigabyte pipe buffer, and some other system
might have a tiny one; we'd like consistent behavior no matter
what size the system uses.  Can we *get* consistent behavior?
I don't know.

[me]
> > The problem that has come up is, if I understand correctly, that
> > some Linux distributions have come with misconfigured pagers
> > that don't bother reading their input, and silently exit zero.
>
> They are not misconfigured. This is how they work.

A pager that reads nothing and writes nothing does not seem
very useful to me.  (Perhaps we can disregard these cases
entirely.  It's not like we should expect Git to handle things if
someone builds a version of `less` that doesn't work.  The
fact is that on these Linux systems, running `$pager foo` on a
file `foo` does nothing at all, for some values of `$pager`.  I
believe I ran into this on a Docker setup at least once.  It's
not Git's fault and hence not something for it to correct.)

[on various exit cases]
> > There's no good way for Git to be able to tell which of these was
> > the case.
>
> In the case git spawns a pager, it knows that this is a pager
> (as per documentation).

Again, this seems irrelevant.  If the pager exited correctly
while reading everything, or it exited correctly without reading
everything, or if it exited incorrectly with or without reading
everything, is not something *Git* can tell.  I'm therefore not
sure that Git should *try* to tell -- which is the point I'm trying
to make here.  The question is this: if we can only do a poor
job, should we try at all?  What *should* we do, given what
we *can* do?  All we get is SIGPIPE and an exit status, and
the SIGPIPE may or may not be meaningful.

That seems to be what you're arguing as well.  So I'm not sure
why you're objecting to what I'm pointing out. :-)

Chris
