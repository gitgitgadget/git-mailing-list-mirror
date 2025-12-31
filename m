Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B02DF125
	for <git@vger.kernel.org>; Wed, 31 Dec 2025 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767170263; cv=none; b=f3F8Fu3xk65NoczZpXAG2g6uMq71nh+PUHQfr3QFIgjxq9IJSkK9I8wO/Vr8rQ+7EtYZrm6JXUSU2t4517AhIeJzJx74//PIKa6uMigJoeDOwNd7QaybAo4p+wJQW760m5ewYgAEKeEBF1U+B/rzG0XamV62tbIhJG1gzg1I6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767170263; c=relaxed/simple;
	bh=UWYG4OjAmA1UgJKJCT7gp6zBWJCWx66aPR5GJh95pL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STE0i0R0wBX1GNPsQMNFLUmlxNUgkmq/zZRWsDw7TaX+BhLKF9S9cB25eBfeeIRoVa3zqdWbaQ8ho3RfrrDklpLif0nxGdeVXlGJ0sWS6JePLrlS5H8aaRFZDb9e6rqe40cBXNQTgu/3Drkv5BGx4n9nDFyBiUlA0MeUF5DUFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=nNSwRn9C; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="nNSwRn9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767170244; x=1767775044; i=l.s.r@web.de;
	bh=dAe03oH9gDZHoQ5dmxkHjktWYwbDSosmsWsd7cxKpWk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nNSwRn9CmmiC7O7DC8SWNeeNfEOZjLK0o0NMq2eIxshIdgbHP5tE5Eru7o5ois+V
	 HI7PMjrqbl+guC94OMEPT3Xi+mKT6uc4HoRlEHLXBR9o3uL1NjwxOJvQcObYn/Mvj
	 M97LJK3mw/xlPJAcQLQnjdT0Rvfk5r/FYEliqZeHabm2D77TuHsKlDxNZmwQG1yLh
	 RM7It3dGZenHnoaRnXRKwbV2ArZfZ1ons9HK3g6DJTJC8GUKVIfjpH0jdBQa4C8e1
	 Fa7DxzTFKeLQOckL5yq5soH878Xl29fYjPxl7jRZ+f0G4l/nIQ9hedIunjondROOx
	 aXlanxEDEoaDIPMpqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.157.122]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1aIB-1vdtyp1hgx-0042wV; Wed, 31
 Dec 2025 09:37:24 +0100
Message-ID: <ebb877bb-c86f-4ca1-b7b7-b236fb95848e@web.de>
Date: Wed, 31 Dec 2025 09:37:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsmonitor: fix khash memory leak in do_handle_client
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Paul Tarjan <github@paulisageek.com>
References: <pull.2148.git.git.1767098576384.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.2148.git.git.1767098576384.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DgbrxAfbwUNx9k8ug/VGCUGXNcTZSG1dvLPuyeP0zuxAmiOwwb5
 Fd33IwhMDMESoLumIRLWzlXhQ/64D1LklcPp9ZeInKwYv2yXrIkImGHFIMU+TMl3i2NMZC9
 YKz891VPYmP8TZc73UIcvv2Y7kM0ZCVO/8X3gz6AysIdA9QGlmvNcFJXJ8nrzaEWoYyZYYg
 Y+jBLg6LsNv4gOrfihzMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lXdnP4CNrZ8=;Whqi5Wdxkc3L3BPu8UDJ467jvuB
 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
 qTXrS+EE5VD+n4juv3nTyjjKz3gLu

On 12/30/25 1:42 PM, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>
>=20
> The do_handle_client() function allocates a khash table to de-duplicate
> pathnames when responding to client requests. Two issues existed:
>=20
> 1. kh_release_str() was used instead of kh_destroy_str(). The release
>    function only frees internal arrays (flags, keys, vals) but not the
>    struct itself (allocated by kh_init_str via xcalloc). This caused a
>    40-byte leak per request.
>=20
> 2. The khash was freed mid-function rather than in the cleanup section,
>    so if the worker thread was interrupted before reaching that point
>    during daemon shutdown, the memory would leak.
>=20
> Fix both issues by:
> - Initializing shown =3D NULL at declaration
> - Using kh_destroy_str() which handles NULL and frees both internal
>   arrays and the struct itself
> - Moving the cleanup to the cleanup section so it runs on all exit paths
>=20
> Signed-off-by: Claude <claude@anthropic.com>
> ---
>     fsmonitor: fix khash memory leak in do_handle_client
>    =20
>     The do_handle_client() function allocates a khash table to de-duplic=
ate
>     pathnames when responding to client requests. Two issues existed:
>    =20
>      1. kh_release_str() was used instead of kh_destroy_str(). The relea=
se
>         function only frees internal arrays (flags, keys, vals) but not =
the
>         struct itself (allocated by kh_init_str via xcalloc). This cause=
d a
>         40-byte leak per request.

Makes sense.

>    =20
>      2. The khash was freed mid-function rather than in the cleanup sect=
ion,
>         so if the worker thread was interrupted before reaching that poi=
nt
>         during daemon shutdown, the memory would leak.

Really?  Would an interrupted thread even reach its cleanup section?

>    =20
>     Fix both issues by:
>    =20
>      * Initializing shown =3D NULL at declaration
>      * Using kh_destroy_str() which handles NULL and frees both internal
>        arrays and the struct itself
>      * Moving the cleanup to the cleanup section so it runs on all exit
>        paths
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-21=
48%2Fptarjan%2Fclaude%2Ffix-fsmonitor-hashmap-leak-gfDCU-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2148/=
ptarjan/claude/fix-fsmonitor-hashmap-leak-gfDCU-v1
> Pull-Request: https://github.com/git/git/pull/2148
>=20
>  builtin/fsmonitor--daemon.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 242c594646..bc4571938c 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -671,7 +671,7 @@ static int do_handle_client(struct fsmonitor_daemon_=
state *state,
>  	const struct fsmonitor_batch *batch;
>  	struct fsmonitor_batch *remainder =3D NULL;
>  	intmax_t count =3D 0, duplicates =3D 0;
> -	kh_str_t *shown;
> +	kh_str_t *shown =3D NULL;
>  	int hash_ret;
>  	int do_trivial =3D 0;
>  	int do_flush =3D 0;
> @@ -909,8 +909,6 @@ static int do_handle_client(struct fsmonitor_daemon_=
state *state,
>  		total_response_len +=3D payload.len;
>  	}
> =20
> -	kh_release_str(shown);
> -
>  	pthread_mutex_lock(&state->main_lock);
> =20
>  	if (token_data->client_ref_count > 0)
> @@ -954,6 +952,7 @@ static int do_handle_client(struct fsmonitor_daemon_=
state *state,
>  	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplic=
ates", duplicates);
> =20
>  cleanup:
> +	kh_destroy_str(shown);
>  	strbuf_release(&response_token);
>  	strbuf_release(&requested_token_id);
>  	strbuf_release(&payload);
>=20
> base-commit: 7c7698a654a7a0031f65b0ab0c1c4e438e95df60

