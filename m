Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB69C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C27C2073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2l9MtR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgC3Q5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:57:13 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:36526 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgC3Q5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 12:57:12 -0400
Received: by mail-qk1-f202.google.com with SMTP id y1so15578646qke.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OUD6dJqlCP+s2UrmxFn2nzWAkMk7KLxA1UXvvXGe9JY=;
        b=k2l9MtR1qLfLien73+ANwMOoiy3Tiy3l/P3Vqwam13tUAHdM33ICYYePgyoukBFQtg
         QE6kNeQ+ew6i3f0J0Ii24XzsvS9RZDWxU2/zmzRBHxcBbzeC3MQ88ByFy+oDfYDOQj8e
         VwcoHi9y3EYZyRmxyXL6x2eeXGgO+A0W4iZmJtxTWYOPJlDTNwyr8yQR+ZCCML1BqbJj
         QhB5UpwbsPI1ZadWgY6LdgJsf8ZCopzIslVib3LIi4khGOuhO5R8NEd/84flR/CzoEkb
         QAb/0Msk/hkpzBjSExVTrnwXzWhDIOx8q09kuceAbkAJ7wVFU9YHtOSvsLe7WlsChnsi
         /A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OUD6dJqlCP+s2UrmxFn2nzWAkMk7KLxA1UXvvXGe9JY=;
        b=piUDA8oTQoM6l4/q5+6uyj9f/RTekUVjvYKYJ/LOaemV2I/E1mKBLekImcYovydw3t
         rgNITpjFejxLKCO90c3EzTqaC3f7uMBuS1DsVjZ2aOs0KxyuwjKQI1S2rlcINAI7HnS4
         t3l/iOp/eu82FiHrKZfkdZknIj/M1ZuVjem4OBVoRDv9k3XGgA7dC0eoH5Oieqkm6GYq
         5fvBCpqiYPo9NjqMdJoHgn9Q6aTePM5IrTw8C3ti0t43VWJ0ZUZEJS5HF9M92BhVTrPY
         8xvrIqDL3zYA+LO37DlGgDDIhufFs+tgIppG1NZz4f9uJelVw/F3OSX1MfpGlzBt6GsA
         K7Og==
X-Gm-Message-State: ANhLgQ3KG2xCB8OqqfOCvFziAB6FdOBh4Sxc2O63MZP4mUsUXg2uoM33
        N6NPPMgO3SpJb+iBg9OqIaXNKZ4Mlxnk15yGPyqO
X-Google-Smtp-Source: ADFU+vsD2slvs4MhGswqDz3UJKZCtwFfkxs2JXa06wCGuCithj7pnMxZAuw9p97h0F2NVHqr86eyGIv4v3dhuMPZl4WF
X-Received: by 2002:ac8:6919:: with SMTP id e25mr903054qtr.151.1585587429789;
 Mon, 30 Mar 2020 09:57:09 -0700 (PDT)
Date:   Mon, 30 Mar 2020 09:57:05 -0700
In-Reply-To: <e917f451-c00a-c819-7f78-888ba6e8f5ea@gmail.com>
Message-Id: <20200330165705.134447-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <e917f451-c00a-c819-7f78-888ba6e8f5ea@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        congdanhqx@gmail.com, newren@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Add a flag to "git rebase" to allow suppression of this feature. This
> > flag only works when using the "merge" backend.
> 
> So this is the behavior that already exists, and you are providing a way
> to suppress it. However, you also change the default in this patch, which
> may surprise users expecting this behavior to continue.

First of all, thanks for looking at this.

I'm not changing the default - was there anything in the commit message
that made you believe it? If yes, I could change it.

Looking back to the title, maybe it should be "rebase --merge: make
skipping of upstreamed commits optional" (although that would exceed 50
characters, so I would have to think of a way to shorten it).

> > +--keep-cherry-pick::
> > +--no-keep-cherry-pick::
> 
> I noticed that this _could_ have been simplified to
> 
> 	--[no-]keep-cherry-pick::
> 
> but I also see several uses of either in our documentation. Do we
> have a preference? By inspecting the lines before a "no-" string,
> I see that some have these two lines, some use the [no-] pattern,
> and others highlight the --no-<option> flag completely separately.

I was following the existing options in this file.

> > +	Control rebase's behavior towards commits in the working
> > +	branch that are already present upstream, i.e. cherry-picks.
> 
> I think the "already present upstream" is misleading. We don't rebase
> things that are _reachable_ already, but this is probably better as
> 
> 	Specify if rebase should include commits in the working branch
> 	that have diffs equivalent to other commits upstream. For example,
> 	a cherry-picked commit has an equivalent diff.

OK, I'll use this.

> > +By default, these commits will be dropped. Because this necessitates
> > +reading all upstream commits, this can be expensive in repos with a
> > +large number of upstream commits that need to be read.
> 
> Now I'm confused. Are they dropped by default? Which option does what?
> --keep-cherry-pick makes me think that cherry-picked commits will come
> along for the rebase, so we will not check for them. But you have documented
> that --no-keep-cherry-pick is the default.

This part is followed by "If --keep-cherry-pick is given", so I thought
it would be clear that this is the "--no-keep-cherry-pick" part (or if
nothing is given), but I'll s/By default/By default, or if
--no-keep-cherry-pick is given/.

