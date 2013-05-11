From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-bzr: Do not use unportable sed "\+"
Date: Sat, 11 May 2013 11:52:33 -0700
Message-ID: <7vwqr5wdqm.fsf@alter.siamese.dyndns.org>
References: <201305111525.53130.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: felipe.contreras@gmail.com, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 11 20:52:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbEuO-0004QW-RR
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 20:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab3EKSwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 May 2013 14:52:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976Ab3EKSwg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 May 2013 14:52:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A2B41E3CF;
	Sat, 11 May 2013 18:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aLRIHlQk49gE
	RaQ6/bmLbLDdR74=; b=OFrVmlTZN2Zbr06yR80a0Pu1Q4dYP7/LQQM67s9F49eB
	cBLwqp27CgSyxGkwP0g9HcetXQ8lUK9awtOY6DXFz/w2Asfn5wzGVewth5eEtIMJ
	47gcj9uq9FPSltKBa/aQpK3nIXhMiFXc5HLwyFX9n+71rZYGQtUvIcS3I4dxtJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lxXnr4
	YpUf0wDIqXcNPKNzf00THJg3Q/L91NS24XwdTVyv2rCsXpZS27U10FGzBwqWki2h
	oqQ2JELltiAmnwIhWEd0oWpvkh1p8H+Z7UxVtWzrf22rDn/GPmpV/Rraq9vJJJnH
	XgDvNkOcb1HwZxkSPGB4KvF2AYy70JpWE6p6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7785A1E3CD;
	Sat, 11 May 2013 18:52:35 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D00A01E3C8;
	Sat, 11 May 2013 18:52:34 +0000 (UTC)
In-Reply-To: <201305111525.53130.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Sat, 11 May 2013 15:25:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F16391E6-BA6B-11E2-926C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224001>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Using sed -e '/[0-9]\+//' to find "one ore more" digits
> is not portable.
> Use the Basic Regular Expression '/[0-9][0-9]*//' instead
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

Thanks.  Is there another one in t/t5551-http-fetch.sh that checks
the tags?

> ---
>  contrib/remote-helpers/test-bzr.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-help=
ers/test-bzr.sh
> index d9c32f4..5dfa070 100755
> --- a/contrib/remote-helpers/test-bzr.sh
> +++ b/contrib/remote-helpers/test-bzr.sh
> @@ -328,7 +328,7 @@ test_expect_success 'strip' '
> =20
>    echo four >> content &&
>    bzr commit -m four &&
> -  bzr log --line | sed -e "s/^[0-9]\+: //" > ../expected
> +  bzr log --line | sed -e "s/^[0-9][0-9]*: //" > ../expected
>    ) &&
> =20
>    (cd gitrepo &&
