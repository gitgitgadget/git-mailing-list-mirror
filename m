Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E43FC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A9E206E9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="0y5vneGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDUUpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbgDUUpU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 16:45:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B80BC0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 13:45:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x3so7151444pfp.7
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 13:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TXyzUm6T875zMPZfQVUXvilbDUNVHNDdxTGUf8GLIaQ=;
        b=0y5vneGVJnIu516cKJu//3jd9BD56Wonek4SsARYo2Oprq8stv+VyHnsEIwInnJn87
         eJ4SF+MGSJ33UboJ4sJ0RF1g0183q2qsFduapr9cU9lzqafocVpTpgYf2LAnstvPgBQn
         addD4z/1nPli5JiedPhPLN8lULmLcK+cj8LeVKaki5bvJ0oO0PB6YDDL9sjgbRbiXN5i
         Ewkm2tmvxFyKK9vnNZ0ndJdBs0F0HrDK9oasdfvEE/Yvs6m/OHgQo7Z+YLUXyEI/uRzu
         OftXo97Uw6pgH8qtyv7XAHW9xAX3aHJsxJeR1GljZeRmv1kiMED2NfbyTX0Q9CvOW+NX
         oqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TXyzUm6T875zMPZfQVUXvilbDUNVHNDdxTGUf8GLIaQ=;
        b=cCWcDQF5ngCEEDHbi5cLNgqyElUIVhlJgOZ+H/r1SPcTEAKB0FEHA2ZWuJIWDonJ3H
         MwnzmjY/6jFahhs7A1rEzXs3uUZHbQBnOsPJJxneyrqIIPQTkz5k4525DGpXhSTT+KQo
         xEHxdUgF8MO0Yu8ybl4z7AWcMy+yhBumqudFNgTl9k7avltjWM/q48XjxYr8Qp+VnsTP
         4jbfpbjKWEDtstfYmdyIw6YSsiPYy33DJw2qomkyk09vng+r2MThBg/KQGRKQ2xWlLre
         3onksSUaSPMxm78c+YBI2x4RGUd2voyMDOPKl9ZDCG4TAprHGe6/Rmj3DLglBu4tcpvu
         5Hkg==
X-Gm-Message-State: AGi0PuafCRe1s0k4vCyx96KBY8RA69GD0pjKIBchCR0Zq23pGr4NpOwc
        ZHPnCX5sD8UxDOySnDGv6/7+XA==
X-Google-Smtp-Source: APiQypKGm6Gr7vSCr6v4pdHKVDTzP49g0A4MgH2pNh9VxzJD5JzHwDsVDOIU0qUybUhVU6lzdR7cjg==
X-Received: by 2002:aa7:9a92:: with SMTP id w18mr23527903pfi.95.1587501918263;
        Tue, 21 Apr 2020 13:45:18 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id p62sm3261304pfb.93.2020.04.21.13.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 13:45:17 -0700 (PDT)
Date:   Tue, 21 Apr 2020 14:45:16 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] shallow.c: use 'reset_repository_shallow' when
 appropriate
Message-ID: <20200421204516.GA69777@syl.local>
References: <8d295389ea43c6b7e008514067b7af6eacba64a5.1587492422.git.me@ttaylorr.com>
 <xmqqeesgmuzv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeesgmuzv.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Apr 21, 2020 at 01:41:56PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > In bd0b42aed3 (fetch-pack: do not take shallow lock unnecessarily,
> > 2019-01-10), the author noted that 'is_repository_shallow' produces
> > visible side-effect(s) by setting 'is_shallow' and 'shallow_stat'.
> >
> > This is a problem for e.g., fetching with '--update-shallow' in a
> > shallow repsoitory with 'fetch.writeCommitGraph' enabled, since the
>
> repository.

Whoops, sorry about that.

