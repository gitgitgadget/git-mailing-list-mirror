From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Wed, 7 Mar 2007 01:37:06 +0100
Message-ID: <200703070137.07477.jnareb@gmail.com>
References: <20070306093917.GA1761@coredump.intra.peff.net> <200703061423.18417.jnareb@gmail.com> <7vzm6qm07l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Li Yang-r58472" <LeoLi@freescale.com>,
	"Jeff King" <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 01:35:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOk8C-0002AY-2P
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 01:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbXCGAfP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 6 Mar 2007 19:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbXCGAep
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 19:34:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:37300 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161037AbXCGAem (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 19:34:42 -0500
Received: by ug-out-1314.google.com with SMTP id 44so367840uga
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 16:34:40 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dDy6XuH6LCnYkpCGF5uZEu3C9OZGGn/5/UFzpjqqPJ50wk21EgCEE35DmxsXyUDwz75/RG0hpRfGVY1qwppC3qb0mNZN+34Ii/RNM15TsqMvPfvzhFnukdB9r9pPoPryrm4T8I0QVSRN5/CtdB2j3UtOtHjzUxp/tN5CRTe24fI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hIeBxYoeClUEbZqlWc4/M1ARHpsEb1ivv8gcBUom72I79XwGU2OKd0UqY6CyGAuHmJvk1MWAG5WXe/+dNJOYudeb6i+qNMzfrqPGzyojlw9IZlRJerjivnyRCFhHE/w3nlsMbh/VaE2Gfp+uerNZ6wkO0fD81tawg7FEPMJQ7CM=
Received: by 10.67.22.14 with SMTP id z14mr2900854ugi.1173227680689;
        Tue, 06 Mar 2007 16:34:40 -0800 (PST)
Received: from host-81-190-22-152.torun.mm.pl ( [81.190.22.152])
        by mx.google.com with ESMTP id i5sm32123887mue.2007.03.06.16.34.38;
        Tue, 06 Mar 2007 16:34:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vzm6qm07l.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41627>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano wrote:
>>
>>> Speaking of -title, I see "sub git_project_list_body" does this:
>>>=20
>>> =C2=A0 =C2=A0 $cgi->a({ ... -title =3D> $pr->{'descr_long'}}, esc_h=
tml($pr->{'descr'}));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> which seems inconsistent with the earlier quoted $fullname
>>> handling (unless $pr->{'descr_long'} is already quoted and $pr->{'d=
escr'}
>>> is not, which I find highly unlikely).
>>
>> CGI::a() subroutine automatically quotes properly _attribute_ values=
,
>> but it does not (and it should not) quote _contents_ of a tag.
>>
>> So the above code is correct.
>=20
> Sorry, you lost me...  I am wondering what you mean by
> "automatically".  Do you mean 'always'?

Yes, I mean that CGI::a() does quoting _of attributes_, always.
=20
> And if that is the case, shouldn't we drop esc_html() around
> $fullname here?
>=20
>     ...  For example, many places esc_html()
>     is used as the body of <a ...>$here</a> but some places it is
>     used as
>=20
>         $cgi->a({ ... -title =3D>esc_html($fullname) }, esc_path($dir=
))
>=20
> as we do not have it around $pr->{'descr_long'} in the above?

The above is wrong, thrice. First, it should be esc_path($fullname).
Second, rules for escaping attribute values are different from escaping
HTML. Third, CGI::a() does escaping of attribute values.

Explanation:

  $cgi->a({ ... -attribute =3D> atribute_value }, tag_contents)

is translated to

  <a ... attribute=3D"attribute_value">tag_contents</a>

The rules for escaping attribute values (which are string contents) are
different. For example you have to take care about escaping embedded '"=
'
and "'" characters; CGI::a() does that for us automatically.

CGI::a() cannot HTML escape tag contents automatically; we might want t=
o
write

  <a href=3D"URL">some <b>bold</b> text</a>

for example. Soe we have to esc_html (or esc_path) if needed.


In short: escape tag contents if needed, do not escape attrbure values.
--=20
Jakub Narebski
Poland
