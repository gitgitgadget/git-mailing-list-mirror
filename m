Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F95A189907
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358733; cv=none; b=RwM5a9xdCITgFwaJsVwnGw0yOILIqV9mKgJDTl6QQyc2gTRnhSIy+4jtQ5croqT0hHi1ShFcZA58CCXxA4ngZFyQPD2ms0IOSkSPaldor567ZTDEStYgwQlotUgw9485800XYmAAjnJvkG5Y6ld82B6velVxjEV2BY4lFeWRxF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358733; c=relaxed/simple;
	bh=3y5KrrD3qSGCx8SBC6vtY3j0Ev4hlvStwbkPL05zJgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kuCi5F+EN89/QWbIe6CKJ3K05vsKWY/rnOBakmwfpmmoNOFrs5polPpEkQp8P7jZXoocbZx4HK6hY7N+TD0X3RgfAOIHn0y1So1dkUVAHZJCdCDRqTuC2BZ4REIsoP8HWQNMjZz3VjujlwuTWcPpYAWjsog8+z9gKUAAB7pVmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LztlbqOq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LztlbqOq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 275553409A;
	Tue, 30 Jul 2024 12:58:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3y5KrrD3qSGC
	x8SBC6vtY3j0Ev4hlvStwbkPL05zJgA=; b=LztlbqOqWmRnk5iRl2p4NG88toSH
	nLaKFdys8zcVC+hptLie1Y73iuYY0Yb2UOq1I3XHIIg/upkMxpRY0mW401qz8nWg
	LKROq4AElJ24v4gMSWn90OK73UCqWhpozP1LpQ5FH3N09Tb9aH3GvR0znl1z4dTh
	NalMNhkaGbZfjx0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 201F634099;
	Tue, 30 Jul 2024 12:58:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85B2934098;
	Tue, 30 Jul 2024 12:58:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] grep: -W: skip trailing empty lines at EOF, too
In-Reply-To: <8b90e0ec-251f-46b3-8777-96efd58e227b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 30 Jul 2024 16:18:54 +0200")
References: <8b90e0ec-251f-46b3-8777-96efd58e227b@web.de>
Date: Tue, 30 Jul 2024 09:58:49 -0700
Message-ID: <xmqqle1ierzq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 FE9D4B62-4E94-11EF-9E26-34EEED2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> 4aa2c4753d (grep: -W: don't extend context to trailing empty lines,
> 2016-05-28) stopped showing empty lines at the end of function context
> when using -W.  Do the same for trailing empty lines at the end of
> files, for consistency -- it doesn't matter whether a function section
> is ended by the next function or the end of the file.

Nice, and the implementation reflects the above logic.

> Test it by adding a trailing empty line to the file used by the test
> "grep -W" and leave its expected output the same.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  grep.c          | 3 ++-
>  t/t7810-grep.sh | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/grep.c b/grep.c
> index ac34bfeafb..2f8b9553df 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1735,7 +1735,8 @@ static int grep_source_1(struct grep_opt *opt, st=
ruct grep_source *gs, int colle
>  				peek_eol =3D end_of_line(peek_bol, &peek_left);
>  			}
>
> -			if (match_funcname(opt, gs, peek_bol, peek_eol))
> +			if (peek_bol >=3D gs->buf + gs->size ||
> +			    match_funcname(opt, gs, peek_bol, peek_eol))
>  				show_function =3D 0;
>  		}
>  		if (show_function ||
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 875dcfd98f..af2cf2f78a 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -31,6 +31,7 @@ int main(int argc, const char **argv)
>  	return 0;
>  	/* char ?? */
>  }
> +
>  EOF
>
>  test_expect_success setup '
> --
> 2.46.0
