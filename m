Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B863CC388F9
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BBCB21D91
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKAd1A7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgKCR7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgKCR7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 12:59:07 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEBFC061A47
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 09:59:05 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id f9so23429934lfq.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 09:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Qnyl1QGYLqA8whDgEnIsXr6sb/MDV78Fuj1b+EDpGJA=;
        b=cKAd1A7JhthbzQPIzZV7stPOxmsplmObEOXCYgCS5tnqPOJOUo86/S43o3nhfvHlNW
         JlERAE/9s99KYXgpsGCxcOD4/S6iNYQq/9Fvn9LIVp6cRSSdXvYJlf1Swpwa2fpnT0pF
         53N9mxEYEOeUpNVYjl3Nwf/Sqod0C1ERDX6Cr6lRVXCvkuz4CSFEZkmSuB/XNX8B0bX4
         2JIHpmrvWmsfv4Mt1UQczlmNP//YvfkiJwOSYZ8RMIVGCoorvqk7Ltq7DpbQEtcYYowq
         K9BvEuoOdiRVFjrTD0uC55ZNmcg069osNRunBQr5UtjfNnat3+lP1Hv3s5+CIra59fHy
         edhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Qnyl1QGYLqA8whDgEnIsXr6sb/MDV78Fuj1b+EDpGJA=;
        b=hq1CFoh9RDWc3aAdNuqEq2Yb4ImcWwwunrERc6ZayA7avUMj2hcoCIZmC7z+hRJycO
         VShZfx+Va/Vyu22t4dXcoq9E4j4K6dAT6JeVDB7CiC4VYTaIvUCbgYgYEjVpH/S7pDn3
         tOJpAAIi6BZhf964u8NvTk5tgzv6+o5bvBctnf5WzfFvJFn4rntzt+LeYzSZixxEralq
         sjimzH5aeJqcHArMXDJqgvPzEm+TM8VZaEFCJ72JzOkzHn9J2vIw13tO/Zi0ULizzVQo
         yZ4MvSnsxVA0NXiEH65MbwtbuuPb3vFeDu5hnK88vlNo7jvKscODgcM345M0+T/e3mv2
         bNlw==
X-Gm-Message-State: AOAM531y/A3YMihKApETtTMGV2u4Yr99tgCnfMwlZZ8D0/si2JAHf+gW
        lweeFeTCiyk6Jn3zpdEaZEaui+UX4I9XOA==
X-Google-Smtp-Source: ABdhPJzYB/L5CzFdJP4kvblzWAdsikDt8DIpGVcckqHU87I5JkUQVQFDpNEsXRTRyWOEHySEmwoiYA==
X-Received: by 2002:a19:8c2:: with SMTP id 185mr7217695lfi.49.1604426343899;
        Tue, 03 Nov 2020 09:59:03 -0800 (PST)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id d16sm3904419lfm.55.2020.11.03.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 09:59:02 -0800 (PST)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v4 09/10] commit-reach: use corrected commit dates in paint_down_to_common()
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <bb9b02af32d028fc0c26d372aa490e260c74e74d.1602079786.git.gitgitgadget@gmail.com>
Date:   Tue, 03 Nov 2020 18:59:03 +0100
In-Reply-To: <bb9b02af32d028fc0c26d372aa490e260c74e74d.1602079786.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Wed, 07 Oct 2020 14:09:44
        +0000")
Message-ID: <85y2jiqq3c.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> With corrected commit dates implemented, we no longer have to rely on
> commit date as a heuristic in paint_down_to_common().
>
> While using corrected commit dates Git walks nearly the same number of
> commits as commit date, the process is slower as for each comparision we
> have to access a commit-slab (for corrected committer date) instead of
> accessing struct member (for committer date).

Something for the future: I wonder if it would be worth it to bring back
generation number from the commit-slab into `struct commit`.

>
> For example, the command `git merge-base v4.8 v4.9` on the linux
> repository walks 167468 commits, taking 0.135s for committer date and
> 167496 commits, taking 0.157s for corrected committer date respectively.