> > update to '.git/shallow' will cause Git to think that the repository
> > isn't shallow when it is, thereby circumventing the commit-graph
> > compatability check.
> >
> > This causes problems in shallow repositories with at least shallow refs
> > that have at least one ancestor (since the client won't have those
> > objects, and therefore can't take the reachability closure over commits
> > when writing a commit-graph).
>
> OK.
>
> > Address this by introducing 'reset_repository_shallow()', and calling
> > it whenever the shallow files is updated. This happens in two cases:
> >
> >   * during 'update_shallow', when either the repository is
> >     un-shallowing, or after commit_lock_file, when the contents of
> >     .git/shallow is changing, and
> >
> >   * in 'prune_shallow', when the repository can go from shallow to
> >     un-shallow when the shallow file is updated, forcing
> >     'is_repository_shallow' to re-evaluate whether the repository is
> >     still shallow after fetching in the above scenario.
> >
> > As a result of the second change, 'prune_shallow' can now only be called
> > once (since 'check_shallow_file_for_update' will die after calling
> > 'reset_repository_shallow'). But, this is OK since we only call
> > 'prune_shallow' at most once per process.
> >
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >
> > Here's a cleaned up version of the patch that we were originally
> > discussing in
> > https://lore.kernel.org/git/20200414235057.GA6863@syl.local/, which
> > addresses some of Jonathan's feedback and adds a test to make sure that
> > the new behavior is working correctly.
> >
> >  commit.h                 |  1 +
> >  fetch-pack.c             |  1 +
> >  shallow.c                | 15 ++++++++-------
> >  t/t5537-fetch-shallow.sh | 36 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 46 insertions(+), 7 deletions(-)
> >
> > diff --git a/commit.h b/commit.h
> > index 008a0fa4a0..ee1ba139d4 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -251,6 +251,7 @@ int register_shallow(struct repository *r, const struct object_id *oid);
> >  int unregister_shallow(const struct object_id *oid);
> >  int for_each_commit_graft(each_commit_graft_fn, void *);
> >  int is_repository_shallow(struct repository *r);
> > +void reset_repository_shallow(struct repository *r);
> >  struct commit_list *get_shallow_commits(struct object_array *heads,
> >  					int depth, int shallow_flag, int not_shallow_flag);
> >  struct commit_list *get_shallow_commits_by_rev_list(
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 1734a573b0..684868bc17 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1632,6 +1632,7 @@ static void update_shallow(struct fetch_pack_args *args,
> >  			rollback_lock_file(&shallow_lock);
> >  		} else
> >  			commit_lock_file(&shallow_lock);
> > +		reset_repository_shallow(the_repository);
> >  		alternate_shallow_file = NULL;
> >  		return;
> >  	}
>
> So, after updating shallow file with "fetch --update-shallow" (or
> failing to do so), we reset the in-core data.
>
> > +void reset_repository_shallow(struct repository *r)
> > +{
> > +	r->parsed_objects->is_shallow = -1;
> > +	stat_validity_clear(r->parsed_objects->shallow_stat);
> > +}
>
> OK.
>
> > @@ -362,6 +361,7 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
> >  		 * shallow file".
> >  		 */
> >  		*alternate_shallow_file = "";
> > +	reset_repository_shallow(the_repository);
> >  	strbuf_release(&sb);
> >  }
>
> And also after writing out the alternate shallow file (whether it is
> empty or polulated).
>
> > @@ -414,6 +414,7 @@ void prune_shallow(unsigned options)
> >  	} else {
> >  		unlink(git_path_shallow(the_repository));
> >  		rollback_lock_file(&shallow_lock);
> > +		reset_repository_shallow(the_repository);
> >  	}
>
> Here, we reset only after we realize we cannot write the updated
> shallow file.  Intended?

Yes, see this earlier discussion I had about it with Jonathan:
https://lore.kernel.org/git/20200416020509.225014-1-jonathantanmy@google.com/.

> > +	cat <<EOF >expect.refs &&
> > +refs/remotes/shallow/master
> > +refs/remotes/shallow/no-shallow
> > +refs/tags/heavy-tag
> > +refs/tags/heavy-tag-for-graph
> > +refs/tags/light-tag
> > +refs/tags/light-tag-for-graph
> > +EOF
>
> 	cat <<-EOF >expect.refs &&
> 	... body can be indented by any number of TAB
> 	... to make it easier to view
> 	EOF
>
> > +	test_cmp expect.refs actual.refs &&
> > +	git log --format=%s shallow/master >actual &&
> > +	cat <<EOF >expect &&
>
> Likewise.

I'd be happy to update these, but I am matching the (poor) style of the
surrounding tests. Are you OK with the inconsistency?  Would you like
another preparatory patch to clean up the surrounding?

Thanks,
Taylor
