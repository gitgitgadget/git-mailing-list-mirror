Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96114C47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B072166E
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PQx5XSuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgEAWiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 18:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgEAWiv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 18:38:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FB3C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 15:38:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d17so5173192pgo.0
        for <git@vger.kernel.org>; Fri, 01 May 2020 15:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hz3neY9iPmx849Ss+uh150TkaaJgoXc8DXx5I3RtHsM=;
        b=PQx5XSuTC/8mE//BXGwQMUps7RHopNA/3wg3dOUBc2jHQdx0pqVbN8BNq5Pv604+/s
         IBkaiXcZibSfDoU0jqq7tovCFSKD460Bvh6AHBw6bsp59iXq1e/8OVYD8ijl2URa+enJ
         +rzRgLT2i4UEWvfVcIuXR9tB5Ij8KWFuwMDJ+UV88gpLO+4gxsBXD1IwXDMr041/NPHu
         ZQpWdsRvLOy4RxZpXkjRR883V/3b45v5L0Tp/2CDlT+xAkqkytrfEso1mhhANkb7s7qG
         DuYRvZuapHXmJYRXVX7mbo5o8QeMw7U8fvvBJ/9IWP3XlNwjKTyViow8gkG1zy8ovL7m
         35AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hz3neY9iPmx849Ss+uh150TkaaJgoXc8DXx5I3RtHsM=;
        b=p7CnFsi/7ZBNOZM8BK6S1iRh7t4H3DwW6ewv6ejDVWAAWXm0aEQxJuvUrnnWqmhyJC
         9X7uVFR2ar95ZHQ6xEFhamkInP37Qh8hUd2QL7Gx+1MgcwZn1ZVEUfbA+ie+4/DHsM6N
         LiCO96zYz8TWyblOWlv9hlTuO0IaIkvWBtfO4ObocudyihC5zTuQ5HDlW6MAWVLE0efV
         bPiJPa08RuNV8ft70yADUIerqUGkfF665LCiiW6aCLlskgbeNo3OH563YA68QBomiYAk
         3/1meaDlMDcOrutoitipkf9pTj8kiRb+Uy16XWBLq/9fFeu1BQiVwL9638bDNdMYVOGH
         SDeQ==
X-Gm-Message-State: AGi0Pua6nS3oA1ZRtBVg8NBezGlorPfT6hRruJun9OfjTv7BKToD01Aa
        giKwSu3ZhF5zEeiiu4nHNdVKJD7TTaTZtbTA
X-Google-Smtp-Source: APiQypIu8LXppc2sx9C2AzvP11XVUQ1aMQ8JWz3Mc+JgFwzGst/5VwcewGmIDtR1AcR65L0si2dwQQ==
X-Received: by 2002:a63:c908:: with SMTP id o8mr4718266pgg.100.1588372730215;
        Fri, 01 May 2020 15:38:50 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id ie17sm612315pjb.19.2020.05.01.15.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 15:38:49 -0700 (PDT)
Date:   Fri, 1 May 2020 16:38:48 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net
Subject: Re: [PATCH 7/7] commit-graph.c: introduce '--[no-]check-oids'
Message-ID: <20200501223848.GH41612@syl.local>
References: <cover.1586836700.git.me@ttaylorr.com>
 <1ff42f4c3d568dd25889d2808cda3edf38a36cb9.1586836700.git.me@ttaylorr.com>
 <20200415042930.GA11703@syl.local>
 <20200415043137.GA12136@syl.local>
 <20200422105536.GB3063@szeder.dev>
 <20200422233930.GB19100@syl.local>
 <20200424105957.GB5925@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200424105957.GB5925@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 12:59:57PM +0200, SZEDER Gábor wrote:
> On Wed, Apr 22, 2020 at 05:39:30PM -0600, Taylor Blau wrote:
> > > > diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> > > > index 46f7f7c573..91e8027b86 100644
> > > > --- a/Documentation/git-commit-graph.txt
> > > > +++ b/Documentation/git-commit-graph.txt
> > > > @@ -82,6 +82,11 @@ tip with the previous tip.
> > > >  Finally, if `--expire-time=<datetime>` is not specified, let `datetime`
> > > >  be the current time. After writing the split commit-graph, delete all
> > > >  unused commit-graph whose modified times are older than `datetime`.
> > > > ++
> > > > +The `--[no-]check-oids` option decides whether or not OIDs are required
> > > > +to be commits. By default, `--check-oids` is implied, generating an
> > > > +error on non-commit objects. If `--no-check-oids` is given, non-commits
> > > > +are silently discarded.
> > >
> > > What happens with OIDs of tags, in particular with OIDs of tags that
> > > can be peeled down to commit objects?  According to (my (too
> > > pedantic?) interpretation of) the above description they will trigger
> > > an error with '--check-oids' or will be ignored with
> > > '--no-check-oids'.  The implementation, however, accepts those oids
> > > and peels them down to commit objects; I think this is the right
> > > behaviour.
> >
> > That's right, and certainly merits a mention in the documentation. I've
> > added that...
> >
> > > What happens with OIDs that name non-existing objects?
> >
> > ...these are silently discarded. I think that you could make a
> > compelling argument in either direction on this one, but I'm slightly
> > swayed towards "discard these, too", since '--no-check-oids' is
> > literally saying "don't check these".
>
> I don't want to argue either way, but I'd argue for making a conscious
> decision that is justified in the commit message and documented in the
> docs.

Me either, I very much welcome your consistently thoughtful replies
(even if my extreme delay in responding to this one would suggest
otherwise... ;)).

