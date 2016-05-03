From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/41] builtin/fetch.c: use error_errno()
Date: Tue, 03 May 2016 12:22:15 -0700
Message-ID: <xmqqr3djlzfc.fsf@gitster.mtv.corp.google.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 21:22:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axfu0-0001qX-UA
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 21:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147AbcECTWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 15:22:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58264 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756032AbcECTWT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2016 15:22:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D1F521823A;
	Tue,  3 May 2016 15:22:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XuGOM3TXW2ts
	lB83ls78uSY3CzA=; b=DmDw8VGFXllFW0sMLyfTsujYLfiNg4oRxMlM3Flt73Rv
	ycqxTtyaNAp1YOWENwWaTX6t/p7M2z075hbQTYlJ+VFefgbSsQeE6RKyKf6K2C1z
	zuc3zu+NrYODcBr9nRC0cd4haeGJ6Tc37qGEMcMzZRHTklHnv2U4lkWQrmzIi2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=frQd6z
	uGbsbWCGECxjQw7gaRVc9c4/OiLY8QYCCHZsPLm4n5FEfdcdRWVJpi97E3FzsDEA
	ebfPiEy3DiDhQHfayR4DdPsZayPmdroS29LEW1HQgXGSos8dnPIspwSeIrNxVD/d
	1Ph2VRDrEdqM6q1ejRoZf01LaR0Ilgay3JZwU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C9AA518239;
	Tue,  3 May 2016 15:22:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3267218237;
	Tue,  3 May 2016 15:22:17 -0400 (EDT)
In-Reply-To: <1462277054-5943-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 3 May
 2016 19:03:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 59319A6E-1164-11E6-81AB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293442>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index f8455bd..1582ca7 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -607,7 +607,7 @@ static int store_updated_refs(const char *raw_url=
, const char *remote_name,
> =20
>  	fp =3D fopen(filename, "a");
>  	if (!fp)
> -		return error(_("cannot open %s: %s\n"), filename, strerror(errno))=
;
> +		return error_errno(_("cannot open %s"), filename);
> =20
>  	if (raw_url)
>  		url =3D transport_anonymize_url(raw_url);
> @@ -848,7 +848,7 @@ static int truncate_fetch_head(void)
>  	FILE *fp =3D fopen_for_writing(filename);
> =20
>  	if (!fp)
> -		return error(_("cannot open %s: %s\n"), filename, strerror(errno))=
;
> +		return error_errno(_("cannot open %s"), filename);
>  	fclose(fp);
>  	return 0;
>  }

Both of these original had unwanted \n at the end, and the updated
one loses them, which is good.
