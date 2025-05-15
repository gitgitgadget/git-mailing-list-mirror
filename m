Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03872614
	for <git@vger.kernel.org>; Thu, 15 May 2025 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327448; cv=none; b=KmHNilGLZPIYBshkGlZigII/7TG6+owZ/22eoGS0lkGCZjwh/Qs24PTwt3EUEOEOS+nkXLAUQE4EDLhU3CEcgcbGso+9V3eAQB0PH3IZFLSth4nIztsf5RomfjJE4X37Mr1Q/O5D7ajJJ7gv2tgj3ik1ywHVYgpWSxLDn1WdJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327448; c=relaxed/simple;
	bh=URe9US3KqD0dOKUUpLQ1sRWho1XGZgkqN8pkDpfG770=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lVliUehuL4sBEUvhGM13Ph8feCPWrZgDw+bbeHBKIMVSdXAvmKXMfdwgmNqS5BbGpQ1SbKvTwMVgW8lOFebKqHbrIalNDECv36NMrUnz+EHrxiEoVo2AwBCVK8tci1GuR9v62/wigYAP5IBr4YEYK21GxunV3CgHTVSqEAboYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz20t1747327396t65677903
X-QQ-Originating-IP: +x3PEaUGgy3CgIteL7GBm2iEz3U9lh4e7XnodmiZ104=
Received: from smtpclient.apple ( [202.119.48.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 00:43:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9516260663202152467
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] sequencer: fix memory leak if `update_squash_messages()`
 failed
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqldqx3ky7.fsf@gitster.g>
Date: Fri, 16 May 2025 00:43:04 +0800
Cc: Phillip Wood <phillip.wood123@gmail.com>,
 Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD5588EE-C935-42E8-9876-F47FB35309D9@smail.nju.edu.cn>
References: <pull.1964.git.git.1747226641249.gitgitgadget@gmail.com>
 <935822b9-33e5-457e-95a7-64058777b52a@gmail.com> <xmqqldqx3ky7.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OUC5DGN0mB58Y3GDSJPVST6MBf0VcMvaXoWkrRKjM9Y5rDPE0BKFDws8
	bLsi3Wr38fDDy9nRvyLkzFRCk+GUc2gKI/iCxAcznpKPu6EOtOsuKSQ3h7FZm2xIIVPqxHg
	wD2YEelDwunGJbYXnQb3yJHZHr9cNPKlpk9YeWKD2tfCwv1MhgzRkLP35SocDHaxgc6LX76
	EWSZTreK/9Uu6HsvDwS3qANGy2/HqJBMwFrIgXhjVWnKNwnWESCKhqOggcRikBpDyHxKBQc
	BZhjMoFE1JL6rFQqZ5x2Mfxy2p25cD36ejq+IDc0CofuxE/UaU1tDUqkD/fqQvn9Wlh0L4U
	GK1rNNdlf43ysjoqxpMX6N4wKfN4GydEu8M3rcOX4xUtlY23fH49l4NhZ3mjEvqOFM1rXKL
	TE00RzjDIm8Ke0eBSkniqeyaodmymPgUcckwB6JnE2iysUvJEdLuZcz9HwiOtlsM+Ng0daG
	ilejhF8u2ZJAxohYpJsBbQDTFbu+tY424VSvCktOhtyy2s4ovgOr51lbZeYAjErVJClIzid
	N9Uv870/cFbw/6UGCGpBLV9hdxGPsEfrb+lPvxrNSH0nuMU6fQT5qkeJRHWlz+/wDjG25lm
	yszFKV4lhnFyEOIYTI33wwkjRenqEaSszED0VpPfHsURyBVqyVO5xzCoTbIo2BoMBhm7E0x
	AX4j8Xk2NW3W+i6tKQriQnXiolbUacwI4XpKP0ymgt3JsnHJwHFmznVCaCodaqpBY3z+wGv
	8AErA7JsV/u331ryKeYLvA3lD1zvutNkRdSvj6lUGmag5yZsO/rsJqXcksUhk6k2q+2Rcar
	3NYKULcdzJ9rcmk0Skbr00i4hgpPf7DZ54rhKMsW5TUfb4vvi23pyxskSLVPa3YtatQVYPM
	U6/gERJp5t8hZFrUKr/389suR663yATWmzK6vTYh3thdCgrjrwQNqnsWoPeGWhROTkPHqVa
	x0rb+v1ZywYK1yDYcl5yZy9hSr0MSZFZluLbVUGq7gWQae4LtNJOkGvvNf5Ftv/Ux2BVqZn
	O7+5F51Le2As+6ZPlc
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B45=E6=9C=8816=E6=97=A5 00:20=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> I am curious if Lidong's tool would notice an unreachable code if
> only the first hunk of the attached patch is applied.  The "else"
> clause in the second hunk would become unreachable.
>=20
>=20
> diff --git c/sequencer.c w/sequencer.c
> index b5c4043757..269637d427 100644
> --- c/sequencer.c
> +++ w/sequencer.c
> @@ -2071,6 +2071,9 @@ static int update_squash_messages(struct =
repository *r,
> const char *message, *body;
> const char *encoding =3D get_commit_output_encoding();
>=20
> + if (!(command =3D=3D TODO_FIXUP || command =3D=3D TODO_SQUASH))
> + BUG("update_squash_messages with command %d", command);
> +
> if (ctx->current_fixup_count > 0) {
> struct strbuf header =3D STRBUF_INIT;
> char *eol;
> @@ -2138,8 +2141,6 @@ static int update_squash_messages(struct =
repository *r,
> strbuf_addstr(&buf, "\n\n");
> strbuf_add_commented_lines(&buf, body, strlen(body),
>   comment_line_str);
> - } else
> - return error(_("unknown command: %d"), command);
> repo_unuse_commit_buffer(r, commit, message);
>=20
> if (!res)

In this case, we do not directly identify the else branch as unreachable =
code.
However, we perform constraint solving on the conditions leading to a =
potential
leak, which ultimately allows us to determine that the leaking path is =
actually
unreachable.

