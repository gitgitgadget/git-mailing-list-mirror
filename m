Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F3F1F45F
	for <e@80x24.org>; Tue,  7 May 2019 08:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfEGIbg (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 04:31:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55153 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGIbg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 04:31:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F5034FC23;
        Tue,  7 May 2019 04:31:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3DcrOHzJft600QS7EcoAk+39bF0=; b=NqpIa9
        XyYLvNlcXLjv3baWY6lJbpN6sUFQgBe7FdL2vuN8Bd/WwZ52Ov8PZ2ZUU8dAntfj
        f0SFTf3H6b4JoZLtd6wTlnPWRT+dDe9SKVLG2JaDMqItflMbQV/jbqrCWsbKTSeY
        gDIdrnbLbnGto26nSSm2/cSmX45Jbdwj4qJUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MWv04S8ZfyHUF7zIITgx4+p+4PoAZ7pO
        U392NUxHE0wgrrGRAiTeO53Cpc5j4WhdBYlaxhplVe+ZGWTZjHavJcuZW16v5gVk
        zHNT1sWSeb1U6p08RdEYJKTwtZ9V5TQ8BGtHJoxgwx6m+WvkkmSWAa81gvwbFWh2
        nbbSemhiY8M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0864D4FC22;
        Tue,  7 May 2019 04:31:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 310A94FC1F;
        Tue,  7 May 2019 04:31:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] midx: pass a repository pointer
References: <pull.182.git.gitgitgadget@gmail.com>
        <3b6324df4d26f47058a714abe47b9df7811c383e.1556554734.git.gitgitgadget@gmail.com>
Date:   Tue, 07 May 2019 17:31:28 +0900
In-Reply-To: <3b6324df4d26f47058a714abe47b9df7811c383e.1556554734.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 29 Apr 2019
        09:18:55 -0700 (PDT)")
Message-ID: <xmqq8svimzrz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83F17BB6-70A2-11E9-9E80-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Much of the multi-pack-index code focuses on the multi_pack_index
> struct, and so we only pass a pointer to the current one. However,
> we will insert a dependency on the packed_git linked list in a
> future change, so we will need a repository reference. Inserting
> these parameters is a significant enough change to split out.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

This is a good move in the loger term, but not a happy thing to do
while your "expire" topic is still in flight, as the impact from
updating the signature of prepare_midx_pack() and friends will break
new callers in expire_midx_packs() etc.

I am tempted to queue this and eject ds/midx-expire-repack for now,
while checking how that topic would look like when rebased on top of
these two patches.  We'll see.

Thanks.

