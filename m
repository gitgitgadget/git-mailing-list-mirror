From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git filter-branch and merging of signed tags
Date: Mon, 2 Nov 2015 17:21:03 +0100
Message-ID: <56378D6F.8080508@drmicha.warpmail.net>
References: <20151102080428.GO4931@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 17:21:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtHr7-0000wK-Eb
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 17:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbbKBQVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 11:21:09 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38457 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752234AbbKBQVG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 11:21:06 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 5226820A36
	for <git@vger.kernel.org>; Mon,  2 Nov 2015 11:21:05 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 02 Nov 2015 11:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=iE1UF4CxF9SpWDkEVpaJXsymQGM=; b=cZY8T4
	JPz2JfZlfqK/rzqIUwp/C9i7euaRUVpqlDSsGf0Sqj2A3mc739Dne4ANvTxfXi37
	9fmX+823ZdnfX0+5puzUiKM4JyueEk0GN+krVEZW9Y+CuWvsvDg1YP/otz2S/WdN
	zGq2XSVPUXn4ZKiSOdlPsexkQF07+GwoHoWhM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=iE1UF4CxF9SpWDk
	EVpaJXsymQGM=; b=jzGZyrxHsX/Al1Y0nbH7+YbyWiCCOJ9Mn6wX+Gb1XHAdF1R
	whuUqxfpmqg291Su5TxUz1GPxYw5Pe372SdIKru+hJUv18Gbvr2QQIvvrJVEqR9W
	p3MjjIHR/GaULVAKLok8hQgNDw51ktOIuMBjpPPlUbN0BHtHSHbxBkWQH4lo=
X-Sasl-enc: Ha5LQmSrb3u1rCh+VlOGqZPTjC79Rj3diVmh0CUSPwVI 1446481264
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7BD05C016FA;
	Mon,  2 Nov 2015 11:21:04 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151102080428.GO4931@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280696>

