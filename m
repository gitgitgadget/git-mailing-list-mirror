Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8728CC54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613D9206ED
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EnLEPxb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDWUSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:18:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62035 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWUSc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 16:18:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5867BCD1E2;
        Thu, 23 Apr 2020 16:18:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JJ9ktyLsiETp
        Rzu1UVqC3ERQf14=; b=EnLEPxb3VYPfIXqSFeLywcj25Korz/KZgPR4i+G1QA8T
        S/zDUu2HmKhYlEq37VHY4vblr186t0caC4zvrfS9tzEIIqYdMuRpiJj3nbab4KEQ
        OBZw/Zxq69NJWPHH4ksdmPdR9Kk8yMf3q9oNfDTjKb0oHqPE6UeCvZF1/xl2EtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=N54R7S
        n/1zSzzUFHmAEI183viXj8zeRw82ssvWOjKnOc12U6BjskpmJXZ+AgxdCN36+pNg
        pSaafOCn9Vp0eJSjNMu5Asdoe9EQN+CTn8rJSjTscZ8Jxlre0zC5woCGsZ3wLgal
        yE1LvineK7zZoogJEBifP2MaZgUb9/6JXnYk8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50C8BCD1E1;
        Thu, 23 Apr 2020 16:18:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8F2C3CD1E0;
        Thu, 23 Apr 2020 16:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 2/4] date.c: validate and set time in a helper function
References: <cover.1586856398.git.congdanhqx@gmail.com>
        <cover.1587644889.git.congdanhqx@gmail.com>
        <0d0e4d8edce37dfef13e573588f0c043ddf07f6a.1587644889.git.congdanhqx@gmail.com>
Date:   Thu, 23 Apr 2020 13:18:25 -0700
In-Reply-To: <0d0e4d8edce37dfef13e573588f0c043ddf07f6a.1587644889.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Thu, 23 Apr
 2020 20:52:39 +0700")
Message-ID: <xmqqzhb2ez1q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 977C3852-859F-11EA-899D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> In a later patch, we will reuse this logic, move it to a helper, now.
>
> While we're at it, explicit states that we intentionally ignore

"explicitly state", perhaps.

> old-and-defective 2nd leap second.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>  date.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/date.c b/date.c
> index b67c5abe24..f5d5a91208 100644
> --- a/date.c
> +++ b/date.c
> @@ -539,6 +539,22 @@ static int set_date(int year, int month, int day, =
struct tm *now_tm, time_t now,
>  	return -1;
>  }
> =20
> +static int set_time(long hour, long minute, long second, struct tm *tm=
)
> +{
> +	/* C90 and old POSIX accepts 2 leap seconds, it's a defect,
> +	 * ignore second number 61
> +	 */

	/*
	 * Style: our multi-line comments ought to be
	 * formatted like this.  Slash-asterisk that opens,
	 * and asterisk-slash that closes, are both on their
	 * own lines.
	 */

But I am not sure we want to even have a new comment here.  After
all we are extracting/reinventing exactly the same logic as the
original.  Why we allow "60" might be worth commenting, but if a
minute that has 62 seconds is a mere historical curiosity, then is
it worth explaining why "61", which we never even wrote in the code,
is missing from here?

> +	if (0 <=3D hour && hour <=3D 24 &&
> +	    0 <=3D minute && minute < 60 &&
> +	    0 <=3D second && second <=3D 60) {
> +		tm->tm_hour =3D hour;
> +		tm->tm_min =3D minute;
> +		tm->tm_sec =3D second;
> +		return 0;
> +	}
> +	return -1;
> +}

I am a bit surprised to see that you chose to unify with the "check
and set" interface of is_date (now set_date).  I was expecting to
see that we'd have "check-only" helper functions.

This is not a complaint, at least not yet until we see the result of
using it in new code; it may very well be possible that the "check
and set" interface would make the new caller(s) clearer.

>  static int match_multi_number(timestamp_t num, char c, const char *dat=
e,
>  			      char *end, struct tm *tm, time_t now)
>  {
> @@ -556,12 +572,8 @@ static int match_multi_number(timestamp_t num, cha=
r c, const char *date,
>  	case ':':
>  		if (num3 < 0)
>  			num3 =3D 0;
> -		if (num < 25 && num2 >=3D 0 && num2 < 60 && num3 >=3D 0 && num3 <=3D=
 60) {
> -			tm->tm_hour =3D num;
> -			tm->tm_min =3D num2;
> -			tm->tm_sec =3D num3;
> +		if (set_time(num, num2, num3, tm) =3D=3D 0)
>  			break;
> -		}
>  		return 0;

This caller does become easier to follow, I would say.  Nicely done.

>  	case '-':
