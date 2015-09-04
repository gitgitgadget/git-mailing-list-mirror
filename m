From: "Rustad, Mark D" <mark.d.rustad@intel.com>
Subject: git grep broken in Fedora 21 update?
Date: Fri, 4 Sep 2015 00:04:38 +0000
Message-ID: <9CAA4751-D295-4ACE-8ED6-720D728D24EA@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="Apple-Mail=_9E59C17A-DB32-44F2-BCB5-CCA16A61B155";
	protocol="application/pgp-signature"; micalg=pgp-sha256
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 02:05:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXeVu-00052I-RZ
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 02:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbbIDAFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 20:05:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:21866 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932631AbbIDAFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 20:05:07 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP; 03 Sep 2015 17:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,465,1437462000"; 
   d="asc'?scan'208";a="797866097"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2015 17:04:40 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.224.2; Thu, 3 Sep 2015 17:04:39 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.229]) by
 ORSMSX112.amr.corp.intel.com ([169.254.12.185]) with mapi id 14.03.0224.002;
 Thu, 3 Sep 2015 17:04:39 -0700
Thread-Topic: git grep broken in Fedora 21 update?
Thread-Index: AQHQ5qVKe24frU5S90mLvqnTJFkmJA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.176.76]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277282>

--Apple-Mail=_9E59C17A-DB32-44F2-BCB5-CCA16A61B155
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I just found a case where grep and git grep yield different results. =
Inside the ixgbe directory of the Linux kernel I did:

$ grep enter_lplu *.[ch]

And got the following:

ixgbe_main.c:	if (adapter->hw.phy.ops.enter_lplu) {
ixgbe_main.c:		adapter->hw.phy.ops.enter_lplu(&adapter->hw);
ixgbe_type.h:	s32 (*enter_lplu)(struct ixgbe_hw *);
ixgbe_x550.c:/** ixgbe_enter_lplu_x550em - Transition to low power =
states
ixgbe_x550.c:static s32 ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
ixgbe_x550.c:			phy->ops.enter_lplu =3D =
ixgbe_enter_lplu_t_x550em;

But when I did:

$ git grep enter_lplu

I got:

ixgbe_main.c:   if (adapter->hw.phy.ops.enter_lplu) {
ixgbe_main.c:           adapter->hw.phy.ops.enter_lplu(&adapter->hw);
ixgbe_type.h:   s32 (*enter_lplu)(struct ixgbe_hw *);
ixgbe_x550.c:/** ixgbe_enter_lplu_x550em - Transition to low power =
states
ixgbe_x550.c:static s32 ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)

You can see that git grep missed the line in ixgbe_x550.c that had two =
hits on the string.

This was with git 2.1.0 in Fedora 21. I use git grep a lot and never =
noticed a problem before. I just updated my Fedora 21 system yesterday, =
so I have to figure that has something to do with it. I checked and git =
didn't get updated, so I figure it must be a library that is really =
broken.

I see in my update log that pcre was updated to:

pcre.x86_64 0:8.35-12.fc21
pcre-devel.x86_64 0:8.35-12.fc21

Yet the grep command is unaffected.

--
Mark Rustad, Networking Division, Intel Corporation


--Apple-Mail=_9E59C17A-DB32-44F2-BCB5-CCA16A61B155
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCAAGBQJV6OAWAAoJEDwO/+eO4+5ukKgP/3kNnZBauAUDXS1uEtCdJEK4
JVxn0C+5FZaYVlC8v3mSJvp3nMF2N4c57/uDDSJynUvemEg1l5b0KVa1KXHs1Y4b
Mm53BJFBARGKsSHu18e9FRlaEBol3V2bWpYpZLlnRWI7+xY07GPojnzT3uradETj
s5YuwvQWdG05Ejx1DIrYSxc9IEtNBaroDY/qRBuVo5rD0OIeNzYFsenla4Ax1rXA
cytcbfH5FZVvTCVlNJv9YTO6pDd2t3BrTW4n73+Y5l8rh8c1YIlzC6BcR60MKNMN
50NsaT65v5ENaW16HKhuKdLnq/3N/Rb6LjT2347PgAoNtc6DrTgG0NlywMnS+dJb
hCe52Oj8gQ2a1jYsjzoYB9y244hJJBDF0yJ6HFlqZ4bsZadTzi+zw4PpnYG2XyDk
gNOW39tChyBCJM2YbKt+Lavlkgmj7rNfA3tp4ZsynfL7akWzE7WfC50FJpv+wlc2
BXUMVmEZj8LIchZiQR0Kjt2Z3/KJpERaEFGr07m0bNp1kkSr1kWCDcX17JsFJUyV
P+RIhZB5SscEJJnLXYneVm5uM3OLwtSS7DjG4dVKiXu7MHW9xSrcaxF4RonMz5Op
n84w9oRXeZGQHu5N941blPZmFhjOa94vRUk+BceF2RkyIdSw5JvOW3EXpwW6kyfA
D4ixpmvXPlzQmiTAZUDE
=uwDW
-----END PGP SIGNATURE-----

--Apple-Mail=_9E59C17A-DB32-44F2-BCB5-CCA16A61B155--
