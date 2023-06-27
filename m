Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59C3EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjF0Qct (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjF0QcO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:32:14 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD8E2D42
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687883516; x=1688488316; i=l.s.r@web.de;
 bh=Cj0DR2BcF8RX3qFUOIdikj0USHn+5Pb/kp2b8uAGgtg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KsyVGhI0WFy3XGChcVuBV3syqjO4sqpWfoZF/V6U7dAJJZeF7X/CPqadmN9fI+3rhdlpuP5
 IqoLC92cKZyZcctEm0RiSmdpPpYllj8SvwHWqNMGE1XhRqNwggHQOuqjh3qhPi5oeuEFhfDu+
 7KTAIkdFF6oYLu69cNh0ezxol06zViTbIzb7zkNUll9ojS7zin4dW3deKelzPrt+UrEVrCo9D
 TOHt6WI/BclwnnlQIgbu0vpChbfAZKlt3b+kQ+0m8CT2S5rtZOvap3tUA1H1noiMwzS4SVwOr
 3/3AGPjDdT8HKDZJtYPdatBGR2j34sfYuJUbWv7SZcopB+Zx1lWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.22.106]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1My6pZ-1pqTHX1E2p-00z7Gq; Tue, 27
 Jun 2023 18:31:56 +0200
Message-ID: <8d2223b8-ab33-be5a-20ea-ad60f6cbcc75@web.de>
Date:   Tue, 27 Jun 2023 18:31:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 4/5] replace strbuf_expand() with strbuf_expand_step()
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <150df0b0-0548-f291-2b68-960841dd1c97@web.de>
 <20230627085422.GJ1226768@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230627085422.GJ1226768@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dzpgNUQ1FVVQ1VRlOVrikcqBHc+YqUe3QyjTYe68jRvZcvOxJUr
 Y6LWKWYEdltl0sTGDXRM31SgVUnB4QuOsbujiSLMKE5e/jHdyhpgkt8rBbX0EXZCrq7uqhl
 9A9QOkNNMpTKdXG0K01ECGmtAjoWY8VH2utNCSDP+2XAvXmvrmdflqSzypjxh6f7nR2u+pW
 aeq45d5Ul158tmNd2QUug==
UI-OutboundReport: notjunk:1;M01:P0:WkHOOnT8+z0=;2NdNHlei822+wA+eomjcFmaQier
 9moxDYZVe8NzCkUjDSkMS05zqYoeGpu/njWykVzuK8ejgDaWdkLi6M3pwOeyHvX7ecfWQPlkp
 6pS8mfnktiQxiZddBxfSJkDFWWrGoaUhO8IufJ/CflqsVkNIXmL0nm02oRHjOQPlUCKVq0ULl
 L1oeY3ruA7s5f8uneID/Z4ZrsIweMG2xuDNjFQjRrnZ86qD34fYe0NHsBCK1r77xSRw0inrH5
 oGdFaB/5fVTzVnjyL/le91UaX1Bi8975QEATOOgbBSpu6Dml0q/iwwwKsAcVniLkkqoNFt31H
 C4xtJrSO3OPNk6LSXdQqDhbYNCNhh4sR8rrTrNvmEP9/Rdy/Kq6P3nh6YBGh5vrU81WIgY8xp
 FiWynVpAg+kShMjjWq8GhnY3/BuhwXi7jL2yXzeFC9136N1PNNtZiBV8Ms9WGeVv/YxnhXQUM
 Zd79ZpyRD8tI+XXU7G/P2EE0CfuYsVd6KopU60IRtr5P8vO2/R1DHlHjVpmZ6UzkB0FSokfiY
 47hxSRHpp2WICTv50Lg87BQOmMlnETUByIwuX2JUPgPCPt4CjccUAwr6zHapkwv/2gJQbYPKm
 Wba1qQk3qQsU0dpUYkpeYz5Pr0nujtKKYmlrIKbjcMNJoYXJPp+T5S/8ppxds2EGCPLEnWIBA
 lYjJHCHpRSBrnQPwL1Pb6E2j0HZXtg3UbwulqRwYjh/k5sEyDXOMOmUkY2YZrIIgWJHzqVJPK
 xOec8xclnVsCkMIx90Q5HPqmZzt7fjgkzUtna26e7o9rgSaJt8nzQ9CVO4CZZplnR54BkcQsH
 L4MK2dORsFDS7tXNXR85SxNEe6KZfZD/vYEceiYyngeiS+fo/+WW43gQoB1vEHEStyUmJ6+Z4
 HiUSxMiMcgudjz97vQlH8fQii9XfR5W5vB2Ehqgl4iEk65cOCwPoAmQ/knoE4C3rBSYPnqlwB
 Kc2OudzMkKz8WTrvDB9TgcnCTZ4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.06.23 um 10:54 schrieb Jeff King:
> On Sat, Jun 17, 2023 at 10:43:17PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Avoid the overhead of passing context to a callback function of
>> strbuf_expand() by using strbuf_expand_step() in a loop instead.  It
>> requires explicit handling of %% and unrecognized placeholders, but is
>> simpler, more direct and avoids void pointers.
>
> I like this. I don't care that much about the runtime overhead of
> passing the context around, but if you meant by "overhead" the
> programmer time and confusion in stuffing everything into context
> structs, then I agree this is much better. :)