> So, the option is '--stdin-commits' or '--input=stdin-commits', but
> it's not only about commits.  Now, allowing OIDs of tags pointing to
> commits and peeling them makes obvious sense, because we want commits
> reachable from those tags included in the commit-graph file.  Allowing
> OIDs of tags pointing to non-commits and silently ignoring them makes
> sense (to better support your 'git f-e-r ... | git c-g write ...' use
> case), though it's not that obvious (after all I managed to overlook
> it back then, that's why we are now here discussing these
> '--check-oids' patches).
>
> But I'm not sure about silently ignoring OIDs pointing to non-existent
> objects, because those might be a sign of some issues in whatever is
> generating the list of objects to be fed to 'git c-g write'.  E.g. there
> could be a race between 'git for-each-ref' listing OIDs and some other
> processes pruning them.  Does this worth worrying about?  Dunno...
> but at least let's think it through, and record in the commit message
> why we made that decision, whatever that decision might be.

Yeah, I think that the most reasonable behavior is definitely that we
should complain about non-existent objects over 'git commit-graph write
--stdin-commits' no matter if '--[no-]check-oids' is given or not.

But, let's step back for a minute. What are we actually hoping to
accomplish with '--check-oids'? I wrote this patch because I wanted a
way to support 'git for-each-ref' piping into 'git commit-graph write'
without having to juggle which tags peel down to commits and which
don't.

Now, I figured that it would be unreasonable to change the default
behavior of 'git commit-graph write --stdin-commits' (which is to
complain and error out in this circumstance), so I added
'--no-check-oids' as a way to avoid that behavior for callers that want
that.

But, are there ever any callers that *wouldn't* want this behavior? As
far as I can tell, probably not. We're only going to be permitting
*more* inputs to 'git commit-graph write', and I seriously doubt that
anybody is depending on the above behavior. (Of course, if that's not
the case, I'd love for somebody to speak up here and we can continue
the course on this patch).

So, I propose the following:

  * We drop the idea of '--[no-]{check,verify}-oids', and always
    silently ignore non-commit inputs, retaining the existing behavior
    of always complaining about things that aren't valid hex OIDs, such
    as "HEAD".

  * We always error out on missing or corrupt commit OIDs, including
    valid OIDs that don't resolve to any object, or resolve to a tag
    that can't be fully peeled.

Does that seem reasonable?

> > I guess that pushes us into the territory of whether or not "check" is
> > the right verb. "verify"?
>
> Oh, I didn't think about this, but now that you mention it we have
> '--verify' in 'git rev-parse', 'git tag' and elsewhere, and we have
> 'verify-commit', 'verify-path' and 'verify-tag' commands.  So
> '--verify-oids' might be more consistent.  I kind of like the 'oids'
> suffix in the option name, though I don't know what else we might want
> to verify in this command in the future...
>
> > "scrutinize" :)?
>
> Huhh, erm, no ;)
>
> > If you're otherwise satisfied with this series, here's the updated
> > patch.
>
> I haven't yet looked closely at the rest of the series...  The
> documentation update in the updated patch below looks good to me,
> thanks.
>
> > -- >8 --
> >
> > Subject: [PATCH] commit-graph.c: introduce '--[no-]check-oids'
> >
> > When operating on a stream of commit OIDs on stdin, 'git commit-graph
> > write' checks that each OID refers to an object that is indeed a commit.
> > This is convenient to make sure that the given input is well-formed, but
> > can sometimes be undesirable.
> >
> > For example, server operators may wish to feed the full commit object
> > IDs pointed to by refs that were updated during a push to 'git
> > commit-graph write --input=stdin-commits', and silently discard any
> > input that doesn't point at a commit. This can be done by combing the
> > output of 'git for-each-ref' with '--format %(*objecttype)', but this
> > requires opening up a potentially large number of objects.  Instead, it
> > is more convenient to feed the updated object IDs to the commit-graph
> > machinery, and let it throw out whatever remains.  to commits.
>
> Either the bulk of a sentence is missing, or there is a stray(?) "to
> commits." at the end of this line.
>
> > Introduce '--[no-]check-oids' to make such a behavior possible. With
> > '--check-oids' (the default behavior to retain backwards compatibility),
> > 'git commit-graph write' will barf on a non-commit line in its input.
> > With '--no-check-oids', such lines will be silently ignored, making the
> > above possible by specifying this option.
> >
> > No matter which is supplied, 'git commit-graph write' retains the
> > behavior from the previous commit of rejecting non-OID inputs like
> > "HEAD" and "refs/heads/foo" as before.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  Documentation/git-commit-graph.txt |  6 ++++++
> >  builtin/commit-graph.c             | 11 ++++++++---
> >  t/t5318-commit-graph.sh            | 28 ++++++++++++++++++++++++++++
> >  3 files changed, 42 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> > index 46f7f7c573..6bdbe42766 100644
> > --- a/Documentation/git-commit-graph.txt
> > +++ b/Documentation/git-commit-graph.txt
> > @@ -82,6 +82,12 @@ tip with the previous tip.
> >  Finally, if `--expire-time=<datetime>` is not specified, let `datetime`
> >  be the current time. After writing the split commit-graph, delete all
> >  unused commit-graph whose modified times are older than `datetime`.
> > ++
> > +The `--[no-]check-oids` option decides whether or not OIDs are required
> > +to be commits. By default, `--check-oids` is implied, generating an
> > +error on non-commit objects. If `--no-check-oids` is given, non-commits
> > +and non-existent objects are silently discarded. In either case, tags
> > +are peeled down to the object they reference.

Thanks,
Taylor
