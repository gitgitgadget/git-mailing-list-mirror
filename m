Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7354B1AAB1
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708913141; cv=none; b=tWFCu8NyHxO4qZ3SVa7adDy73QblPycmmmQMzryq1v8i+NGrWHnaNa7JCru0kUljLYsa7RpkFc4WPHPUIeOZYu3P1GgXuwrsUcGjvR8Ca9th+wOPtmxZjPUo93lBJRJIP98/r/+TVo4lx1XOHPWYt9vI5N2QJTN7iYHaxiXVbq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708913141; c=relaxed/simple;
	bh=hIB6FYAAhG4A21aSt9nMrjR7h8kcMvfRwRQpcmBXgbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ghgytlltrbk/POsMw0giAp4HmkjZJxHBGtSNiP/kG4AcZiEAA2owr9elq5vEPhqQ63ZAO4pc+S4+LSg5HIPFGeNTEJXz1ZKVtVda0N6/KBz+HwzyO7/spJ5zLryBBqsXUqby5dAt2hLqN3GSYszgYUW6jcel+l/7Sqj1vlHfZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QVt+67n/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QVt+67n/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 65AE73583E;
	Sun, 25 Feb 2024 21:05:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hIB6FYAAhG4A
	21aSt9nMrjR7h8kcMvfRwRQpcmBXgbs=; b=QVt+67n/h2Y7QxedqSjORVyakaJE
	rbKFnR2L3usePVa2B/rhkX2mH9pTxQcTCB+fXyil/8/IcEqsvhzfpd91n2TBBfwK
	EYPyZpsAsNAMcpcTfVz5TNpBdDXTe28WXoalzkLFoFSqejaQQWXP1O+CJE5iFDeI
	3CRY9Dl7Jx25aXA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F61B3583C;
	Sun, 25 Feb 2024 21:05:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE18A35839;
	Sun, 25 Feb 2024 21:05:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] name-rev: use mem_pool_strfmt()
In-Reply-To: <20240225113947.89357-3-l.s.r@web.de> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message
	of "Sun, 25 Feb 2024 12:39:45 +0100")
References: <20240225113947.89357-1-l.s.r@web.de>
	<20240225113947.89357-3-l.s.r@web.de>
