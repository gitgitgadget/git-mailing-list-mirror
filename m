Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FD0C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 00:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8766B20782
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 00:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ryembFHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgDUADx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725550AbgDUADx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 20:03:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3D8C061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 17:03:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p8so5909150pgi.5
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p5DvJyxZ9cNq4/SyWIqavIOtQKT6x92gj2Sy2f8kBeE=;
        b=ryembFHLiWP7wrD2kKJEgHFOrSGztFivXWFVu0pVqfPUCNgvDZhcAtndnsALu9lAFW
         vL6291zHYiNcdu4oW8t60Qz/tzwd6Jhm9mY8S0e6VdwagrUkydeVbnRHASWxiKYK6Qaz
         tna9gKObnE9gTf1nwpZFvvVyt5Oh8DYWGgwQZnHOhVUJNMV+ntWv9jqfPbel7Tqxu/dQ
         2CBG4sWmaQWRSBNCMoha02EJ7DoBQv8mYUXlnfiZoVJHY3gT5eADLbBRySqmFygCeVre
         X2QY8q7Dy3Mzxh8ssvHW9ac8nNWWBgYjTtSV34MPD1+RUUnZqx/wjmF0vGYiwXw/SDQ2
         EcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p5DvJyxZ9cNq4/SyWIqavIOtQKT6x92gj2Sy2f8kBeE=;
        b=liYO09+Vf2nMtpkl/NfS4mSKBsnFt/YiBC0wHl3CISwKzuRECjFRfiSeKLm2uR7edY
         BXPn8YuLlFElcW4i7DS5ElsynDcfdfqK7JaZdjQyoOESrglmRfBU4WhFQu63kHH6cPxx
         YVKAimYNAfJjrx/P4Kby/FlcPVuv60DqvuSYSt4kHv/whL8qLPHq4z48AMQqfumjX7My
         7KSbOHEAWyhA9nZ+KdX9OCuU0k0Rk4HN307hUQJsVkIR9CUM2r1qBp7uJNU2etpBxOB9
         KIAMAkRB24Cm3P+qLgA9olQp54nTpnXxsRzbx+w5km1HB/kgEqKqlruy+ZwvlFDSWGZx
         RTGg==
X-Gm-Message-State: AGi0PubQCdabuwBu2vGX9dyrf/hRu5ou4cppQng1Wm1hbuV7TFnR7bWg
        IE3/ikvBAf563yJs1nUYm8o4Ww==
X-Google-Smtp-Source: APiQypICk+OQPA4M7U153qZZkBPr/fn0KaO9xYP0Xkbrext9Hh4A5g8WB88yDGKzM8ubH/ePoTaUxA==
X-Received: by 2002:a63:4920:: with SMTP id w32mr14024060pga.119.1587427432147;
        Mon, 20 Apr 2020 17:03:52 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i8sm633946pfq.126.2020.04.20.17.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 17:03:51 -0700 (PDT)
Date:   Mon, 20 Apr 2020 18:03:50 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, vd@FreeBSD.org
Subject: Re: [PATCH] diff-tree.c: load notes machinery when required
Message-ID: <20200421000350.GA19835@syl.local>
References: <ce1ba0641e37ac84a104cd44af63e759324feb14.1586997354.git.me@ttaylorr.com>
 <20200416045630.GA21547@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416045630.GA21547@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 16, 2020 at 12:56:30AM -0400, Jeff King wrote:
> On Wed, Apr 15, 2020 at 06:37:38PM -0600, Taylor Blau wrote:
>
> > Since its introduction in 7249e91 (revision.c: support --notes
> > command-line option, 2011-03-29), combining '--notes' with any option
> > that causes us to format notes (e.g., '--pretty', '--format="%N"', etc)
> > results in a failed assertion at runtime.
> >
> >   $ git rev-list HEAD | git diff-tree --stdin --pretty=medium --notes
> >   commit 8f3d9f354286745c751374f5f1fcafee6b3f3136
> >   git: notes.c:1308: format_display_notes: Assertion `display_notes_trees' failed.
> >   Aborted
> >
> > This failure is due to diff-tree not calling 'load_display_notes' to
> > initialize the notes machinery.
> >
> > Ordinarily, this failure isn't triggered, because it requires passing
> > both '--notes' and another of the above mentioned options. In the case
> > of '--pretty', for example, we set 'opt->verbose_header', causing
> > 'show_log()' to eventually call 'format_display_notes()', which expects
> > a non-NULL 'display_note_trees'.
>
> This looks much better. One question, though...
>
> > @@ -127,6 +128,14 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
> >  	precompose_argv(argc, argv);
> >  	argc = setup_revisions(argc, argv, opt, &s_r_opt);
> >
> > +	memset(&w, 0, sizeof(w));
> > +	userformat_find_requirements(NULL, &w);
> > +
> > +	if (!opt->show_notes_given && (!opt->pretty_given || w.notes))
> > +		opt->show_notes = 1;
> > +	if (opt->show_notes)
> > +		load_display_notes(&opt->notes_opt);
> > +
>
> I assume these lines were lifted from builtin/log.c. But what is
> pretty_given doing here?
>
> In git-log, it's turning on notes for the default case when no format is
> given. But here, if no format has been given we _wouldn't_ want to show
> notes.
>
> I think it's relatively harmless, since our default format is not to do
> any pretty-printing, and therefore we wouldn't look at the notes. But it
> does cause us to call load_display_notes() when we don't need to. I
> think that conditional can be simplified to just:
>
>   if (!opt->show_notes_given && w.notes)
> 	opt->show_notes = 1;

Yep, your reasoning makes perfect sense, and I think that what you
suggested is exactly right. (The original code was indeed lifted from
'git log'...)

> > Fix this by initializing the notes machinery after parsing our options,
> > and harden this behavior against regression with a test in t4013. (Note
> > that the added ref in this test requires updating two unrelated tests
> > which use 'log --all', and thus need to learn about the new refs).
>
> This makes the test update rather hard to follow, but I don't think
> there's an easy way around it. I wondered if we could insert and remove
> our notes just for our tests, but it's hard to do with the big while
> loop in that script.
>
> I also thought it might not be that bad to just add a few tests at the
> end, but there are some complications (like removing sha1s from the
> output; easily done with a custom format, but the point is to test
> --pretty).
>
> So what you have is probably the most sensible thing (and the new commit
> would make it easier to test other commands around notes later, if we
> chose to).

Yeah :/.

> > @@ -398,6 +407,8 @@ diff --no-index --raw --no-abbrev dir2 dir
> >
> >  diff-tree --pretty --root --stat --compact-summary initial
> >  diff-tree --pretty -R --root --stat --compact-summary initial
> > +diff-tree --pretty --notes note
> > +diff-tree --format=%N note
> >  diff-tree --stat --compact-summary initial mode
> >  diff-tree -R --stat --compact-summary initial mode
>
> Perhaps worth testing that:
>
>   diff-tree --pretty note
>
> does not print any notes by default?

Good idea.

> -Peff

I'll send an updated patch as a response in a separate email shortly...

Thanks,
Taylor
