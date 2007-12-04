From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 11:11:04 +0100
Message-ID: <8BED0A14-31F0-4288-B7A2-59B2CEE6DF97@wincent.com>
References: <4753D419.80503@clearchain.com> <20071204084412.GA19597@auto.tuwien.ac.at> <200712041047.39340.ismail@pardus.org.tr> <200712041055.41593.ismail@pardus.org.tr>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>,
	Benjamin Close <Benjamin.Close@clearchain.com>,
	git@vger.kernel.org,
	Perl Unicode Mailing List <perl-unicode@perl.org>,
	Dan Kogai <dankogai@dan.co.jp>
To: =?ISO-8859-1?Q?Ismail_D=F6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Tue Dec 04 11:12:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzUlh-0007aj-84
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 11:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbXLDKMY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 05:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbXLDKMY
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 05:12:24 -0500
Received: from wincent.com ([72.3.236.74]:34524 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbXLDKMX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2007 05:12:23 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB4AB52r023501;
	Tue, 4 Dec 2007 04:11:06 -0600
In-Reply-To: <200712041055.41593.ismail@pardus.org.tr>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67034>

El 4/12/2007, a las 9:55, Ismail D=C3=B6nmez escribi=C3=B3:

> Tuesday 04 December 2007 10:47:39 Ismail D=C3=B6nmez yazm=C4=B1=C5=9F=
t=C4=B1:
>> Tuesday 04 December 2007 10:44:12 Martin Koegler yazm=C4=B1=C5=9Ft=C4=
=B1:
>>> On Tue, Dec 04, 2007 at 10:33:39AM +0200, Ismail D=C3=B6nmez wrote:
>>>> Following to_utf8 function works for me :
>>>
>>> For me too (Debian sarge+etch).
>>
>> Thanks for testing.
>
> Use Perl built-in utf8 function for UTF-8 decoding.
>
> Signed-off-by: =C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ff5daa7..db255c1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -695,10 +695,9 @@ sub validate_refname {
> # in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
> sub to_utf8 {
> 	my $str =3D shift;
> -	my $res;
> -	eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
> -	if (defined $res) {
> -		return $res;
> +        if (utf8::valid($str)) {
> +                utf8::decode($str);
> +                return $str;

This is good as it fixes another problem which some may have =20
encountered. On at least one distro that I use (Red Hat Enterprise =20
Linux 3) the Encode module is very old (it's 1.83; the latest release =20
is 2.23), and so gitweb won't even run, dying during compilation with =20
this:

	Too many arguments for Encode::decode_utf8 at gitweb.cgi line 686, =20
near "Encode::FB_CROAK)"

Of course, the workaround is to install a newer version of the module, =
=20
but this patch eliminates that dependency which is IMO a good thing.

Cheers,
Wincent
