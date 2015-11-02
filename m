From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: git filter-branch and merging of signed tags
Date: Mon, 2 Nov 2015 09:04:28 +0100
Message-ID: <20151102080428.GO4931@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 09:04:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtA6U-0001yP-IS
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 09:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbbKBIEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 03:04:31 -0500
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36859 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbbKBIEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 03:04:30 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0] ident=Debian-exim)
	by metis.ext.pengutronix.de with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1ZtA6O-0002p0-U0
	for git@vger.kernel.org; Mon, 02 Nov 2015 09:04:28 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.84)
	(envelope-from <ukl@pengutronix.de>)
	id 1ZtA6O-0003tW-LR
	for git@vger.kernel.org; Mon, 02 Nov 2015 09:04:28 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280687>

Hello,

Consider I want to rewrite a commit that is a merge of a signed tag. In
my case that's 064ca93f7ab927c2752d86fc5727716e340d737c that currently
sits in linux-next:

	~/gsrc/linux$ git version
	git version 2.6.1
	~/gsrc/linux$ git checkout 064ca93f7ab927c2752d86fc5727716e340d737c
	~/gsrc/linux$ git cat-file commit HEAD
	tree 7086bbd51d06ebd0e3fcca70380d0a066efce6ef
	parent e44a01fa0e0aec2f3a21dadb9c030d14831d4258
	parent f719a0d6a8541b383c506aaa4b4fa6b4109669f4
	author Arnd Bergmann <arnd@arndb.de> 1444139956 +0200
	committer Arnd Bergmann <arnd@arndb.de> 1444139956 +0200
	mergetag object f719a0d6a8541b383c506aaa4b4fa6b4109669f4
	 type commit
	 tag efm32-for-4.4-rc1
	 tagger Uwe Kleine-K=F6nig <uwe@kleine-koenig.org> 1443549594 +0200
	=20
	 efm32 cleanups for 4.4-rc1
	=20
	 These are just two followup cleanups for commits that are in v3.17-rc=
1 and
	 waited in my private tree for application since that time.
	 -----BEGIN PGP SIGNATURE-----
	=20
	 iQEcBAABCgAGBQJWCtIwAAoJEMH8FHityuwJFPYH/2LJpi0yUhI01s0D9U5rZgjl
	 8mLP70utAMaqXiGqP/O0ndH+za5TrrUTwDJE5jhAHru1Q6q62Ld2BfOR5+K8zlrP
	 4UDGBDj3ePJgEtbSsJYJIRT+AKque2GONbeGpJh2arPrNamWChKIz8HoGSgwdRlx
	 TvQuVFEa6C3ujP0ATM8x54f0vR4bYm9WmBS522DwZQY4JpGZC005A3Quw6fmFxPJ
	 vJRo1fE1d2OZ3Cuxb15m8PLtZw6sbMdMwgyirAFGrJsN9u/V6BzsSzH0s8suT7IP
	 WIohnmYtFSUfkQjaGrMl2wIpJSsIzettiXf9GrQDXSGZsQ4k7sW3U+qrcZ7ZUR4=3D
	 =3Dngv1
	 -----END PGP SIGNATURE-----

	Merge tag 'efm32-for-4.4-rc1' of git://git.pengutronix.de/git/ukl/linu=
x into next/cleanup

	Merge "efm32 cleanups for 4.4-rc1" from Uwe Kleine-Koenig:

	These are just two followup cleanups for commits that are in v3.17-rc1=
 and
	waited in my private tree for application since that time.

	* tag 'efm32-for-4.4-rc1' of git://git.pengutronix.de/git/ukl/linux:
	  ARM: efm32: switch to vendor,device compatible strings
	  ARM: efm32: switch to properly namespaced location property

OK, to fix my name in the commit log I do:

	 git filter-branch -f --msg-filter "sed 's/Kleine-Koenig/$(echo Kleine=
-K+APY-nig | iconv -f utf-7 -t utf-8)/'" HEAD ^HEAD^ ^HEAD^2

