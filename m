Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD0CC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 18:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562D3206A5
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 18:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vr+71G5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfLKSo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:44:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54070 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLKSoz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 13:44:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A8B1373A6;
        Wed, 11 Dec 2019 13:44:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bN0JvA6XJprQ/MYPqary/ifWmrQ=; b=Vr+71G
        5NJAaksMOaTzhchLWQVmHetQ+/iarcNvEvsLPAMhBCqlQ3ORYSAYW86nomXCFB3M
        gVdyhED1pInJFxw8bfcl+y/x8x7iTbPbFuiJsMm2RUgdRsAwix6KriV4Z97PEHHA
        h5igKYd+2a+NbyTN9Flpunk4cw4UodXC1uVHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P/J54p1HOBdc7TtJreEwIluMdM34Z0+z
        4JODT9nc4EbjwfGz9HZaaN29Mx+0DItNhsdpak4Q/y55yEa76OQe/p7dBFKLv0OF
        xHsX2pbzARoTyjQDN0YriXOXoqEg6yBMdeh6icNPIrpvh2vK5/w1/cHOeJHTYWiA
        F8iJdCplOpk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62B4A373A4;
        Wed, 11 Dec 2019 13:44:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B36293739E;
        Wed, 11 Dec 2019 13:44:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] sparse-checkout: respect core.ignoreCase in cone mode
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
        <23705845ce73992bf7ab645d28febebe0a698d49.1575920580.git.gitgitgadget@gmail.com>
Date:   Wed, 11 Dec 2019 10:44:52 -0800
In-Reply-To: <23705845ce73992bf7ab645d28febebe0a698d49.1575920580.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 09 Dec 2019
        19:43:00 +0000")
Message-ID: <xmqqtv66og63.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 520413B6-1C46-11EA-AB63-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Another option would be to do case-insensitive checks while
> updating the skip-worktree bits during unpack_trees(). Outside of
> the potential performance loss on a more expensive code path, that
> also breaks compatibility with older versions of Git as using the
> same sparse-checkout file would change the paths that are included.

I haven't thought things through, but that sounds as if saying that
we cannot fix old bugs.  We use the entries in the index as a hint
for "correcting" a path to the right case on a case-insensitive
filesystem to avoid corrupting the case in the index, which is case
sensitive and is a way to convey the intended case (by writing them
out to a tree object) to those who use systems that can reliably
reproduce cases in pathnames.  But that still does not mean on a
case-insensitive filesystem, "hello.c" in the "right" case recorded
in the index will always be spelled like so---somebody can make
readdir() or equivalent to yield "Hello.c" for it, and if the user
tells us to say they want to do X (e.g. ignore, skip checkout, etc.)
to "hello.c", we should do the same to "Hello.c" on such a system, I
would think.

If the runtime needs to deal with the case insensitive filesystems
anyway (and I suspect it does), there isn't much point matching and
forcing the case to the paths in the index like this patch does, I
think.  So...


> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt |  4 ++++
>  builtin/sparse-checkout.c             | 19 +++++++++++++++++--
>  cache.h                               |  1 +
>  name-hash.c                           | 10 ++++++++++
>  t/t1091-sparse-checkout-builtin.sh    | 13 +++++++++++++
>  5 files changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index b975285673..849efa0f0b 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -150,6 +150,10 @@ expecting patterns of these types. Git will warn if the patterns do not match.
>  If the patterns do match the expected format, then Git will use faster hash-
>  based algorithms to compute inclusion in the sparse-checkout.
>  
> +If `core.ignoreCase=true`, then the 'git sparse-checkout set' command will
> +correct for incorrect case when assigning patterns to the sparse-checkout
> +file.
> +
>  SEE ALSO
>  --------
>  
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index a542d617a5..0de426384e 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -336,6 +336,22 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
>  	}
>  }
>  
> +static void sanitize_cone_input(struct strbuf *line)
> +{
> +	if (ignore_case) {
> +		struct index_state *istate = the_repository->index;
> +		const char *name = index_dir_matching_name(istate, line->buf, line->len);
> +
> +		if (name) {
> +			strbuf_setlen(line, 0);
> +			strbuf_addstr(line, name);
> +		}
> +	}
> +
> +	if (line->buf[0] != '/')
> +		strbuf_insert(line, 0, "/", 1);
> +}
> +
>  static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
>  {
>  	strbuf_trim(line);
> @@ -345,8 +361,7 @@ static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
>  	if (!line->len)
>  		return;
>  
> -	if (line->buf[0] != '/')
> -		strbuf_insert(line, 0, "/", 1);
> +	sanitize_cone_input(line);
>  
>  	insert_recursive_pattern(pl, line);
>  }
> diff --git a/cache.h b/cache.h
> index d3c89e7a53..a2d9d437f0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -728,6 +728,7 @@ int repo_index_has_changes(struct repository *repo,
>  int verify_path(const char *path, unsigned mode);
>  int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
>  int index_dir_exists(struct index_state *istate, const char *name, int namelen);
> +const char *index_dir_matching_name(struct index_state *istate, const char *name, int namelen);
>  void adjust_dirname_case(struct index_state *istate, char *name);
>  struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
>  
> diff --git a/name-hash.c b/name-hash.c
> index ceb1d7bd6f..46898b6571 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -681,6 +681,16 @@ int index_dir_exists(struct index_state *istate, const char *name, int namelen)
>  	return dir && dir->nr;
>  }
>  
> +const char *index_dir_matching_name(struct index_state *istate, const char *name, int namelen)
> +{
> +	struct dir_entry *dir;
> +
> +	lazy_init_name_hash(istate);
> +	dir = find_dir_entry(istate, name, namelen);
> +
> +	return dir ? dir->name : NULL;
> +}
> +
>  void adjust_dirname_case(struct index_state *istate, char *name)
>  {
>  	const char *startPtr = name;
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index d5e2892526..d0ce48869f 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -304,4 +304,17 @@ test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status'
>  	git -C dirty sparse-checkout disable
>  '
>  
> +test_expect_success 'cone mode: set with core.ignoreCase=true' '
> +	test_when_finished git -C repo config --unset core.ignoreCase &&
> +	git -C repo sparse-checkout init --cone &&
> +	git -C repo config core.ignoreCase true &&
> +	git -C repo sparse-checkout set Folder1 &&
> +	cat >expect <<-EOF &&
> +		/*
> +		!/*/
> +		/folder1/
> +	EOF
> +	test_cmp expect repo/.git/info/sparse-checkout
> +'
> +
>  test_done
