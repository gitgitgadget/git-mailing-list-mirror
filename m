From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] transport: Catch non positive --depth option value
Date: Tue, 19 Nov 2013 09:15:39 -0800
Message-ID: <xmqq61ro9utf.fsf@gitster.dls.corp.google.com>
References: <5283A380.9030308@gmail.com>
	<xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com>
	<528A9877.4060802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: =?utf-8?Q?Andr=C3=A9s_G=2E_Aragoneses?= <knocte@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 18:15:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Viotv-000896-VW
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 18:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab3KSRPn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Nov 2013 12:15:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab3KSRPm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Nov 2013 12:15:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17AF9518B2;
	Tue, 19 Nov 2013 12:15:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Uy+mF75kIUKS
	ZfIPVmb5XvGKjIs=; b=qNAqMOzAdEp9vgEXLUjA2LAAxZV1/ax46gVZkMLQ5sr9
	XKvuNnq3efLJGEeWKhmf/Go/DecZjdySbOy72U23PYIyab9P/bqd5N2cp/3+Jw1V
	d2mmUXplbzXRSJr1+e6+RUAqEB1yyAh9aQjoHHrGISv7zA8snJbD/2oCDQEqjGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=C3sUKU
	U/S0DbFF3VPv15ReWsVvRpwqBis/aaP1g942qgos4v7j6s6+pW3D1LPz5EVHLH4b
	1tuNY/v8Ukif8/e5Mkt2J+fyXZMu2U2EHjsdq3wIVaCBnafXs+VreviXKQGnWv6o
	i8/tNnKe66F58+hBSSjqZvgMikYFHTHaxFi9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05883518B1;
	Tue, 19 Nov 2013 12:15:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58E0D518B0;
	Tue, 19 Nov 2013 12:15:41 -0500 (EST)
In-Reply-To: <528A9877.4060802@gmail.com> (=?utf-8?Q?=22Andr=C3=A9s?= G.
 Aragoneses"'s message of
	"Mon, 18 Nov 2013 23:45:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 37975A44-513E-11E3-B6AE-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238031>

"Andr=C3=A9s G. Aragoneses" <knocte@gmail.com> writes:

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
> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> ---
>  transport.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/transport.c b/transport.c
> index 7202b77..edd63eb 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -483,6 +483,8 @@ static int set_git_option(struct
> git_transport_options *opts,
>              opts->depth =3D strtol(value, &end, 0);
>              if (*end)
>                  die("transport: invalid depth option '%s'", value);
> +            if (opts->depth < 1)
> +                die("transport: invalid depth option '%s' (non
> positive)", value);

"transport: depth option '%s' must be positive", perhaps?

>          }
>          return 0;
>      }

Linewrapped and whitespace damaged.
