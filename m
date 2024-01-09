Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A33C067
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qt9KsHmC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F8A31C919B;
	Tue,  9 Jan 2024 13:19:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=a9xTqGLHnrqU
	WVTKswAy/i5DfVzQinJJglydouzqLd4=; b=Qt9KsHmCcTQxhPq3+8B9YSb380wZ
	+6cg/VI0rJIjas7EWkep3ZM8q6zL4nHXQzFdSqJWnG1wfZMlCLYRkYUUGdHVYzv5
	94kfmR1/yAyTwITNaKZMJCTClz8f4S58nyjANSJB4KxaMCTcB5lz84sMr+xqQkfk
	eFpYogWdP1ynTKI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 169EE1C919A;
	Tue,  9 Jan 2024 13:19:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6CDBC1C9198;
	Tue,  9 Jan 2024 13:19:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] t/test-tool: usage description
In-Reply-To: <ec57072d-0069-4d07-a695-b89436350568@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 9 Jan 2024 16:29:30 +0100")
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
	<ec57072d-0069-4d07-a695-b89436350568@gmail.com>
Date: Tue, 09 Jan 2024 10:19:06 -0800
Message-ID: <xmqqy1cygyjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 93DAC7D2-AF1B-11EE-8CA3-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

> Subject: Re: [PATCH 1/3] t/test-tool: usage description

Good eyes to spot the missing close-angle-bracket.  I'll add some
missing verb, e.g. "fix usage string", while queuing.

I would not bother replacing the fprintf() format string in the same
patch.  Hits from

    $ git grep '"usage:' t/helper

indicates that far less than half (3 among 12) reuses usage_str[]
for this purpose.  Making these "usage:" strings come from a unified
API (perhaps parse_options() family of functions have something more
appropriate than ad-hoc use of fprintf()?  I didn't check) might be
a welcome change but that is clearly outside the scope of the
mark-up fix, and I do not see touching only this one that still uses
fprintf() advances toward such a goal.

t/helper/test-chmtime.c:	fprintf(stderr, "usage: %s %s\n", argv[0], usage=
_str);
t/helper/test-delta.c:		fprintf(stderr, "usage: %s\n", usage_str);
t/helper/test-windows-named-pipe.c:	fprintf(stderr, "usage: %s %s\n", arg=
v[0], usage_string);


t/helper/test-advise.c:		die("usage: %s <advice>", argv[0]);
t/helper/test-csprng.c:		fprintf(stderr, "usage: %s [<size>]\n", argv[0])=
;
t/helper/test-genrandom.c:		fprintf(stderr, "usage: %s <seed_string> [<si=
ze>]\n", argv[0]);
t/helper/test-genzeros.c:		fprintf(stderr, "usage: %s [<count>]\n", argv[=
0]);
t/helper/test-hash-speed.c:		die("usage: test-tool hash-speed algo_name")=
;
t/helper/test-mergesort.c:	fprintf(stderr, "usage: test-tool mergesort ge=
nerate <distribution> <mode> <n> <m>\n");
t/helper/test-strcmp-offset.c:		die("usage: %s <string1> <string2>", argv=
[0]);
t/helper/test-tool.c:	fprintf(stderr, "usage: test-tool <toolname> [args]=
\n");


> Even though this is an internal tool, let's keep the usage description
> correct and well organized.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  t/helper/test-tool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 37ba996539..d9f57c20db 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -5,7 +5,7 @@
>  #include "parse-options.h"
> =20
>  static const char * const test_tool_usage[] =3D {
> -	"test-tool [-C <directory>] <command [<arguments>...]]",
> +	"test-tool [-C <directory>] <command> [<arguments>...]]",
>  	NULL
>  };
> =20
> @@ -100,7 +100,7 @@ static NORETURN void die_usage(void)
>  {
>  	size_t i;
> =20
> -	fprintf(stderr, "usage: test-tool <toolname> [args]\n");
> +	fprintf(stderr, "usage: %s\n", test_tool_usage[0]);
>  	for (i =3D 0; i < ARRAY_SIZE(cmds); i++)
>  		fprintf(stderr, "  %s\n", cmds[i].name);
>  	exit(128);
