Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D73403F6
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701452; cv=none; b=G+rmGdduFJPoYfnlhStJMfIQUd4fT1KcYaEAQhukSja8WwlyNAbO7ubt/M7M3ldu1FJ5xdC07T/UCSO/cGIp05Wj12g7Nb+T+3dwRYd3u37j+8rUlhILQvWQ6Lgb1hLNTF4SchGwuLq8HmIp7cGGiOF8nS9D3X9YBkJQToZsvqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701452; c=relaxed/simple;
	bh=gHs6K3s1J5TaNSzw+chIz+Dm1Da33Dj/U3rrbkSDGn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1KAImMdIv2UFUyoqkLt5JsPQrKtYrWfOrJqFS2p/6Ir35q9uNjkAH9OvDGYGNrsoENQP+LMD1l6qz4hLqvB7jA7c/RRa8/Fng5xEJDj2AM2CkyNVXp+sD7V0P5hI5IA7jGKJIerj53zqpHiL2jKHT8RY6KGf+WbRaNynKVyyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=i5mlgSDv; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="i5mlgSDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783701441; x=1784306241; i=l.s.r@web.de;
	bh=ta49hjTHaF6Xn1C5tcpeB9SUB7tSIGXKnTnj90I4VIo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i5mlgSDvkrW89gwgy04UXFwCqxTrH2AiNVo9ZCaVouEGpqkbjrDlnC5lKnPteH9V
	 xXHkyJCgBeJw+081linO1o7UlRcCIt2dhxe+EVb6cGPUXm51NL7+Sm159VTVbvopv
	 ADsd0POU9R2HImSVamkHVWl372G1/1Rl+lWyqfHiw5DymsuY+AviBEYz+RANzvazZ
	 h9iF5usBt13GYjqNDmEz5fIHuctjiPGkHk9qezX3OXZnssz1X+8SB2B3kj1vYJgyG
	 ziERBZW1doRNWPXhGQUkBxVccc0E6Am/Ru3DOvEq0zOZKfI6t6ucaAgF4Hya07dON
	 vxICLrl9uYh/bhdFYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXGOC-1wYwxT2jFu-00Xajs; Fri, 10
 Jul 2026 18:37:21 +0200
Message-ID: <10fad562-90b8-4feb-b7ab-d61015872127@web.de>
Date: Fri, 10 Jul 2026 18:37:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] prio-queue: use cascade for unfused gets
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
References: <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
 <pull.2132.v3.git.1783532989.gitgitgadget@gmail.com>
 <89a22c6a7532afa530f1c04ee27177e141dd360c.1783532989.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <89a22c6a7532afa530f1c04ee27177e141dd360c.1783532989.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fWrenzBDDQa8ctg2VJkpB3nBV+5NJzojQEuRaVjZMYE+DukYsMm
 1pfZ4hPTAE41iXuWbqm06Bxwul7eXwdPmdr65eJSp8twTXYXUwoP7B/TxPWC7/QL2kupO25
 tJSohYh7ggXxhyn7CWVklE3gF4mFIR/cwLb0wRj0p24aAkm8VeUfePx+/sMmguqKYF2fE2C
 QI+EVVjb/TWJ0wWDhmQvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xBNRhu+1DRI=;6SQjupvZL/80srZSgaYJl244ZRJ
 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

On 7/8/26 7:49 PM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
>=20
> When flush_get() removes the root without an immediate replacement,
> use a cascade-then-sift-up strategy instead of sift-down.
>=20
> Standard sift-down places the last element at the root and sifts it
> down.  This needs two comparisons per level (pick the smaller child,
> then compare against the element), even though the displaced element
> almost always ends up near the bottom where it came from.
>=20
> cascade_down() instead moves the vacancy down by promoting the
> smaller child at each level (one comparison per level), leaving the
> vacancy at a leaf.  The last element is then placed at the vacancy
> and sift_up() floats it to its correct position, which is typically
> very little work since it already belongs near the bottom.
>=20
> This is the well-known "bottom-up" variant of sift-down [1].
>=20
> [1] https://en.wikipedia.org/wiki/Heapsort#Bottom-up_heapsort

On an Apple M1 I get a 1% slowdown for bulk describe on Git's repo:

Benchmark 1: ./git_next describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     939.5 ms =C2=B1   3.6 ms    [User: 576.8 =
ms, System: 65.0 ms]
  Range (min =E2=80=A6 max):   935.0 ms =E2=80=A6 946.2 ms    10 runs

Benchmark 2: ./git describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     945.5 ms =C2=B1   3.3 ms    [User: 581.6 =
ms, System: 67.5 ms]
  Range (min =E2=80=A6 max):   940.1 ms =E2=80=A6 950.5 ms    10 runs

Summary
  ./git_next describe $(git rev-list v2.41.0..v2.47.0) ran
    1.01 =C2=B1 0.01 times faster than ./git describe $(git rev-list v2.41=
.0..v2.47.0)

... and on Linux's repo:

Benchmark 1: ./git_next -C ../linux describe $(git -C ../linux rev-list v4=
.0..v4.1)
  Time (mean =C2=B1 =CF=83):      4.880 s =C2=B1  0.014 s    [User: 3.914 =
s, System: 0.252 s]
  Range (min =E2=80=A6 max):    4.864 s =E2=80=A6  4.905 s    10 runs

Benchmark 2: ./git -C ../linux describe $(git -C ../linux rev-list v4.0..v=
4.1)
  Time (mean =C2=B1 =CF=83):      4.917 s =C2=B1  0.011 s    [User: 3.948 =
s, System: 0.254 s]
  Range (min =E2=80=A6 max):    4.902 s =E2=80=A6  4.938 s    10 runs

