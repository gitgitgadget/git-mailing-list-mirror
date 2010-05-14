From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 3/7] grep: --count over binary
Date: Fri, 14 May 2010 13:34:24 +0400
Message-ID: <20100514093424.GA6212@dpotapov.dyndns.org>
References: <4BEC6211.2000309@lsrfire.ath.cx>
 <4BEC62F6.9050602@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Phil Lawrence <prlawrence@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri May 14 11:34:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrHx-0008Fg-2c
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab0ENJec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 05:34:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35351 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab0ENJea (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:34:30 -0400
Received: by fxm6 with SMTP id 6so1261383fxm.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RfqC34F2kOk1iGjchMZCCkjy6mH/1uP95CSXf8faCuQ=;
        b=Dw8XZsYMiwx47dqqsc/Xs61FghgHBA/nCM0fqxO/E+eYAxhU31m5l7HVa32zRvYagq
         JRdJpIHqBCXluAQ8niIBA/++ht7puSio4BpK8qrQnKs+TCm/lDG4bmqJRDrxcr/AMUBp
         /zzawl1eCeYhcjQzUytaV4Skd8VgAojiEvYjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=x4+m/BHFitPkrukeOTBnIM1byzk+O2ofioTvcws/sP0lmJ4x5HS5k7Z9oDwmVNzp2q
         wj7P2R6eV/Ve3npJ8qrVyvq/HgijguitdyvT7LMGfMyUAq1OEfCipCQzqBmkhrbRRcQG
         CGPWEizuEQmuZEHq3q6cFabxLZQW+h+AlV7HU=
Received: by 10.223.35.12 with SMTP id n12mr1294540fad.35.1273829668846;
        Fri, 14 May 2010 02:34:28 -0700 (PDT)
Received: from localhost (ppp85-140-167-195.pppoe.mtu-net.ru [85.140.167.195])
        by mx.google.com with ESMTPS id u12sm10096049fah.16.2010.05.14.02.34.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 02:34:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BEC62F6.9050602@lsrfire.ath.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147057>

On Thu, May 13, 2010 at 10:37:10PM +0200, Ren=E9 Scharfe wrote:
> The intent of showing the message "Binary file xyz matches" for
> binary files is to avoid annoying users by potentially messing up
> their terminals by printing control characters.  In --count mode,
> this precaution isn't necessary.
>=20
> Display counts of matches if -c/--count was specified, even if -a
> was not given.  GNU grep does the same.

It is also not necessary with '-l' and '-L' options. (At least, if
we follow GNU grep).

> --- a/grep.c
> +++ b/grep.c
> @@ -802,7 +802,7 @@ static int grep_buffer_1(struct grep_opt *opt, co=
nst char *name,
> =20
>  	switch (opt->binary) {
>  	case GREP_BINARY_DEFAULT:
> -		if (buffer_is_binary(buf, size))
> +		if (!opt->count && buffer_is_binary(buf, size))
>  			binary_match_only =3D 1;

So, I believe it should be:

		if (!opt->count && !opt->name_only && !opt->unmatch_name_only &&
				buffer_is_binary(buf, size))


Dmitry
