Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A433CC54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82BF22082E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 17:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dQyMnnCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgDVRF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:05:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63233 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgDVRF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 13:05:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66B665B636;
        Wed, 22 Apr 2020 13:05:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7NZK1d4WRXn9
        4L33SOT5Dodh/bw=; b=dQyMnnCfpDE9Q6wfu7CLW6c8Sms1vRcY5QQbr7BvfY2e
        Q8XxtQLFPxvS6qbiBEe5MPp/xM9iqULP2SWoRTs9BBgrb0skmzd+XMhCA08Ih7oH
        JLCc5qo0O6hAhlt41xB69QTradoc0zF4iX5JcsKDXje9xTO69hXS/kXKtYl/n+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qrJWNo
        Xtr8tVkj6EQ4Zsd7SG1+NtTeXVDMDPdDzOsJ0S3UhXaou2jEmQ6shtoV/8fEmCUv
        +1gBr75AQ1AuINCzbzg7Ow4yh2RA5Pi4cdg9o1ZNvXeEQRYzxPGJ3KAI5huFHThi
        4AbG4e1x8L2Hvnsql5RzPjNezh3AF1arGWi2o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E2E25B635;
        Wed, 22 Apr 2020 13:05:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC21B5B634;
        Wed, 22 Apr 2020 13:05:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/2] date.c: skip fractional second part of ISO-8601
References: <cover.1586856398.git.congdanhqx@gmail.com>
        <cover.1587559135.git.congdanhqx@gmail.com>
        <c6d42785bb762f691b00c48b57c73a1933fadbc3.1587559135.git.congdanhqx@gmail.com>
Date:   Wed, 22 Apr 2020 10:05:54 -0700
In-Reply-To: <c6d42785bb762f691b00c48b57c73a1933fadbc3.1587559135.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Wed, 22 Apr
 2020 20:15:52 +0700")
Message-ID: <xmqqk127jvrh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8718FF3E-84BB-11EA-BDC9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>  	/* Time? Date? */
>  	switch (c) {
>  	case ':':
> -		if (num3 < 0)
> +		if (num3 < 0) {
>  			num3 =3D 0;
> +		} else if (*end =3D=3D '.' && isdigit(end[1]) &&
> +			   tm->tm_year !=3D -1 && tm->tm_mon !=3D -1 &&
> +			   tm->tm_mday !=3D -1) {
> +			/* Attempt to guess meaning of <num> in HHMMSS.<num>
> +			 * only interpret as fractional when %Y %m %d is known.
> +			 */
> +			strtol(end + 1, &end, 10);

OK, so we saw ':' and parsed <num2> after it, and then saw ':' and
<num3>, which we know is a good positive number.  We haven't checked
what <num2> is at this point, but it has to be 0 or more digits
(because we wouldn't have parsed for <num3> if it weren't terminated
with the same c, i.e. ':').

*end points at the byte that stopped <num3> and we make sure <num3>
is followed by "." and a digit.

Regardless of what <num2> is, we just discard the "fractional part
of seconds" (assuming that <num3> is the "seconds" part).

> +		}
>  		if (num < 25 && num2 >=3D 0 && num2 < 60 && num3 >=3D 0 && num3 <=3D=
 60) {
>  			tm->tm_hour =3D num;
>  			tm->tm_min =3D num2;

And after all that is done, if <num2> (and others) are within a
reasonable range, we use that as HH:MM:SS. =20

OK.  If <num2> (or <num3>, or even <num> for that matter) weren't
reasonable, is it still sensible to discard the fractional part?
The answer is not immediately obvious to me.

To be safe, it might make sense to extract a helper function from
the next conditional, i.e.

static int is_hms(long num1, long num2, long num3)
{
	return (0 <=3D num1 && num1 < 25 &&
		0 <=3D num2 && num2 < 60 &&
		0 <=3D num3 && num3 <=3D 60);
}

and use it in the new "else if" block like so?


	} else if (*end =3D=3D '.' && isdigit(end[1]) &&
		   is_date(tm->tm_year, tm->tm_mon, tm->tm_mday, NULL, now, tm) &&
		   is_hms(num, num2, num3)) {
		/* Discard ".<num4>" from "HH:MM:SS.<num4>" */
		(void) strtol(end + 1, &end, 10);
	}

	if (is_hms(num, num2, num3)) {
		...



> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index d9fcc829a9..80917c81c3 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -81,6 +81,8 @@ check_parse 2008-02 bad
>  check_parse 2008-02-14 bad
>  check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
>  check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
> +check_parse '2008.02.14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
> +check_parse '2008-02-14 20:30:45.019-04:00' '2008-02-14 20:30:45 -0400=
'
>  check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
>  check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
>  check_parse '2008-02-14 20:30:45 -5:' '2008-02-14 20:30:45 +0000'
> @@ -103,6 +105,7 @@ check_approxidate 5.seconds.ago '2009-08-30 19:19:5=
5'
>  check_approxidate 10.minutes.ago '2009-08-30 19:10:00'
>  check_approxidate yesterday '2009-08-29 19:20:00'
>  check_approxidate 3.days.ago '2009-08-27 19:20:00'
> +check_approxidate '12:34:56.3.days.ago' '2009-08-27 12:34:56'
>  check_approxidate 3.weeks.ago '2009-08-09 19:20:00'
>  check_approxidate 3.months.ago '2009-05-30 19:20:00'
>  check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00'
