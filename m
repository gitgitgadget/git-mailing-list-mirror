Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48456C4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 17:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD21221EF
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 17:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdUf3yPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbgJARyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 13:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732795AbgJARyy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 13:54:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBAAC0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 10:54:53 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v123so6342376qkd.9
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AlwccekBWUObpa8LBRukcN/aUSomAeIIAdWCdCUQlEU=;
        b=ZdUf3yPERYQKtI24LyhatNc021W1v0iXkv1H0hm7WK7ZDMTnqbn9DiVK58bytR135x
         gngJpRfzFxgaqFNG6Q49cxz8GVzsEUefROUbubP/oSJ0dfKJ4AwAvW5S8EAFzMgRCiPY
         xkDhr3nmFV+F8S0G4qUCo8bsWLEn0WoX/Ej5gBExp9iNdgRO+roQN0Ls9bsLjq3UQX8L
         S4lYdaONttkzkXGKmBbCSbIROmQxviTaco0vQhRhWPl48Q2kyChWL01DHOh1ZAmm6AcJ
         l1dXaOwzqJwhiJGMj+lNP5WPoj+Ghy/Onvxg694T17/84ViTqh17yXGMqVNeL0gWcMJb
         akzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AlwccekBWUObpa8LBRukcN/aUSomAeIIAdWCdCUQlEU=;
        b=CPjhc5lpuda8+tr0QoBanMBk2rknxfHFqqGY9obeFw3k2mjRiSa8N7yUZCqnTox5kX
         QWf6DY8kktWnOCPP4Xcr0peTaJJ0m+i1nt85iJw3YWjOYSqrABCdCH80MgVEkBdmsB+j
         SL1PxR4bUkypP4a5Z7PzmC8FfBaHgIyqwz/Zmc5tsro4NrHWL3pOfHvtZxO3HDEgpqTX
         WhPW3ISBo9puPj7X1m69YToI6K/zlpMCfWQaxrTHZgeXHCZI9ISKxFLSkrTJYFo7xbRl
         5v29Dz67pQFou61SqnygBtMSLMJP732rIYpcL2+kRf3SSP5fWQ3R6QqQuFUBwnU2mZzS
         zgAA==
X-Gm-Message-State: AOAM533MYvGzXQ35DVxZiaLl/tAjk/esl+tdk2y4g+AjKC4n1eRMpJ3x
        8LemSXTGX0lfgrXJiTXWQEo=
X-Google-Smtp-Source: ABdhPJzN+xgcJ5IH6edqDCftYxlVsxFoLrZDGsfYjsgwHRWlTpsaTng75jqV6oisXpUozHD4gkZlHA==
X-Received: by 2002:a37:78b:: with SMTP id 133mr8709573qkh.107.1601574892121;
        Thu, 01 Oct 2020 10:54:52 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.104.31])
        by smtp.gmail.com with ESMTPSA id x25sm7149829qtp.64.2020.10.01.10.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:54:51 -0700 (PDT)
Date:   Thu, 1 Oct 2020 23:24:43 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v9 0/3] push: add "--[no-]force-if-includes"
Message-ID: <20201001175443.GA28444@mail.clickyotomy.dev>
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
 <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
 <xmqqlfgqc5kq.fsf@gitster.c.googlers.com>
 <xmqq4knddg5v.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4knddg5v.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 10/01/2020 10:12, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> >
> >> Changes since v8:
> >>   - Disable "commit-graph" when "in_merge_bases_many()" is called
> >>     for this check, because it returns different results depending
> >>     on whether "commit-graph" is enabled [1].
> >
> > Is that a wise move, though?  If the "different results" is
> > expected, then it is a different story, but I would think it is a
> > bug in commit-graph codepath if it produces a result different from
> > what the callers expect, and disabling from the caller's end would
> > mean that we lose one opportunity to help commit-graph folks to go
> > and fix their bugs, no?

I didn't want want to cause a delay with this patch. Since the new
option was seemingly working without it, I decided to disable it here
and added a "TODO" in the comments to remove "toggle_commit_graph()"
in the future. We can definitely put this on hold and wait until the
with and without "commit-graph" result disparities are clarified.

> > Other than that, I think the topic is in quite a good shape.  Thanks
> > for working on polishing it.

Thanks, I appreciate it!
 
> In other words, how about doing it like so.
> 
> In an ideal world, folks who know more about commit-graph than we do
> will find what's broken in in_merge_bases_many() when commit-graph
> is in use, before I finish lecturing against hiding a breakage under
> the rug.  Let's see if another call for help helps ;-)

:)
 
>  remote.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git i/remote.c w/remote.c
> index 98a578f5dc..361b8f1c0e 100644
> --- i/remote.c
> +++ w/remote.c
> @@ -2408,7 +2408,20 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
>  /* Toggle the "commit-graph" feature; return the previously set state. */
>  static int toggle_commit_graph(struct repository *repo, int disable) {
>  	int prev = repo->commit_graph_disabled;
> -	repo->commit_graph_disabled = disable;
> +	static int should_toggle = -1;
> +
> +	if (should_toggle < 0) {
> +		/*
> +		 * The in_merge_bases_many() seems to misbehave when
> +		 * the commit-graph feature is in use.  Disable it for
> +		 * normal users, but keep it enabled when specifically
> +		 * testing the feature.
> +		 */
> +		should_toggle = !git_env_bool("GIT_TEST_COMMIT_GRAPH", 0);
> +	}
> +
> +	if (should_toggle)
> +		repo->commit_graph_disabled = disable;
>  	return prev;
>  }
>  

Ah, this will keep a record of the behavior in the tests; nice,
will update in the next set.