Uwe Kleine-K=F6nig venit, vidit, dixit 02.11.2015 09:04:
> Hello,
>=20
> Consider I want to rewrite a commit that is a merge of a signed tag. =
In
> my case that's 064ca93f7ab927c2752d86fc5727716e340d737c that currentl=
y
> sits in linux-next:
>=20
> 	~/gsrc/linux$ git version
> 	git version 2.6.1
> 	~/gsrc/linux$ git checkout 064ca93f7ab927c2752d86fc5727716e340d737c
> 	~/gsrc/linux$ git cat-file commit HEAD
> 	tree 7086bbd51d06ebd0e3fcca70380d0a066efce6ef
> 	parent e44a01fa0e0aec2f3a21dadb9c030d14831d4258
> 	parent f719a0d6a8541b383c506aaa4b4fa6b4109669f4
> 	author Arnd Bergmann <arnd@arndb.de> 1444139956 +0200
> 	committer Arnd Bergmann <arnd@arndb.de> 1444139956 +0200
> 	mergetag object f719a0d6a8541b383c506aaa4b4fa6b4109669f4
> 	 type commit
> 	 tag efm32-for-4.4-rc1
> 	 tagger Uwe Kleine-K=F6nig <uwe@kleine-koenig.org> 1443549594 +0200
> 	=20
> 	 efm32 cleanups for 4.4-rc1
> 	=20
> 	 These are just two followup cleanups for commits that are in v3.17-=
rc1 and
> 	 waited in my private tree for application since that time.
> 	 -----BEGIN PGP SIGNATURE-----
> 	=20
> 	 iQEcBAABCgAGBQJWCtIwAAoJEMH8FHityuwJFPYH/2LJpi0yUhI01s0D9U5rZgjl
> 	 8mLP70utAMaqXiGqP/O0ndH+za5TrrUTwDJE5jhAHru1Q6q62Ld2BfOR5+K8zlrP
> 	 4UDGBDj3ePJgEtbSsJYJIRT+AKque2GONbeGpJh2arPrNamWChKIz8HoGSgwdRlx
> 	 TvQuVFEa6C3ujP0ATM8x54f0vR4bYm9WmBS522DwZQY4JpGZC005A3Quw6fmFxPJ
> 	 vJRo1fE1d2OZ3Cuxb15m8PLtZw6sbMdMwgyirAFGrJsN9u/V6BzsSzH0s8suT7IP
> 	 WIohnmYtFSUfkQjaGrMl2wIpJSsIzettiXf9GrQDXSGZsQ4k7sW3U+qrcZ7ZUR4=3D
> 	 =3Dngv1
> 	 -----END PGP SIGNATURE-----
>=20
> 	Merge tag 'efm32-for-4.4-rc1' of git://git.pengutronix.de/git/ukl/li=
nux into next/cleanup
>=20
> 	Merge "efm32 cleanups for 4.4-rc1" from Uwe Kleine-Koenig:
>=20
> 	These are just two followup cleanups for commits that are in v3.17-r=
c1 and
> 	waited in my private tree for application since that time.
>=20
> 	* tag 'efm32-for-4.4-rc1' of git://git.pengutronix.de/git/ukl/linux:
> 	  ARM: efm32: switch to vendor,device compatible strings
> 	  ARM: efm32: switch to properly namespaced location property
>=20
> OK, to fix my name in the commit log I do:
>=20
> 	 git filter-branch -f --msg-filter "sed 's/Kleine-Koenig/$(echo Klei=
ne-K+APY-nig | iconv -f utf-7 -t utf-8)/'" HEAD ^HEAD^ ^HEAD^2
>=20
> This destroys the mergetag, as now I have:
>=20
> 	~/gsrc/linux$ git cat-file commit HEAD
> 	tree 7086bbd51d06ebd0e3fcca70380d0a066efce6ef
> 	parent e44a01fa0e0aec2f3a21dadb9c030d14831d4258
> 	parent f719a0d6a8541b383c506aaa4b4fa6b4109669f4
> 	author Arnd Bergmann <arnd@arndb.de> 1444139956 +0200
> 	committer Arnd Bergmann <arnd@arndb.de> 1444139956 +0200
>=20
> 	 efm32 cleanups for 4.4-rc1
> 	=20
> 	 These are just two followup cleanups for commits that are in v3.17-=
rc1 and
> 	 waited in my private tree for application since that time.
> 	 -----BEGIN PGP SIGNATURE-----
> 	=20
> 	 iQEcBAABCgAGBQJWCtIwAAoJEMH8FHityuwJFPYH/2LJpi0yUhI01s0D9U5rZgjl
> 	 8mLP70utAMaqXiGqP/O0ndH+za5TrrUTwDJE5jhAHru1Q6q62Ld2BfOR5+K8zlrP
> 	 4UDGBDj3ePJgEtbSsJYJIRT+AKque2GONbeGpJh2arPrNamWChKIz8HoGSgwdRlx
> 	 TvQuVFEa6C3ujP0ATM8x54f0vR4bYm9WmBS522DwZQY4JpGZC005A3Quw6fmFxPJ
> 	 vJRo1fE1d2OZ3Cuxb15m8PLtZw6sbMdMwgyirAFGrJsN9u/V6BzsSzH0s8suT7IP
> 	 WIohnmYtFSUfkQjaGrMl2wIpJSsIzettiXf9GrQDXSGZsQ4k7sW3U+qrcZ7ZUR4=3D
> 	 =3Dngv1
> 	 -----END PGP SIGNATURE-----
>=20
> 	Merge tag 'efm32-for-4.4-rc1' of git://git.pengutronix.de/git/ukl/li=
nux into next/cleanup
>=20
> 	Merge "efm32 cleanups for 4.4-rc1" from Uwe Kleine-K=F6nig:
>=20
> 	These are just two followup cleanups for commits that are in v3.17-r=
c1 and
> 	waited in my private tree for application since that time.
>=20
> 	* tag 'efm32-for-4.4-rc1' of git://git.pengutronix.de/git/ukl/linux:
> 	  ARM: efm32: switch to vendor,device compatible strings
> 	  ARM: efm32: switch to properly namespaced location property
>=20
> 	~/gsrc/linux$ diff -u <(git cat-file commit HEAD) <(git cat-file com=
mit 064ca93f7ab927c2752d86fc5727716e340d737c)
> 	--- /dev/fd/63	2015-11-02 09:02:17.310373539 +0100
> 	+++ /dev/fd/62	2015-11-02 09:02:17.310373539 +0100
> 	@@ -3,7 +3,11 @@
> 	 parent f719a0d6a8541b383c506aaa4b4fa6b4109669f4
> 	 author Arnd Bergmann <arnd@arndb.de> 1444139956 +0200
> 	 committer Arnd Bergmann <arnd@arndb.de> 1444139956 +0200
> 	-
> 	+mergetag object f719a0d6a8541b383c506aaa4b4fa6b4109669f4
> 	+ type commit
> 	+ tag efm32-for-4.4-rc1
> 	+ tagger Uwe Kleine-K=F6nig <uwe@kleine-koenig.org> 1443549594 +0200
> 	+=20
> 	  efm32 cleanups for 4.4-rc1
> 	 =20
> 	  These are just two followup cleanups for commits that are in v3.17=
-rc1 and
> 	@@ -21,7 +25,7 @@
> 	=20
> 	 Merge tag 'efm32-for-4.4-rc1' of git://git.pengutronix.de/git/ukl/l=
inux into next/cleanup
> 	=20
> 	-Merge "efm32 cleanups for 4.4-rc1" from Uwe Kleine-K=F6nig:
> 	+Merge "efm32 cleanups for 4.4-rc1" from Uwe Kleine-Koenig:
> 	=20
> 	 These are just two followup cleanups for commits that are in v3.17-=
rc1 and
> 	 waited in my private tree for application since that time.
>=20
> So now the PGP-Signature also appears in the regular commit log. So
> either remove the mergetag info completely or (preferably) keep it
> completely if the merged parent didn't change.

Does your git include
a5a4b3f (filter-branch: remove multi-line headers in msg filter,
2015-10-08)? That takes care of the incomplete header tag parsing.

Should be in master by now, I think.

Keeping the mergetag signature would require some extra logic in
filter-branch.

Michael
