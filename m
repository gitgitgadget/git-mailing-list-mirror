Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE31C2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D391720728
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtBOZzgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgDXLAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXLAC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 07:00:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182AC09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:00:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d15so8639149wrx.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bemzeg2Sd3M+H5e5pBBR0eCRtcVk6vp8CdmCx2DLxpY=;
        b=HtBOZzgs4gFCJ3HPATfKdNdtLfSo+eHyn/SuW3QZCQCBSiqIR0MBqnvALsFV4CVnX3
         eUBF++Y5gQ55i5zj2/CVkLpCdtRQ7Lw3jvWjIEjjjzq4Qg/dRED6RCgzNxYrPSXf0oGe
         wo1TWvPjy+FBQVRpGo3rc6/LS4EI/alIhBry0A55z4+NRDp4XFzw1/W6DUYtTRMK2Lhs
         RkhDCPRW1eFkR4YFs0Sv9y/gLmWB7sGadP0XyZzIlfDteWVJfDDzRfaBHcFK5szGXWJ+
         OL/xZx010QkDbCk8pAx6DggZs4eEgO5Hr1wSbsJ1gWFU/3FdZyXz77pBvhJlW2E9jMmZ
         LMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bemzeg2Sd3M+H5e5pBBR0eCRtcVk6vp8CdmCx2DLxpY=;
        b=NbdySlaUDul9G0tBTXheJgPrqSeGNWpzypFkWBnu4XoKMb1UaCqQGeemfGdpNOl1vU
         lrCVUz3Qu+WHl5njktypm3HyKqVCB1pBuEsy5uY+h97ZcP9BlaW55rVHyAX4bisSWkMZ
         DfhjpwjuclG3GurJ5r4KdpnMLYcJZvbS5S/bFo1OtN7Pi27rHdM/dFglYP156v1EQeRR
         SHtt3CKgOme/1+T0TyHUvjbFqcKH68YLKBdRn1wrV+4QLCiUNPdcIT9Rfu4thz72bx62
         6b2r54wvju9m4xTxgOzm5U3TFHUCVI/VO/5i/vXd+3RwFFMdIEaVbQp+53ThOXm+gJzS
         j6DA==
X-Gm-Message-State: AGi0PuZkaEGqQAcQX3+Tknk/1q/CbydK989C79mXlZjFt3n5DWDUWY8I
        bSft8/T3WmHG6al/jLXMxUU=
X-Google-Smtp-Source: APiQypLg+KBka83jEIdXc7f0Wnb//bc8d3q+f+DHvWvMLeZmScKWCUPQwmyZGl1IswVozF91RxViog==
X-Received: by 2002:adf:f98e:: with SMTP id f14mr10340074wrr.253.1587726000457;
        Fri, 24 Apr 2020 04:00:00 -0700 (PDT)
Received: from szeder.dev (92-249-246-129.pool.digikabel.hu. [92.249.246.129])
        by smtp.gmail.com with ESMTPSA id k9sm7981542wrd.17.2020.04.24.03.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 03:59:59 -0700 (PDT)
Date:   Fri, 24 Apr 2020 12:59:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com, peff@peff.net
Subject: Re: [PATCH 7/7] commit-graph.c: introduce '--[no-]check-oids'
Message-ID: <20200424105957.GB5925@szeder.dev>
References: <cover.1586836700.git.me@ttaylorr.com>
 <1ff42f4c3d568dd25889d2808cda3edf38a36cb9.1586836700.git.me@ttaylorr.com>
 <20200415042930.GA11703@syl.local>
 <20200415043137.GA12136@syl.local>
 <20200422105536.GB3063@szeder.dev>
 <20200422233930.GB19100@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422233930.GB19100@syl.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 05:39:30PM -0600, Taylor Blau wrote:
> > > diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> > > index 46f7f7c573..91e8027b86 100644
> > > --- a/Documentation/git-commit-graph.txt
> > > +++ b/Documentation/git-commit-graph.txt
> > > @@ -82,6 +82,11 @@ tip with the previous tip.
> > >  Finally, if `--expire-time=<datetime>` is not specified, let `datetime`
> > >  be the current time. After writing the split commit-graph, delete all
> > >  unused commit-graph whose modified times are older than `datetime`.
> > > ++
> > > +The `--[no-]check-oids` option decides whether or not OIDs are required
> > > +to be commits. By default, `--check-oids` is implied, generating an
> > > +error on non-commit objects. If `--no-check-oids` is given, non-commits
> > > +are silently discarded.
> >
> > What happens with OIDs of tags, in particular with OIDs of tags that
> > can be peeled down to commit objects?  According to (my (too
> > pedantic?) interpretation of) the above description they will trigger
> > an error with '--check-oids' or will be ignored with
> > '--no-check-oids'.  The implementation, however, accepts those oids
> > and peels them down to commit objects; I think this is the right
> > behaviour.
> 
> That's right, and certainly merits a mention in the documentation. I've
> added that...
> 
> > What happens with OIDs that name non-existing objects?
> 
> ...these are silently discarded. I think that you could make a
> compelling argument in either direction on this one, but I'm slightly
> swayed towards "discard these, too", since '--no-check-oids' is
> literally saying "don't check these".