I think it would be good idea to explicitly refer to the commit that
changed paint_down_to_common() to *not* use generation numbers v1
(topological levels) in the cases such as this, namely 091f4cf3 (commit:
don't use generation numbers if not needed).  In this commit we have the
following:

  This change makes a concrete difference depending on the topology
  of the commit graph. For instance, computing the merge-base between
  consecutive versions of the Linux kernel has no effect for versions
  after v4.9, but 'git merge-base v4.8 v4.9' presents a performance
  regression:

      v2.18.0: 0.122s
  v2.19.0-rc1: 0.547s
         HEAD: 0.127s

  To determine that this was simply an ordering issue, I inserted
  a counter within the while loop of paint_down_to_common() and
  found that the loop runs 167,468 times in v2.18.0 and 635,579
  times in v2.19.0-rc1.

The times you report (0.135s and 0.157s) are close to 0.122s / 0.127s
reported in 091f4cf3 - that is most probably because of the differences
in the system performance (hardware, operating system, load, etc.).
Numbers of commits walked for the committed date heuristics, that is
167,468 agrees with your results; 167,496 (+28) for corrected commit
date (generation number v2) is significantly smaller (-468,083) than
635,579 reported for topological levels (generation number v1).

I suspect that there are cases (with date skew) where corrected commit
date gives better performance than committer date heuristics, and I am
quite sure that generation number v2 can give better performance in case
where paint_down_to_common() uses generation numbers.

.................................................................

Here begins separate second change, which is not put into separate
commit because it is fairly tightly connected to the change described
above.  It would be good idea, in my opinion, to add a sentence that
explicitely marks this switch, for example:

  This change accidentally broke fragile t6404-recursive-merge test.
  t6404-recursive-merge setups a unique repository...

Maybe with s/accidentaly/incidentally/.

Or add some other way of connection those two parts of the commit
messages.

> t6404-recursive-merge setups a unique repository where all commits have
> the same committer date without well-defined merge-base.
>
> While running tests with GIT_TEST_COMMIT_GRAPH unset, we use committer
> date as a heuristic in paint_down_to_common(). 6404.1 'combined merge
> conflicts' merges commits in the order:
> - Merge C with B to form a intermediate commit.
> - Merge the intermediate commit with A.
>
> With GIT_TEST_COMMIT_GRAPH=3D1, we write a commit-graph and subsequently
> use the corrected committer date, which changes the order in which
> commits are merged:
> - Merge A with B to form a intermediate commit.
> - Merge the intermediate commit with C.
>
> While resulting repositories are equivalent, 6404.4 'virtual trees were
> processed' fails with GIT_TEST_COMMIT_GRAPH=3D1 as we are selecting
> different merge-bases and thus have different object ids for the
> intermediate commits.
>
> As this has already causes problems (as noted in 859fdc0 (commit-graph:
> define GIT_TEST_COMMIT_GRAPH, 2018-08-29)), we disable commit graph
> within t6404-recursive-merge.

Very nice explanation.

Perhaps in the future we could make this test less fragile.

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c             | 14 ++++++++++++++
>  commit-graph.h             |  8 +++++++-
>  commit-reach.c             |  2 +-
>  t/t6404-recursive-merge.sh |  5 ++++-
>  4 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 5d15a1399b..3de1933ede 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -705,6 +705,20 @@ int generation_numbers_enabled(struct repository *r)
>  	return !!first_generation;
>  }
>=20=20
> +int corrected_commit_dates_enabled(struct repository *r)
> +{
> +	struct commit_graph *g;
> +	if (!prepare_commit_graph(r))
> +		return 0;
> +
> +	g =3D r->objects->commit_graph;
> +
> +	if (!g->num_commits)
> +		return 0;
> +
> +	return g->read_generation_data;
> +}

Very nice abstraction.

