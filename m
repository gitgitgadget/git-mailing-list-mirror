Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D40C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2193E208D5
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="empJjx5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgFRUa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:30:59 -0400
Received: from mout.web.de ([217.72.192.78]:44807 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgFRUa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 16:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592512250;
        bh=DTgKyccMID3DIaLa5qOuChmXDEgWb45TLyw5w8bViqQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=empJjx5pLxQyTXHpf3JhmQwvu74rmotA4WlIuCarGN5P8r7iVlmn+OiJXOScwFaN2
         0E2+Nkv0KNUUuFDc5kcCXSjWuvprK3FAHoCRI7o7vqqXcOhkb68h1OMQCOzocCSlnu
         t2wIBJozK9/wfdO6hFxRYvuaEUAgl6MUOv94RuIU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDxGV-1jfjNO3ca7-00HPRa; Thu, 18
 Jun 2020 22:30:49 +0200
Subject: Re: [PATCH 3/8] commit-graph: simplify chunk writes into loop
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <3d24b9802df3d1fe8c670ba602890c95df96f2f5.1592252093.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6779f98a-8ba3-089b-afd6-889c2caba2ff@web.de>
Date:   Thu, 18 Jun 2020 22:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3d24b9802df3d1fe8c670ba602890c95df96f2f5.1592252093.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NZZr+PzOFnltIv1YiyWN9d0qCwyGUA9B/f9wYNF2sEoMpbszRHn
 1ZxDs/i2VJjbnc+VcCjzHkM2Z4apzF3xxYuYBfb97rygKV/MI/P5qfd8stax1WR57JXI/G9
 0aNvk+ykcJ4x8pLSNRYxRbckbQteFRQXN7PcFL+JOduxoFv/lcHkAM2BZq9N5F/muwPMusf
 hZObmBIy1hjuqUaQ+KOFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dgIpOJpETF4=:x/i0yXfiQTHGeo1UgJksdT
 7ovkzflg58zfNhvejSEaBKfBTLTDvNdIijEyHheb/kwUUvtbOieuJK9r83KfjYa6YaIgDYtPO
 wQZNQBOXa7uUTWmoBVfi8CLwHYlBEzDPYmW5tPng6gypqD2W+LWGUuKKcUfQxNIugIElmyx66
 2nHqIssIMgjwxGGjXpwTsQsu8l6g/3VILgapH+snPS4x/2QrYe4ei7EZiSSXYO1xXAAMJe2OX
 jKeMyjsNZqdBOh7dkjveOnMxp0vFTlLMGVYAYKwtFGlvVN3Wdu0cn6hdRjjWjq/8VMesA6EBY
 esvRCxYNGpMbcCnHFHVlgy7bhZ5zNuOsB1eobTyGK1OlwMExPpK/au0D9QtGHBo4FI+mCg+hy
 J0t51SPL9sfkcGCtxfh6bJUgE4POO6eMgukMYub0/81bmQQb61yFtpzbDE5YqKx5abuUfQVSY
 mBQk9GTUkCxO9bbXlMGvd0eelmnKGwl8uBuYjDD86wJB9Vp6r+Ed7rJ9xI11TCf/8flkkPdi0
 NVPU92B6Dxvlehf/T6aI4eN+viCJySbyGFo1yETgngzdnnZoRrvqvPWn1vMyQycdIXWwf1Ot/
 yxPOHJPdV/zxUZC9gBigcP5P/mXpO3rDWAf0bAn9qSsJY+tu5YmvBd49M2vuz1KEtE+fMSJ7m
 1QaVQycFkjd1csIez4uGUbfafj1wzR5xUVSS35o/yFwJ/uOVYSzC0977t0dOfqD1deEo7VQd3
 17/HORBOnvALTQvf6YnWzqnBkaeejCaSHTKFP0fbbb5F3FkZegRDhL8DMUtoHBBcxIfQMf6Wc
 QxTuiQhQ7BOwFFv0U75cQdFDbcTAiUEitt3nqDdSavX2jlrUElVhhmJsu7NKTvhPN3dg7CqYV
 0a5akcggbQwnA4hgzKkWGXDgTO0IjujbIcTwvbMRv5UBbsEGeP5LPDC0gwkEaGw1n0v1CS9DN
 5zYn8a7WfxQkB85zzfUZ/bs4hZDEoPxcNhiCCXAj/PUvnN8sdlfy0s+Um++2W94ctcRLlJ/El
 UKKkmNCtHoZ6Uapxm20oBe3ahi2LpATMCosT32p8dCclUlAJxB7OGiKBNAE0DJ+7/On9bAIOw
 oGj+84Y9TeMhLL8xIUC0TNOuq0y6GPWMKeh0/f8Jzbt2poI4f9zmlXgr3LQqXt4YOR4TOG7dt
 2ybPnCyRcxDAcxvF1NoE8NtfwzZcUR4KRSanlD+9p4GzaOqIksePwJsbIvEXIFfFS3JrM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.20 um 22:14 schrieb SZEDER G=C3=A1bor via GitGitGadget:
> From: =3D?UTF-8?q?SZEDER=3D20G=3DC3=3DA1bor?=3D <szeder.dev@gmail.com>
>
> In write_commit_graph_file() we now have one block of code filling the
> array of 'struct chunk_info' with the IDs and sizes of chunks to be
> written, and an other block of code calling the functions responsible
> for writing individual chunks.  In case of optional chunks like Extra
> Edge List an Base Graphs List there is also a condition checking
> whether that chunk is necessary/desired, and that same condition is
> repeated in both blocks of code. Other, newer chunks have similar
> optional conditions.
>
> Eliminate these repeated conditions by storing the function pointers
> responsible for writing individual chunks in the 'struct chunk_info'
> array as well, and calling them in a loop to write the commit-graph
> file.  This will open up the possibility for a bit of foolproofing in
> the following patch.

OK.  An alternative would be a switch in the loop that calls the right
function based on the chunk id.  That would not require uniform
interfaces for all write functions; patch 2 would not be necessary.

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 3bae1e52ed0..78e023be664 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1532,9 +1532,13 @@ static int write_graph_chunk_base(struct hashfile=
 *f,
>  	return 0;
>  }
>
> +typedef int (*chunk_write_fn)(struct hashfile *f,
> +			      struct write_commit_graph_context *ctx);
> +
>  struct chunk_info {
>  	uint32_t id;
>  	uint64_t size;
> +	chunk_write_fn write_fn;
>  };
>
>  static int write_commit_graph_file(struct write_commit_graph_context *c=
tx)
> @@ -1591,27 +1595,34 @@ static int write_commit_graph_file(struct write_=
commit_graph_context *ctx)
>
>  	chunks[0].id =3D GRAPH_CHUNKID_OIDFANOUT;
>  	chunks[0].size =3D GRAPH_FANOUT_SIZE;
> +	chunks[0].write_fn =3D write_graph_chunk_fanout;
>  	chunks[1].id =3D GRAPH_CHUNKID_OIDLOOKUP;
>  	chunks[1].size =3D hashsz * ctx->commits.nr;
> +	chunks[1].write_fn =3D write_graph_chunk_oids;
>  	chunks[2].id =3D GRAPH_CHUNKID_DATA;
>  	chunks[2].size =3D (hashsz + 16) * ctx->commits.nr;
> +	chunks[2].write_fn =3D write_graph_chunk_data;
>  	if (ctx->num_extra_edges) {
>  		chunks[num_chunks].id =3D GRAPH_CHUNKID_EXTRAEDGES;
>  		chunks[num_chunks].size =3D 4 * ctx->num_extra_edges;
> +		chunks[num_chunks].write_fn =3D write_graph_chunk_extra_edges;
>  		num_chunks++;
>  	}
>  	if (ctx->changed_paths) {
>  		chunks[num_chunks].id =3D GRAPH_CHUNKID_BLOOMINDEXES;
>  		chunks[num_chunks].size =3D sizeof(uint32_t) * ctx->commits.nr;
> +		chunks[num_chunks].write_fn =3D write_graph_chunk_bloom_indexes;
>  		num_chunks++;
>  		chunks[num_chunks].id =3D GRAPH_CHUNKID_BLOOMDATA;
>  		chunks[num_chunks].size =3D sizeof(uint32_t) * 3
>  					  + ctx->total_bloom_filter_data_size;
> +		chunks[num_chunks].write_fn =3D write_graph_chunk_bloom_data;
>  		num_chunks++;
>  	}
>  	if (ctx->num_commit_graphs_after > 1) {
>  		chunks[num_chunks].id =3D GRAPH_CHUNKID_BASE;
>  		chunks[num_chunks].size =3D hashsz * (ctx->num_commit_graphs_after - =
1);
> +		chunks[num_chunks].write_fn =3D write_graph_chunk_base;
>  		num_chunks++;
>  	}
>
> @@ -1647,19 +1658,15 @@ static int write_commit_graph_file(struct write_=
commit_graph_context *ctx)
>  			progress_title.buf,
>  			num_chunks * ctx->commits.nr);
>  	}
> -	write_graph_chunk_fanout(f, ctx);
> -	write_graph_chunk_oids(f, ctx);
> -	write_graph_chunk_data(f, ctx);
> -	if (ctx->num_extra_edges)
> -		write_graph_chunk_extra_edges(f, ctx);
> -	if (ctx->changed_paths) {
> -		write_graph_chunk_bloom_indexes(f, ctx);
> -		write_graph_chunk_bloom_data(f, ctx);
> -	}
> -	if (ctx->num_commit_graphs_after > 1 &&
> -	    write_graph_chunk_base(f, ctx)) {
> -		return -1;
> +
> +	for (i =3D 0; i < num_chunks; i++) {
> +		if (chunks[i].write_fn(f, ctx)) {
> +			error(_("failed writing chunk with id %"PRIx32""),
> +			      chunks[i].id);

This error message is new and not mentioned in the commit message.
write_graph_chunk_base() seems to be the only write function that can
return something else than 0, and it already reports an error in that
case.  So do we really want the one here as well?

Ren=C3=A9
