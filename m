Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C2E1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 22:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeHOBc6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 21:32:58 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40917 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeHOBc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 21:32:58 -0400
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so36623961oie.7
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 15:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PR0hvn0QMmBT/inElZNcw9uCUoBZRCmHyx1gN2PtZTw=;
        b=j3qr94tOX39I+KZNhL5y6U+yi4MvJr2rJcDFRWdoNksrZpLS4fc94tTwubJ5XvdENN
         Y0qqh7YQG9cQxDRPJJgyEb/1rLFqXojBBLqwrGQiITUJWwbpFtTHCQKeHdUCZAwFxo3t
         ceZHc29wWQdSyaozrJxlOkIsnu5EZlFAHHAeZBqLgHXvTyOPp4GDPXJTzkk49ZUWn35w
         ikw3YMwN+EB4+dJD+u8195iyp/olBrBQgDLocKwhRRekY7pq+tyXB0WV3ubICr7cxdOR
         ZoH8waivgtqRdTdPhGQORmFUQLLq15RzEubt2sotUPC9NJI/IkW+HN8qXz020vszzV++
         3Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PR0hvn0QMmBT/inElZNcw9uCUoBZRCmHyx1gN2PtZTw=;
        b=VMPZf8NB86vxUcKprPM5sdt6Uvt+K5qakmM+0kvbCU6FbwWqX8hsfbPjuTuwlpNOGn
         AlPsDH/XJjGbHgh+7MMPTAAYLC/HWWiFqT1IsS+mDzLVPIUMHzgC9XZ6eYBsUOnCdtHF
         vutau4Uw1rMkNvANsLcSCBNG/eK8dWsChtoCjPUWLwQ0hgneHjEe7PLkMk6EQ74Yg86r
         KoOVk/0S5cwrY9rYQKVTZKlGDVzX0sbGNWrbLXRbrTaQ8ZjVL6yvNz+3M88QHmPg8fO0
         byKu3EbbKsrXeLNSulcYcyCDUBYd/Ovkq1HOu541W37GnujTrS4bAgApnRLEcmyd/HJO
         OAOQ==
X-Gm-Message-State: AOUpUlFFJmt50cz0sjcDrFMeKE5cTw8ZI7zyH1+aTOcS8TE+ol5FPobJ
        jdtBKNEIeZqwIb9hedSWMfVtE5e+HuFv+gsGoPx+buM=
X-Google-Smtp-Source: AA+uWPz6TeuklcbwMkWMnA6Vts/Bo+Z3Akn9kQ9Qp+kE5kLUwuBPtTiDxBP3On5gMn041jco3jlo0HO0EWwKAl8+K1w=
X-Received: by 2002:aca:3057:: with SMTP id w84-v6mr24529569oiw.231.1534286616392;
 Tue, 14 Aug 2018 15:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <e01e202cb0445b72dc52a1c8763dbd9c737fb86e.1534267611.git.matvore@google.com>
 <20180814180626.31788-1-jonathantanmy@google.com>
In-Reply-To: <20180814180626.31788-1-jonathantanmy@google.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Tue, 14 Aug 2018 15:43:25 -0700
Message-ID: <CAMfpvh+2SeOynnzH_keOPE9g2PrMgfzrjOMHWxQxkuOf+T3Y7A@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] rev-list: handle missing tree objects properly
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 11:06 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > Previously, we assumed only blob objects could be missing. This patch
> > makes rev-list handle missing trees like missing blobs. A missing tree
> > will cause an error if --missing indicates an error should be caused,
> > and the hash is printed even if the tree is missing.
>
> The last sentence is difficult to understand - probably better to say
> that all --missing= arguments and --exclude-promisor-objects work for
> missing trees like they currently do for blobs (and do not fixate on
> just --missing=error). And also demonstrate this in tests, like in
> t6612.
Fixed the commit message. And for the tests, in t0410 I changed the
--missing=allow-any to --missing-allow-promisor, and in t6112 I added
--missing=allow-any and --missing=print test cases.

