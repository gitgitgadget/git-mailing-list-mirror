From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import.c: Silence build warning
Date: Mon, 31 Aug 2009 16:42:48 -0700
Message-ID: <7vfxb7y2h3.fsf@alter.siamese.dyndns.org>
References: <d2e97e800908310421u7de8ae58o361bd64a026384bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 01:43:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiGWf-00049e-Rb
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 01:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbZHaXm4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2009 19:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbZHaXm4
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 19:42:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbZHaXm4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2009 19:42:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 995363E28F;
	Mon, 31 Aug 2009 19:42:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=L3lDGTlRvWTxr6dUImI1txxxz
	dM=; b=gW3GIkwQCKF73UqTvkbum8vEgUtob9ZhJMTG/Cw7M6AqGhyp12Vfbeetc
	ae37yulaw81RWBegXPcDGOGBwMUV+KfFGlnXidkQ418fD3DAhoYzRXJDHnlrwjTO
	VDrlkaqDh5dvlQZWjuOcQaOSOL3YhciJ0Iyb0g7rvUx79vc1BQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=uqCxWmAbPJOtrI/Q8Kb
	FnGeA2/aczJFpwnz6U/2KgRUKI/fKmquCsCO/MTL+rUOem2yXyeJSjPLeptC3uRC
	Q+d72AqjrQhkUv3BihKgBnHMkzH9yFwJkHneOYK5+7VIj2SKU5Lzft61H2nuBAv6
	N8CAaFV3Zb1U/RSjbnyPlTFc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B8913E28E;
	Mon, 31 Aug 2009 19:42:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3EFAA3E28C; Mon, 31 Aug 2009
 19:42:49 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02373D80-9688-11DE-8B2B-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127509>

Michael Wookey <michaelwookey@gmail.com> writes:

> gcc 4.3.3 (Ubuntu 9.04) warns that the return value of strtoul() was =
not
> checked by issuing the following notice:
>
>   warning: ignoring return value of =E2=80=98strtoul=E2=80=99, declar=
ed with attribute
> warn_unused_result
>
> Provide a dummy variable to keep the compiler happy.
>
> Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
> ---
>  fast-import.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index 7ef9865..1386e75 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1744,10 +1744,11 @@ static int validate_raw_date(const char *src,
> char *result, int maxlen)
>  {
>  	const char *orig_src =3D src;
>  	char *endp;
> +	unsigned long int unused;
>
>  	errno =3D 0;
>
> -	strtoul(src, &endp, 10);
> +	unused =3D strtoul(src, &endp, 10);

Isn't this typically done by casting the expression to (void)?

Otherwise a clever compiler has every right to complain "the variable
unused is assigned but never used."
