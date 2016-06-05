From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] regex: fix a SIZE_MAX macro redefinition warning
Date: Sun, 5 Jun 2016 09:15:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606050815360.4250@virtualbox>
References: <575212DF.90209@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 09:15:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9SHh-0007l6-Bu
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 09:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbcFEHPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 03:15:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:56950 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbcFEHPj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 03:15:39 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MNq8p-1b6QH50s5D-007UOx; Sun, 05 Jun 2016 09:15:28
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <575212DF.90209@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:jCahCtg4mWLKi4kfiQl/LGlPN8/qPJsbpZPach77AgBKsag00Qg
 7R9Uw9rcDQWubGCnc3Ig0UbgV9Ot3UoFV3YkXnSdrAvBzvbXuZpnEP8aWxdAysB5DfgM+Bh
 DiTrSZLqVQ4SwS8tM8KYmccIeoovAy76bDcWt5K3m3j3hDAyR9wu8n/NzcuJIppDh2vX5sb
 JvPgGKsI/T8MIxBm3+U2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vdVuc5M8eG8=:S/iNPDXVxCvH0PUgbiKxyR
 ix0Vd27rWndFejqSCtZ06TmAZpIiIOb/QCXQn9ZmDXqaFFailJT8Fp55VZ81+0LGzukQfanKS
 Z7oOiSsAwWaPfU02P4UeOmTZnuwbQjpj8IZj+gV7/1HUV4/T7O+kKvVTIOwirJdGN7ufnmKlJ
 b3NpxTMIDHuRiG6NQDaJGpTO9E1I8pJ9ulMR8TDe77uHz8X32lDKTQ9gLo1y5YW9cRCaQiQf4
 yB9iyHhlx+n5Pv6pJUps+MTBhce0x+x8r+4umHJXRyYC7qDpPnqPA7UyerHaPPB2wgiOdzl0E
 vE2WmVa6QkcrmCkG5GXlJKp/9Hu3EQXocpEA9DoJ2PF8EXP/89CHqykQq18cDaRYWKbkdAfvb
 X/nME6wME/kbNAovXxfW4DXK9Z13TNeA1FrZSUt+JDPP7S1clw56rcJtSQdbnsmhJSUzXS2Gk
 BHu32xzA3IOJta8nwvHa/Lgk+67ZSTr6WoNp+7d5STynOYpALz+NKrAoLckgk7Y91/Trw2xY0
 xnzi6jWLoU3+eK2i6mzpxLLhhEZRm2iJ4oplU6V81D/kRwS93d8gbTZHr66HDJzS4/m3239YT
 W3reR5x1SnqYo6bgRMHB9gnnd1DVLKm2LzcFYdqlFWvJUI0cV4HRXohODHtwxiBzy8h2eH3+f
 TF/hh7eLz3xKx1xcyeoJoAKdQM/Ku+GImHwBldoqcPYGXkvcqxQJEtgZTAf7QbUceeJN0K6/R
 eQzNCTiNcmVLU0h092o441Ao9BVIRlOZ0J20sO5BLUE626duro62HSqO4MA9NlGE3bl4biqX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296469>

Hi Ramsay,

thanks for working on this!

On Sat, 4 Jun 2016, Ramsay Jones wrote:

> diff --git a/Makefile b/Makefile
> index 0d59718..3f6c70a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1987,7 +1987,7 @@ endif
>  
>  ifdef NO_REGEX
>  compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
> -	-DGAWK -DNO_MBSUPPORT
> +	-DGAWK -DNO_MBSUPPORT -DHAVE_STDINT_H

Maybe a comment here, something like "the fallback regex implementation
*requires* stdint.h"?

Other than that, I think this patch is an improvement.

Thanks again,
Dscho
