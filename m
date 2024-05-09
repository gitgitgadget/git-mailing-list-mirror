Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983171A2C0A
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272666; cv=none; b=PWZQIFngoDxraVMPLjWjL8GHsnS/ZU9gUKIQqq0J1VJDGG7FnH4vWv/2Ypf3ZCA4/11n0mSX0SYP/TOp9tJNA2deSkitdx+9G6YY1+XLpZAqiUIuOU3GUOwLgO4byzk/MvAFJv5iiY8IYhjnLJVuc25GGK2EwSCzjCxKZAsLny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272666; c=relaxed/simple;
	bh=eOexV5H2K7POqGil+qbY+HN5YYClOOdnrT0N9aNnpww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dvA8NUVJslU5gWtrc5drGY8dyj1yhRDiO6c+V/1fsc2ZOVEupgN/ISb9ew9MpKWvmg7QbDVEq2K0n0SZjhiviMJWYGb9mW7MOo5VEt2ffIe23CVYTGkR9xjyt75mXs6RS2qgex6Tcyk83wIW/ZIZsphkkwKL4ZGNkOMe5oP/HaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oJaodNrZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oJaodNrZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 55E2437833;
	Thu,  9 May 2024 12:37:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eOexV5H2K7PO
	qGil+qbY+HN5YYClOOdnrT0N9aNnpww=; b=oJaodNrZCt6P50+6h/sF577OzhUW
	rnDxv695kWQYkDb4Lt2nTZMHZkO/Hr7mbWWMcCdJHPwqsRVmS/kss30uv4MlKFjv
	ZiakWnFMe0RbkD6048FpASZWjNW40GN9BSX3DxtuF/zikIlAexddpTsgPSlqPl0k
	g06Pp4mgKW55ba0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D84C37832;
	Thu,  9 May 2024 12:37:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6BC737831;
	Thu,  9 May 2024 12:37:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  takimoto-j@kba.biglobe.ne.jp
Subject: Re: [PATCH v2 1/1] macOS: ls-files path fails if path of workdir is
 NFD
In-Reply-To: <20240509161110.12121-1-tboegi@web.de> (tboegi@web.de's message
	of "Thu, 9 May 2024 18:11:10 +0200")
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
	<20240509161110.12121-1-tboegi@web.de>
Date: Thu, 09 May 2024 09:37:41 -0700
Message-ID: <xmqqikznueju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 75097DCE-0E22-11EF-BD27-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Under macOS, `git ls-files path` does not work (gives an error)
> if the absolute 'path' contains characters in NFD (decomposed).
> ...
>
> Reported-by: Jun T <takimoto-j@kba.biglobe.ne.jp>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Looks good.  I've queued with a slight rewording to the proposed log
message, and a bit of extra quoting in the test.  Any string that
contains "$aumlcdiar" are enclosed in a pair of double-quotes in the
script, so not just the one given to ls-files, other two references
to it are also quoted now.

Thanks.

1:  a00cec23cf ! 1:  ee6ba4053d macOS: ls-files path fails if path of wor=
kdir is NFD
    @@ Commit message
         In the 'fatal:' error message, there are three =C3=BC;
         the 1st and 2nd are in NFC, the 3rd is in NFD.
    =20
    -    This commit adds a test case that follows the bug report,
    -    with the simplification that the '=C3=BC' is replaced by an '=C3=
=A4',
    -    which is already used as NFD and NFC in t0050.
    +    Add a test case that follows the bug report, with the simplifica=
tion
    +    that the '=C3=BC' is replaced by an '=C3=A4', which is already u=
sed as NFD and
    +    NFC in t0050.
    =20
    -    The solution is to precompose the result of getcwd(), if needed.
    +    Precompose the result of getcwd(), if needed, just like all othe=
r
    +    paths we use internally.  That way, paths comparisons are all do=
ne
    +    in NFC and we would correctly notice that the early part of the
    +    path given as an absolute path matches the current directory.
    =20
         One possible implementation would be to re-define getcwd() simil=
ar
    -    to opendir(), readdir() and closedir().
    -    Since there is already a strbuf wrapper around getcwd(), and onl=
y this
    -    wrapper is used inside the whole codebase, equip strbuf_getcwd()=
 with
    -    a call to the newly created function precompose_strbuf_if_needed=
().
    +    to opendir(), readdir() and closedir(), but since there is alrea=
dy a
    +    strbuf wrapper around getcwd(), and only this wrapper is used in=
side
    +    the whole codebase, equip strbuf_getcwd() with a call to the new=
ly
    +    created function precompose_strbuf_if_needed().
    +
         Note that precompose_strbuf_if_needed() is a function under macO=
S,
         and is a "no-op" on all other systems.
    =20
    @@ t/t0050-filesystem.sh: test_expect_success CASE_INSENSITIVE_FS 'ch=
eckout with no
     =20
     +test_expect_success 'git ls-files under NFD' '
     +	(
    -+		mkdir -p somewhere/$aumlcdiar &&
    ++		mkdir -p "somewhere/$aumlcdiar" &&
     +		mypwd=3D$PWD &&
    -+		cd somewhere/$aumlcdiar &&
    ++		cd "somewhere/$aumlcdiar" &&
     +		git init &&
    -+		git --literal-pathspecs ls-files "$mypwd/somewhere/$aumlcdiar"  2=
>err &&
    ++		git --literal-pathspecs ls-files "$mypwd/somewhere/$aumlcdiar" 2>=
err &&
     +		>expected &&
     +		test_cmp expected err
     +	)
