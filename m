From: =?utf-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
	<dpb@corrigendum.ru>
Subject: Re: [PATCH] send-email: handle adjacent RFC 2047-encoded words
 properly
Date: Mon, 24 Nov 2014 21:26:22 +0300
Message-ID: <op.xpudh8c3nngjn5@freezie>
References: <1416786604-4988-1-git-send-email-dpb@corrigendum.ru>
 <20141124153609.GA25912@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjar?= =?utf-8?Q?mason?= 
	<avarab@gmail.com>, "Jay Soffian" <jaysoffian@gmail.com>,
	"Thomas Rast" <tr@thomasrast.ch>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 19:26:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsyLI-0007dB-Kh
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 19:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbaKXS02 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 13:26:28 -0500
Received: from forward9l.mail.yandex.net ([84.201.143.142]:34212 "EHLO
	forward9l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbaKXS01 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2014 13:26:27 -0500
Received: from smtp2m.mail.yandex.net (smtp2m.mail.yandex.net [77.88.61.129])
	by forward9l.mail.yandex.net (Yandex) with ESMTP id 20D52E610C9;
	Mon, 24 Nov 2014 21:26:24 +0300 (MSK)
Received: from smtp2m.mail.yandex.net (localhost [127.0.0.1])
	by smtp2m.mail.yandex.net (Yandex) with ESMTP id 55E934208B9;
	Mon, 24 Nov 2014 21:26:23 +0300 (MSK)
Received: from cs7-mts-1-124.dialup.mts-nn.ru (cs7-mts-1-124.dialup.mts-nn.ru [82.208.71.124])
	by smtp2m.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id i2S17R8nAN-QMauC98n;
	Mon, 24 Nov 2014 21:26:22 +0300
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: d832ac02-4e78-4b40-8d42-34912e4a4479
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
	t=1416853582; bh=2cyqjyARzZNkUvGOHyRQ/9eJUeKlWxpe1qOiEjUDjwE=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:
	 Content-Transfer-Encoding:From:Message-ID:In-Reply-To:User-Agent;
	b=z/+ePKy31nUXei2knHhRrMOjvQyk+kvDHZsvQdDNkB7ekUCR2QsPlM2JqiQ+yvVFe
	 UBAKh6yEi2Z8EIa2KdrVQAdgC+uf1zw/a3uLYbnIJxs/aw6Vd+0QIEPGRvGux4+H++
	 aMN3mgjf1SVNQGx4FrNO+H6A2knISflDJMJDgeuE=
Authentication-Results: smtp2m.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
In-Reply-To: <20141124153609.GA25912@peff.net>
User-Agent: Opera Mail/12.17 (Win64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260136>

Jeff King <peff@peff.net> =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =D0=B2 =D1=81=D0=
=B2=D0=BE=D1=91=D0=BC =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=B5 Mon, 24 Nov =
2014 18:36:09 =20
+0300:

> On Mon, Nov 24, 2014 at 02:50:04AM +0300, =D0=A0=D0=BE=D0=BC=D0=B0=D0=
=BD =D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE wrote:
>
>> The RFC says that they are to be concatenated after decoding (i.e. t=
he
>> intervening whitespace is ignored).
>>
>> I change the sender's name to an all-Cyrillic string in the tests so=
 =20
>> that
>> its encoded form goes over the 76 characters in a line limit, forcin=
g
>> format-patch to split it into multiple encoded words.
>>
>> Since I have to modify the regular expression for an encoded word =20
>> anyway,
>> I take the opportunity to bring it closer to the spec, most notably
>> disallowing embedded spaces and making it case-insensitive (thus =20
>> allowing
>> the encoding to be specified as both "q" and "Q").
>
> The overall goal makes sense to me. Thanks for working on this. I hav=
e a
> few questions/comments, though.
>
>>  sub unquote_rfc2047 {
>>  	local ($_) =3D @_;
>> +
>> +	my $et =3D qr/[!->@-~]+/; # encoded-text from RFC 2047
>> +	my $sep =3D qr/[ \t]+/;
>> +	my $encoded_word =3D qr/=3D\?($et)\?q\?($et)\?=3D/i;
>
> The first $et in $encoded_word is actually the charset, which is defi=
ned
> by RFC 2047 as:
>
>      charset =3D token    ; see section 3
>
>      token =3D 1*<Any CHAR except SPACE, CTLs, and especials>
>
>      especials =3D "(" / ")" / "<" / ">" / "@" / "," / ";" / ":" / "
> 	               <"> / "/" / "[" / "]" / "?" / "." / "=3D"
>
> Your regex is a little more liberal. I doubt that it is a big deal in
> practice (actually, in practice, I suspect [a-zA-Z0-9-] would be fine=
).
> But if we are tightening things up in general, it may make sense to d=
o
> so here (and I notice that is_rfc2047_quoted does a more thorough $to=
ken
> definition, and it probably makes sense for the two functions to be
> consistent).

Yeah, I did realize that token is more restrictive than encoded-text, b=
ut =20
I didn't want to stray too far from the subject line of the patch. What=
 =20
I'll probably do is split the patch into two, one for regex tweaking an=
d =20
one for multiple-word handling. And yeah, I'll try to make the two =20
functions use the same regexes.

>
> For your definition of encoded-text, RFC 2047 says:
>
>      encoded-text =3D 1*<Any printable ASCII character other than "?"
>                           or SPACE>
>
> It looks like you pulled the definition of $et from is_rfc2047_quoted=
,
> but I am not clear on where that original came from (it is from a3a82=
62,
> but that commit message does not explain the regex).

No, it's actually an independent discovery. :-) I don't think it needs =
=20
explanation, though - it's just a character class with two ranges cover=
ing =20
every printable character but the question mark.

> Also, I note that we handle 'q'-style encodings here, but not 'b'. I
> wonder if it is worth adding that in while we are in the area (it is =
not
> a big deal if you always send-email git-generated patches, as we neve=
r
> generate it).

I could add "b" decoding, but since format-patch never generates "b" =20
encodings, testing would be a problem. And I'd rather not do it without=
 =20
any tests.

>
>> +	s{$encoded_word(?:$sep$encoded_word)+}{
>
> If I am reading this right, it requires at least two $encoded_words.
> Should this "+" be a "*"?

I hang my head in shame. Looks like I'll have to add more tests...

>
>> +		my @words =3D split $sep, $&;
>> +		foreach (@words) {
>> +			m/$encoded_word/;
>> +			$encoding =3D $1;
>> +			$_ =3D $2;
>> +			s/_/ /g;
>> +			s/=3D([0-9A-F]{2})/chr(hex($1))/eg;
>
> In the spirit of your earlier change, should this final regex be
> case-insensitive? RFC 2047 says only "Upper case should be used for
> hexadecimal digits "A" through "F." but that does not seem like a "MU=
ST"
> to me.

Sounds reasonable.

Roman.
