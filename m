Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C0AC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3909F20776
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zm1ibYqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDWU3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:29:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50612 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWU3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 16:29:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EF914CB5D;
        Thu, 23 Apr 2020 16:29:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RXU6/nJKNSYW
        c9cfRIMKSv2nUZY=; b=Zm1ibYqUUhRKlqXpF6lX40IfGZ+iRC5Otl1GlJlpHBdW
        TsHGA2kLH6/RRj7tFw8dKLJiSeQTifaozrSYAwbbUqll7aaZ+4dG73N0+XnVRpkK
        IgACEoFsqcA+BevypTuUQd3PJEjM3mn0TgpnOmWHBy5Rqbvk+f+ILnGbqAePbUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RUfwdo
        QrXmXpt8PxNuvROKN6suMZtUpGatd76Ip0mobjTRuqrEfnr0vn3kv13APN1wLE0U
        5Vid7O3KaUzuKCKySIDeISv1F+7vuPPzwaMQ0wlUPDwfZ2lcobj/r8wJfrIP8tAl
        UyUXApkBn9hWkOwgI3QaD+86AMmFW3VW3bHXo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9444E4CB5C;
        Thu, 23 Apr 2020 16:29:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5CE34CB5B;
        Thu, 23 Apr 2020 16:29:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 3/4] date.c: skip fractional second part of ISO-8601
References: <cover.1586856398.git.congdanhqx@gmail.com>
        <cover.1587644889.git.congdanhqx@gmail.com>
        <8b18d0ee5d6f08394e54e16ca7618c687791a509.1587644889.git.congdanhqx@gmail.com>
Date:   Thu, 23 Apr 2020 13:29:21 -0700
In-Reply-To: <8b18d0ee5d6f08394e54e16ca7618c687791a509.1587644889.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Thu, 23 Apr
 2020 20:52:40 +0700")
Message-ID: <xmqqv9lqeyji.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1D6EBB5A-85A1-11EA-B2F5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> -		if (num3 < 0)
> +		if (num3 < 0) {
>  			num3 =3D 0;
> +		} else if (*end =3D=3D '.' && isdigit(end[1]) &&
> +			   tm->tm_year !=3D -1 && tm->tm_mon !=3D -1 && tm->tm_mday !=3D -1=
 &&
> +			   set_time(num, num2, num3, tm) =3D=3D 0) {
> +			/* %Y%m%d is known, ignore fractional <num4> in HHMMSS.<num4> */
> +			strtol(end + 1, &end, 10);
> +		}
>  		if (set_time(num, num2, num3, tm) =3D=3D 0)

Hmmm. =20

While calling set_time() on the same 4-tuple might be idempotent
when it succeeds, the call with a potential new side effect in the
conditional part leaves a bad taste in my mouth.

I am wondering if the follwoing would be a more readable
alternative.

 date.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index f5d5a91208..3eb9b6032c 100644
--- a/date.c
+++ b/date.c
@@ -572,8 +572,16 @@ static int match_multi_number(timestamp_t num, char =
c, const char *date,
 	case ':':
 		if (num3 < 0)
 			num3 =3D 0;
-		if (set_time(num, num2, num3, tm) =3D=3D 0)
+		if (set_time(num, num2, num3, tm) =3D=3D 0) {
+			/*=20
+			 * Is the "HH:MM:SS" we just parsed followed by
+			 *  ".<num4>" (fractinal second)?  Discard it
+			 * only when we already have YY/MM/DD.
+			 */
+			if (*end =3D=3D '.' && isdigit(end[1]) && date_known(tm))
+				(void) strtol(end + 1, &end, 10);
 			break;
+		}
 		return 0;
=20
 	case '-':