This destroys the mergetag, as now I have:

	~/gsrc/linux$ git cat-file commit HEAD
	tree 7086bbd51d06ebd0e3fcca70380d0a066efce6ef
	parent e44a01fa0e0aec2f3a21dadb9c030d14831d4258
	parent f719a0d6a8541b383c506aaa4b4fa6b4109669f4
	author Arnd Bergmann <arnd@arndb.de> 1444139956 +0200
	committer Arnd Bergmann <arnd@arndb.de> 1444139956 +0200

	 efm32 cleanups for 4.4-rc1
	=20
	 These are just two followup cleanups for commits that are in v3.17-rc=
1 and
	 waited in my private tree for application since that time.
	 -----BEGIN PGP SIGNATURE-----
	=20
	 iQEcBAABCgAGBQJWCtIwAAoJEMH8FHityuwJFPYH/2LJpi0yUhI01s0D9U5rZgjl
	 8mLP70utAMaqXiGqP/O0ndH+za5TrrUTwDJE5jhAHru1Q6q62Ld2BfOR5+K8zlrP
	 4UDGBDj3ePJgEtbSsJYJIRT+AKque2GONbeGpJh2arPrNamWChKIz8HoGSgwdRlx
	 TvQuVFEa6C3ujP0ATM8x54f0vR4bYm9WmBS522DwZQY4JpGZC005A3Quw6fmFxPJ
	 vJRo1fE1d2OZ3Cuxb15m8PLtZw6sbMdMwgyirAFGrJsN9u/V6BzsSzH0s8suT7IP
	 WIohnmYtFSUfkQjaGrMl2wIpJSsIzettiXf9GrQDXSGZsQ4k7sW3U+qrcZ7ZUR4=3D
	 =3Dngv1
	 -----END PGP SIGNATURE-----

	Merge tag 'efm32-for-4.4-rc1' of git://git.pengutronix.de/git/ukl/linu=
x into next/cleanup

	Merge "efm32 cleanups for 4.4-rc1" from Uwe Kleine-K=F6nig:

	These are just two followup cleanups for commits that are in v3.17-rc1=
 and
	waited in my private tree for application since that time.

	* tag 'efm32-for-4.4-rc1' of git://git.pengutronix.de/git/ukl/linux:
	  ARM: efm32: switch to vendor,device compatible strings
	  ARM: efm32: switch to properly namespaced location property

	~/gsrc/linux$ diff -u <(git cat-file commit HEAD) <(git cat-file commi=
t 064ca93f7ab927c2752d86fc5727716e340d737c)
	--- /dev/fd/63	2015-11-02 09:02:17.310373539 +0100
	+++ /dev/fd/62	2015-11-02 09:02:17.310373539 +0100
	@@ -3,7 +3,11 @@
	 parent f719a0d6a8541b383c506aaa4b4fa6b4109669f4
	 author Arnd Bergmann <arnd@arndb.de> 1444139956 +0200
	 committer Arnd Bergmann <arnd@arndb.de> 1444139956 +0200
	-
	+mergetag object f719a0d6a8541b383c506aaa4b4fa6b4109669f4
	+ type commit
	+ tag efm32-for-4.4-rc1
	+ tagger Uwe Kleine-K=F6nig <uwe@kleine-koenig.org> 1443549594 +0200
	+=20
	  efm32 cleanups for 4.4-rc1
	 =20
	  These are just two followup cleanups for commits that are in v3.17-r=
c1 and
	@@ -21,7 +25,7 @@
	=20
	 Merge tag 'efm32-for-4.4-rc1' of git://git.pengutronix.de/git/ukl/lin=
ux into next/cleanup
	=20
	-Merge "efm32 cleanups for 4.4-rc1" from Uwe Kleine-K=F6nig:
	+Merge "efm32 cleanups for 4.4-rc1" from Uwe Kleine-Koenig:
	=20
	 These are just two followup cleanups for commits that are in v3.17-rc=
1 and
	 waited in my private tree for application since that time.

So now the PGP-Signature also appears in the regular commit log. So
either remove the mergetag info completely or (preferably) keep it
completely if the merged parent didn't change.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