I looked around a little bit trying to understand what was happening
here. As mentioned before [1], "repo_in_merge_bases_many()" returns
early because of this:

  for (i = 0; i < nr_reference; i++) {
	  if (repo_parse_commit(r, reference[i]))
		  return ret;

	  generation = commit_graph_generation(reference[i]);
	  if (generation < min_generation)
		  min_generation = generation;
	  fprintf(stderr,
		  "[%s]: (local): generation: %u, min_generation: %u\n",
		  oid_to_hex(&reference[i]->object.oid),
		  generation,
		  min_generation);
  }

  generation = commit_graph_generation(commit);
  fprintf(stderr, "[%s]: (remote) generation: %u, min_generation: %u\n",
	  oid_to_hex(&commit->object.oid), generation, min_generation);
  if (generation > min_generation) {
	  return ret;
  }


I made some changes locally to display the generation numbers of all
the commits that were collected during the "reflog" traversal.

In the beginning we get the minimum generation number of the list of
the commits in "reference[]" to see if the "commit" is reachable from
one of the items in "reference[]". Since in this case, the generation
number of "commit" is higher than minimum amongst the members of
"reference", does it mean it cannot be reached?

When "GIT_TEST_COMMIT_GRAPH" is turned off, all of the commits in
"reference" as well as "commit" have "GENERATION_NUMBER_INFINITY",
and the path moves forward to "paint_down_to_common()" and correctly
identifies the reachability.

I ran the test again, but this time with running "git-commit-graph"
right before pushing:

  (a) git commit-graph write --reachable, and the commit's generation
      number was "GENERATION_NUMBER_INFINITY".

  (b) git-show-ref -s | git commit-graph write --stdin-commits, and
      the commit's generation number was 5.

and since generation number of "commit" was always higher than the
minimum -- it returns that it is not reachable from any of "reference".

One of the failing tests in t5533 was modified (for debugging), and
the following shows the difference in behavior of
"repo_in_merge_bases_many()". The test checks if the remote tip is
reachable from the reflog entries of the local branch after
"git pull --rebase" is run.

  $ git log --graph --oneline # (before "pull --rebase")
   * be2465f J
   * 157d38b C
   * f9a2dac B
   * 112d1ac A

  $ git log --graph --oneline # (after "pull --rebase")
   * 7c16010 J
   * b995a30 G
   * 00b6961 F
   * 157d38b C
   * f9a2dac B
   * 112d1ac A

  $ git reflog master
  7c16010 master@{0}: pull --rebase origin master (finish): refs/heads/master onto b995a30227dd14b34b6f7728201aefac8cc12296
  be2465f master@{1}: commit: J
  157d38b master@{2}: commit: C
  f9a2dac master@{3}: commit: B
  112d1ac master@{4}: commit (initial): A

  - (a) is run.
    $ git push --force-if-includes --force-with-lease=master
    [7c16010bad84d8b53873875c2e242890920360f2]: (local):  generation: 4294967295, min_generation: 4294967295
    [be2465f6a155acb8f5eb9ee876bad730e0f656cf]: (local):  generation: 4, min_generation: 4
    [157d38b4112d457e6645c7c4e9a486e6189be435]: (local):  generation: 3, min_generation: 3
    [f9a2dac17e4f8cafaa9655d40cb86c53094da8d6]: (local):  generation: 2, min_generation: 2
    [112d1ac551b908f10b995d7e41456f4cd8f071c5]: (local):  generation: 1, min_generation: 1
    [b995a30227dd14b34b6f7728201aefac8cc12296]: (remote): generation: 4294967295, min_generation: 1
    [...] fail.

  - "git fetch --all" and (b) is run.
    $ git push --force-if-includes --force-with-lease=master
    [7c16010bad84d8b53873875c2e242890920360f2]: (local):  generation: 4294967295, min_generation: 4294967295
    [be2465f6a155acb8f5eb9ee876bad730e0f656cf]: (local):  generation: 4, min_generation: 4
    [157d38b4112d457e6645c7c4e9a486e6189be435]: (local):  generation: 3, min_generation: 3
    [f9a2dac17e4f8cafaa9655d40cb86c53094da8d6]: (local):  generation: 2, min_generation: 2
    [112d1ac551b908f10b995d7e41456f4cd8f071c5]: (local):  generation: 1, min_generation: 1
    [b995a30227dd14b34b6f7728201aefac8cc12296]: (remote): generation: 5, min_generation: 1
    [...] fail.

  - neither (a), nor (b) are run, and "core.commitGraph" is disabled.
    $ git push --force-if-includes --force-with-lease=master
    [7c16010bad84d8b53873875c2e242890920360f2]: (local):  generation: 4294967295, min_generation: 4294967295
    [be2465f6a155acb8f5eb9ee876bad730e0f656cf]: (local):  generation: 4294967295, min_generation: 4294967295
    [157d38b4112d457e6645c7c4e9a486e6189be435]: (local):  generation: 4294967295, min_generation: 4294967295
    [f9a2dac17e4f8cafaa9655d40cb86c53094da8d6]: (local):  generation: 4294967295, min_generation: 4294967295
    [112d1ac551b908f10b995d7e41456f4cd8f071c5]: (local):  generation: 4294967295, min_generation: 4294967295
    [b995a30227dd14b34b6f7728201aefac8cc12296]: (remote): generation: 4294967295, min_generation: 4294967295
    [...] pass.

It looks like G (b995a30) is reachable from J (7c16010), but
"repo_in_merge_bases_many()" disagrees when "GIT_TEST_COMMIT_GRAPH"
is enabled. I hope this information helps a little to understand
why this happens and whether it is a bug or not.

[1] https://public-inbox.org/git/20200928193400.GA88208@mail.clickyotomy.dev

Thanks.
-- 
Srinidhi Kaushik
