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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D593CC433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB64207DD
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dJpcSl6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbgFRUas (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:30:48 -0400
Received: from mout.web.de ([217.72.192.78]:37325 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgFRUar (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 16:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592512241;
        bh=8DMFruPiiG9P/gn545uhf8ZpKWW7khqM2k4NVHPyIO8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dJpcSl6MNiKWFMC6brj+93mxcsUMHlae0GVIgH9FZzYmfGnFnsXWGRNts+QDichYy
         7kDT9spL8R/AAuewOUfHtpxWx3Rsbn3HqT88eWQDIX32XJ0SEHbaGWCcV65UfoFxAM
         WqMxZ4XuQ5anlxNUiOkHkvvVM+5psSLJeHXfbdfg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MfHsM-1jW0Sp29gQ-00Oqdh; Thu, 18
 Jun 2020 22:30:41 +0200
Subject: Re: [PATCH 1/8] commit-graph: place bloom_settings in context
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <c966969071bf0ba135d304bbc0d5c16fbcbedc1e.1592252093.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4a7fbd99-c581-fb30-90b3-e78c30708ff2@web.de>
Date:   Thu, 18 Jun 2020 22:30:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c966969071bf0ba135d304bbc0d5c16fbcbedc1e.1592252093.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mudcu7y5Zwp13Jc3zg1z+PA454L2CImjEjSLhpPseF2gnwggNXa
 0b4teXwkxqfxqLhC8jC9/ehQYkFGaNB6AG4ZHIhB6bHT/fyDXDk+/9WIZZiTxv0NKkvFeUs
 x2pUHvmAWqJqt3zSScudbtQ2kng6hpOUcaVh4rozGNiFDyZOB8z8FB4MEEzDqTWL29YBqhn
 IeThpdl8A6lcG5+5s1QSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zxudb9PG6hA=:yiR90x27HDVwfhkMy2YGAW
 zuq/0hrfdwR7hVc44yQXoOGBKD474nbgtBbPH2wEXcib4wvqGfRuAGmEu1GZzjJn2RPcuQjTp
 u19wRJad71FfipcKl7+854hSAOZTTVdad6pCH0uIDXJe1WmNBW/aqCZfhUgOULkpgMqcdjBZe
 4AEoZCQY4mMke+2iYrFcccrI18l+RM3XHFXRG1u3RRYapyH30YMLJwU+j7rz6sTweLrUQ7y9Z
 Kwj8j9qk4raTcGEDIANyHFH4wDXm+U76hnS1B08Wa+3+bIlShyX/szbkG0GW5PBROtSiMrl/e
 LdL2UizYQvVCpWZkeewwl7kpUjbkcga+gTruHerrdiW64hXyGwoI9ZxeLFpR3k2n4Jn6DcFXc
 EGYSVfKBZh9xMhYATQr3BsuUwX9YWXJPTIQQB7AgzUekbFNvC3yiw2Nk47utAJMFwIcn4opZ3
 QCVvyMIPWeWJj/5/KUzvslf0E/VKgCnHzslnYF7bHR6ao4q/Ldh8L7OWZ3gP+PmSCbMLs+hhG
 hg6oSvovHi69zgymAHK5gP1V/pbaHXikn9XkbmVFrd9MmlO2jPbtx1Lj6KLYnoUkpWkTaG3QG
 QnrhofN2w/6BaFTTV2hl2z8i034hYlhKWmyyOHlW6DkAWniVM+DE4Fnj1bDLR4AwOnBNBIJ9C
 6eyAqfwhxkPzyLzs9ChV0QjSQAZ7Il/ioRaQdjIps4rQb154DVLOSTDdk/HmBCp/70UhDRJxZ
 nqmkt2Jy28WEP68itwDJ42p4xbwiaRC3xC5oxnn8OJdSUM8HRZ/56ZL9NF0gL0EScwFXfPDAG
 2fQ+0sATYJVKBiD4lmnkn/xbaRAsKHHKF+vRkjNpth8odLKfpgVIjKigqVsZElnJfdPL2xk+j
 oEhH1ll+MIVa7IelV3IPwhJRPkssTw4/P0fncSvd0d1cnOhN2YV7kN16mhqXy9jzse5u0bKJy
 DpNaycKwXIb0HGWdyksRNeY65Rt5LuJZqH7enGrpqF7kfEwyKS+z8s7X/MVPJl2gQWcV/p2JM
 fb+x14Aj1/mYFby432py1n5NK7Pep784X2WjM58tMRjO5xLK4D/TCjuRo6r3RKajKV1v9mVQk
 UEkSrr6S4X+4P1rEXnUJFb+3IWzanTpXMag68sl54DMf1AMs5vqWIKhwZngywrU1L877ofVfB
 tdDhtqPqX3dRuULxsjgctfwIqZUTPItb5dVcYWOLw4cynLXs9KZI2HfWxjyqsvVgk+uUc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.20 um 22:14 schrieb Derrick Stolee via GitGitGadget:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Place an instance of struct bloom_settings into the struct
> write_commit_graph_context. This allows simplifying the function
> prototype of write_graph_chunk_bloom_data(). This will allow us
> to combine the function prototypes and use function pointers to
> simplify write_commit_graph_file().
>
> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 887837e8826..05b7035d8d5 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -882,6 +882,7 @@ struct write_commit_graph_context {
>
>  	const struct split_commit_graph_opts *split_opts;
>  	size_t total_bloom_filter_data_size;
> +	struct bloom_filter_settings bloom_settings;

That structure is quite busy already, so adding one more member wouldn't
matter much.

Passing so many things to lots of functions makes it harder to argue
about them, though, as all of them effectively become part of their
signature, and you have to look at their implementation to see which
pseudo-parameters they actually use.  It's like a God object.

>  };
>
>  static void write_graph_chunk_fanout(struct hashfile *f,
> @@ -1103,8 +1104,7 @@ static void write_graph_chunk_bloom_indexes(struct=
 hashfile *f,
>  }
>
>  static void write_graph_chunk_bloom_data(struct hashfile *f,
> -					 struct write_commit_graph_context *ctx,
> -					 const struct bloom_filter_settings *settings)
> +					 struct write_commit_graph_context *ctx)
>  {
>  	struct commit **list =3D ctx->commits.list;
>  	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
> @@ -1116,9 +1116,9 @@ static void write_graph_chunk_bloom_data(struct ha=
shfile *f,
>  			_("Writing changed paths Bloom filters data"),
>  			ctx->commits.nr);
>
> -	hashwrite_be32(f, settings->hash_version);
> -	hashwrite_be32(f, settings->num_hashes);
> -	hashwrite_be32(f, settings->bits_per_entry);
> +	hashwrite_be32(f, ctx->bloom_settings.hash_version);
> +	hashwrite_be32(f, ctx->bloom_settings.num_hashes);
> +	hashwrite_be32(f, ctx->bloom_settings.bits_per_entry);
>
>  	while (list < last) {
>  		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list, 0);
> @@ -1541,6 +1541,8 @@ static int write_commit_graph_file(struct write_co=
mmit_graph_context *ctx)
>  	struct object_id file_hash;
>  	const struct bloom_filter_settings bloom_settings =3D DEFAULT_BLOOM_FI=
LTER_SETTINGS;
>
> +	ctx->bloom_settings =3D bloom_settings;

So we use the defaults, no customization?  Then you could simply move
the declaration of bloom_settings from write_commit_graph_file() to
write_graph_chunk_bloom_data().  Glancing at pu I don't see additional
uses there, so no need to put it into the context (yet?).

Ren=C3=A9