Date: Sun, 25 Feb 2024 18:05:28 -0800
Message-ID: <xmqqfrxghtef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 841E0124-D44B-11EE-83D8-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> 1c56fc2084 (name-rev: pre-size buffer in get_parent_name(), 2020-02-04)
> got a big performance boost in an unusual repository by calculating the
> name length in advance.  This is a bit awkward, as it references the
> name components twice.
>
> Use a memory pool to store the strings for the struct rev_name member
> tip_name.  Using mem_pool_strfmt() allows efficient allocation without
> explicit size calculation.  This simplifies the formatting part of the
> code without giving up performance:
>
> Benchmark 1: ./git_2.44.0 -C ../chromium/src name-rev --all
>   Time (mean =C2=B1 =CF=83):      1.231 s =C2=B1  0.013 s    [User: 1.0=
82 s, System: 0.136 s]
>   Range (min =E2=80=A6 max):    1.214 s =E2=80=A6  1.252 s    10 runs
>
> Benchmark 2: ./git -C ../chromium/src name-rev --all
>   Time (mean =C2=B1 =CF=83):      1.220 s =C2=B1  0.020 s    [User: 1.0=
83 s, System: 0.130 s]
>   Range (min =E2=80=A6 max):    1.197 s =E2=80=A6  1.254 s    10 runs
>
> Don't bother discarding the memory pool just before exiting.  The effor=
t
> for that would be very low, but actually measurable in the above
> example, with no benefit to users.  At least UNLEAK it to calm down lea=
k
> checkers.  This addresses the leaks that 45a14f578e (Revert "name-rev:
> release unused name strings", 2022-04-22) brought back.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> This doesn't make any test script leak-free, though.

Hmph, is the root cause of the leak because no sensible ownership
rules are applied to .tip_name?  Sometimes it is allocated for the
paritcular rev_name, but some other times the pointer is copied from
another rev_name.tip_name?  As the way currently the code uses the
.tip_name member seems to be "allocate and use without any freeing",
I tend to agree that throwing them into mem-pool does make sense.

>  builtin/name-rev.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 2dd1807c4e..ad9930c831 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -15,6 +15,7 @@
>  #include "commit-slab.h"
>  #include "commit-graph.h"
>  #include "wildmatch.h"
> +#include "mem-pool.h"
>
>  /*
>   * One day.  See the 'name a rev shortly after epoch' test in t6120 wh=
en
> @@ -155,30 +156,25 @@ static struct rev_name *create_or_update_name(str=
uct commit *commit,
>  	return name;
>  }
>
> -static char *get_parent_name(const struct rev_name *name, int parent_n=
umber)
> +static char *get_parent_name(const struct rev_name *name, int parent_n=
umber,
> +			     struct mem_pool *string_pool)
>  {
> -	struct strbuf sb =3D STRBUF_INIT;
>  	size_t len;
>
>  	strip_suffix(name->tip_name, "^0", &len);
>  	if (name->generation > 0) {
> -		strbuf_grow(&sb, len +
> -			    1 + decimal_width(name->generation) +
> -			    1 + decimal_width(parent_number));
> -		strbuf_addf(&sb, "%.*s~%d^%d", (int)len, name->tip_name,
> -			    name->generation, parent_number);
> +		return mem_pool_strfmt(string_pool, "%.*s~%d^%d",
> +				       (int)len, name->tip_name,
> +				       name->generation, parent_number);
>  	} else {
> -		strbuf_grow(&sb, len +
> -			    1 + decimal_width(parent_number));
> -		strbuf_addf(&sb, "%.*s^%d", (int)len, name->tip_name,
> -			    parent_number);
> +		return mem_pool_strfmt(string_pool, "%.*s^%d",
> +				       (int)len, name->tip_name, parent_number);
>  	}
> -	return strbuf_detach(&sb, NULL);
>  }
>
>  static void name_rev(struct commit *start_commit,
>  		const char *tip_name, timestamp_t taggerdate,
> -		int from_tag, int deref)
> +		int from_tag, int deref, struct mem_pool *string_pool)
>  {
>  	struct prio_queue queue;
>  	struct commit *commit;
> @@ -195,9 +191,10 @@ static void name_rev(struct commit *start_commit,
>  	if (!start_name)
>  		return;
>  	if (deref)
> -		start_name->tip_name =3D xstrfmt("%s^0", tip_name);
> +		start_name->tip_name =3D mem_pool_strfmt(string_pool, "%s^0",
> +						       tip_name);
>  	else
> -		start_name->tip_name =3D xstrdup(tip_name);
> +		start_name->tip_name =3D mem_pool_strdup(string_pool, tip_name);
>
>  	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO */
>  	prio_queue_put(&queue, start_commit);
> @@ -235,7 +232,8 @@ static void name_rev(struct commit *start_commit,
>  				if (parent_number > 1)
>  					parent_name->tip_name =3D
>  						get_parent_name(name,
> -								parent_number);
> +								parent_number,
> +								string_pool);
>  				else
>  					parent_name->tip_name =3D name->tip_name;
>  				ALLOC_GROW(parents_to_queue,
> @@ -415,7 +413,7 @@ static int name_ref(const char *path, const struct =
object_id *oid,
>  	return 0;
>  }
>
> -static void name_tips(void)
> +static void name_tips(struct mem_pool *string_pool)
>  {
>  	int i;
>
> @@ -428,7 +426,7 @@ static void name_tips(void)
>  		struct tip_table_entry *e =3D &tip_table.table[i];
>  		if (e->commit) {
>  			name_rev(e->commit, e->refname, e->taggerdate,
> -				 e->from_tag, e->deref);
> +				 e->from_tag, e->deref, string_pool);
>  		}
>  	}
>  }
> @@ -561,6 +559,7 @@ static void name_rev_line(char *p, struct name_ref_=
data *data)
>
>  int cmd_name_rev(int argc, const char **argv, const char *prefix)
>  {
> +	struct mem_pool string_pool;
>  	struct object_array revs =3D OBJECT_ARRAY_INIT;
>  	int all =3D 0, annotate_stdin =3D 0, transform_stdin =3D 0, allow_und=
efined =3D 1, always =3D 0, peel_tag =3D 0;
>  	struct name_ref_data data =3D { 0, 0, STRING_LIST_INIT_NODUP, STRING_=
LIST_INIT_NODUP };
> @@ -587,6 +586,7 @@ int cmd_name_rev(int argc, const char **argv, const=
 char *prefix)
>  		OPT_END(),
>  	};
>
> +	mem_pool_init(&string_pool, 0);
>  	init_commit_rev_name(&rev_names);
>  	git_config(git_default_config, NULL);
>  	argc =3D parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
> @@ -648,7 +648,7 @@ int cmd_name_rev(int argc, const char **argv, const=
 char *prefix)
>  	adjust_cutoff_timestamp_for_slop();
>
>  	for_each_ref(name_ref, &data);
> -	name_tips();
> +	name_tips(&string_pool);
>
>  	if (annotate_stdin) {
>  		struct strbuf sb =3D STRBUF_INIT;
> @@ -676,6 +676,7 @@ int cmd_name_rev(int argc, const char **argv, const=
 char *prefix)
>  				  always, allow_undefined, data.name_only);
>  	}
>
> +	UNLEAK(string_pool);
>  	UNLEAK(revs);
>  	return 0;
>  }
> --
> 2.44.0
