From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v5 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 14:33:33 +0100
Message-ID: <20130331133332.GD2286@serenity.lan>
References: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org>
 <cover.1364601337.git.jaseg@physik-pool.tu-berlin.de>
 <51562E79.7000202@physik.tu-berlin.de>
 <87obe0x94e.fsf@linux-k42r.v.cablecom.net>
 <51581617.1030107@physik.tu-berlin.de>
 <039abbea-6a8b-4014-a383-ad2189a6969d@email.android.com>
 <515824C2.1020004@physik.tu-berlin.de>
 <e92b404b-d5e7-489a-90d0-190d1f15177f@email.android.com>
 <51582BA8.90500@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Sebastian =?iso-8859-1?Q?G=F6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Sun Mar 31 15:34:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMIOo-0001od-Jr
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 15:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865Ab3CaNdo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 09:33:44 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:56927 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab3CaNdo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 09:33:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 64406161E396;
	Sun, 31 Mar 2013 14:33:43 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n4zsEm7STSEo; Sun, 31 Mar 2013 14:33:42 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id B29EC161E27E;
	Sun, 31 Mar 2013 14:33:36 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <51582BA8.90500@physik.tu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219620>

On Sun, Mar 31, 2013 at 02:27:20PM +0200, Sebastian G=F6tte wrote:
> On 03/31/2013 02:16 PM, Thomas Rast wrote:
> > "Sebastian G=F6tte" <jaseg@physik.tu-berlin.de> wrote:
> >=20
> >> expecting success:=20
> >> test_must_fail git merge --ff-only --verify-signatures side-untrus=
ted
> >> 2>mergeerror &&
> >>        test_i18ngrep "has a good, untrusted GPG signature" mergeer=
ror
> >>
> >> =3D=3D1430=3D=3D Conditional jump or move depends on uninitialised=
 value(s)
> >> =3D=3D1430=3D=3D    at 0x4C26B5C: strchrnul (mc_replace_strmem.c:7=
11)
> >> =3D=3D1430=3D=3D    by 0x47B90B: check_commit_signature (commit.c:=
1057)
> >> =3D=3D1430=3D=3D    by 0x444212: cmd_merge (merge.c:1245)
> >> =3D=3D1430=3D=3D    by 0x4050E6: handle_internal_command (git.c:28=
1)
> >> =3D=3D1430=3D=3D    by 0x40530C: main (git.c:489)
> >>
> >> Though I also can't see the problem. strchrnul gets passed a char*=
 that
> >> is just fine.
> >=20
> > Usually that means that the string *contents* are uninitialized,
> > usually because you scanned past the end of the string...
>
> I checked for that, everything looks fine to me. The pointer should p=
oint to a valid, 0-terminated string.

It looks like the "found" pointer has wandered off the end of the
string.  In the test case here, the gpg_status is:

-- >8 --
[GNUPG:] SIG_ID rzX3GbdzQyxB4Jdm1uD0CzL4B4Y 2013-03-31 1364735152
[GNUPG:] GOODSIG 61092E85B7227189 Eris Discordia <discord@example.net>
[GNUPG:] VALIDSIG D4BE22311AD3131E5EDA29A461092E85B7227189 2013-03-31
1364735152 0 4 0 1 2 00 D4BE22311AD3131E5EDA29A461092E85B7227189
[GNUPG:] TRUST_UNDEFINED
-- 8< --

But the parse_signature_lines code assumes that after reading a
signature it can fill in the key from the next 16 bytes and then look
for a newline after that.  In this case it clearly needs to only read
the signature if it's a GOODSIG or BADSIG line.

Wrapping a "signature_check[i].result !=3D 'U'" condition around the li=
nes
that extract the key and advance the "found" pointer after doing so
fixes this for me.


John
