Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D3F18C1A
	for <git@vger.kernel.org>; Mon, 20 May 2024 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247119; cv=none; b=ACX+EHD2dgq0ugO4HaoE9Q4/PPBJtfwABxW1Y9i3Vub9fLznKrcU4EpH+HoqSYCUolQT8OKbggKEsiiEkbSRIApfVmfs/vh4ujf3MEATyZyaLFsOGGgKPqNCUheWmdzeLLIe6rLViLihMu2jF3gUbvmYnBsRJsHlAvFEgUgtdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247119; c=relaxed/simple;
	bh=O1RPcR/hLGEqParzg380wYOXZePVlG9r6/hEu4tK8H8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CzhM8cnzUc1wb3ghoggx2FnqPLodCbfbpjH1vEyv1FsJ19v8H21ltHKsK+DcTTJiW2oI0BuLo3EugiSdNyNSSM+WiCM1IIxlOCSZmIioICyVWpXcCOm/C4UJvVZX8Jh8vxaLb+PqOanLLuvlh2puXy6+rMEheIvB706zstghYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DFQufZAL; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DFQufZAL"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BEEB29F24;
	Mon, 20 May 2024 19:18:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=O1RPcR/hLGEq
	Parzg380wYOXZePVlG9r6/hEu4tK8H8=; b=DFQufZALuRUEiQprbjcK1JJciA3S
	nEIctmWIsagqjnXeWoAxvWE6F28CNIQEQv5a981oeUaENxTtYDzIvfaPF3nPcZ6J
	TL+6SNMFkLk4Gr/pO3Z34DRbqByppuFwTjV2bbFRg21MeC/60XoyEMc5XxRer1us
	u7B4ofqOzbG9Vv0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 54B8429F23;
	Mon, 20 May 2024 19:18:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 64FFB29F20;
	Mon, 20 May 2024 19:18:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
In-Reply-To: <dcc9f9bf-3c0f-435f-ba10-35ff31122b7d@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 21 May 2024 00:47:21 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
	<xmqqh6esffh1.fsf@gitster.g>
	<dcc9f9bf-3c0f-435f-ba10-35ff31122b7d@gmail.com>
Date: Mon, 20 May 2024 16:18:33 -0700
Message-ID: <xmqq5xv8dqd2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 47879850-16FF-11EF-A347-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> even with "less -F"
>> (--quit-if-one-screen).  As we know how much output we are throwing
>> at the user, we'd want to make this conditional to the size of the
>> hunk being shown and the terminal height.
>
> Are you thinking of something like?:

I don't. =20

Your hunk may have overly wide lines in which case counting the
number of lines may be insuffucient to measure the necessary display
height.   Besides, comparison with term_columns() is meaningless
unless your window is square ;-)

An explicit 'P' might be palatable, though.

Thanks.

> =20
> diff --git a/add-patch.c b/add-patch.c
> index cefa3941a3..495baad3ac 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1449,11 +1449,18 @@ static int patch_update_file(struct add_p_state=
 *s,
>  		strbuf_reset(&s->buf);
>  		if (file_diff->hunk_nr) {
>  			if (rendered_hunk_index !=3D hunk_index) {
> -				setup_pager();
> +				int lines =3D 0;
>  				render_hunk(s, hunk, 0, colored, &s->buf);
> +				for(int i =3D 0; i < s->buf.len; i++) {
> +					if (s->buf.buf[i] =3D=3D '\n')
> +						lines++;
> +				}
> +				if (lines > term_columns())
> +					setup_pager();
>  				fputs(s->buf.buf, stdout);
>  				rendered_hunk_index =3D hunk_index;
> -				wait_for_pager();
> +				if (lines > term_columns())
> +					wait_for_pager();
>  			}
> =20
>  			strbuf_reset(&s->buf);
>
> This would significantly reduce the blast radius.
>
> Thanks.