> (Also, I keep writing "--[no-]keep-cherry-picks" (plural) because that
> seems more natural to me. Then I go back and fix it when I notice.)

OK, let's see if others have opinions on this. Admittedly,
--keep-cherry-picks with the "s" at the end now sounds more natural to
me.

> > +If `--keep-cherry-pick is given`, all commits (including these) will be
> 
> Bad tick marks: "`--keep-cherry-pick` is given"

Thanks.

> > +re-applied. This allows rebase to forgo reading all upstream commits,
> > +potentially improving performance.
> 
> This reasoning is good. Could you also introduce a config option to make
> --keep-cherry-pick the default? I would like to enable that option by
> default in Scalar, but could also see partial clones wanting to enable that
> by default, too.

Maybe this could be done in another patch. This sounds like a good idea.

> > +See also INCOMPATIBLE OPTIONS below.
> > +
> 
> Could we just say that his only applies with the --merge option? Why require
> the jump to the end of the options section? (After writing this, I go look
> at the rest of the doc file and see this is a common pattern.)

Yes, I'm following the pattern.

> > +Also, the --keep-cherry-pick option requires the use of the merge backend
> > +(e.g., through --merge).
> > +
> 
> Will the command _fail_ if someone says --keep-cherry-pick without the merge
> backend, or just have no effect? Also, specify the option with ticks and
> 
> 	`--[no-]keep-cherry-pick`
> 
> It seems that none of the options in this section are back-ticked, which I think
> is a doc bug.

It will fail. I'll figure out how to add a test for that (which might be
difficult since the default merge backend is changing).

I'll add the ticks. (The "no-" is fine with either backend, since it
just invokes the current behavior.)

> > @@ -381,6 +382,7 @@ static int run_rebase_interactive(struct rebase_options *opts,
> >  	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
> >  	flags |= opts->root_with_onto ? TODO_LIST_ROOT_WITH_ONTO : 0;
> >  	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
> > +	flags |= opts->keep_cherry_pick ? TODO_LIST_KEEP_CHERRY_PICK : 0;
> 
> Since opts->keep_cherry_pick is initialized as zero, did you change the default
> behavior? 

I did not change it - keep_cherry_pick being 0 means that we do not keep
any cherry-picks, so we have to read every upstream commit in order to
know which are cherry-picks (which is the current behavior).

> Do we not have a test that verifies this behavior when using the merge
> backend an no "--keep-cherry-pick" option?

Yes, there are existing tests that already check the deduplicating
behavior of "git rebase --merge".

> > +	if (options.keep_cherry_pick && !is_interactive(&options))
> > +		die(_("--keep-cherry-pick does not work with the 'apply' backend"));
> > +
> 
> I see you are failing here. Is this the right decision?
> 
> The apply backend will "keep" cherry-picks because it will not look for them upstream.
> If anything, shouldn't it be that "--no-keep-cherry-pick" is incompatible?

I haven't delved deeply into the "apply" backend, but it seems to me
that it still performs some sort of cherry-pick detection (that is, it
does not keep cherry-picks, thus --no-keep-cherry-pick). In this patch,
I have a test with the lines:

  # Regular rebase fails, because the 1-11 commit is deduplicated
  test_must_fail git -C repo rebase --merge master 2> err &&

When I remove "--merge" from this line, the rebase still fails (with a
different error message, so indeed another backend is used).

> > +test_expect_success '--keep-cherry-pick' '
> > +	git init repo &&
> > +
> > +	# O(1-10) -- O(1-11) -- O(0-10) master
> > +	#        \
> > +	#         -- O(1-11) -- O(1-12) otherbranch
> > +
> > +	printf "Line %d\n" $(test_seq 1 10) >repo/file.txt &&
> > +	git -C repo add file.txt &&
> > +	git -C repo commit -m "base commit" &&
> > +
> > +	printf "Line %d\n" $(test_seq 1 11) >repo/file.txt &&
> > +	git -C repo commit -a -m "add 11" &&
> > +
> > +	printf "Line %d\n" $(test_seq 0 10) >repo/file.txt &&
> > +	git -C repo commit -a -m "add 0 delete 11" &&
> > +
> > +	git -C repo checkout -b otherbranch HEAD^^ &&
> > +	printf "Line %d\n" $(test_seq 1 11) >repo/file.txt &&
> > +	git -C repo commit -a -m "add 11 in another branch" &&
> > +
> > +	printf "Line %d\n" $(test_seq 1 12) >repo/file.txt &&
> > +	git -C repo commit -a -m "add 12 in another branch" &&
> > +
> > +	# Regular rebase fails, because the 1-11 commit is deduplicated
> > +	test_must_fail git -C repo rebase --merge master 2> err &&
> > +	test_i18ngrep "error: could not apply.*add 12 in another branch" err &&
> > +	git -C repo rebase --abort &&
> 
> OK. So here you are demonstrating that the --no-keep-cherry-pick is the
> new default. Just trying to be sure that this was intended.

Yes, --no-keep-cherry-pick is the default, but it has the same behavior
as if the flag was omitted. (The existing tests that test the
cherry-pick deduplication behavior all still work.)