I don't want to argue either way, but I'd argue for making a conscious
decision that is justified in the commit message and documented in the
docs.

So, the option is '--stdin-commits' or '--input=stdin-commits', but
it's not only about commits.  Now, allowing OIDs of tags pointing to
commits and peeling them makes obvious sense, because we want commits
reachable from those tags included in the commit-graph file.  Allowing
OIDs of tags pointing to non-commits and silently ignoring them makes
sense (to better support your 'git f-e-r ... | git c-g write ...' use
case), though it's not that obvious (after all I managed to overlook
it back then, that's why we are now here discussing these
'--check-oids' patches).

But I'm not sure about silently ignoring OIDs pointing to non-existent
objects, because those might be a sign of some issues in whatever is
generating the list of objects to be fed to 'git c-g write'.  E.g. there
could be a race between 'git for-each-ref' listing OIDs and some other
processes pruning them.  Does this worth worrying about?  Dunno...
but at least let's think it through, and record in the commit message
why we made that decision, whatever that decision might be.

> I guess that pushes us into the territory of whether or not "check" is
> the right verb. "verify"? 

Oh, I didn't think about this, but now that you mention it we have
'--verify' in 'git rev-parse', 'git tag' and elsewhere, and we have
'verify-commit', 'verify-path' and 'verify-tag' commands.  So
'--verify-oids' might be more consistent.  I kind of like the 'oids'
suffix in the option name, though I don't know what else we might want
to verify in this command in the future...

> "scrutinize" :)?

Huhh, erm, no ;)

> If you're otherwise satisfied with this series, here's the updated
> patch.

I haven't yet looked closely at the rest of the series...  The
documentation update in the updated patch below looks good to me,
thanks.

> -- >8 --
> 
> Subject: [PATCH] commit-graph.c: introduce '--[no-]check-oids'
> 
> When operating on a stream of commit OIDs on stdin, 'git commit-graph
> write' checks that each OID refers to an object that is indeed a commit.
> This is convenient to make sure that the given input is well-formed, but
> can sometimes be undesirable.
> 
> For example, server operators may wish to feed the full commit object
> IDs pointed to by refs that were updated during a push to 'git
> commit-graph write --input=stdin-commits', and silently discard any
> input that doesn't point at a commit. This can be done by combing the
> output of 'git for-each-ref' with '--format %(*objecttype)', but this
> requires opening up a potentially large number of objects.  Instead, it
> is more convenient to feed the updated object IDs to the commit-graph
> machinery, and let it throw out whatever remains.  to commits.

Either the bulk of a sentence is missing, or there is a stray(?) "to
commits." at the end of this line.

> Introduce '--[no-]check-oids' to make such a behavior possible. With
> '--check-oids' (the default behavior to retain backwards compatibility),
> 'git commit-graph write' will barf on a non-commit line in its input.
> With '--no-check-oids', such lines will be silently ignored, making the
> above possible by specifying this option.
> 
> No matter which is supplied, 'git commit-graph write' retains the
> behavior from the previous commit of rejecting non-OID inputs like
> "HEAD" and "refs/heads/foo" as before.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-commit-graph.txt |  6 ++++++
>  builtin/commit-graph.c             | 11 ++++++++---
>  t/t5318-commit-graph.sh            | 28 ++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 46f7f7c573..6bdbe42766 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -82,6 +82,12 @@ tip with the previous tip.
>  Finally, if `--expire-time=<datetime>` is not specified, let `datetime`
>  be the current time. After writing the split commit-graph, delete all
>  unused commit-graph whose modified times are older than `datetime`.
> ++
> +The `--[no-]check-oids` option decides whether or not OIDs are required
> +to be commits. By default, `--check-oids` is implied, generating an
> +error on non-commit objects. If `--no-check-oids` is given, non-commits
> +and non-existent objects are silently discarded. In either case, tags
> +are peeled down to the object they reference.
