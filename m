Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C0537F5
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284662; cv=none; b=ZRQHJJSYIUs2zzQjDzg2a3ffvnGI6a1AqJwwlLT+FcKTJk5hHqjgAJsxHuEhUduXMhztYWAhG6M1lJMJ3SqawgyBkcrK2LGzwIT/F7UgUDkkK60T8SFvEzMcjALiYYGNosFFpFqy6e0/mbvubjC6plAoccDt8L+gQBp0kE8n+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284662; c=relaxed/simple;
	bh=EUKX2DDVWdbPNAzUHoV8ahy3Uln0ZZ6lJzbMUOSuFdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbXUCHuSMlcIl3dLI6hRP7XNmvTwpRydnUkk+3pZB2PmwY4b/wQSTVh5+eQ19Xeq6OMErOPfDWoKPr5tar+ztpYqFPkq3eX7kMCYqjYo++zSMQQHc/0ysPp58qXym6KMXcEF8oHb5fj9qNxoelk2o5i6JdE/jR6PBRVRex0p4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=wiEgrgq1; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="wiEgrgq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727284645; x=1727889445; i=l.s.r@web.de;
	bh=QaMUZAM6FL84aI3dwF797nJoG1rLdGl6JWoFF7vj3RA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wiEgrgq1blKelJuXKb+wuVVmUzyUAhXrjxDSdEzFunZqMhgJiTbjTKxITtJpKOb1
	 ryg+tbcvfJGWfinkZVQIVGz47WA8vBx9jt17yMUT2n29Ph5eqBlHrGuLTGNY3Rf/q
	 vTqAklQsgkbOcBVMexqoS+nKsIl/6c9nbSmC4A+zGr/RfeToTM9OSvmlWcWmShFAZ
	 10MXNGS+VVdj7gP8UnR01Ox7QRdfnLYfm5QfE07cSkeS8GVepKeKos9SbjrAX2yOK
	 jauIntkYzxMfDCjNIpV7jcXN7O6N9RlkkrtkaIOewEyhUTb+s7gFoxeGbotnBhOST
	 P5SdOt6uF/e4q2aanw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.135]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBSB9-1smfsJ41ol-00BMgd; Wed, 25
 Sep 2024 19:17:25 +0200
Message-ID: <5914d021-722c-4188-806c-1633bba3d3ab@web.de>
Date: Wed, 25 Sep 2024 19:17:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/28] fetch-pack: fix leaking sought refs
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924215103.GC1143820@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240924215103.GC1143820@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lQCBSfF1QUjHsitXWxDoIgW3qtzB0S4IFdAOu1PRCJirYc1xz5j
 E05G2XiweVx7qloTyPCI9rquD0vBK1BShqKwBqtRNv5SOjg75Vy9N6YUn8exdcPJWgUviV/
 DQBY76V5v0QGz2yV9JP7aJt0eLaklR/HHen5uH9+gddp3yb4RwfC/o+0ZbT5KbIRS55GumD
 u8ebzfcwI5F0TZkQSgjiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X1uPwzx2ys4=;S1ZlE4cHvkyRJNaFfev0fTfrNV7
 QnMALxd8sYkt3tfwI17YGJkvCccu5lN7o1AXpVd8zos7GOPUok6sSs6Tc8wj1Icm4L8V0r6eu
 JHu6uLKIB2tZfocsjgh+oT90BbsxUCFV7lmZ/0mFh5Xg76HQjXcTsshymEDOOmRhuIr8K3Aft
 LXoKq6upMFrqg8Rpnd2fYX2uxEinUkkYbc0SGIiVSIztC9iz3g/joNk8Xor1MyouQfDL1IDxk
 GSWuG4l6X8T1QsjnIffTLKNg/aR29nN7ANPgte5xMGHZ+S57nDsLtlNYjPJ0ka0r3absbgVd9
 oMpNM1ZSyrVe9mMh351QeKs0P1liY6I0a0/9g4UeAJwBj0kavzTPNiYJq6iCP0L4B5kpNUFLr
 Zo1wCEywoAve3F9ZCG6K0mkJQzhRzdjzDzDg1GHIR1LBioo9YMQEE7CXASBjccQ83HLJpQi66
 2hIDqI9dalKAq/QvzztwZHbyjtx4HsSfcHwSg6aSMF+1gT5oFYXz422hKEqfYGLrMSVsIpWEm
 WcWD4AW0/miFpLQFBHA/xvdEX89X4xGTaSG9JLI8F4PJkYmsdvx1e6gcFgIKM4yzNADOUK08u
 MHooUvXy6GxaOssneiIdoD+ucMlDWi7HybEPtzAs/kDRizuEDDM1kdGu4lEnMwpcC+SFW63lu
 BRz32T2ZbOYtO36kHrqe+CbwF34s/z81jhco3d+/uPRsDn+l2Gv4Oiu28S2fC2Ej0q6GPo/Ex
 whA2BtQ3H6edLu5Cxy+ve6TBvqDrAHDC3m6L0j8LJoCLApUsZfX1e01x/nLoNhoSq0213S3SL
 Q0GV4tMqQNvlV6b/oTAi271Q==

