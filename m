From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Wed, 13 Mar 2013 09:16:41 -0700
Message-ID: <7vehfj46mu.fsf@alter.siamese.dyndns.org>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
 <1363179556-4144-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tboegi@web.de, artagnon@gmail.com,
	robert.allan.zeh@gmail.com, finnag@pvv.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 17:17:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFoMZ-0007jc-3F
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 17:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043Ab3CMQQp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 12:16:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62933 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932145Ab3CMQQn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Mar 2013 12:16:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67974B699;
	Wed, 13 Mar 2013 12:16:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dJIf/Hi1CVbO
	rTFo3LIHEZyOPgw=; b=K5j1i2A09X784myR5Tj74zEcRTDsYA9QtOHxLikF/veB
	UbLglIuSklsL5xLEmeD/hh3RusbvXmcNao8xHlMpnstvsN3xZWH675rXfzWt2hT4
	DanzNIuptuN4bt15Rusgmoaqr35b0hwf3zeSBpANhCQroGj5dAVcIePmYJb1aEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wNVuB1
	WJVbCC0o/bCFSaJs6dPieBFRLbAaTQLwWKlOB60Q2csKv3I2ghAUqRtMKmgFofzK
	l5AIGMyizNtAJxuWmr83zpBcGDNGXVOWTKGKCc7SNyCFjBwAhVlYCFoOMEvWFfMH
	3AmJDdOsNwg4oxTO5+j7TAj+k9b8ycEiETDAI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C2B6B697;
	Wed, 13 Mar 2013 12:16:43 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95FEBB696; Wed, 13 Mar 2013
 12:16:42 -0400 (EDT)
In-Reply-To: <1363179556-4144-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 13 Mar
 2013 19:59:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64A5BB58-8BF9-11E2-92BC-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218063>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index bbba728..e91d06f 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -178,6 +178,10 @@ advice.*::
>  		the template shown when writing commit messages in
>  		linkgit:git-commit[1], and in the help message shown
>  		by linkgit:git-checkout[1] when switching branch.
> +	statusUno::
> +		If collecting untracked files in linkgit:git-status[1]
> +		takes more than 2 seconds, hint the user that the option
> +		`-uno` could be used to stop collecting untracked files.

It looks to me that the way this paragraph conveys information is
vastly different from all the others in the section.  The section
begins with "by setting their corresponding variables to false
various advice messages can be squelched; here are the list of
variables and which advice message each of them controls", so the
description should be in "variable:: which advice message" form.

The noise this introduces to the test suite is a bit irritating and
makes us think twice if this really a good change.

> diff --git a/wt-status.c b/wt-status.c
> index ef405d0..6fde08b 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -540,7 +540,16 @@ void wt_status_collect(struct wt_status *s)
>  		wt_status_collect_changes_initial(s);
>  	else
>  		wt_status_collect_changes_index(s);
> -	wt_status_collect_untracked(s);
> +	if (s->show_untracked_files && advice_status_uno) {
> +		struct timeval tv1, tv2;
> +		gettimeofday(&tv1, NULL);
> +		wt_status_collect_untracked(s);
> +		gettimeofday(&tv2, NULL);
> +		s->untracked_in_ms =3D
> +			(uint64_t)tv2.tv_sec * 1000 + tv2.tv_usec / 1000 -
> +			((uint64_t)tv1.tv_sec * 1000 + tv1.tv_usec / 1000);
> +	} else
> +		wt_status_collect_untracked(s);
>  }

This is not wrong per-se but it took me two reads to spot that this
is not "if advise is active, do the timer but do not collect;
otherwise do just collect as before".  I wonder if we can structure
the code a bit better to make the timing bit less loud.

>  static void wt_status_print_unmerged(struct wt_status *s)
> @@ -1097,6 +1106,15 @@ void wt_status_print(struct wt_status *s)
>  		wt_status_print_other(s, &s->untracked, _("Untracked files"), "add=
");
>  		if (s->show_ignored_files)
>  			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f=
");
> +		if (advice_status_uno && s->untracked_in_ms > 2000) {
> +			status_printf_ln(s, GIT_COLOR_NORMAL,
> +					 _("It took %.2f seconds to collect untracked files."),
> +					 (float)s->untracked_in_ms / 1000);
> +			status_printf_ln(s, GIT_COLOR_NORMAL,
> +					 _("If it happens often, you may want to use option -uno"));
> +			status_printf_ln(s, GIT_COLOR_NORMAL,
> +					 _("to speed up by stopping displaying untracked files"));
> +		}

"to speed up by stopping displaying untracked files" does not look
like giving a balanced suggestion.  It is increasing the risk of
forgetting about newly created files the user may want to add, but
the risk is not properly warned.

I tend to agree that the new advice would help users if phrased in a
right way.  Do we want them in COLOR_NORMAL, or do we want to make
them stand out a bit more (do we have COLOR_BLINK ;-)?
