From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/3] t/gitweb-lib.sh: print to stderr when gitweb_run has errors
Date: Sat, 19 Feb 2011 16:46:00 +0100
Message-ID: <201102191646.02543.jnareb@gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com> <1298129262-10468-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 16:46:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqp0k-0007WQ-55
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 16:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785Ab1BSPqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 10:46:13 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60259 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746Ab1BSPqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 10:46:13 -0500
Received: by fxm17 with SMTP id 17so180436fxm.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 07:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Ae+w6sL3zWCEL3UiP5sfr8LG0rikX36R4j242y6xxjE=;
        b=s4mRFDi6KCESOnEfoW+h13N7yYDyB5MYv3tUQ1/YDN6AIwW1QruCjalMmf3ujhPbk8
         SvNxMk6Fr/eH64KK8+Ek4MYVg0qjYFnpAznoL0OAWn+nIlH9LjHF315+jSlutNyt1pcV
         whv0eNpLfs/d0k+xNUCCe/c7o/InkKBziKZjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RVq9ijNhyEAdrbcQI2d4WbzwY+IprVkNd1idlFqSL8QOQ6/EKE9r0nGtaDp7Kd9MB3
         MBzVvo4L6RBQHvvGFbTLkGCI/x+rz9BuUhJ/pJFN287yhY8CyPgaBFwpNX9P4cgHcfs8
         QH5CGJrh+lHZfePkWaDthJfR54fH5JmBi9Ko0=
Received: by 10.223.97.8 with SMTP id j8mr1336655fan.141.1298130371573;
        Sat, 19 Feb 2011 07:46:11 -0800 (PST)
Received: from [192.168.1.13] (abwm176.neoplus.adsl.tpnet.pl [83.8.236.176])
        by mx.google.com with ESMTPS id n3sm1602075fax.31.2011.02.19.07.46.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 07:46:10 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1298129262-10468-2-git-send-email-avarab@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167292>

On Sat, 19 Feb 2011, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> Change the gitweb_run test subroutine to spew errors to stderr if
> there are any, previously it would just silently fail, which made
> tests very hard to debug.
>=20
> Before you'd get this output, when running tests under `--verbose
> --immediate --debug`:

Which test?

[...]
> --- a/t/gitweb-lib.sh
> +++ b/t/gitweb-lib.sh
> @@ -82,7 +82,12 @@ gitweb_run () {
>  		}
>  		close O;
>  	' gitweb.output &&
> -	if grep '^[[]' gitweb.log >/dev/null 2>&1; then false; else true; f=
i
> +	if grep '^[[]' gitweb.log >/dev/null 2>&1; then
> +		cat gitweb.log >&2
> +		false
> +	else
> +		true
> +	fi

I don't understand this change.  Either it is not necessary, because
test suite (or at least t9500) has

  test_debug 'cat gitweb.log'

after each test, so that error messages would be printed with `--debug`=
,
or it doesn't go far enough: if the above is used then those test_debug
should be removed.

--=20
Jakub Narebski
Poland
