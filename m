From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: allocate enough space when strbuf_setlen() is
 called first time
Date: Tue, 26 Apr 2011 08:25:19 -0700
Message-ID: <7v7hahghls.fsf@alter.siamese.dyndns.org>
References: <1303820660-744-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 17:25:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEk8y-0000xH-Av
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 17:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538Ab1DZPZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 11:25:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab1DZPZe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 11:25:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 99C7C42A6;
	Tue, 26 Apr 2011 11:27:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OK52AC+AFWMr
	ThTmXMmFm567neI=; b=Wd/mILG+PVl8Y2+Gbn44Z5Galwes3URLstgd2Rp8HReh
	fPDGbK26p7cPesgtUckgiv2oLymD7DANd6U3P0rjfgmGcKDTnHfatilhgW57VOgl
	r5wppv2zI3glxhwPMbmrIRTwfJG338vkT09s6rDQ/RZktdsoJhxHrg9EKj0NEec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ncma4w
	KLOAagLw4zx8RSA83DCl26pQXawzhVqz7up8AcemWhxnHtaE3SkjIYFVvjmAfyR8
	8/QPcjdqn8XSF+xi2PvfdbTUwuEP024nhDhVKAiK4CSeTEByU/U4L9fur/rHto6E
	NXFC+L8u+e6qg5woWB8H6hJqnJAwMMBNwrm9M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78AF642A4;
	Tue, 26 Apr 2011 11:27:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 976EB42A3; Tue, 26 Apr 2011
 11:27:23 -0400 (EDT)
In-Reply-To: <1303820660-744-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpCU5n4buNYw==?= Duy"'s message of "Tue, 26 Apr
 2011 19:24:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0D1F6A2-7019-11E0-B9FF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172099>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> strbuf_grow(sb, 0) may allocate less than requested len and violate t=
he
> next assertion.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  strbuf.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/strbuf.h b/strbuf.h
> index 07060ce..ab213da 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -34,7 +34,7 @@ extern void strbuf_grow(struct strbuf *, size_t);
> =20
>  static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
>  	if (!sb->alloc)
> -		strbuf_grow(sb, 0);
> +		strbuf_grow(sb, len);
>  	assert(len < sb->alloc);

This looks so obviously correct that it is scary.

How could 60 callsites of this function manage to have run without cras=
hes
so far?  They all happen to use the function on a buffer that already h=
as
something on it?

Well spotted, thanks.
