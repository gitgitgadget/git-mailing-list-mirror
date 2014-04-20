From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] blame: use different blame_date_width for different locale
Date: Sun, 20 Apr 2014 14:40:23 -0700
Message-ID: <7vbnvvllx4.fsf@alter.siamese.dyndns.org>
References: <cover.1398010052.git.worldhello.net@gmail.com>
	<07e4dcdc98b5eb9c78b9ed53bf2adc3b33139b67.1398010052.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Brian Gesiak <modocache@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 23:39:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbzSP-0003o0-Ks
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 23:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbaDTVir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 17:38:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbaDTVip (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 17:38:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C20767E6A4;
	Sun, 20 Apr 2014 17:38:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AoeDCN9EM17KEWis6ibZtB6cIIY=; b=L9MKAU
	W0sE7eq8K+VuSYND4fnlM0w4XGcHnLo5MPLcG3VOG5028Ei2r9bogTxf4Elvl66e
	O0wJcfrRumRuK4wBDaXBPdsTP+YoJKnKIpOtiBOt+9MaLFxWHJlxkSeAxRiYa6Dp
	/ifPII47PguSCjsZhOgE+Zc/aPSK4JGvCUlsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V/OA2Owp1SF2Ss3fuAbeTsMPeltS0QIE
	Z4vIiskEaNse39/XDZo06PGkH4Mkz/NVe7uLoU0k7+HKOjX2LiwsYUVDvNSjXhve
	rjusqQd1uwybKHRt73dh7zTwJeAN1k8A9iAMLXC8RGaXHicHANnjpskaf5bwCJUS
	CfX49iZp1IE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A61027E6A3;
	Sun, 20 Apr 2014 17:38:44 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E5EC7E69F;
	Sun, 20 Apr 2014 17:38:42 -0400 (EDT)
In-Reply-To: <07e4dcdc98b5eb9c78b9ed53bf2adc3b33139b67.1398010052.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Mon, 21 Apr 2014 00:13:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 248B899E-C8D4-11E3-A6CC-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246588>

Jiang Xin <worldhello.net@gmail.com> writes:

> When show date in relative date format for `git blame`, the max display
> width of datetime is set as the length of the string "Thu Oct 19
> 16:00:04 2006 -0700" (30 characters long).  But actually the max width
> for C locale is only 22 (the length of string "x years, xx months ago").
> And for other locale, it maybe smaller.  E.g. For Chinese locale, only
> needs 16-character width.
>
> Set blame_date_width as the display width of _("4 years, 11 months
> ago"), so that translators can make the choice.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  builtin/blame.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 0a0a858..9350ea3 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2340,7 +2340,15 @@ parse_done:
>  		blame_date_width = sizeof("2006-10-19");
>  		break;
>  	case DATE_RELATIVE:
> -		/* "normal" is used as the fallback for "relative" */
> +		/* TRANSLATORS: what we care about is not the content itself,
> +		   but the display width of this string.  We use the width of
> +		   the string as the max width of the datetime in relative
> +		   format.  For English and many other languages, "4 years,
> +		   11 months ago" is the longest one among "89 seconds ago",
> +		   "89 minites ago", "35 hours ago", "13 days ago", "10 weeks
> +		   ago", "in the future" and many others. */
> +		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /* add the null */
> +		break;


This is not wrong per-se, but I am not sure if translators would
understand that "years and months ago" may not be the longuest
variant for their language and they are asked to use "89 seconds
ago" if the translation of that is longer than the translation for
"4 years, 11 months ago" in their language, with the given
explanation.

How about dropping the second sentence "We use..." and end the
comment with something like:

	ago", "in the future" and many others.  It is possible that
	the translation of "89 seconds ago" may be the longest
	possible translation in your language (then by definition,
	it would be longer than the translation of this string in
	your language), and in such a case, please write the
	translation of "89 seconds ago" here.

Actually, even though "many others" is correct, the possibilities
are within a bounded set of template i18n formats, no?  I wonder if
it would be nicer to the translators if we did not use a single
"representative string" here, but add a helper function to date.c
that goes something like:

    int date_relative_maxwidth(void)
    {
        struct strbuf buf = STRBUF_INIT;
        static int length;

        if (length)
            return length;

        strbuf_addf(&buf, _("in the future"));
        length = (length < buf.len) ? buf.len : length;
        strbuf_addf(&buf, Q_("%lu second ago", "%lu seconds ago", 89), 89);
        length = (length < buf.len) ? buf.len : length;
        ...
        strbuf_addf(&buf, Q_("%lu year ago", "%lu years ago", 9999), 9999);
        length = (length < buf.len) ? buf.len : length;

        return length;
    }

immediately after the definition of show_date_relative() and used it
in this codepath?

Of course, given a date that is far enough into the future, the
actuall length is unbounded, so this approach will not come up with
the absolute minimum width to align all lines (you would need to do
a two pass, measuring how wide all timestamps that would appear in
the output before producing the first line of the output---but I do
not think it is worth it, and as long as we do not overflow the
buffer, showing occasional misalignment for a line that came from
year 27342 is much better than a worse latency-to-first-output).

>  	case DATE_LOCAL:
>  	case DATE_NORMAL:
>  		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