Indeed, I meant the burden of being forced to define a struct and
filling in all necessary context.  Bureaucratic overhead.

> It does still feel like we should be handling "%%" on behalf of the
> callers.

I feel the same, but restrained myself from doing that, so that we
can see all the pieces for now.  It allows us to recombine them in
better ways than before.

>>  builtin/cat-file.c |  35 +++++++--------
>>  builtin/ls-files.c | 109 +++++++++++++++++++--------------------------
>>  builtin/ls-tree.c  | 107 +++++++++++++++++---------------------------
>>  daemon.c           |  61 ++++++++-----------------
>>  pretty.c           |  72 ++++++++++++++++++------------
>>  strbuf.c           |  20 ---------
>>  strbuf.h           |  37 ++-------------
>>  7 files changed, 169 insertions(+), 272 deletions(-)
>
> The changes mostly looked OK to me (and the diffstat is certainly
> pleasing). The old callbacks returned a "consumed" length, and we need
> each "step" caller to now do "format +=3D consumed" themselves. At first
> glance I thought there were cases where you didn't, but then I realized
> that you are relying on skip_prefix() to do that incrementing. Which
> makes sense and the resulting code looks nice, but it took me a minute
> to realize what was going on.

*nod*  The "returns consumed length" style is still used by
strbuf_expand_literal, though, so we have a bit of a mix.  Which
works, but a uniform convention might be better.

>> @@ -1894,7 +1880,26 @@ void userformat_find_requirements(const char *fm=
t, struct userformat_want *w)
>>  			return;
>>  		fmt =3D user_format;
>>  	}
>> -	strbuf_expand(&dummy, fmt, userformat_want_item, w);
>> +	while (strbuf_expand_step(&dummy, &fmt)) {
>> +		if (skip_prefix(fmt, "%", &fmt))
>> +			continue;
>> +
>> +		if (*fmt =3D=3D '+' || *fmt =3D=3D '-' || *fmt =3D=3D ' ')
>> +			fmt++;
>> +
>> +		switch (*fmt) {
>> +		case 'N':
>> +			w->notes =3D 1;
>> +			break;
>> +		case 'S':
>> +			w->source =3D 1;
>> +			break;
>> +		case 'd':
>> +		case 'D':
>> +			w->decorate =3D 1;
>> +			break;
>> +		}
>> +	}
>>  	strbuf_release(&dummy);
>>  }
>
> This one actually doesn't increment the format (so we restart the
> expansion on "N" or whatever). But neither did the original! It always
> returned 0:
>
>> -static size_t userformat_want_item(struct strbuf *sb UNUSED,
>> -				   const char *placeholder,
>> -				   void *context)
>> -{
>> -	struct userformat_want *w =3D context;
>> -
>> -	if (*placeholder =3D=3D '+' || *placeholder =3D=3D '-' || *placeholde=
r =3D=3D ' ')
>> -		placeholder++;
>> -
>> -	switch (*placeholder) {
>> -	case 'N':
>> -		w->notes =3D 1;
>> -		break;
>> -	case 'S':
>> -		w->source =3D 1;
>> -		break;
>> -	case 'd':
>> -	case 'D':
>> -		w->decorate =3D 1;
>> -		break;
>> -	}
>> -	return 0;
>> -}
>
> So probably OK, though a little funny.
>
> It also feels like this whole function would be just as happy using
> "strchr()", since it throws away the expanded result anyway. But that
> can be for another time. :)

Good idea!  And the conversion to a loop brings us halfway there.

>
>> @@ -1912,7 +1917,16 @@ void repo_format_commit_message(struct repositor=
y *r,
>>  	const char *output_enc =3D pretty_ctx->output_encoding;
>>  	const char *utf8 =3D "UTF-8";
>>
>> -	strbuf_expand(sb, format, format_commit_item, &context);
>> +	while (strbuf_expand_step(sb, &format)) {
>> +		size_t len;
>> +
>> +		if (skip_prefix(format, "%", &format))
>> +			strbuf_addch(sb, '%');
>> +		else if ((len =3D format_commit_item(sb, format, &context)))
>> +			format +=3D len;
>> +		else
>> +			strbuf_addch(sb, '%');
>> +	}
>
> This one doesn't advance the format for a not-understood placeholder.
> But that's OK, because we know it isn't "%", so starting the search from
> there again is correct.

Right.  This is copied from strbuf_expand.

>
>> @@ -1842,7 +1852,7 @@ static size_t format_commit_item(struct strbuf *s=
b, /* in UTF-8 */
>>  	}
>>
>>  	orig_len =3D sb->len;
>> -	if (((struct format_commit_context *)context)->flush_type !=3D no_flu=
sh)
>> +	if ((context)->flush_type !=3D no_flush)
>>  		consumed =3D format_and_pad_commit(sb, placeholder, context);
>>  	else
>>  		consumed =3D format_commit_one(sb, placeholder, context);
>
> Since we're no longer casting, the extra parentheses seem redundant now.
> I.e., this can just be context->flush_type.

Indeed.

Ren=C3=A9
