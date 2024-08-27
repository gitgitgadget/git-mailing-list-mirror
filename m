Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500261C2E
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724721098; cv=none; b=LoKbRtY/sRXdSpNEXvRprilE0xPF/Jqtbe3JRHgw+3CidW2c4OFhFTcYhw7prH0F/wZB1h7LRIElKIifiKjxfjr109TfuCvYSmSch5fCL9E39wE4Fe9u1Ue/sbO5/jM1Tm21RrorNmX0XKV6x9lV+TJb1WyHm3Hvmokqgw8C/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724721098; c=relaxed/simple;
	bh=EraqNPo/o7gbDvaNj7/C2rFyeIsaJMOoE/oSc2iz8pQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lYKobDqotFZHjxX4w1AWPOgHzQeflOgfziVtqbQIRQylBebEOPapoxzTYcHenVFhPtpVzoo2D6b3Hs+8zx8Ebees2xeNM+Ty8Ad4VjWXaFspvK+wh0V7moUkSDLrAEyqw6OeeFg9CUJiLOzgR29pP+la1+ugsb38Ro+h0/oBcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ltrStjzK; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ltrStjzK"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D4B3C1F476;
	Mon, 26 Aug 2024 21:11:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EraqNPo/o7gb
	DvaNj7/C2rFyeIsaJMOoE/oSc2iz8pQ=; b=ltrStjzKsm1dD36vvTN/50NM8GqS
	nIVbKYonMb00jD4K09kXELYlFo/xpbWGcB42If0zhA1hViAcTjppVxZy34QwlMwU
	qMl2KiQ576WR3RN2r+0N1a09BUFhAljTXIqTZrs4Pi3dIW3CF/VJKPk7HWFJIctP
	ppRp0jnJJiLoXnc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CEB8C1F475;
	Mon, 26 Aug 2024 21:11:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 541A81F473;
	Mon, 26 Aug 2024 21:11:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] apply: introduce `ignore_ws_default`
In-Reply-To: <5e35f260-056c-4af3-95d9-70d6f117bff9@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 25 Aug 2024 12:17:37 +0200")
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
	<5e35f260-056c-4af3-95d9-70d6f117bff9@gmail.com>
Date: Mon, 26 Aug 2024 18:11:31 -0700
Message-ID: <xmqq4j76epmk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4C9164FC-6411-11EF-9B98-E92ED1CD468F-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> When we see `--whitespace=3Dfix` we don't consider a possible
> option: `--no-ignore-whitespace`.
>
> The expected result in the following example is a failure when
> applying the patch, however:
>
>     $ printf "a \nb\nc\n" >file
>     $ git add file
>     $ cat >patch <<END
>     --- a/file
>     +++ b/file
>     @@ -1,3 +1,2 @@
>      a
>     -b
>      c
>     END
>     $ git apply --no-ignore-whitespace --whitespace=3Dfix patch
>     $ xxd file
>     00000000: 610a 630a                                a.c.
>
> This unexpected result will be addressed in an upcoming commit.
>
> As a preparation, we need to detect when the user has explicitly
> said `--no-ignore-whitespace`.

If you said, before all of the above, what _other_ case you are
trying to differenciate from the case where the user explicitly gave
the "--no-ignore-whitespace" option, it would clarify why a
differenciator is needed.  IOW, perhaps start

    By default, "git apply" does not ignore whitespace changes
    (i.e. state.ws_ignore_action is initialized to ignore_ws_none).
    However we want to treat this default case and the case where
    the user explicitly gave the "--no-ignore-whitespace" option FOR
    SUCH AND SUCH REASONS.

    ... elaborate SUCH AND SUCH REASONS as needed here ...

    Initialize state.ws_ignore_action to ignore_ws_default, and
    later after the parse_options() returns, if the state is still
    _default, we can tell there wasn't such an explicit option.

or something?

The rest of the code paths are not told what to do when they see
ws_ignore_action is set to this new value, so I somehow find it iffy
that this step is complete.  Shouldn't it at least flip some other bit
after apply_parse_options() makes parse_options() call and notices that
the default value is still there, and then replace the _default value
with ws_none, or something, along the lines of ...

 apply.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git i/apply.c w/apply.c
index 6e1060a952..acc0f64d37 100644
--- i/apply.c
+++ w/apply.c
@@ -5190,5 +5190,13 @@ int apply_parse_options(int argc, const char **arg=
v,
 		OPT_END()
 	};
=20
-	return parse_options(argc, argv, state->prefix, builtin_apply_options, =
apply_usage, 0);
+	ret =3D parse_options(argc, argv, state->prefix,
+			    builtin_apply_options, apply_usage, 0);
+	if (!ret) {
+		if (state->ws_ignore_action =3D=3D ignore_ws_default) {
+			... note that --no-ignore-whitespace was *NOT* used ...
+			state->ws_ignore_action =3D ignore_ws_none;
+		}
+	}
+	return ret;
 }

... without that anywhere state.ws_ignore_action gets inspected, the
all must treat _none and _default pretty much the same way, no?

> Currently, we only have one explicit consideration for
> `ignore_ws_change`, and no, implicit or explicit, considerations for
> `ignore_ws_none`.  Therefore, no modification to the existing logic
> is required in this step.

Yes, that is a plausible excuse, but it feels somehat brittle.

More importantly, the proposed log message does not explain why
"--no-ignore-whitespace", which is the default, needs to be special
cased when it is given explicitly.  You had symptoms you want to fix
described, but it is probably a few steps disconnected from the
reason why the default vs explicit setting of ws_ignore_action need
to make the code behave differently.

Thanks.
