From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/25] isxdigit: cast input to unsigned char
Date: Thu, 16 Oct 2014 10:16:10 -0700
Message-ID: <xmqqwq80szol.fsf@gitster.dls.corp.google.com>
References: <20141015223244.GA25368@peff.net>
	<20141015223405.GB25630@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 19:16:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xeof0-0006yY-OA
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 19:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbaJPRQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 13:16:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751364AbaJPRQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 13:16:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD85613A3A;
	Thu, 16 Oct 2014 13:16:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TfcqYq3s8QgYe7xIR1Dgm+axi6U=; b=gW/ebS
	/NS4d7t4ejISftX7AGiYT6OTTGAU9JeHWHozlbJiEVEX5/Aa/8dv85fTEK9a5zaf
	Bu4dSgWe6xI07W16Ub/YyQf7axruFiWUDUOB3GaK20eEn5TuvZAesbNJxFCpaEg2
	Bw09EEmRvWCxSY5N9xQmN4NP9qFqmq93hJjx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LOO2z6O10y64f3Rl3endf+c6Mf/Kiyv2
	P38yuxK514N7H2QS9benwQd4uoHOX4tyn8IsZ1lLv0/4zc7fT+KY+w+geHJ26C8n
	hDr9YAs56o0BrpEIPUG1qolH+z8JKF6CqNBtRQ7scRissQD3RWyDxNs5fK+BJ0IT
	EOD0fF/55jU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C439213A38;
	Thu, 16 Oct 2014 13:16:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AA5013A37;
	Thu, 16 Oct 2014 13:16:12 -0400 (EDT)
In-Reply-To: <20141015223405.GB25630@peff.net> (Jeff King's message of "Wed,
	15 Oct 2014 18:34:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 20C3D774-5558-11E4-AB49-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Otherwise, callers must do so or risk triggering warnings
> -Wchar-subscript (and rightfully so; a signed char might
> cause us to use a bogus negative index into the
> hexval_table).
>
> While we are dropping the now-unnecessary casts from the
> caller in urlmatch.c, we can get rid of similar casts in
> actually parsing the hex by using the hexval() helper, which
> implicitly casts to unsigned (but note that we cannot
> implement isxdigit in terms of hexval(), as it also casts
> its return value to unsigned).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The patch that added more calls to isxdigit later in the series actually
> got reworked. So this is purely a cleanup and can be dropped if need be,
> though I still think it is an improvement.

Yes, thanks.

>
>  git-compat-util.h | 2 +-
>  urlmatch.c        | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index fb41118..44890d5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -677,7 +677,7 @@ extern const unsigned char sane_ctype[256];
>  #define iscntrl(x) (sane_istest(x,GIT_CNTRL))
>  #define ispunct(x) sane_istest(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
>  		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
> -#define isxdigit(x) (hexval_table[x] != -1)
> +#define isxdigit(x) (hexval_table[(unsigned char)(x)] != -1)
>  #define tolower(x) sane_case((unsigned char)(x), 0x20)
>  #define toupper(x) sane_case((unsigned char)(x), 0)
>  #define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
> diff --git a/urlmatch.c b/urlmatch.c
> index 3d4c54b..618d216 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -43,11 +43,11 @@ static int append_normalized_escapes(struct strbuf *buf,
>  		from_len--;
>  		if (ch == '%') {
>  			if (from_len < 2 ||
> -			    !isxdigit((unsigned char)from[0]) ||
> -			    !isxdigit((unsigned char)from[1]))
> +			    !isxdigit(from[0]) ||
> +			    !isxdigit(from[1]))
>  				return 0;
> -			ch = hexval_table[(unsigned char)*from++] << 4;
> -			ch |= hexval_table[(unsigned char)*from++];
> +			ch = hexval(*from++) << 4;
> +			ch |= hexval(*from++);
>  			from_len -= 2;
>  			was_esc = 1;
>  		}
