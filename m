From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] transport: Catch non positive --depth option value
Date: Thu, 21 Nov 2013 12:18:00 -0800
Message-ID: <xmqq1u294ih3.fsf@gitster.dls.corp.google.com>
References: <5283A380.9030308@gmail.com>
	<xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com>
	<528A9877.4060802@gmail.com>
	<xmqq61ro9utf.fsf@gitster.dls.corp.google.com>
	<528E2660.6020107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: =?utf-8?Q?Andr=C3=A9s_G=2E_Aragoneses?= <knocte@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 21 21:18:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjahm-00060S-U8
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab3KUUSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 15:18:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab3KUUSK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Nov 2013 15:18:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2173D54EE7;
	Thu, 21 Nov 2013 15:18:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=H91sJwjD/2Nj
	ctQz2po7OW2e1wE=; b=oUo1ARgeYnPDHdS69xJLlTLrXTFljHMvUiwIG5pGVVJ6
	dQmdZAsLtmzLGb4+dwJ0jpvFnAhD4ws/RjpQx45P+utnQhVItwG536Ke2Y9fPJJn
	bGqYIC/DtNh0+pPXl1gIXt7jJ/Ri8pZxUxYutbAUSOUj3ufY8HG3OiX8q0SP25o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nc4FhW
	4R3lR13H4Incg9azLg7q8Ht6TxOaKVAolfiJ2o5ih4xHGHoU4G3+2T/QAANq2azn
	qkzEBr6PV8AqDId7zUymNNchiPLjTgstlwTcxnZQyqX/YDA2T9+xUPu1cZa7WsHg
	M2qzSU7fs2KV3un1hbGLevtnAls2Z0jN+eAco=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1063A54EE4;
	Thu, 21 Nov 2013 15:18:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC03754EE2;
	Thu, 21 Nov 2013 15:18:08 -0500 (EST)
In-Reply-To: <528E2660.6020107@gmail.com> (=?utf-8?Q?=22Andr=C3=A9s?= G.
 Aragoneses"'s message of
	"Thu, 21 Nov 2013 16:27:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 099EB152-52EA-11E3-9DCE-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238139>

"Andr=C3=A9s G. Aragoneses" <knocte@gmail.com> writes:

> From 99e387151594572dc136bf1fae45593ee710e817 Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?Andr=3DC3=3DA9s=3D20G=3D2E=3D20Aragoneses?=3D <knoc=
te@gmail.com>
> Date: Wed, 13 Nov 2013 16:55:08 +0100
> Subject: [PATCH] transport: Catch non positive --depth option value
>
> Instead of simply ignoring the value passed to --depth
> option when it is zero or negative, now it is caught
> and reported.
>
> This will let people know that they were using the
> option incorrectly (as depth<0 should be simply invalid,
> and under the hood depth=3D=3D0 didn't have any effect).
>
> Signed-off-by: Andres G. Aragoneses <knocte@gmail.com>
> Reviewed-by: Duy Nguyen <pclouds@gmail.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>=20

I didn't exactly "review" this.

Have you run the tests with this patch?  It seems that it breaks
quite a lot of them, including t5500, t5503, t5510, among others.

> ---
>  transport.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/transport.c b/transport.c
> index 7202b77..edd63eb 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -483,6 +483,8 @@ static int set_git_option(struct git_transport_op=
tions *opts,
>  			opts->depth =3D strtol(value, &end, 0);
>  			if (*end)
>  				die("transport: invalid depth option '%s'", value);
> +			if (opts->depth < 1)
> +				die("transport: invalid depth option '%s' (must be positive)", v=
alue);
>  		}
>  		return 0;
>  	}
