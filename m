From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] t/gitweb-lib: Split HTTP response with non-GNU sed
Date: Tue, 24 Nov 2009 17:59:28 +0100
Message-ID: <200911241759.28972.jnareb@gmail.com>
References: <1258997622-62403-1-git-send-email-brian@gernhardtsoftware.com> <7vocmtyu3v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 18:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCykx-0002co-40
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 18:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933481AbZKXQ7h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2009 11:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933566AbZKXQ7g
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 11:59:36 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43141 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933574AbZKXQ7f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 11:59:35 -0500
Received: by bwz27 with SMTP id 27so6177282bwz.21
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 08:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=raUpF5W7QBGkHiCc4sYVehbqON1KPx/l3wlcOjRDKYc=;
        b=al7wewQIcdQOGihtHlyh4XDwxf3FdFOvaTus8Vevo5cyf9V+wkzESVHsf6eTSL5EDl
         81HQrJSTMLcwtkz5BPR0dZFRoPHhLbRx2Pkaj5qBfV6TP7mZjPwpCwsV+kvLeoh5jHkG
         M/OY/GhWTT6JQbRjcexD2ZEUdO2dXmTXJazgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GI5FI+jdtVZaxHQWVfSueINKAPaDO8oB67n4SzKa8waohMZ44XHwjzO/BoiaU87DtF
         BSij0ItY2syUC3MdHXR0jfD68A3/r/6mZ091MO71E0x8VePQnpHI3+pTBkk3+le9ALN8
         qDozrX+EhZctdayxzaEaIWqk9FwVokBhJfqb0=
Received: by 10.204.16.88 with SMTP id n24mr6468618bka.52.1259081979184;
        Tue, 24 Nov 2009 08:59:39 -0800 (PST)
Received: from ?192.168.1.13? (abwj137.neoplus.adsl.tpnet.pl [83.8.233.137])
        by mx.google.com with ESMTPS id 15sm1864518fxm.10.2009.11.24.08.59.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 08:59:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vocmtyu3v.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133581>

On Mon, 23 Nov 2009, Junio C Hamano wrote:
> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
>=20
> > Recognizing \r in a regex is something GNU sed will do, but other s=
ed
> > implementation's won't.  (Found with BSD sed on OS X.) So use a
> > literal carriage return instead.
[...]

> > diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
> > index 32b841d..35dda58 100644
> > --- a/t/gitweb-lib.sh
> > +++ b/t/gitweb-lib.sh
> > @@ -52,8 +52,8 @@ gitweb_run () {
> > =A0=A0=A0=A0=A0=A0=A0=A0rm -f gitweb.log &&
> > =A0=A0=A0=A0=A0=A0=A0=A0perl -- "$SCRIPT_NAME" \
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0>gitweb.output 2>gi=
tweb.log &&
> > -=A0=A0=A0=A0=A0=A0=A0sed -e =A0 '/^\r$/q' <gitweb.output >gitweb.h=
eaders &&
> > -=A0=A0=A0=A0=A0=A0=A0sed -e '1,/^\r$/d' <gitweb.output >gitweb.bod=
y =A0 =A0&&
> > +=A0=A0=A0=A0=A0=A0=A0sed -e =A0 '/^
> > $/q' <gitweb.output >gitweb.headers &&
> > +=A0=A0=A0=A0=A0=A0=A0sed -e '1,/^
> > $/d' <gitweb.output >gitweb.body =A0 =A0&&
> > =A0=A0=A0=A0=A0=A0=A0=A0if grep '^[[]' gitweb.log >/dev/null 2>&1; =
then false; else
> > true; fi=20
> > =A0=A0=A0=A0=A0=A0=A0=A0# gitweb.log is left for debugging

If we were to do it this way, I would prefer to set and then use=20
'cr' or 'crlf' variable (in sed expression).

>=20
> I'd actually prefer not having to deal with this issue.  How about do=
ing
> something like this instead?
>=20
>  t/gitweb-lib.sh |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
> index 32b841d..3121950 100644
> --- a/t/gitweb-lib.sh
> +++ b/t/gitweb-lib.sh
> @@ -52,8 +52,18 @@ gitweb_run () {
>  	rm -f gitweb.log &&
>  	perl -- "$SCRIPT_NAME" \
>  		>gitweb.output 2>gitweb.log &&
> -	sed -e   '/^\r$/q' <gitweb.output >gitweb.headers &&
> -	sed -e '1,/^\r$/d' <gitweb.output >gitweb.body    &&
> +	perl -w -e '

"perl", or "$PERL", or "$PERL_PATH"?

> +		open O, ">gitweb.headers";

Well, modern Perl would use here

+		open my $fh, ">", "gitweb.headers";

But it is not that important here.

> +		while (<>) {
> +			print O;
> +			last if (/^\r$/ || /^$/);
> +		}
> +		open O, ">gitweb.body";
> +		while (<>) {
> +			print O;
> +		}
> +		close O;
> +	' gitweb.output &&
>  	if grep '^[[]' gitweb.log >/dev/null 2>&1; then false; else true; f=
i
> =20
>  	# gitweb.log is left for debugging
>=20

This is a good solution.  We test Perl script anyway (so Perl is requir=
ed
for running this test), and this way we can do this portably and in one
pass (one fork).

--=20
Jakub Narebski
Poland
