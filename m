From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 2/4] gitweb: Make feed title valid utf8
Date: Tue, 09 Apr 2013 21:58:41 +0200
Message-ID: <516472F1.4060903@gmail.com>
References: <m2y5csbx91.fsf@blackdown.de> <51642F67.5010501@gmail.com> <m2r4ija9gh.fsf@zahir.fritz.box> <51645D99.6000106@gmail.com> <m2ip3va4ro.fsf@zahir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SsO8cmdlbiBLcmVpbGVkZXI=?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Apr 09 21:58:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPegt-0003dj-Fr
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 21:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936083Ab3DIT6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 15:58:46 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:53037 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936043Ab3DIT6q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 15:58:46 -0400
Received: by mail-ee0-f53.google.com with SMTP id c13so3003765eek.26
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=H7jrMlH5C+FE+AKljtmjnaH82Va3bONtD9P8evHrJXE=;
        b=GnW8290aVmug7lQACPxvAGI1vZ4b7bB9+5mQMB3EIgk7bfHvDTxxO4PuzQ1WLvPBxY
         DdO0c8SOQkZQyRmIyFRiG4lwzqB1PqmY+w8wq54rwZdiHe8/Q5WDZr/R9DFL2X3Vl0gU
         g5F0UGhoT8WPPxxEpbhgaKBIIjgeMAYwB1mLEtFyUeWQvrmkx1hwehooZa/SxqMHFTaT
         DdBvlRxYbgkhyr2an2vjBl0TXJX3RUZFs/WmN1Vw0B9qjQXuOt3YYMWH3X6aIBccrCuQ
         LmFz7eKBR6/p7uZJ9/ffrgLUtVHTHu/zyxd7hxxjuL9fhgoE/NUTnUhCO1QA0kqOzmyK
         6B4w==
X-Received: by 10.15.32.67 with SMTP id z43mr53945927eeu.24.1365537524565;
        Tue, 09 Apr 2013 12:58:44 -0700 (PDT)
Received: from [192.168.1.14] (dce9.neoplus.adsl.tpnet.pl. [83.23.56.9])
        by mx.google.com with ESMTPS id cb50sm18160801eeb.14.2013.04.09.12.58.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 12:58:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <m2ip3va4ro.fsf@zahir.fritz.box>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220625>

W dniu 09.04.2013 21:22, J=C3=BCrgen Kreileder napisa=C5=82:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:=20
>> W dniu 09.04.2013 19:40, J=C3=BCrgen Kreileder napisa=C5=82:
>>> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>>>> J=C3=BCrgen Kreileder wrote:
>>>>
>>>>> Properly encode site and project names for RSS and Atom feeds.

>>> Good point.  But it doesn't fix the string in question:
>>> It looks like to_utf8("$a $b") !=3D (to_utf8($a) . " " . to_utf8($b=
)).
>>
>> Strange.  I wonder if the bug is in our to_utf8() implementation,
>> or in Encode, or in Perl... and whether this bug can be triggered
>> anywhere else in gitweb.
>=20
> I don't think it's a bug, more like a consequence of concatenating ut=
f8
> and non-utf8 strings:
>=20
>     my $a =3D "=C3=BC";
>     my $b =3D "=C3=BC";
>     my $c =3D "$a - $b";
>     print "$c -> ". to_utf8($c) . ": " . (utf8::is_utf8($c) ? "utf8" =
: "not utf8") . "\n"; # GOOD
>     $b =3D to_utf8($b);
>     $c =3D "$a - $b";
>     print "$c -> ". to_utf8($c) . ": " . (utf8::is_utf8($c) ? "utf8" =
: "not utf8") . "\n"; # GOOD
>=20
> yields (hopefully the broken encoding shows up correctly here):
>=20
>     =C3=83=C2=BC - =C3=83=C2=BC -> =C3=BC - =C3=BC: not utf8
>     =C3=83=C2=BC - =C3=BC -> =C3=83=C2=BC - =C3=BC: utf8

Ah, so it looks like it is misfeature of the way Perl handles Unicode;
concatenating adds 'UTF8' flag if either of concatenates strings has
it to the result.

[Which I have checked using Devel::Peek with
 perl -MDevel::Peek -E '
  my $a =3D "=C5=BC"; my $b =3D "\x{17c}";
  Dump $a; Dump $b; Dump "$b - $a"'
]

> In gitweb we have the bad case:=20
>=20
>    my $title =3D "$site_name - $project/$action";
>=20
> $project and $action are apparently utf8 already but $site_name isn't=
=2E

$project and $action are taken from URL, and we have to run decode_utf8
(at least for query params) for gitweb to work correctly.

$site_name is usually taken from config file, and gitweb doesn't have
"use utf8" pragma.

> The resulting string is marked as utf8 - although the encoding of
> $site_name was never fixed.  The to_utf8() in esc_html() returns the =
string
> without fixing anything because of that.

O.K.

_Maybe_ it would be worth adding explanation of this to commit message
(and I see I should audit gitweb for similar problems elsewhere), but a=
nyway

Acked-by: Jakub Narebski <jnareb@gmail.com>

--=20
Jakub Nar=C4=99bski