Minor issue: I wonder if it would be better to use _available() or
"_present()" rather than _enabled() suffix.

> +
>  struct bloom_filter_settings *get_bloom_filter_settings(struct repositor=
y *r)
>  {
>  	struct commit_graph *g =3D r->objects->commit_graph;
> diff --git a/commit-graph.h b/commit-graph.h
> index ad52130883..d2c048dc64 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -89,13 +89,19 @@ struct commit_graph *read_commit_graph_one(struct rep=
ository *r,
>  struct commit_graph *parse_commit_graph(struct repository *r,
>  					void *graph_map, size_t graph_size);
>=20=20
> +struct bloom_filter_settings *get_bloom_filter_settings(struct repositor=
y *r);
> +
>  /*
>   * Return 1 if and only if the repository has a commit-graph
>   * file and generation numbers are computed in that file.
>   */
>  int generation_numbers_enabled(struct repository *r);
>=20=20
> -struct bloom_filter_settings *get_bloom_filter_settings(struct repositor=
y *r);

This moving get_bloom_filter_settings() before generation_numbers_enabled()=
=20
looks like accidental change.  If not, why it is here?

> +/*
> + * Return 1 if and only if the repository has a commit-graph
> + * file and generation data chunk has been written for the file.
> + */
> +int corrected_commit_dates_enabled(struct repository *r);
>

All right, nice to have documentation for the public function.

>  enum commit_graph_write_flags {
>  	COMMIT_GRAPH_WRITE_APPEND     =3D (1 << 0),
> diff --git a/commit-reach.c b/commit-reach.c
> index 20b48b872b..46f5a9e638 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -39,7 +39,7 @@ static struct commit_list *paint_down_to_common(struct =
repository *r,
>  	int i;
>  	timestamp_t last_gen =3D GENERATION_NUMBER_INFINITY;
>=20=20
> -	if (!min_generation)
> +	if (!min_generation && !corrected_commit_dates_enabled(r))
>  		queue.compare =3D compare_commits_by_commit_date;
>=20=20
>  	one->object.flags |=3D PARENT1;

All right, this is the meat of the first change.

> diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
> index 332cfc53fd..7055771b62 100755
> --- a/t/t6404-recursive-merge.sh
> +++ b/t/t6404-recursive-merge.sh
> @@ -15,6 +15,8 @@ GIT_COMMITTER_DATE=3D"2006-12-12 23:28:00 +0100"
>  export GIT_COMMITTER_DATE
>=20=20
>  test_expect_success 'setup tests' '
> +	GIT_TEST_COMMIT_GRAPH=3D0 &&
> +	export GIT_TEST_COMMIT_GRAPH &&
>  	echo 1 >a1 &&
>  	git add a1 &&
>  	GIT_AUTHOR_DATE=3D"2006-12-12 23:00:00" git commit -m 1 a1 &&

All right, we turn off running this test with commit-graph for the whole
script, not only for a single test.  As this is a setup, it would be run
even if we are skipping some tests.

> @@ -66,7 +68,7 @@ test_expect_success 'setup tests' '
>  '
>=20=20
>  test_expect_success 'combined merge conflicts' '
> -	test_must_fail env GIT_TEST_COMMIT_GRAPH=3D0 git merge -m final G
> +	test_must_fail git merge -m final G
>  '

All right, it is no longer necessary to run this specific test with
GIT_TEST_COMMIT_GRAPH=3D0 as now the whole script is run with this
setting.

>=20=20
>  test_expect_success 'result contains a conflict' '
> @@ -82,6 +84,7 @@ test_expect_success 'result contains a conflict' '
>  '
>=20=20
>  test_expect_success 'virtual trees were processed' '
> +	# TODO: fragile test, relies on ambigious merge-base resolution
>  	git ls-files --stage >out &&
>=20=20
>  	cat >expect <<-EOF &&

Good call!  Nice adding TODO comment for the future.

Best,
--=20
Jakub Nar=C4=99bski