>  builtin/multi-pack-index.c |  2 +-
>  builtin/pack-objects.c     |  2 +-
>  midx.c                     | 22 ++++++++++++++--------
>  midx.h                     |  7 ++++---
>  packfile.c                 |  4 ++--
>  5 files changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index ae6e476ad5..72dfd3dadc 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -46,7 +46,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
>  	if (!strcmp(argv[0], "write"))
>  		return write_midx_file(opts.object_dir);
>  	if (!strcmp(argv[0], "verify"))
> -		return verify_midx_file(opts.object_dir);
> +		return verify_midx_file(the_repository, opts.object_dir);
>  
>  	die(_("unrecognized verb: %s"), argv[0]);
>  }
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 2d9a3bdc9d..e606b9ef03 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1078,7 +1078,7 @@ static int want_object_in_pack(const struct object_id *oid,
>  
>  	for (m = get_multi_pack_index(the_repository); m; m = m->next) {
>  		struct pack_entry e;
> -		if (fill_midx_entry(oid, &e, m)) {
> +		if (fill_midx_entry(the_repository, oid, &e, m)) {
>  			struct packed_git *p = e.p;
>  			off_t offset;
>  
> diff --git a/midx.c b/midx.c
> index d5d2e9522f..8b8faec35a 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -201,7 +201,7 @@ void close_midx(struct multi_pack_index *m)
>  	FREE_AND_NULL(m->pack_names);
>  }
>  
> -int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id)
> +int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id)
>  {
>  	struct strbuf pack_name = STRBUF_INIT;
>  
> @@ -261,7 +261,10 @@ static uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
>  	return get_be32(m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH);
>  }
>  
> -static int nth_midxed_pack_entry(struct multi_pack_index *m, struct pack_entry *e, uint32_t pos)
> +static int nth_midxed_pack_entry(struct repository *r,
> +				 struct multi_pack_index *m,
> +				 struct pack_entry *e,
> +				 uint32_t pos)
>  {
>  	uint32_t pack_int_id;
>  	struct packed_git *p;
> @@ -271,7 +274,7 @@ static int nth_midxed_pack_entry(struct multi_pack_index *m, struct pack_entry *
>  
>  	pack_int_id = nth_midxed_pack_int_id(m, pos);
>  
> -	if (prepare_midx_pack(m, pack_int_id))
> +	if (prepare_midx_pack(r, m, pack_int_id))
>  		die(_("error preparing packfile from multi-pack-index"));
>  	p = m->packs[pack_int_id];
>  
> @@ -301,14 +304,17 @@ static int nth_midxed_pack_entry(struct multi_pack_index *m, struct pack_entry *
>  	return 1;
>  }
>  
> -int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m)
> +int fill_midx_entry(struct repository * r,
> +		    const struct object_id *oid,
> +		    struct pack_entry *e,
> +		    struct multi_pack_index *m)
>  {
>  	uint32_t pos;
>  
>  	if (!bsearch_midx(oid, m, &pos))
>  		return 0;
>  
> -	return nth_midxed_pack_entry(m, e, pos);
> +	return nth_midxed_pack_entry(r, m, e, pos);
>  }
>  
>  /* Match "foo.idx" against either "foo.pack" _or_ "foo.idx". */
> @@ -1020,7 +1026,7 @@ static int compare_pair_pos_vs_id(const void *_a, const void *_b)
>  			display_progress(progress, _n); \
>  	} while (0)
>  
> -int verify_midx_file(const char *object_dir)
> +int verify_midx_file(struct repository *r, const char *object_dir)
>  {
>  	struct pair_pos_vs_id *pairs = NULL;
>  	uint32_t i;
> @@ -1034,7 +1040,7 @@ int verify_midx_file(const char *object_dir)
>  	progress = start_progress(_("Looking for referenced packfiles"),
>  				  m->num_packs);
>  	for (i = 0; i < m->num_packs; i++) {
> -		if (prepare_midx_pack(m, i))
> +		if (prepare_midx_pack(r, m, i))
>  			midx_report("failed to load pack in position %d", i);
>  
>  		display_progress(progress, i + 1);
> @@ -1099,7 +1105,7 @@ int verify_midx_file(const char *object_dir)
>  
>  		nth_midxed_object_oid(&oid, m, pairs[i].pos);
>  
> -		if (!fill_midx_entry(&oid, &e, m)) {
> +		if (!fill_midx_entry(r, &oid, &e, m)) {
>  			midx_report(_("failed to load pack entry for oid[%d] = %s"),
>  				    pairs[i].pos, oid_to_hex(&oid));
>  			continue;
> diff --git a/midx.h b/midx.h
> index 26dd042d63..3eb29731f2 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -5,6 +5,7 @@
>  
>  struct object_id;
>  struct pack_entry;
> +struct repository;
>  
>  #define GIT_TEST_MULTI_PACK_INDEX "GIT_TEST_MULTI_PACK_INDEX"
>  
> @@ -37,18 +38,18 @@ struct multi_pack_index {
>  };
>  
>  struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
> -int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id);
> +int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
>  int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
>  struct object_id *nth_midxed_object_oid(struct object_id *oid,
>  					struct multi_pack_index *m,
>  					uint32_t n);
> -int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
> +int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
>  int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name);
>  int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
>  
>  int write_midx_file(const char *object_dir);
>  void clear_midx_file(struct repository *r);
> -int verify_midx_file(const char *object_dir);
> +int verify_midx_file(struct repository *r, const char *object_dir);
>  
>  void close_midx(struct multi_pack_index *m);
>  
> diff --git a/packfile.c b/packfile.c
> index cdf6b6ec34..7b94a14726 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1035,7 +1035,7 @@ struct packed_git *get_all_packs(struct repository *r)
>  		for (m = r->objects->multi_pack_index; m; m = m->next) {
>  			uint32_t i;
>  			for (i = 0; i < m->num_packs; i++) {
> -				if (!prepare_midx_pack(m, i)) {
> +				if (!prepare_midx_pack(r, m, i)) {
>  					m->packs[i]->next = p;
>  					p = m->packs[i];
>  				}
> @@ -1998,7 +1998,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
>  		return 0;
>  
>  	for (m = r->objects->multi_pack_index; m; m = m->next) {
> -		if (fill_midx_entry(oid, e, m))
> +		if (fill_midx_entry(r, oid, e, m))
>  			return 1;
>  	}
