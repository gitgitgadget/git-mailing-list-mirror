Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7342CC4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 15:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A94206CA
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 15:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkzTsgB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388215AbgJBPHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 11:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388169AbgJBPHU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 11:07:20 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854F5C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 08:07:18 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j10so925138qvk.11
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FOHosnP219/LzSMhtF3afAGk26fCTHZ7Hkj0bzO5GJo=;
        b=ZkzTsgB2U0gzjLy/aqw2hxUQm0ZNKn3uz4Hbj9Vkgo/O22e4cHfgl8oAptdCJMQIZI
         yO7b0uFPtMLaf0EaG/++hX1p01d5rWfiynCd+5w5S7nZspChFLjz3fhcYKMJHerNqnwg
         CjLfIpNkC/IkbW0QAYdI+VdT31aG+WBe+PLxTua5MELjm/Hho6ewbKkLAKu0zPESRJ/H
         J3/JSiO1g7F5Ql2V+GvqW8EPSaX2Pa0Iqj9XBUSkdkidtcXOGugaUaYfdd5B9VYrS8UJ
         UNuneTeeaEOZWh5+vmA5pyCAZ/LIh8XgO03WLpf5lktO1ZKQ+6hS8DOzibaVV+w0ICPG
         wiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FOHosnP219/LzSMhtF3afAGk26fCTHZ7Hkj0bzO5GJo=;
        b=GT+q5mSDnFUkcEEb6ah82x1gntLUxif3JXwYkkdUNQPly3YzsYTnD9NjKxk5jsoJBm
         aHloq31kXcXimSUy+GKKeRNjVz6UjWmwl6luwj+crVhn78xeeG/YmBC/xVfO/u+7l0KL
         H5aSVYSwIvEJ4s7xQ+TUHmAJUjEtYkA07SlexniW1f04N+uSGo2qcJ1x0JR6gEFdRsZ+
         M4WhEOBio18GmoyHwYYdwaRG+KlZ5DRFCk9uTbalCMbjh2F/bxIR3O/ow0xPCtxLkjQd
         MWoR6uvNGfK3JzmT6vUu5CtdIEVVL+kx9Fs3eSdcQo+z7U1/yJubttlBButzD6swR1Kn
         bYMA==
X-Gm-Message-State: AOAM531O2U01XxlYBBFRh/UThlGbubDcJz1OknQ9xuMZxHMLLjfz1yWh
        +Rw7UDQKKqEmc5vR18SBB5E=
X-Google-Smtp-Source: ABdhPJyfaAfICbkQ4tJbUTIV2zDjmTW9EpQ9qKeLm0wRtZCw4cNSbo8D1IDOaARKN0H3hJVncEE5Yg==
X-Received: by 2002:a0c:f3c2:: with SMTP id f2mr2657919qvm.37.1601651237574;
        Fri, 02 Oct 2020 08:07:17 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.104.31])
        by smtp.gmail.com with ESMTPSA id z37sm1261366qtz.67.2020.10.02.08.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 08:07:16 -0700 (PDT)
Date:   Fri, 2 Oct 2020 20:37:10 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v9 1/3] push: add reflog check for "--force-if-includes"
Message-ID: <20201002150710.GA54370@mail.clickyotomy.dev>
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
 <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
 <20201001082118.19441-2-shrinidhi.kaushik@gmail.com>
 <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 10/02/2020 15:52, Johannes Schindelin wrote:
> Hi Srinidhi,
> 
> 
> On Thu, 1 Oct 2020, Srinidhi Kaushik wrote:
> 
> > Add a check to verify if the remote-tracking ref of the local branch
> > is reachable from one of its "reflog" entries.
> >
> > The check iterates through the local ref's reflog to see if there
> > is an entry for the remote-tracking ref and collecting any commits
> > that are seen, into a list; the iteration stops if an entry in the
> > reflog matches the remote ref or if the entry timestamp is older
> > the latest entry of the remote ref's "reflog". If there wasn't an
> > entry found for the remote ref, "in_merge_bases_many()" is called
> > to check if it is reachable from the list of collected commits.
> >
> > When a local branch that is based on a remote ref, has been rewound
> > and is to be force pushed on the remote, "--force-if-includes" runs
> > a check that ensures any updates to the remote-tracking ref that may
> > have happened (by push from another repository) in-between the time
> > of the last update to the local branch (via "git-pull", for instance)
> > and right before the time of push, have been integrated locally
> > before allowing a forced update.
> >
> > If the new option is passed without specifying "--force-with-lease",
> > or specified along with "--force-with-lease=<refname>:<expect>" it
> > is a "no-op".
> >
> > Calls to "in_merge_bases_many()" return different results depending
> > on whether the "commit-graph" feature is enabled or not -- it is
> > temporarily disabled when the check runs [1].
> >
> > [1] https://lore.kernel.org/git/xmqqtuvhn6yx.fsf@gitster.c.googlers.com
> 
> I can verify that the multiple calls to `in_merge_bases_many()` lead to a
> problem, and I intend to debug this further, but it is the wrong function
> to call to begin with.
> 
> With these two patches, the tests pass for me, and they also reduce the
> complexity quite a bit (Junio, could I ask you to put them on top of
> sk/force-if-includes?):

Thanks for looking into this. :)
 
