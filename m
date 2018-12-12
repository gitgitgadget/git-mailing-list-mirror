Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1329720A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 19:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeLLT6R (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 14:58:17 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:43990 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLLT6R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 14:58:17 -0500
Received: by mail-it1-f201.google.com with SMTP id 128so53670itw.8
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 11:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ipUa9TvwTfUXX2rtEHRdmrvTnqQ20EVVTpmQSyE375U=;
        b=psJyQcPahyURhlrWKiAx6zE+JcnTguWdWJp+3nqdF1GrO4C3BWeBUVGNm5WhnZHFre
         OpG0rqmzLYjW4ixoNegyMdOXe8Tj0kgTNOQ40EI2a33RbiAa8wDPOJUhT+9sW4Dxxggj
         jc85bA6l1s3Dzs5v7hNvIb7uHHa1rDopKliM0vNiAwTjchCnP6MG5Ltpkq2ZMmc3WU8l
         7pVgiBdN6pyuv+4Lczw+hAL3bermstSJzyqgLcqOaaMjggnzatkDANtPdkB7jDcsqLRO
         rPGOX7RkVA7UiDrynKFFQQqb98jfLeFy/OgF9toDzooPt/0CZdyOyiP/omETJBDAljnR
         Wbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ipUa9TvwTfUXX2rtEHRdmrvTnqQ20EVVTpmQSyE375U=;
        b=eVcIMNKxP70IPrbprvDWyA5fGah5OwUtdIYbjfX+6K+wYbtFqayZ3Nu6vvqDsB4VJ5
         QBZ9SMEgO7dYX2qC3wVDNb5x0ai3lT7Eyr+XmJNK57aZgpDJtRnTK82c/VeaWSO5q/r9
         Ovrs/xm1e+DvzrojNfVK1SPDdsnZ5lomx67bzBJwEbKihSGEYj9SzEd4SId/FWgtX/by
         ZXj9xEtl/J18zqf5l3I+okzMW6eFuODsKm8WwZug+MMKNx3Fqu9C8BO3oQoJKrn2s89w
         mWUJv1nsnotLgaG61C+Y9+Ca9xpGOMXQ1LR1+UJoGEIb2aQonuceGKLKc5KEV6kltvNR
         Xl+A==
X-Gm-Message-State: AA+aEWb6oarL8VKvmndS3T4gcOnSYA5ZTfL1byuyUoLt7RDIFtv7CyF5
        IM2I/Q3Eo6TXpePmgyRQE/kpky9sWKeQZWemmPml
X-Google-Smtp-Source: AFSGD/XoxFeHyt3+vahiH1R5b8uzUSll9MvQW6avM9KmgxSbSDJEDqE2X0MHhmr4fq+iQ54tbzTpz6CYh3nEoGBOp2Fm
X-Received: by 2002:a24:50c:: with SMTP id 12mr5863485itl.18.1544644695780;
 Wed, 12 Dec 2018 11:58:15 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:58:12 -0800
In-Reply-To: <20181211105439.GA8452@sigill.intra.peff.net>
Message-Id: <20181212195812.232726-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181211105439.GA8452@sigill.intra.peff.net>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH on master v2] revision: use commit graph in get_reference()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     gitster@pobox.com, jonathantanmy@google.com, git@vger.kernel.org,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Sun, Dec 09, 2018 at 09:51:28AM +0900, Junio C Hamano wrote:
> 
> > > -static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
> > > +static struct commit *parse_commit_in_graph_one(struct repository *r,
> > > +						struct commit_graph *g,
> > > +						struct commit *shell,
> > > +						const struct object_id *oid)
> > 
> > Now the complexity of the behaviour of this function deserves to be
> > documented in a comment in front.  Let me see if I can get it
> > correctly without such a comment by explaining the function aloud.
> > 
> > The caller may or may not have already obtained an in-core commit
> > object for a given object name, so shell could be NULL but otherwise
> > it could be used for optimization.  When shell==NULL, the function
> > looks up the commit object using the oid parameter instead.  The
> > returned in-core commit has the parents etc. filled as if we ran
> > parse_commit() on it.  If the commit is not yet in the graph, the
> > caller may get a NULL even if the commit exists.

In the next revision, I'll unify parse_commit_in_graph_one() (quoted
above) with parse_commit_in_graph(), so that the comment I wrote for the
latter can cover the entire functionality. I think the comment covers
the details that you outline here.

> Yeah, this was the part that took me a bit to figure out, as well. The
> optimization here is really just avoiding a call to lookup_commit(),
> which will do a single hash-table lookup. I wonder if that's actually
> worth this more complex interface (as opposed to just always taking an
> oid and then always returning a "struct commit", which could be old or
> new).

Avoidance of lookup_commit() is more important than an optimization, I
think. Here, we call lookup_commit() only when we know that that object
is a commit (by its presence in a commit graph). If we just called it
blindly, we might mistakenly create a commit for that hash when it is
actually an object of another type. (We could inline lookup_commit() in
parse_commit_in_graph_one(), removing the object creation part, but that
adds complexity as well.)