>
> > In list-objects.c we no longer print a message to stderr if a tree
> > object is missing (quiet_on_missing is always true). I couldn't find
> > any place where this would matter, or where the caller of
> > traverse_commit_list would need to be fixed to show the error. However,
> > in the future it would be trivial to make the caller show the message if
> > we needed to.
> >
> > This is not tested very thoroughly, since we cannot create promisor
> > objects in tests without using an actual partial clone. t0410 has a
> > promise_and_delete utility function, but the is_promisor_object function
> > does not return 1 for objects deleted in this way. More tests will will
> > come in a patch that implements a filter that can be used with git
> > clone.
>
> These two paragraphs are no longer applicable, I think.
Sorry about that. Removed.

>
> > @@ -373,6 +375,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
> >       init_revisions(&revs, prefix);
> >       revs.abbrev = DEFAULT_ABBREV;
> >       revs.commit_format = CMIT_FMT_UNSPECIFIED;
> > +     revs.do_not_die_on_missing_tree = 1;
>
> Is this correct? I would have expected this to be set only if --missing
> was set.
If --missing is not set, then we want to fetch missing objects
automatically, and then die if we fail to do that, which is what
happens for blobs. So we don't want to die in list-objects.c. If we
fail to fetch, then we will die on line 213 in rev-list.c.

>
> > -     process_tree_contents(ctx, tree, base);
> > +     /*
> > +      * NEEDSWORK: we should not have to process this tree's contents if the
> > +      * filter wants to exclude all its contents AND the filter doesn't need
> > +      * to collect the omitted OIDs. We should add a LOFR_SKIP_TREE bit which
> > +      * allows skipping all children.
> > +      */
> > +     if (parsed)
> > +             process_tree_contents(ctx, tree, base);
>
> I agree with Jeff Hostetler in [1] that a LOFR_SKIP_TREE bit is
> desirable, but I don't think that this patch is the right place to
> introduce this NEEDSWORK. For me, this patch is about skipping iterating
> over the contents of a tree because the tree does not exist; this
> NEEDSWORK is about skipping iterating over the contents of a tree
> because we don't want its contents, and it is quite confusing to
> conflate the two.
I've removed this.

>
> [1] https://public-inbox.org/git/d751d56b-84bb-a03d-5f2a-7dbaf8d947cc@jeffhostetler.com/
>
> > @@ -124,6 +124,7 @@ struct rev_info {
> >                       first_parent_only:1,
> >                       line_level_traverse:1,
> >                       tree_blobs_in_commit_order:1,
> > +                     do_not_die_on_missing_tree:1,
>
> I know that the other flags don't have documentation, but I think it's
> worth documenting this one because it is rather complicated. I have
> provided a sample one in my earlier review - feel free to use that or
> come up with your own.
Added your wording to revision.h without major change.

>
> > diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> > index 4984ca583..74e3c5767 100755
> > --- a/t/t0410-partial-clone.sh
> > +++ b/t/t0410-partial-clone.sh
> > @@ -186,6 +186,72 @@ test_expect_success 'rev-list stops traversal at missing and promised commit' '
> >       ! grep $FOO out
> >  '
> >
> > +test_expect_success 'show missing tree objects with --missing=print' '
> > +     rm -rf repo &&
> > +     test_create_repo repo &&
> > +     test_commit -C repo foo &&
> > +     test_commit -C repo bar &&
> > +     test_commit -C repo baz &&
> > +
> > +     TREE=$(git -C repo rev-parse bar^{tree}) &&
> > +
> > +     promise_and_delete $TREE &&
> > +
> > +     git -C repo config core.repositoryformatversion 1 &&
> > +     git -C repo config extensions.partialclone "arbitrary string" &&
> > +     git -C repo rev-list --quiet --missing=print --objects HEAD >missing_objs 2>rev_list_err &&
> > +     echo "?$TREE" >expected &&
> > +     test_cmp expected missing_objs &&
> > +
> > +     # do not complain when a missing tree cannot be parsed
> > +     ! grep -q "Could not read " rev_list_err
> > +'
>
> I think that the --exclude-promisor-tests can go in t0410 as you have
> done, but the --missing tests (except for --missing=allow-promisor)
> should go in t6112. (And like the existing --missing tests, they should
> be done without setting extensions.partialclone.)
Done.

>
> As for --missing=allow-promisor, I don't see them being tested anywhere
> :-( so feel free to make a suggestion. I would put them in t6112 for
> easy comparison with the other --missing tests.
Kept my allow-promisor test in t0410 since it requires partial clone
to be turned on in the config, and because it is pretty similar to
--exclude-promisor-objects.
