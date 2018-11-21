Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E219C1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 03:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeKUOCO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 09:02:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60435 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeKUOCO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 09:02:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9475231DD1;
        Tue, 20 Nov 2018 22:29:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JfIHdQQtKYlH
        wnYfI5L+ERFZwpM=; b=cucZYl8fcc1OUwqW+lz39tGsSQF0c22an/umR6y34h/s
        L50Hz8rs1pKhDKLpPYNqAH1U4GCoWCDil4/29l7zk5C24Uv15hxalVJauT113bQL
        JSdVzeT0KnzvxLB18xxw9khRfL79ethxcT6Q7OR1XOga7GtQQv4xN8fan/nsOiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hM+rEa
        mjVADO2oMmyCWHVq+5cLyyP/eH41ag18wWl8T/idiup6UnA1vX769y7UxJT8xHKc
        aP0j3O4mzvovgwiwOayYrGu47mJ/jS9wFLn/HloGCHTdwood4ooes0NnoTgBJlaP
        NBWIxCzYYxImGNFEnjU0qeeo4KDL+m8PWiTj0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D65831DCF;
        Tue, 20 Nov 2018 22:29:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9188631DCD;
        Tue, 20 Nov 2018 22:29:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
References: <20181121012344.26711-1-szeder.dev@gmail.com>
        <20181121012532.26878-1-szeder.dev@gmail.com>
Date:   Wed, 21 Nov 2018 12:29:34 +0900
In-Reply-To: <20181121012532.26878-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 21 Nov 2018 02:25:32 +0100")
Message-ID: <xmqqwop785wh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABCFF088-ED3D-11E8-9D41-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> I rename these variables to 'num_large_edges', because the commit
> graph file format speaks about the 'Large Edge List' chunk.
>
> However, I do find that the term 'extra' makes much more sense and
> fits the concept better (i.e. extra commit graph edges resulting from
> the extra parents or octopus merges; after a s/extra/large/g the
> previous phrase would make no sense), and notice that the term 'large'
> doesn't come up in the file format itseld (the chunk's magic is {'E',
> 'D', 'G', 'E'}, there is no 'L' in there), but only in the
> specification text and a couple of variable and function names in the
> code.
>
> Would it make sense to do the rename in the other direction?

So edges that are involved in octopus merges are counted with
num_extra_edges and written to the large edges table?

I tend to agree that "large edge" is a misnomer.  These edges that
point at third and subsequent parents are no larger than the edges
that point at the first or the second parents---they are the same
size.  What is larger than usual is the size of the list of edges
(i.e. the number of parents), because the commit has extra (compared
to the majority of commits) number of edges.  So from the point of
view, I agree with you that "extra" makes a lot more sense than
"large".

And the magic number being "EDGE" without "L" is probably a good
thing, as a graph whose commits are all without any extra edge does
not need the "EDGE" chunk, so presence of the chunk by itself is a
sign that extra things are involved.  Which means that there isn't
any need to update the magic number, if we wanted to get rid of
"large" and replace it with "extra".  The only thing needed to
update the documentation, variable names and in-code comment.

And while at it, GRAPH_OCTOPUS_EDGES_NEEDED may also want to be
renamed with s/OCTOPUS/EXTRA/;

>  commit-graph.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 40c855f185..7b4e3a02cf 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -475,7 +475,7 @@ static void write_graph_chunk_data(struct hashfile =
*f, int hash_len,
>  {
>  	struct commit **list =3D commits;
>  	struct commit **last =3D commits + nr_commits;
> -	uint32_t num_extra_edges =3D 0;
> +	uint32_t num_large_edges =3D 0;
> =20
>  	while (list < last) {
>  		struct commit_list *parent;
> @@ -507,7 +507,7 @@ static void write_graph_chunk_data(struct hashfile =
*f, int hash_len,
>  		if (!parent)
>  			edge_value =3D GRAPH_PARENT_NONE;
>  		else if (parent->next)
> -			edge_value =3D GRAPH_OCTOPUS_EDGES_NEEDED | num_extra_edges;
> +			edge_value =3D GRAPH_OCTOPUS_EDGES_NEEDED | num_large_edges;
>  		else {
>  			edge_value =3D sha1_pos(parent->item->object.oid.hash,
>  					      commits,
> @@ -521,7 +521,7 @@ static void write_graph_chunk_data(struct hashfile =
*f, int hash_len,
> =20
>  		if (edge_value & GRAPH_OCTOPUS_EDGES_NEEDED) {
>  			do {
> -				num_extra_edges++;
> +				num_large_edges++;
>  				parent =3D parent->next;
>  			} while (parent);
>  		}
> @@ -761,7 +761,7 @@ void write_commit_graph(const char *obj_dir,
>  	uint32_t chunk_ids[5];
>  	uint64_t chunk_offsets[5];
>  	int num_chunks;
> -	int num_extra_edges;
> +	int num_large_edges;
>  	struct commit_list *parent;
>  	struct progress *progress =3D NULL;
> =20
> @@ -871,7 +871,7 @@ void write_commit_graph(const char *obj_dir,
>  	commits.alloc =3D count_distinct;
>  	ALLOC_ARRAY(commits.list, commits.alloc);
> =20
> -	num_extra_edges =3D 0;
> +	num_large_edges =3D 0;
>  	for (i =3D 0; i < oids.nr; i++) {
>  		int num_parents =3D 0;
>  		if (i > 0 && oideq(&oids.list[i - 1], &oids.list[i]))
> @@ -885,11 +885,11 @@ void write_commit_graph(const char *obj_dir,
>  			num_parents++;
> =20
>  		if (num_parents > 2)
> -			num_extra_edges +=3D num_parents - 1;
> +			num_large_edges +=3D num_parents - 1;
> =20
>  		commits.nr++;
>  	}
> -	num_chunks =3D num_extra_edges ? 4 : 3;
> +	num_chunks =3D num_large_edges ? 4 : 3;
> =20
>  	if (commits.nr >=3D GRAPH_PARENT_MISSING)
>  		die(_("too many commits to write graph"));
> @@ -916,7 +916,7 @@ void write_commit_graph(const char *obj_dir,
>  	chunk_ids[0] =3D GRAPH_CHUNKID_OIDFANOUT;
>  	chunk_ids[1] =3D GRAPH_CHUNKID_OIDLOOKUP;
>  	chunk_ids[2] =3D GRAPH_CHUNKID_DATA;
> -	if (num_extra_edges)
> +	if (num_large_edges)
>  		chunk_ids[3] =3D GRAPH_CHUNKID_LARGEEDGES;
>  	else
>  		chunk_ids[3] =3D 0;
> @@ -926,7 +926,7 @@ void write_commit_graph(const char *obj_dir,
>  	chunk_offsets[1] =3D chunk_offsets[0] + GRAPH_FANOUT_SIZE;
>  	chunk_offsets[2] =3D chunk_offsets[1] + GRAPH_OID_LEN * commits.nr;
>  	chunk_offsets[3] =3D chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commit=
s.nr;
> -	chunk_offsets[4] =3D chunk_offsets[3] + 4 * num_extra_edges;
> +	chunk_offsets[4] =3D chunk_offsets[3] + 4 * num_large_edges;
> =20
>  	for (i =3D 0; i <=3D num_chunks; i++) {
>  		uint32_t chunk_write[3];