Am 24.09.24 um 23:51 schrieb Jeff King:
> From: Patrick Steinhardt <ps@pks.im>
>
> When calling `fetch_pack()` the caller is expected to pass in a set of
> sought-after refs that they want to fetch. This array gets massaged to
> not contain duplicate entries, which is done by replacing duplicate refs
> with `NULL` pointers. This modifies the caller-provided array, and in
> case we do unset any pointers the caller now loses track of that ref and
> cannot free it anymore.
>
> Now the obvious fix would be to not only unset these pointers, but to
> also free their contents. But this doesn't work because callers continue
> to use those refs. Another potential solution would be to copy the array
> in `fetch_pack()` so that we dont modify the caller-provided one. But
> that doesn't work either because the NULL-ness of those entries is used
> by callers to skip over ref entries that we didn't even try to fetch in
> `report_unmatched_refs()`.
>
> Instead, we make it the responsibility of our callers to duplicate these
> arrays as needed. It ain't pretty, but it works to plug the memory leak.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/fetch-pack.c   | 11 ++++++++++-
>  t/t5700-protocol-v1.sh |  1 +
>  transport.c            | 11 ++++++++++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 49222a36fa..c5319232a5 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -53,6 +53,7 @@ int cmd_fetch_pack(int argc,
>  	struct ref *fetched_refs =3D NULL, *remote_refs =3D NULL;
>  	const char *dest =3D NULL;
>  	struct ref **sought =3D NULL;
> +	struct ref **sought_to_free =3D NULL;
>  	int nr_sought =3D 0, alloc_sought =3D 0;
>  	int fd[2];
>  	struct string_list pack_lockfiles =3D STRING_LIST_INIT_DUP;
> @@ -243,6 +244,13 @@ int cmd_fetch_pack(int argc,
>  		BUG("unknown protocol version");
>  	}
>
> +	/*
> +	 * Create a shallow copy of `sought` so that we can free all of its en=
tries.
> +	 * This is because `fetch_pack()` will modify the array to evict some
> +	 * entries, but won't free those.
> +	 */
> +	DUP_ARRAY(sought_to_free, sought, nr_sought);
> +
>  	fetched_refs =3D fetch_pack(&args, fd, remote_refs, sought, nr_sought,
>  			 &shallow, pack_lockfiles_ptr, version);
>
> @@ -280,7 +288,8 @@ int cmd_fetch_pack(int argc,
>  		       oid_to_hex(&ref->old_oid), ref->name);
>
>  	for (size_t i =3D 0; i < nr_sought; i++)
> -		free_one_ref(sought[i]);
> +		free_one_ref(sought_to_free[i]);
> +	free(sought_to_free);

OK.

>  	free(sought);
>  	free_refs(fetched_refs);
>  	free_refs(remote_refs);
> diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
> index a73b4d4ff6..985e04d06e 100755
> --- a/t/t5700-protocol-v1.sh
> +++ b/t/t5700-protocol-v1.sh
> @@ -11,6 +11,7 @@ export GIT_TEST_PROTOCOL_VERSION
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  # Test protocol v1 with 'git://' transport
> diff --git a/transport.c b/transport.c
> index 3c4714581f..1098bbd60e 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -414,7 +414,7 @@ static int fetch_refs_via_pack(struct transport *tra=
nsport,
>  	struct git_transport_data *data =3D transport->data;
>  	struct ref *refs =3D NULL;
>  	struct fetch_pack_args args;
> -	struct ref *refs_tmp =3D NULL;
> +	struct ref *refs_tmp =3D NULL, **to_fetch_dup =3D NULL;
>
>  	memset(&args, 0, sizeof(args));
>  	args.uploadpack =3D data->options.uploadpack;
> @@ -477,6 +477,14 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
>  		goto cleanup;
>  	}
>
> +	/*
> +	 * Create a shallow copy of `sought` so that we can free all of its en=
tries.
> +	 * This is because `fetch_pack()` will modify the array to evict some
> +	 * entries, but won't free those.
> +	 */
> +	DUP_ARRAY(to_fetch_dup, to_fetch, nr_heads);
> +	to_fetch =3D to_fetch_dup;
> +
>  	refs =3D fetch_pack(&args, data->fd,
>  			  refs_tmp ? refs_tmp : transport->remote_refs,
>  			  to_fetch, nr_heads, &data->shallow,
> @@ -500,6 +508,7 @@ static int fetch_refs_via_pack(struct transport *tra=
nsport,
>  		ret =3D -1;
>  	data->conn =3D NULL;
>
> +	free(to_fetch_dup);

This makes a shallow copy and passes it to fetch_pack() and later to
report_unmatched_refs().  It shields callers of fetch_refs_via_pack()
from the effect of fetch_pack()'s NULLification.  This is what the
commit message says would not work.  What am I missing?

>  	free_refs(refs_tmp);
>  	free_refs(refs);
>  	list_objects_filter_release(&args.filter_options);