Summary
  ./git_next -C ../linux describe $(git -C ../linux rev-list v4.0..v4.1) r=
an
    1.01 =C2=B1 0.00 times faster than ./git -C ../linux describe $(git -C=
 ../linux rev-list v4.0..v4.1)

I see a 1% slowdown on an Apple M5 as well in both cases.  I can't
reproduce it on a Ryzen laptop, but that's too noisy to measure 1%
changes anyway.

Checked the total number of prio_queue comparisons with the crude patch
below, and as expected they go down, from 70386235 to 60682175 for Git
and from 473983445 to 439809087 for Linux.  So there's less work to do,
still user time goes up -- no idea why.

Also this -- what's up with the system time here:

Benchmark 1: ./git_next rev-list --all --count
  Time (mean =C2=B1 =CF=83):     115.2 ms =C2=B1   0.8 ms    [User: 95.6 m=
s, System: 17.7 ms]
  Range (min =E2=80=A6 max):   113.0 ms =E2=80=A6 117.1 ms    24 runs

Benchmark 2: ./git rev-list --all --count
  Time (mean =C2=B1 =CF=83):     116.5 ms =C2=B1   0.8 ms    [User: 95.4 m=
s, System: 19.0 ms]
  Range (min =E2=80=A6 max):   115.1 ms =E2=80=A6 118.6 ms    24 runs

Summary
  ./git_next rev-list --all --count ran
    1.01 =C2=B1 0.01 times faster than ./git rev-list --all --count

But:

Benchmark 1: ./git_next -C ../linux rev-list --all --count
  Time (mean =C2=B1 =CF=83):     937.6 ms =C2=B1   2.2 ms    [User: 887.2 =
ms, System: 45.5 ms]
  Range (min =E2=80=A6 max):   933.2 ms =E2=80=A6 939.9 ms    10 runs

Benchmark 2: ./git -C ../linux rev-list --all --count
  Time (mean =C2=B1 =CF=83):     937.3 ms =C2=B1   1.7 ms    [User: 887.8 =
ms, System: 45.0 ms]
  Range (min =E2=80=A6 max):   934.6 ms =E2=80=A6 940.3 ms    10 runs

Summary
  ./git -C ../linux rev-list --all --count ran
    1.00 =C2=B1 0.00 times faster than ./git_next -C ../linux rev-list --a=
ll --count

:-?

> Helped-by: Rene Scharfe <l.s.r@web.de>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  prio-queue.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/prio-queue.c b/prio-queue.c
> index 926fc04e85..230d6f5e33 100644
> --- a/prio-queue.c
> +++ b/prio-queue.c
> @@ -66,13 +66,31 @@ static void sift_down_root(struct prio_queue *queue)
>  	}
>  }
> =20
> +/* Cascade vacancy toward a leaf, promoting the smaller child at each l=
evel */
> +static size_t cascade_down(struct prio_queue *queue)
> +{
> +	size_t ix, child;
> +
> +	for (ix =3D 0; (child =3D ix * 2 + 1) < queue->nr_; ix =3D child) {
> +		if (child + 1 < queue->nr_ &&
> +		    compare(queue, child, child + 1) >=3D 0)
> +			child++;
> +		queue->array[ix] =3D queue->array[child];
> +	}
> +	return ix;
> +}
> +
>  static inline void flush_get(struct prio_queue *queue)
>  {
> +	size_t ix;
> +
>  	if (!queue->get_pending)
>  		return;
>  	queue->get_pending =3D 0;
> -	queue->array[0] =3D queue->array[--queue->nr_];
> -	sift_down_root(queue);
> +	--queue->nr_;
> +	ix =3D cascade_down(queue);
> +	queue->array[ix] =3D queue->array[queue->nr_];
> +	sift_up(queue, ix);
>  }
> =20
>  void prio_queue_put(struct prio_queue *queue, void *thing)

The patch looks fine, though.  It introduces struct assignments, but
they should be OK.  Tried replacing them with swap() instead (which
does a useless extra write), but that didn't change the performance
(still 1% slowdown).  Odd.

Ren=C3=A9


diff --git a/builtin/describe.c b/builtin/describe.c
index c0abc931a59..4a6ad976d30 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -791,5 +791,6 @@ int cmd_describe(int argc,
 		while (argc-- > 0)
 			describe(*argv++, argc =3D=3D 0);
 	}
+	print_compares();
 	return 0;
 }
diff --git a/prio-queue.c b/prio-queue.c
index 199775d5afd..b0189bf80e6 100644
=2D-- a/prio-queue.c
+++ b/prio-queue.c
@@ -1,6 +1,13 @@
 #include "git-compat-util.h"
 #include "prio-queue.h"
=20
+static uintmax_t compares;
+
+void print_compares(void)
+{
+	fprintf(stderr, "compares: %lu\n", compares);
+}
+
 static inline int compare(struct prio_queue *queue, size_t i, size_t j)
 {
 	int cmp =3D queue->compare(queue->array[i].data, queue->array[j].data,
@@ -8,6 +15,7 @@ static inline int compare(struct prio_queue *queue, size_=
t i, size_t j)
 	if (!cmp)
 		cmp =3D (queue->array[i].ctr > queue->array[j].ctr) -
 		      (queue->array[i].ctr < queue->array[j].ctr);
+	compares++;
 	return cmp;
 }
=20
diff --git a/prio-queue.h b/prio-queue.h
index 570b48e6485..e4cc0c4fb83 100644
=2D-- a/prio-queue.h
+++ b/prio-queue.h
@@ -68,4 +68,6 @@ void clear_prio_queue(struct prio_queue *);
 /* Reverse the LIFO elements */
 void prio_queue_reverse(struct prio_queue *);
=20
+void print_compares(void);
+
 #endif /* PRIO_QUEUE_H */

