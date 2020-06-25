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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5551EC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 07:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FBC20789
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 07:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jQFuhiLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbgFYHZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:25:15 -0400
Received: from mout.web.de ([212.227.17.12]:46595 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390110AbgFYHZO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 03:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593069910;
        bh=oeE56x9RsdgoS0rDGUvHPhuI94zf5fU/RS73xoB7Lhg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jQFuhiLpkhf3NXn6fWcbzkFwmYtWP3+SG0NAbFIou2bAXaQXNVvHOMgzhAbMa4/7Q
         iQL/PW9PZSZkTXxarK+OWTGDc59Lh7jhV5mrOqOmPGU+9fJZfECvYBRwZQvizC1yVE
         ef23EePlKaJgrYqclkl+mlINFwQSahNMK/X+L/qQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3Bdr-1ixMQb0RUN-00sy0i; Thu, 25
 Jun 2020 09:25:10 +0200
Subject: Re: [PATCH v2 05/11] commit-graph: unify the signatures of all
 write_graph_chunk_*() functions
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <244668fec4428872f441d515e570e923808f0db1.1592934430.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <562263d0-9376-bf90-254c-880e611ffd2b@web.de>
Date:   Thu, 25 Jun 2020 09:25:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <244668fec4428872f441d515e570e923808f0db1.1592934430.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:12g85mrFoZd+PxK1/05R7N2ma9F8u4uzq3mdn3R2ooIHVrxGpXN
 FLBtmNtDyrDY9jD6AvP9VFR+5DY5ivV3ceKmvrYeCXZ69dtidRwmFlqqsD3+cZhTBZiyaPn
 eGgI0mGZ7VSZfPtmif5UFdaaOaTKIv+cI1oZh4X0VCSLbqE+xcKWokxZ2ICr4UV0tWy2nrp
 EI9QONmfD7IYxsWn/1zkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0QMl3c9NyHA=:Dl+MNe7/TS4THhJ636LML8
 FWCvDq+ZL8wwxRalWp1ekGKjce9vyveUZttrfw+i7gaJXtV2vz8I33+TMXidfFQ9gtfi6NPXc
 XX+WnGbFnPytQoNYgtK0y/nWs802qyzGsQef9ucq+CAwrs1poEiXiBSMC2tMrEnJUZ+cqgYSD
 aczCSlFj1E0zsbOYTXMoLCv5BK3IKL3QsdUJnsSUZnQQX98+jFMSaAAdwuVJGqYyrzwmsy0XG
 gejHxxIQn19/7ekLqMz/VHJpDf8Yb9AOy5lIBH4J4/wBXpqdD0/G7jnLnz3lqoZv/sE7Ngz4j
 xLzfFBMQcM5RUYOxP4PXwuC7S9PI3FMfSOkP/dMj51ClKC1XpHqtlN2wO/3ZWits6ArAPfEmY
 jcq9egC2nX4mZ1NwchSP3ZRJM+NH+Mz445mx6nw8GGhQh9NOVTdkeguw1bk/FPbutvMciH1Pz
 eBcXmyGfYkSCLhzmRRZi1tXAvrdXshK+PDudPPjlpUNGimo4hKryA4irSeMFVLvUoZ7W38IA+
 W0CjrV2VeeOw1XMrVPHY0es7H1e18ea1C0YL4u54iqmrzitsEEKGLdyO89J4I0din8kIc1jTA
 W4IdptZRhjQPMJwEBwmaJVGOfBJdzKBhC5nrPDMXon3l1beC5fJHdheorpO6fN9psVaZtkMU7
 updkbT9BdZNsGq1gPqkkJuNsl1KUzAomfljQhn68oqGrhD2u42dRpSFBalN5RGa+fuSXv32hw
 MC6Lvm+gXUBpj0HvRE8SSKHLjM9nG81m7jAXcWHDAZsoMN2+ROptsUCyarYQHyOrHveHVTMdl
 90DKltAFPqzsf0qwhoRIC657uJtGuQoj/IujLfNzC/ftXvwPemYLcH1WWH/V+P0dQN14Yg+Ph
 O75ulNv6PP6RBMNp8IKCX8Aab4Std1J5KX6r7ckK/rMiwwZB1T73FyYk0GlRHn571pg5HztnT
 oJs8HnX5qLLhdRrLQzcjOpO7GJvsWX3VlFPHtCWeka4i4+++oF9JuMTnHP7cBfqPkwbx/EOCU
 izuufISwHytxF6fLcmFgtkVkcpBLCYA3dOg1qGBtpKaMEAxMqV2nNICwrc7VPdsu7W+cJdLzn
 eLellJUYguEd0Vf7fTfYGxe91gO0320S7C3mfwpTX7GYvUXt4g+rhJAZYezalGYXUd2d/EDJO
 4SEpPwk7TJrjuZtl4G8SGU4Q2YEoheK3A86O4f7rlVgMDUhrhi47a0+oKbixOUTCKsYKw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.20 um 19:47 schrieb SZEDER G=C3=A1bor via GitGitGadget:
> From: =3D?UTF-8?q?SZEDER=3D20G=3DC3=3DA1bor?=3D <szeder.dev@gmail.com>
>
> Update the write_graph_chunk_*() helper functions to have the same
> signature:
>
>   - Return an int error code from all these functions.
>     write_graph_chunk_base() already has an int error code, now the
>     others will have one, too, but since they don't indicate any
>     error, they will always return 0.
>
>   - Drop the hash size parameter of write_graph_chunk_oids() and
>     write_graph_chunk_data(); its value can be read directly from
>     'the_hash_algo' inside these functions as well.
>
> This opens up the possibility for further cleanups and foolproofing in
> the following two patches.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 42 ++++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 908f094271..f33bfe49b3 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -891,8 +891,8 @@ struct write_commit_graph_context {
>  	const struct bloom_filter_settings *bloom_settings;
>  };
>
> -static void write_graph_chunk_fanout(struct hashfile *f,
> -				     struct write_commit_graph_context *ctx)
> +static int write_graph_chunk_fanout(struct hashfile *f,
> +				    struct write_commit_graph_context *ctx)
>  {
>  	int i, count =3D 0;
>  	struct commit **list =3D ctx->commits.list;
> @@ -913,17 +913,21 @@ static void write_graph_chunk_fanout(struct hashfi=
le *f,
>
>  		hashwrite_be32(f, count);
>  	}
> +
> +	return 0;
>  }
>
> -static void write_graph_chunk_oids(struct hashfile *f, int hash_len,
> -				   struct write_commit_graph_context *ctx)
> +static int write_graph_chunk_oids(struct hashfile *f,
> +				  struct write_commit_graph_context *ctx)
>  {
>  	struct commit **list =3D ctx->commits.list;
>  	int count;
>  	for (count =3D 0; count < ctx->commits.nr; count++, list++) {
>  		display_progress(ctx->progress, ++ctx->progress_cnt);
> -		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
> +		hashwrite(f, (*list)->object.oid.hash, (int)the_hash_algo->rawsz);
                                                       ^^^^^
This cast is confusing...

>  	}
> +
> +	return 0;
>  }
>
>  static const unsigned char *commit_to_sha1(size_t index, void *table)
> @@ -932,8 +936,8 @@ static const unsigned char *commit_to_sha1(size_t in=
dex, void *table)
>  	return commits[index]->object.oid.hash;
>  }
>
> -static void write_graph_chunk_data(struct hashfile *f, int hash_len,
> -				   struct write_commit_graph_context *ctx)
> +static int write_graph_chunk_data(struct hashfile *f,
> +				  struct write_commit_graph_context *ctx)
>  {
>  	struct commit **list =3D ctx->commits.list;
>  	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
> @@ -950,7 +954,7 @@ static void write_graph_chunk_data(struct hashfile *=
f, int hash_len,
>  			die(_("unable to parse commit %s"),
>  				oid_to_hex(&(*list)->object.oid));
>  		tree =3D get_commit_tree_oid(*list);
> -		hashwrite(f, tree->hash, hash_len);
> +		hashwrite(f, tree->hash, the_hash_algo->rawsz);

... and obviously not needed, as this example shows.

>
>  		parent =3D (*list)->parents;
>
> @@ -1030,10 +1034,12 @@ static void write_graph_chunk_data(struct hashfi=
le *f, int hash_len,
>
>  		list++;
>  	}
> +
> +	return 0;
>  }
>
> -static void write_graph_chunk_extra_edges(struct hashfile *f,
> -					  struct write_commit_graph_context *ctx)
> +static int write_graph_chunk_extra_edges(struct hashfile *f,
> +					 struct write_commit_graph_context *ctx)
>  {
>  	struct commit **list =3D ctx->commits.list;
>  	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
> @@ -1082,10 +1088,12 @@ static void write_graph_chunk_extra_edges(struct=
 hashfile *f,
>
>  		list++;
>  	}
> +
> +	return 0;
>  }
>
> -static void write_graph_chunk_bloom_indexes(struct hashfile *f,
> -					    struct write_commit_graph_context *ctx)
> +static int write_graph_chunk_bloom_indexes(struct hashfile *f,
> +					   struct write_commit_graph_context *ctx)
>  {
>  	struct commit **list =3D ctx->commits.list;
>  	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
> @@ -1107,6 +1115,7 @@ static void write_graph_chunk_bloom_indexes(struct=
 hashfile *f,
>  	}
>
>  	stop_progress(&progress);
> +	return 0;
>  }
>
>  static void trace2_bloom_filter_settings(struct write_commit_graph_cont=
ext *ctx)
> @@ -1124,8 +1133,8 @@ static void trace2_bloom_filter_settings(struct wr=
ite_commit_graph_context *ctx)
>  	jw_release(&jw);
>  }
>
> -static void write_graph_chunk_bloom_data(struct hashfile *f,
> -					 struct write_commit_graph_context *ctx)
> +static int write_graph_chunk_bloom_data(struct hashfile *f,
> +					struct write_commit_graph_context *ctx)
>  {
>  	struct commit **list =3D ctx->commits.list;
>  	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
> @@ -1151,6 +1160,7 @@ static void write_graph_chunk_bloom_data(struct ha=
shfile *f,
>  	}
>
>  	stop_progress(&progress);
> +	return 0;
>  }
>
>  static int oid_compare(const void *_a, const void *_b)
> @@ -1662,8 +1672,8 @@ static int write_commit_graph_file(struct write_co=
mmit_graph_context *ctx)
>  			num_chunks * ctx->commits.nr);
>  	}
>  	write_graph_chunk_fanout(f, ctx);
> -	write_graph_chunk_oids(f, hashsz, ctx);
> -	write_graph_chunk_data(f, hashsz, ctx);
> +	write_graph_chunk_oids(f, ctx);
> +	write_graph_chunk_data(f, ctx);
>  	if (ctx->num_extra_edges)
>  		write_graph_chunk_extra_edges(f, ctx);
>  	if (ctx->changed_paths) {
>
