From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Thu, 14 Jan 2010 10:51:25 +0200
Message-ID: <20100114085124.GA10298@Knoppix>
References: <20100113173610.GA7609@Knoppix>
 <20100113183520.GA23674@inner.home.ulmdo.de>
 <20100113191802.GA8110@Knoppix>
 <32541b131001131130i6afae1a1xd3a70e5de5daa5cf@mail.gmail.com>
 <20100113200629.GA8383@Knoppix>
 <32541b131001131213m75b4baefsc70a4cbf3c8431c8@mail.gmail.com>
 <20100113210414.GA8535@Knoppix>
 <32541b131001131403u162bc6ebpd551ed19aadde7fb@mail.gmail.com>
 <20100113230023.GA9171@Knoppix>
 <32541b131001131551m38ff02acpdd08d9f0562ac84d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Krey <a.krey@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 09:51:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVLQW-0002Az-0g
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 09:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542Ab0ANIvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 03:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756540Ab0ANIvc
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 03:51:32 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:51707 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab0ANIvb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2010 03:51:31 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 2E3EB13B771;
	Thu, 14 Jan 2010 10:51:30 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A02CBA2EB9D; Thu, 14 Jan 2010 10:51:30 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id EEE6C27DA1;
	Thu, 14 Jan 2010 10:51:25 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <32541b131001131551m38ff02acpdd08d9f0562ac84d@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136969>

On Wed, Jan 13, 2010 at 06:51:03PM -0500, Avery Pennarun wrote:
> On Wed, Jan 13, 2010 at 6:00 PM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
> > On Wed, Jan 13, 2010 at 05:03:45PM -0500, Avery Pennarun wrote:
> >
> > No client-side fallbacks, key auth works pseudonymously. That takes
> > care of them pretty well.
>=20
> Perhaps I'm being dense, but I don't understand what you mean by
> either of those.

The client tries only one auth method instead of potentially trying
multiple. Witness the 'use verbose mode and check if it uses the key'
type stuff.

With keypair auth, the server can accept arbitrary (valid) keypair,
but only limited set have special priviledges -> Cuts down significantl=
y
on "why this doesn't accept the key" problems (the keyid is usually
printed on denied access).

> >> If you solve your main
> >> annoyances with ssh, how do you know you won't introduce any new
> >> annoying failure modes?
> >
> > Ensuring that at least some information make back to client (presua=
bly
> > enough to figure out the problem).
>=20
> Unfortunately revealing information like that is a compromise; it
> helps attackers as well as legitimate users.  It's the same reason
> login prints "invalid username or password" instead of choosing
> between "invalid username" and "invalid password."

Yeah. Sometimes one must chose balance between being helpful to users
and being helpful for attackers.

> >> *Why* can't ssh be fixed to solve the =C2=A0problem?
> >
> > Client side fallbacks (may be desired or not!), service not being
> > able to intervene on wheither to allow client or not in case of
> > keypair auth.
>=20
> I don't understand that answer.  Couldn't ssh be patched to do
> whatever you want?  Particularly if it's just better (optional)
> diagnostics, you'd think someone would accept the patch for that.

OpenSSH? With the level of paranoia in it, I'd say good luck. And
it's not just client, its the server also (and especially the
server).

> >> =C2=A0Will I have to generate and manage yet another new set of
> >> keys to use the new system?
> >
> > Yes.
>=20
> Ouch.

Well, usually that means one keypair to generate and exchanging
keyids.

And if you host the repo system too, you would get second key anyway
(and SSH is not too good at handling multiple keys).

> > Well, if you like SSH more, then use ssh://...
>=20
> I'm just looking for a justification for why I *shouldn't* like ssh
> more.  Is the only reason the fact that it might be easier to
> initially configure the key exchange?

And besides, gits:// is for host multiple repos type stuff, not for
private repos on your account (use the ssh:// for those, and there the
failure modes of SSH matter much less).

-Ilari
