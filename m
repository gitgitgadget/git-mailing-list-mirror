Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959E1C433E3
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 07:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755AF20789
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 07:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MtRsMAKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbgFYHZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:25:20 -0400
Received: from mout.web.de ([212.227.17.11]:55557 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390110AbgFYHZT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 03:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593069915;
        bh=u8pD9+qnL28WGJaNhnfoqOuk840Fa5VK+gFBZ400Jf0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MtRsMAKrQD5gp3I+UE2iIo7+XGIbhVRDMv8JqmdUxugiEgBqWjJez9o8sFKI1EXgl
         AXusAkLAAEom9zO+YgMxFCY1EHJsRNxuFMoxwRgQglDcuLZrybtKDjpBQ7QmDcYdhk
         s4wOVEdIPA9/vi9yAUcZLklCHOzNzDy9vMfFaWbQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOAnY-1jiqTe3eR2-005YEU; Thu, 25
 Jun 2020 09:25:14 +0200
Subject: Re: [PATCH v2 06/11] commit-graph: simplify chunk writes into loop
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <8b959f2f374654aeb87b847560761890c2f9aa2c.1592934430.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <675f46df-c57c-bcd6-3f6a-fdd40b2f3066@web.de>
Date:   Thu, 25 Jun 2020 09:25:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8b959f2f374654aeb87b847560761890c2f9aa2c.1592934430.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:46KnYNrr6P0FgknURVl3sKHp+osizDs5iphP5tA8X6M7YjyV0kK
 HEpCv9nHAo/uOki/nSL8lQX1nCU2vpsaFc9/j1XyFzftjBSbUewUNz8uBxBRVSMuH3r9PzM
 fH24a5kNSUWbRis3aLp24JUT7fK8rF5AfKjNTBWrCrgThfi0NE/2Z5rg9Fih0Xp8Lo6dhgC
 j+hVBqrvjv+66tcYhQeVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PK7KNcyKD+8=:Mia/TpxKFPzOxTEu8+ny89
 x17Ln1cNTYMN78mxFEfl8w/9B3SGxuGzjqHrJrPcp4/ychceJxdBmtItMhy5QR1IktXfSzoCc
 LopjZarqvRVZJWvwnNmepbpF328JD95wFPhHBB88UaN+TL+LdeyVQS3KPqX54r7WmmVuDAIP/
 m7sP+ILRF+ntBHzITQYNqX0zQQXClLIq7t2JPamaJoYg7lbk0SP0O7Wwt8G4H7cCq4u2+8uw+
 0V/RFNlQW5DQktLWtLRFC5OsCG3iGoFBx4SO2tngavMJ0tvI7fq+1VuY7yRJdPs36wG3JrgwR
 7P03UFVohC054mLQYJt1fZdJGsMmHkuEggJdbmdPauDi1UpXU1JfVT//ldFjGPDMwoWsXgxyJ
 WUAZ0TlScMXsXLw9iTwNbdAltgIyRLp4hZ2tKD20Jm5oCuEqLOCPszNwuloyy/j0kBinKUShu
 1vmwdZTmvFuE5qRSEgb+JXieOA/oz1lv9muQOCFtM+f8h4TZymNPC5KUWFejmYMnDoxxVT+Ac
 blnpFS3kTMD1BmzTGQ3moC8ra6tVofpwuorSpBigCHdy+Cr1sdLckhJBJR42EZxZ0zo1ZEvBk
 HiOw2I4FPvP3qmnDWPLcyGWVpBJjeC2rOjzhgpjgF4ZvvD7fozzPkQwjIg1JPQa9JmKvGUz4Z
 BQNiAfdg+ZMOc2ysEfEqSkJMoUmU4v2iN92DVy/vMHwocJ6VuAhkIDpsE6bwF2ABd/AGG1TIb
 iMvsWkStgYcdigMH2UCjqJM/61O5lenZZoSm+W7DTOGIg0rFn6oA5q9yuTFu4hra8w6g1Vz5A
 RtrKjRCW4PY7buJurhg21z4ENi843T3nLXvOJ0gC0onbUX3qU1DQELWpNx1iu/15XadlgGNz1
 dLCeyByU3awvld9SGHnZg1eubBoYbwHekohHnhx4VbISVd2PgAD3PpPY8y5uoaw4msIdfeap0
 xF/8byPmFYKr8u2PttCLffXCzJ/R4s+/iEUDmQJq8+tbE0Koeq+DWeu9XCZJtUgbU0paFavJb
 V61gpVqLB6E/wqFOIW17MI8zXemarZmQy9jusoKOhlyCiJUdBgUHrSXnhrlD5PEXbtnQQuggy
 rGfWkxvejHepksdY4s6TwwSs0MrrcXwLRkzwEFrbWwSzXurvL+UXJrDsNUtYlbmLfnq9T3nlE
 JQZiGoLcgNeMYENeoDLgLQk4X9NHdPPC+gwlkgvDQiMal83QkaEzTGnLll11hOgo/Mybg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.20 um 19:47 schrieb SZEDER G=C3=A1bor via GitGitGadget:
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

You can do that without storing function pointers by selecting the
function to use based on the chunk ID -- like parse_commit_graph() does
on the read side.  Advantage: You don't need to press all write
functions into the same mold and can keep their individual signatures.

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index f33bfe49b3..086fc2d070 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1555,9 +1555,13 @@ static int write_graph_chunk_base(struct hashfile=
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
> @@ -1615,27 +1619,34 @@ static int write_commit_graph_file(struct write_=
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
> @@ -1671,19 +1682,15 @@ static int write_commit_graph_file(struct write_=
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

Of all the write functions only write_graph_chunk_base() can return
non-zero and it already prints an error message in that case ("failed to
write correct number of base graph ids").  Why add this one?

> +			return -1;
> +		}
>  	}
> +
>  	stop_progress(&ctx->progress);
>  	strbuf_release(&progress_title);
>
>
