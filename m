From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 2/3] gitweb/gitweb.perl: remove use of qw(...) as parentheses
Date: Sat, 19 Feb 2011 16:54:41 +0100
Message-ID: <201102191654.41601.jnareb@gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com> <1298129262-10468-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 16:55:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqp9F-0003s3-AE
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 16:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780Ab1BSPyv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 10:54:51 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40801 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742Ab1BSPyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 10:54:51 -0500
Received: by fxm17 with SMTP id 17so186115fxm.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 07:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=naVlUCa6L8Fi9nnra9n47gOcERQXskOL3rWmCEid3Oc=;
        b=gCcKec20PyainVsyS69AbosVAC1uSnKALL2OklhquD+J/NlpsdI9JglD6zXeg/dCLL
         7fIx/n2m1vodalUFNtlp07DuEDkeB5/6Nm7osnjwEW+MowKxqWJOzD1h18eRWixZUIww
         f9A1DI9q4Uf5R3PKLhEIH33sanh8ZfkDAwsBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZGSeUJOhvRui5fl2yDjEe0Uk/k1ruBgyQxNzsEXYGy/euI14gkSNPfLcMYpvkkJDKZ
         0kUhTk+voFh3zAeBooJUf3AqMV0hsplIB6y0BrIwEegK6MmlCKM39mI0Mosc0U69AQTt
         AMEwyJB7G0g7CCvYIMuugFbNh5EPvTo6Fvk8Y=
Received: by 10.223.79.14 with SMTP id n14mr2718742fak.19.1298130889859;
        Sat, 19 Feb 2011 07:54:49 -0800 (PST)
Received: from [192.168.1.13] (abwm176.neoplus.adsl.tpnet.pl [83.8.236.176])
        by mx.google.com with ESMTPS id z1sm1053357fau.45.2011.02.19.07.54.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 07:54:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1298129262-10468-3-git-send-email-avarab@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167293>

On Sat, 19 Feb 2011, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Using the qw(...) construct as implicit parentheses was deprecated in
> perl 5.13.5. Change the relevant code in gitweb to not use the
> deprecated construct. The offending code was introduced in 3562198b b=
y
> Jakub Narebski.

It is strange that Perl introduces such backwards incompatibile change
(well, actually will introduce, as 5.13.x is development branch leading
to future Perl version 5.14).

qw{} is described in perlop(1) as "word list" operator, so one would
suppose that it generates a list.
=20
> The issue is that perl will now warn about this:
>=20
>     $ perl -wE 'for my $i qw(a b) { say $i }'
>     Use of qw(...) as parentheses is deprecated at -e line 1.
>     a
>     b

Hmmm... does it affect only foreach loop, or dows it affect also other=20
places, like

      use POSIX qw( setlocale localeconv )
      @EXPORT =3D qw( foo bar baz );
=20
Both of those forms are used by gitweb:

      use CGI qw(:standard :escapeHTML -nosticky);

      map { $_ =3D> 'sh'  } qw(bash zsh ksh)
      my @navs =3D qw(summary shortlog log commit commitdiff tree);

[...]
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3501,7 +3501,7 @@ sub print_feed_meta {
>  			$href_params{'-title'} =3D 'log';
>  		}
> =20
> -		foreach my $format qw(RSS Atom) {
> +		foreach my $format (qw(RSS Atom)) {
>  			my $type =3D lc($format);
>  			my %link_attr =3D (
>  				'-rel' =3D> 'alternate',

I am not against futureproofing gitweb in above way for future
Perl 5.14.x

--=20
Jakub Narebski
Poland
