From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Simple update to bash completions to prevent unbound variable errors.
Date: Mon, 12 Jan 2009 21:56:59 -0600
Message-ID: <200901122157.03658.bss@iguanasuicide.net>
References: <496C0003.7040909@tedpavlic.com> <7vy6xfew2n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1268738.2xDI64HvNn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Ted Pavlic <ted@tedpavlic.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 04:57:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMaPX-0006fJ-EA
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 04:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbZAMD43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 22:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753710AbZAMD42
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 22:56:28 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:57632 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbZAMD42 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 22:56:28 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMaO8-0007zt-Kz; Tue, 13 Jan 2009 03:56:24 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <7vy6xfew2n.fsf@gitster.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105450>

--nextPart1268738.2xDI64HvNn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2009 January 12 21:14:40 Junio C Hamano wrote:
>Ted Pavlic <ted@tedpavlic.com> writes:
>> A vim modeline has also been added for consistency.
>
>Yuck.

While I dislike emacs and use vim pretty much exclusively, I don't really s=
ee=20
the need for a vim modeline.  On top of that, fdm=3Dmarker is a bit silly s=
ince=20
there aren't any markers.  ff=3Dunix and ft=3Dsh are redundant, as any vim =
should=20
detect these properly, given the filename.

So, I'm slightly negative on the modeline hunk.

>> @@ -111,7 +115,7 @@ __git_ps1 ()
>>  			fi
>>  		fi
>>
>> -		if [ -n "$1" ]; then
>> +		if [ $# -gt 0 ] && [ -n "$1" ]; then
>
>I found the previous round's [ -n "${1-}" ] much easier to read, if we were
> to do this.  If -n "${1-}", then "$1" is definitely set so nothing need to
> change in the then ... else part.

I found "${1-}" ugly, and this a bit better, but I'll defer to Junio.

>> @@ -131,11 +136,22 @@ __gitcomp_1 ()
>>  	done
>>  }
>>
>> +# __gitcomp accepts 1, 2, 3, or 4 arguments
>> +# generates completion reply with compgen
>>  __gitcomp ()
>>  {
>> -	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
>> -	if [ $# -gt 2 ]; then
>> -		cur=3D"$3"
>> +	local one two cur=3D"${COMP_WORDS[COMP_CWORD]}" four
>> +	if [ $# -gt 0 ]; then
>> +		one=3D"$1"
>> +		if [ $# -gt 1 ]; then
>> +			two=3D"$2"
>> +			if [ $# -gt 2 ]; then
>> +				cur=3D"$3"
>> +				if [ $# -gt 3 ]; then
>> +					four=3D"$4"
>> +				fi
>> +			fi
>> +		fi
>>  	fi
>
>Yuck.

Definitely agreeing with Junio here.  This is far less ascetic than the old=
=20
patch.  Truth be told, this whole thread would probably have been more=20
productive without me chiming in.  Sorry about that.

>If you are taking advantage of the fact that "local one"=20
>will bind one to emptiness anyway, can't you do something like:
>
>	local one=3D${1-} two=3D${2-} cur=3D${3-} four=3D${4-}

Even better to use variable names that match the usage, if possible.=20
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1268738.2xDI64HvNn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklsEQ8ACgkQdNbfk+86fC30PACeNnslN4qrfd9xg7yy0EqJBiEp
9xsAnivVMYnAYBzpaM9CnzykVepiMFuk
=iGTO
-----END PGP SIGNATURE-----

--nextPart1268738.2xDI64HvNn--
