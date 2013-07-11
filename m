From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Thu, 11 Jul 2013 12:57:33 +0200
Message-ID: <20130711105733.GG10217@login.drsnuggles.stderr.nl>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin>
 <7vip78go6b.fsf@alter.siamese.dyndns.org>
 <CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com>
 <7vvcb8f6aw.fsf@alter.siamese.dyndns.org>
 <20130528091812.GG25742@login.drsnuggles.stderr.nl>
 <7va9nf2fyp.fsf@alter.siamese.dyndns.org>
 <20130709133542.GJ10217@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 11 12:57:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxEZM-0005Kv-4z
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 12:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120Ab3GKK5s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jul 2013 06:57:48 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:46131 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab3GKK5r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 06:57:47 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1UxEZ3-0000hs-Rz; Thu, 11 Jul 2013 12:57:34 +0200
Received: (nullmailer pid 2715 invoked by uid 1000);
	Thu, 11 Jul 2013 10:57:33 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20130709133542.GJ10217@login.drsnuggles.stderr.nl>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230083>

Hi Junio,

> While implementing the above, I noticed my fix now introduced an
> off-by-one error the other way. When investigating, I found this comm=
it:
>=20
> 	commit 682c7d2f1a2d1a5443777237450505738af2ff1a
> 	Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
> 	Date:   Fri Jan 11 16:05:47 2013 +0700
>=20
> 	    upload-pack: fix off-by-one depth calculation in shallow clone
>=20
> 	    get_shallow_commits() is used to determine the cut points at a g=
iven
> 	    depth (i.e. the number of commits in a chain that the user likes=
 to
> 	    get). However we count current depth up to the commit "commit" b=
ut we
> 	    do the cutting at its parents (i.e. current depth + 1). This mak=
es
> 	    upload-pack always return one commit more than requested. This p=
atch
> 	    fixes it.
>=20
> 	    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pcloud=
s@gmail.com>
> 	    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>=20
> Which actually seems to fix the off-by-one bug that is described in t=
his
> thread, but without going through the hoops of preserving current
> behaviour for older git versions (that is, it makes behaviour depende=
nt
> on server version instead of client version).
>=20
> Does this mean the discussion in this thread is meaningless, or is th=
at
> commit not intended to be the final fix?
Looking more closely, I also see that the above change is already
released in 1.8.2 versions. Given that, I don't think it makes sense to
to still try to provide this capability to get backward compatible
behaviour, since this would cause a off-by-one error the other way when
talking to 1.8.2.x servers...

However, since I pretty much finished the code for this, I'll send over
the patches and let you decide wether to include them or not. If you
want to include them but they need to be changed in some way, just let
me know.

The first patch of the series should be merged regardless.

Gr.

Matthijs