> -- snipsnap --
> From 0e7bd31c4cb0ae08ad772ac230eea2dd7a884886 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Fri, 2 Oct 2020 15:33:05 +0200
> Subject: [PATCH 1/2] fixup??? push: add reflog check for "--force-if-includes"
> 
> This follows the pattern used elsewhere.
> 
> Maybe we should also rename this to `commit_array`? It is not a linked
> list, after all.

Makes sense. I'll change it.
 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  remote.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/remote.c b/remote.c
> index 37533cafc44..2c6c63aa906 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2441,6 +2441,7 @@ struct reflog_commit_list {
>  	struct commit **item;
>  	size_t nr, alloc;
>  };
> +#define REFLOG_COMMIT_LIST_INIT { NULL, 0, 0 }
> 
>  /* Append a commit to the list. */
>  static void append_commit(struct reflog_commit_list *list,
> @@ -2514,7 +2515,7 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
>  	struct commit *commit;
>  	struct commit **chunk;
>  	struct check_and_collect_until_cb_data cb;
> -	struct reflog_commit_list list = { NULL, 0, 0 };
> +	struct reflog_commit_list list = REFLOG_COMMIT_LIST_INIT;
>  	size_t size = 0;
>  	int ret = 0;
> 
> --
> 2.28.0.windows.1.18.g5300e52e185
> 
> 
> From 10ea5640015f4bc7144e8e5b025e31294329c600 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Fri, 2 Oct 2020 15:35:58 +0200
> Subject: [PATCH 2/2] fixup??? push: add reflog check for "--force-if-includes"
> 
> We should not call `in_merge_bases_many()` repeatedly: there is a much
> better API for that: `get_reachable_subset()`.

Perfect. I wasn't aware of this.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  remote.c | 43 ++++---------------------------------------
>  1 file changed, 4 insertions(+), 39 deletions(-)
> 
> diff --git a/remote.c b/remote.c
> index 2c6c63aa906..881415921e2 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2513,10 +2513,9 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
>  {
>  	timestamp_t date;
>  	struct commit *commit;
> -	struct commit **chunk;
>  	struct check_and_collect_until_cb_data cb;
>  	struct reflog_commit_list list = REFLOG_COMMIT_LIST_INIT;
> -	size_t size = 0;
> +	struct commit_list *reachable;
>  	int ret = 0;
> 
>  	commit = lookup_commit_reference(the_repository, &remote->old_oid);
> @@ -2542,61 +2541,27 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
>  	 * Check if the remote commit is reachable from any
>  	 * of the commits in the collected list, in batches.
>  	 */
> -	for (chunk = list.item; chunk < list.item + list.nr; chunk += size) {
> -		size = list.item + list.nr - chunk;
> -		if (MERGE_BASES_BATCH_SIZE < size)
> -			size = MERGE_BASES_BATCH_SIZE;
> -
> -		if ((ret = in_merge_bases_many(commit, size, chunk)))
> -			break;
> -	}
> +	reachable = get_reachable_subset(list.item, list.nr, &commit, 1, 0);
> +	ret = !!reachable;
> +	free_commit_list(reachable);
> 
>  cleanup_return:
>  	free_reflog_commit_list(&list);
>  	return ret;
>  }
> 
> -/* Toggle the "commit-graph" feature; return the previously set state. */
> -static int toggle_commit_graph(struct repository *repo, int disable) {
> -	int prev = repo->commit_graph_disabled;
> -	static int should_toggle = -1;
> -
> -	if (should_toggle < 0) {
> -		/*
> -		 * The in_merge_bases_many() seems to misbehave when
> -		 * the commit-graph feature is in use.  Disable it for
> -		 * normal users, but keep it enabled when specifically
> -		 * testing the feature.
> -		 */
> -		should_toggle = !git_env_bool("GIT_TEST_COMMIT_GRAPH", 0);
> -	}
> -
> -	if (should_toggle)
> -		repo->commit_graph_disabled = disable;
> -	return prev;
> -}
> -

OK. The tests are passing with or without "GIT_TEST_COMMIT_GRAPH"
by switching to "get_reachable_subset()" we don't have to toggle
te feature during the check.

>  /*
>   * Check for reachability of a remote-tracking
>   * ref in the reflog entries of its local ref.
>   */
>  static void check_if_includes_upstream(struct ref *remote)
>  {
> -	int prev;
>  	struct ref *local = get_local_ref(remote->name);
>  	if (!local)
>  		return;
> 
> -	/*
> -	 * TODO: Remove "toggle_commit_graph()" calls around the check.
> -	 * Depending on whether "commit-graph" enabled or not,
> -	 * "in_merge_bases_many()" returns different results;
> -	 * disable it temporarily when the check runs.
> -	 */
> -	prev = toggle_commit_graph(the_repository, 1);
>  	if (is_reachable_in_reflog(local->name, remote) <= 0)
>  		remote->unreachable = 1;
> -	toggle_commit_graph(the_repository, prev);
>  }
> 
>  static void apply_cas(struct push_cas_option *cas,
> --
> 2.28.0.windows.1.18.g5300e52e185
> 

Again, thank you so much working on this! If you'd like, I can go ahead
and apply these patches and rename "reflog_commit_list" to "commit_array"
in the next series (v10).

Thanks.
-- 
Srinidhi Kaushik
