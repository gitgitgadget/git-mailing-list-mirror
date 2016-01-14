From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0060: loosen overly strict expectations
Date: Thu, 14 Jan 2016 09:33:12 -0800
Message-ID: <xmqqziw8jcbr.fsf@gitster.mtv.corp.google.com>
References: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Blume <blume.mike@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 18:33:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJllx-0003FB-PH
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 18:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbcANRdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 12:33:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755652AbcANRdO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 12:33:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 155763AF4E;
	Thu, 14 Jan 2016 12:33:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HGdD/eoqEmuMypB/MAVXkXJTpZ4=; b=mqJ/0e
	8ZmlKM5YD6p1x6lkWDKot2pw7chEtrlG/xRyDwz9Lr1yMN6A5pDaJCVb/qGxXpa/
	UvzMdJoAryVIa/saZ7TurhTIKpGkgKLLvvW+i89o9WAI69p04nbpvgUxLlVjwT7H
	BufmsLwTxHEljlYYEmGuypit4wnrQ+NjWBHb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F9lca+AD3AKfuvMWaDO8BSkqGBheWPxw
	azG4nl7XiQ+o9yG0V758XhA0NdaN51F9v5l9/lwYG4ezgdKGoybwzOdp1ZDo+5DE
	Z8I1NHwmCkbc1lCxOROl5Gz03T57sDUz/yr1Hw5yuzqWVLlC51xX72A2uG6FKCui
	VjjviMKNzs4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CCE53AF4D;
	Thu, 14 Jan 2016 12:33:14 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7D64F3AF4A;
	Thu, 14 Jan 2016 12:33:13 -0500 (EST)
In-Reply-To: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 14 Jan 2016 07:48:27 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3692282-BAE4-11E5-B437-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284072>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The dirname() tests file were developed and tested on only the five
> platforms available to the developer at the time, namely: Linux (both 32
> and 64bit), Windows XP 32-bit (MSVC), MinGW 32-bit and Cygwin 32-bit.
>
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/basename.html
> (i.e. the POSIX spec) says, in part:
>
> 	If the string pointed to by path consists entirely of the '/'
> 	character, basename() shall return a pointer to the string "/".
> 	If the string pointed to by path is exactly "//", it is
> 	implementation-defined whether "/" or "//" is returned.
>
> The thinking behind testing precise, OS-dependent output values was to
> document that different setups produce different values. However, as the
> test failures on MacOSX illustrated eloquently: hardcoding pretty much each
> and every setup's expectations is pretty fragile.
>
> This is not limited to the "//" vs "/" case, of course, other inputs are
> also allowed to produce multiple outpus by the POSIX specs.
>
> So let's just test for all allowed values and be done with it. This still
> documents that Git cannot rely on one particular output value in those
> cases, so the intention of the original tests is still met.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Sounds sensible.  Thanks.

This is not a problem with this patch, but the resulting
basename_data[] array seems to test "C:/usr" going to "usr" twice
under _MSC_VER or __MINGW32__.

Also...

> -#if defined(__MINGW32__)
> -	/* the following is clearly wrong ... */
> -	{ "C:",              "."      },
> -#endif
> -
> -#if defined(_MSC_VER)
> -	{ "C:",              "C:."    },
> -#endif
> -
> -#endif
> +	{ "C:",              "C:.", "." },
>  #endif

"C:" is still allowed to go to "."; is it still "clearly wrong",
or do we have a reason why we think it is not wrong at all?

I think the comment was written by Ramsay and also suspect that you
did not specifically agree or disagree with that particular
decision, so I'd understand if you do not have a strong opinion
either way, but I'd like to hear from Ramsay.  Perhaps earlier we
thought it was clearly wrong but we no longer do?
