Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B73ED5AD
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850189; cv=none; b=pjzmiIRLz5doSCf0CCPWNJdNb+/OyQX310QmHqKTGWMtGssN3T7oWXVKaDT2s3fy5s/qoOq8xAMKNan1Jo5m6L3PzEpzrL+rP6NtPhpVmzJRVeBDxxcgxMh+zTOEvnHHadvZQ6oVEd4y2T3bfehy90+tfp7tksGUiWMgNxgCrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850189; c=relaxed/simple;
	bh=Zdpuu2Pz30l06ebQ21Ra0PR78u+wfFhacObbMHZvPo4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VrBj8mueC52hwZ/L1k2KrGv+HjD/0rLixtVlaH23E+tUC7mzdpVuDr1NAR0/WPZH91T8880IMG0oPjn0nbSK2E5BUjMGBXaKpn5ZNmyuky4ncueg0gbnmnFUiSRZ/lM4IFpiNJLsnRAxqKf72IkN6wn6Fuq9EBijEp1PWMfZrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=PkxIZGwf; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="PkxIZGwf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773850177; x=1774454977; i=l.s.r@web.de;
	bh=rYDb9/2XWFDz6p/5Xt3Q5sQz+jxGiJCVLQgU/V0+uyA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PkxIZGwfD3CY+YWcOpt2ounoAypLrNW2RSLoL8Rng+7lEed51sC7moIFIBykcXs1
	 /DJYWT9ClXmVF/PhFE5EUFv88AH53qNXa0ft0DxoqHkDZxEAMaDmgyxSFJTFOa2V/
	 0265X+uBEdUU+6/ofCp1V9tbuqpv5l+Yrn94sqdsEX7B4tB4XGScWGX/8zda4cQg4
	 R91ADSGxpQsmdqlvGjwcRc5rl690BtEENveSJvVbDl8LUUdFIMU4SEJFvZwwYh6+l
	 IlkhdXC1jYelHHM24RMhKeSAh5knEsG4I1vlVCadz3vZZiFxyu6BeYg9H3gh9/o5Y
	 wrzJkzW6998mz12gLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mty5u-1vjyZR2Ptc-00zNEL; Wed, 18
 Mar 2026 17:09:37 +0100
Message-ID: <c01eb1e3-d839-4cf6-ba47-5a9edd336ae3@web.de>
Date: Wed, 18 Mar 2026 17:09:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit-reach: simplify cleanup of remaining bitmaps in
 ahead_behind()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
References: <06000e28-c1b1-472f-bd6b-367b6c8d208d@web.de>
Content-Language: en-US
In-Reply-To: <06000e28-c1b1-472f-bd6b-367b6c8d208d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H67yHmjdnZovL9iVxYXX7Y4BodIGsOPqBT8DtGGTyADwhHcwd6n
 ktzxEsZLDn/p8BjkxGqkhDU97w9iQfEyJ7+JnX897e6d7XjUZyzaUAAq1yHcigcXwfvV80x
 kq++Z3sg8CZ6KGJSuXljmfzGMvu+yy/9H0PqzpFv+IMAA1JgZqrv8wkDx58D1nmTaZvC4mh
 ERIuk0XTCarOzjtPkWfGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BkSry9VmsA4=;BJD/Hj6Q/LxhfDPe5m34wm0daKL
 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
 EOJc23t87+fzH8yozURttA0il1CHKsf5g==

On 3/18/26 1:45 PM, Ren=C3=83=C2=A9 Scharfe wrote:
> Use the deep clear function of the bit_arrays commit slab to free
> bitmaps of commits we didn't traverse.  We don't care about their order
> anymore at this point, so we can bypass the prio_queue and its heap
> rebalancing logic.  Note that bitmap_free() handles NULL pointers, so we
> don't have to check.

That's nice and all, but it's also slower:

Benchmark 1: ./git_main for-each-ref --format=3D'%(objectname) %(ahead-beh=
ind:main)'
  Time (mean =C2=B1 =CF=83):      1.228 s =C2=B1  0.001 s    [User: 1.188 =
s, System: 0.039 s]
  Range (min =E2=80=A6 max):    1.226 s =E2=80=A6  1.231 s    10 runs

Benchmark 2: ./git_deep_clear for-each-ref --format=3D'%(objectname) %(ahe=
ad-behind:main)'
  Time (mean =C2=B1 =CF=83):      1.354 s =C2=B1  0.002 s    [User: 1.313 =
s, System: 0.039 s]
  Range (min =E2=80=A6 max):    1.351 s =E2=80=A6  1.356 s    10 runs

Summary
  ./git_main for-each-ref --format=3D'%(objectname) %(ahead-behind:main)' =
ran
    1.10 =C2=B1 0.00 times faster than ./git_deep_clear for-each-ref --for=
mat=3D'%(objectname) %(ahead-behind:main)'

Please don't apply this patch -- I should have measured first.

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  commit-reach.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/commit-reach.c b/commit-reach.c
> index 9604bbdcce..a4fc41ff40 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -1047,6 +1047,11 @@ static void free_bit_array(struct commit *c)
>  	*bitmap =3D NULL;
>  }
> =20
> +static void free_bitmap_pointer(struct bitmap **bitmap)
> +{
> +	bitmap_free(*bitmap);
> +}
> +
>  void ahead_behind(struct repository *r,
>  		  struct commit **commits, size_t commits_nr,
>  		  struct ahead_behind_count *counts, size_t counts_nr)
> @@ -1117,11 +1122,7 @@ void ahead_behind(struct repository *r,
> =20
>  	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
>  	repo_clear_commit_marks(r, PARENT2 | STALE);
> -	while (prio_queue_peek(&queue)) {
> -		struct commit *c =3D prio_queue_get(&queue);
> -		free_bit_array(c);
> -	}
> -	clear_bit_arrays(&bit_arrays);
> +	deep_clear_bit_arrays(&bit_arrays, free_bitmap_pointer);

The prio_queue contains just a few unvisited entries at this point (or
perhaps even none), while deep_clear_*() will visit all commits that
ever had a bitmap, even if their bitmap pointer is NULL now.

We could still access them in array order, which must be cheaper:

	for (size_t i =3D 0; i < queue.nr; i++)
		free_bit_array(queue.array[i].data);

Performance is the same for my local Git repo clone, though.

>  	clear_prio_queue(&queue);
>  }
> =20

