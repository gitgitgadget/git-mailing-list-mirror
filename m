From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: [PATCH v2] git-svn: use SVN::Ra::get_dir2 when possible
Date: Fri, 31 Oct 2014 21:53:54 +0000
Message-ID: <1414792434.54806.YahooMailBasic@web172304.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Fri Oct 31 22:54:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkK8u-0004pt-U1
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 22:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803AbaJaVx4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Oct 2014 17:53:56 -0400
Received: from nm37-vm1.bullet.mail.ir2.yahoo.com ([212.82.97.142]:33452 "EHLO
	nm37-vm1.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751541AbaJaVxz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 17:53:55 -0400
Received: from [212.82.98.52] by nm37.bullet.mail.ir2.yahoo.com with NNFMP; 31 Oct 2014 21:53:54 -0000
Received: from [212.82.98.99] by tm5.bullet.mail.ir2.yahoo.com with NNFMP; 31 Oct 2014 21:53:54 -0000
Received: from [127.0.0.1] by omp1036.mail.ir2.yahoo.com with NNFMP; 31 Oct 2014 21:53:54 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 560315.87120.bm@omp1036.mail.ir2.yahoo.com
Received: (qmail 85504 invoked by uid 60001); 31 Oct 2014 21:53:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414792434; bh=EAk9USminD3oHcBV/tOKtCEJvCdLFUlyFwyqz6q0yAY=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=DboK8+nVJv1lRNneypDXc/51pDxeuk5DaNlXa6HL1fJt9MPkk64+tDo8Uh6L1/N2jGbMDOUrECaNkuvS+KqsGI+PgXFYKziId8+VAFwnW6Lon8ze60FuQMYHUFSzvuh1pcJVwtNyJBRauyKL2KmlXwGkqSmJu5djWr3j1DxrXBk=
X-YMail-OSG: V4Gbob4VM1kKVbjJhbELfu2CENeM3U1.0eAK.EPuxojC5Iz
 m27ajRJoivrOBuW5JNCsJGemZ4ueahDjZmiPkulMoBA4APY40TSdAzKHT0J8
 v9z5fbakmap8NmBrJasW2IX5HjDehe1RlX8rKH6.PyqGOabagxZ9I5lbC1JY
 oJJ.hT5sUeykvJB638IPxSnSFkxkZDr7.JHPLYIkMgmVpIMTi0HXcmXhAWgE
 xtiXltNvr5WSuRHy7hEp.1wLMInlk3vvtW3Mg5SBuyjLZs7XO0PHBfO9Fc3p
 NsdeMzjDuuh0_NnI2wmnNwA04vzdZEFfWQYDsYqO9iDskEZnYOQccBgdHhvR
 6UHwDvRmpi5MlXvKB6TSiCby758_pFokCjzBaE98U8FCX6i.f0Ba_e8B4Vjz
 082stv8nVuIOQZXfd73lMJPKOFRYCThFdrKWEa62zAYasqpIuQfgQT5u_kIA
 KxaJM2qeS615r1.p5RecWWW6fTdUfV0LuLW.9XK82SGWsHYhght27oRg.Ei9
 xh9MzIudnUsx5LKyyw7notkXh7g1E4KrNJU7S06ExIn7u7Ymf4.HGP9FwZsD
 RrMKzjK8CHNM9.aVdSD0X2f_f_l2Gdd0psAtl5pGR
Received: from [86.30.137.134] by web172304.mail.ir2.yahoo.com via HTTP; Fri, 31 Oct 2014 21:53:54 GMT
X-Rocket-MIMEInfo: 002.001,LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KT24gRnJpLCBPY3QgMzEsIDIwMTQgMTA6MzQgR01UIEVyaWMgV29uZyB3cm90ZToNCg0KPlRoaXMgYXZvaWRzIHRoZSBmb2xsb3dpbmcgZmFpbHVyZSB3aXRoIG5vcm1hbCAiZ2V0X2RpciIgb24gbmV3ZXINCj52ZXJzaW9ucyBvZiBTVk4gKHRlc3RlZCB3aXRoIFNWTiAxLjguOC0xdWJ1bnR1My4xKToNCj4NCj7CoCBJbmNvcnJlY3QgcGFyYW1ldGVycyBnaXZlbjogQ291bGQgbm90IGNvbnZlcnQgJyVsZCcgaW50byBhIG51bWJlcg0KPg0KPmdldF9kaXIyIGFsc28BMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-------------------------
On Fri, Oct 31, 2014 10:34 GMT Eric Wong wrote:

>This avoids the following failure with normal "get_dir" on newer
>versions of SVN (tested with SVN 1.8.8-1ubuntu3.1):
>
>=A0 Incorrect parameters given: Could not convert '%ld' into a number
>
>get_dir2 also has the potential to be more efficient by requesting
>less data.
>
>ref: <1414636504.45506.YahooMailBasic@web172304.mail.ir2.yahoo.com>
>ref: <1414722617.89476.YahooMailBasic@web172305.mail.ir2.yahoo.com>
>
>Signed-off-by: Eric Wong <normalperson@yhbt.net>
>Cc: Hin-Tak Leung <htl10@users.sourceforge.net>

Tested-by: Hin-Tak Leung <htl10@users.sourceforge.net>

Okay, this one on top of my "git 2.1.0 + 10 recent git svn improvement =
patches"
allow me to fetch further.

I suspect the problem must be elsewhere though, and this just band-aide=
d
over it.

=46or me, reverting the additional patches and just use git 2.1.0 also =
allow
me to fetch further, so the problem appear to me to be associated with
the additional patches. But you are saying that git-svn on debian as sh=
ipped
exhibit this problem?=20

>---
> Sorry, waaay past my bed time.=A0 This version doesn't infinite loop
> on autoload or older SVN(*) (at least I hope it doesn't)
>
> perl/Git/SVN/Ra.pm | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>
>diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
>index 82d6108..496f430 100644
>--- a/perl/Git/SVN/Ra.pm
>+++ b/perl/Git/SVN/Ra.pm
>@@ -177,7 +177,17 @@ sub get_dir {
> =A0=A0=A0 =A0=A0=A0 }
> =A0=A0=A0 }
> =A0=A0=A0 my $pool =3D SVN::Pool->new;
>-=A0=A0=A0 my ($d, undef, $props) =3D $self->SUPER::get_dir($dir, $r, =
$pool);
>+=A0=A0=A0 my ($d, undef, $props);
>+
>+=A0=A0=A0 if (::compare_svn_version('1.4.0') >=3D 0) {
>+=A0=A0=A0 =A0=A0=A0 # n.b. in addition to being potentially more effi=
cient,
>+=A0=A0=A0 =A0=A0=A0 # this works around what appears to be a bug in s=
ome
>+=A0=A0=A0 =A0=A0=A0 # SVN 1.8 versions
>+=A0=A0=A0 =A0=A0=A0 my $kind =3D 1; # SVN_DIRENT_KIND
>+=A0=A0=A0 =A0=A0=A0 ($d, undef, $props) =3D $self->get_dir2($dir, $r,=
 $kind, $pool);
>+=A0=A0=A0 } else {
>+=A0=A0=A0 =A0=A0=A0 ($d, undef, $props) =3D $self->SUPER::get_dir($di=
r, $r, $pool);
>+=A0=A0=A0 }
> =A0=A0=A0 my %dirents =3D map { $_ =3D> { kind =3D> $d->{$_}->kind } =
} keys %$d;
> =A0=A0=A0 $pool->clear;
> =A0=A0=A0 if ($r !=3D $cache->{r}) {
>--=20
>EW
>
