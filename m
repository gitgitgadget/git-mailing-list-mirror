From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] convert: Inhibit contraction of foreign $Id$ during
 stats.
Date: Thu, 01 Apr 2010 12:56:51 -0700
Message-ID: <7v634bosjg.fsf@alter.siamese.dyndns.org>
References: <cover.1269860022.git.grubba@grubba.org>
 <a75a46b1b6fdb9d52f608643676512e87474e16d.1269860022.git.grubba@grubba.org>
 <6d9d8b0eaa022f441c507b141ff0efa3f21d1988.1269860022.git.grubba@grubba.org>
 <74ce7980eb1fe629a651433ca9f1662f26495ce9.1269860022.git.grubba@grubba.org>
 <81e71814080d0eca72809a751e4e90026f8fe0ea.1269860022.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Henrik_Grubbstr=C3=B6m_=28Grubba=29?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Thu Apr 01 21:57:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxQVo-0008QW-6t
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 21:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758785Ab0DAT5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 15:57:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab0DAT46 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 15:56:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B91BA777A;
	Thu,  1 Apr 2010 15:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0o9X7Kv0qbqG
	dM5p19/sEuyITdw=; b=xN/3tt6BEWF4EERyhYnOIyoLCjtRxTCVlY+S+22VaIDY
	rgo/4LcuiVDU0k5h1ZF9k0PL0jz0ltrYH5wsKreQqFMpp1v4JTrB0GABvSxywS7O
	NwDoYCxxhDqe2tCofJ+0DXg2g9B+KhzII/ZGAeo7EbAgUh9rJVl2oElvZr7B/KU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R9+gnB
	kw7KfOStOSNOz7QwbQiuBG4lzPHXg4+gzZaBVFD1CEa+Y2fWC0HfWla9ZtyQI6FY
	hBVoKrO46TWt3H5350sN/0YdoKX4nRDEPe+LAQTWmCK7zdb3Udyr9/Umle65M8WW
	nRC1ozP3Vrx45I9EnBWfIOdyeBAWMrOblyV/E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D669AA7777;
	Thu,  1 Apr 2010 15:56:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 340D0A7775; Thu,  1 Apr
 2010 15:56:53 -0400 (EDT)
In-Reply-To: <81e71814080d0eca72809a751e4e90026f8fe0ea.1269860022.git.grubba@grubba.org>
 ("Henrik =?utf-8?Q?Grubbstr=C3=B6m=22's?= message of "Mon\, 29 Mar 2010
 13\:28\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B97281F2-3DC8-11DF-8001-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143744>

"Henrik Grubbstr=C3=B6m (Grubba)"  <grubba@grubba.org> writes:

> @@ -462,6 +463,20 @@ static int ident_to_git(const char *path, const =
char *src, size_t len,
>  				continue;
>  			}
> =20
> +			if ((identmode =3D=3D IDENT_MODE_KEEP_FOREIGN) && len > 5) {
> +				spc =3D memchr(src + 4, ' ', dollar - src - 4);
> +				if (spc && spc < dollar-1) {
> +					/* Foreign id.
> +					 * Contraction of these is inhibited
> +					 * during status operations to avoid
> +					 * all files containing such being
> +					 * marked as modified on checkout.
> +					 * cf sha1_file.c:index_mem().
> +					 */
> +					continue;
> +				}
> +			}

Somehow this feels to me that it is applying a band-aid to solve a prob=
lem
that does not exist, only because the second patch in this series to ke=
ep
the foreign one left expanded were not such a good change after all...
