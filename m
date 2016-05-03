From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/41] builtin/pack-objects.c: use die_errno() and warning_errno()
Date: Tue, 03 May 2016 12:54:14 -0700
Message-ID: <xmqqeg9incih.fsf@gitster.mtv.corp.google.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 21:54:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axgOn-0000bX-V7
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 21:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbcECTyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 15:54:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751699AbcECTyS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2016 15:54:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F12D0186D2;
	Tue,  3 May 2016 15:54:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1gtWF2V3NDX6
	0aEhu8JBiI8HIes=; b=MVIqpP0nOxZPTAYdgBW4ZCLiaZDGjkI0KUe2utuVeELl
	rm+HBkMv6c843Uh74gsIRK1/db5ICP51Dfh6Z9d6ClqXgYEEgOhDRi0EnPsz2KZr
	ItBTzPM6exDAu71b/y7pK5PSsWxEYwDzyc9lpMx7HJSYFy3FKbhqRyyBu9gnIEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ya7ovS
	2xGgUEwwnKbdlFy5i+VXZyJxO4hm2Q0dlcdbqoR7sN12jiqXzBG1uDr+FWtxjTfb
	RVmxo9s7hkyMW7Ay9yWGxhbblmbAtzC2kKYRWJZdMw/OZFDSOz0iT9TGxah+G2ZH
	xk/HjCMQKbvLM9pfA94CigBaLXnbVnlwAtu6Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E6516186D1;
	Tue,  3 May 2016 15:54:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5571F186D0;
	Tue,  3 May 2016 15:54:16 -0400 (EDT)
In-Reply-To: <1462277054-5943-11-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 3 May
 2016 19:03:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D11786E8-1168-11E6-ADC2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293446>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

> @@ -2020,7 +2018,7 @@ static void ll_find_deltas(struct object_entry =
**list, unsigned list_size,
>  		ret =3D pthread_create(&p[i].thread, NULL,
>  				     threaded_find_deltas, &p[i]);
>  		if (ret)
> -			die("unable to create thread: %s", strerror(ret));
> +			die_errno("unable to create thread");

This deserves a mention in the log message.  pthread_create()
returns 0 on success and it returns "an error number" on error.  We
used to format that returned value with strerror().

I do not see anywhere in the updated code that copies ret back to
errno, which would mean die_errno() would use whatever happens to be
in errno, and the relationship between the returned value 'ret' and
the value that is in 'errno' at this point in the code is unclear to
me.
