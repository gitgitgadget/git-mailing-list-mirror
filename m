From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/41] builtin/mailsplit.c: use error_errno()
Date: Tue, 03 May 2016 12:48:43 -0700
Message-ID: <xmqqinyuncro.fsf@gitster.mtv.corp.google.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 21:48:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axgJS-0006Ut-16
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 21:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158AbcECTss convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 15:48:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752111AbcECTsr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2016 15:48:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D7D917895;
	Tue,  3 May 2016 15:48:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=J/l7csKf+znJ
	izCnHzKNbbrK/s4=; b=rOWyjrQJRhobVWBbKPuSV5T2yHboVU894hSjPnn7rMeu
	0yiK9VhsAKAqfEQ8Wf7o+a77Vr2JaSeL3rNtw5trDtKk3laH/Cbs8Ps8r19bG4++
	lr19kHmiT01Nb3Nvgn422KMCuTzYCb3fG9fRM/NbBQpe+PF+A9E6V24yb+eZFP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lp2MP+
	AnvJIkFyVglR36bQsq8OfXRqNdBgvbO5RCL4x4nBG7miQxs9kGnA6KDWHswMZDTg
	7YZ20EAP1ksjAnmSNFkVlqspN8hluvCoUGR7V66sdlkLba2Bx/eybhQ/JVacxiyw
	s3SrgHbOrEwGJhJeJOjUp9i93DhNEumKlRwwY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 050A117894;
	Tue,  3 May 2016 15:48:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55C6417893;
	Tue,  3 May 2016 15:48:45 -0400 (EDT)
In-Reply-To: <1462277054-5943-9-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 3 May
 2016 19:03:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0BCD3982-1168-11E6-BB9A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293445>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> -			error("cannot opendir %s (%s)", name, strerror(errno));
> +			error_errno("cannot opendir %s", name);
> -			error("cannot open mail %s (%s)", file, strerror(errno));
> +			error_errno("cannot open mail %s", file);
> -			error("cannot read mail %s (%s)", file, strerror(errno));
> +			error_errno("cannot read mail %s", file);
> -			error("cannot stat %s (%s)", arg, strerror(errno));
> +			error_errno("cannot stat %s", arg);

These all used to use its own formatting, but will use "<message>: <err=
no>"
format like everybody else, which is good.

> @@ -210,7 +210,7 @@ static int split_mbox(const char *file, const cha=
r *dir, int allow_bare,
>  	int file_done =3D 0;
> =20
>  	if (!f) {
> -		error("cannot open mbox %s", file);
> +		error_errno("cannot open mbox %s", file);
>  		goto out;
>  	}

It may be a bit unclear from the context, but it uses errno that was
set when fopen() returned a NULL.

The changes in this patch are not faithful conversion like other
patches, but they are all good, I would say.

Thanks.
