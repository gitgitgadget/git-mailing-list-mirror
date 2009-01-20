From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the reflogs twice
Date: Tue, 20 Jan 2009 01:41:08 +0100
Message-ID: <200901200141.14129.trast@student.ethz.ch>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <200901200111.38917.trast@student.ethz.ch> <alpine.DEB.1.00.0901200121190.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1390605.oykVZTuqBG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 01:42:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP4hG-0000hs-0w
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 01:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbZATAlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 19:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754919AbZATAk7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 19:40:59 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24463 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754362AbZATAk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 19:40:59 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Jan 2009 01:40:58 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Jan 2009 01:40:57 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.18-0.2-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0901200121190.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 20 Jan 2009 00:40:57.0669 (UTC) FILETIME=[C2630750:01C97A97]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106419>

--nextPart1390605.oykVZTuqBG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> 1) it introduces a lot of code, with a lot of possibility for bugs to hid=
e=20

And I can understand in the case of read_ref_at() since there the
translation is really nontrivial (though I'd readily put the blame on
the optimized-to-death original code ;-).  But in the case of
for_each_reflog_ent(), it should be really straightforward.

> 2) on Windows, mmap() is really implemented as xmalloc() && fread().  So=
=20
>    all the shortcomings of what Junio said about my array approach would=
=20
>    hold true for your approach, too.

But the @{} syntax _already_ uses mmap via read_ref_at().  And both
uses of for_each_reflog_ent() I'm aware of, the existing git log -g
and the present @{-N} syntax, have to read to the end anyway because
they're mostly interested in the newer stuff.

So while the mmap() might occasionally grab a few more MB of RAM than
would actually be required with simple line-based input, Windows
has to read the whole reflog no matter what.

(Well, unless we make a for_each_reflog_ent_backward() that can jump
in somewhere near the end and start parsing lines backwards.)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1390605.oykVZTuqBG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl1HaoACgkQqUud07tmzP1VWgCglQZgZZ/HLMnhFupOzsn+a4Ey
7qAAn0fUWzhJtDw0xwtQDKeEO3gqP3VZ
=sOwi
-----END PGP SIGNATURE-----

--nextPart1390605.oykVZTuqBG--
