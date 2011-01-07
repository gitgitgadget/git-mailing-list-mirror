From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Fri, 7 Jan 2011 23:45:01 +0200
Message-ID: <20110107214501.GA29959@LK-Perkele-VI.localdomain>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
 <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
 <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
 <20110107052207.GA23128@sigill.intra.peff.net>
 <20110107053119.GA23177@sigill.intra.peff.net>
 <20110107185218.GA16645@LK-Perkele-VI.localdomain>
 <20110107191719.GA6175@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 22:45:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbK7Z-0002jN-H1
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 22:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab1AGVoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 16:44:55 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:36121 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab1AGVoy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 16:44:54 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 3403EC7DD5;
	Fri,  7 Jan 2011 23:44:53 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01F362EA56; Fri, 07 Jan 2011 23:44:53 +0200
Received: from LK-Perkele-VI (a88-112-56-215.elisa-laajakaista.fi [88.112.56.215])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id B533A402E;
	Fri,  7 Jan 2011 23:44:47 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20110107191719.GA6175@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164767>

On Fri, Jan 07, 2011 at 02:17:19PM -0500, Jeff King wrote:
> On Fri, Jan 07, 2011 at 08:52:18PM +0200, Ilari Liusvaara wrote:
> 
> > 
> > git clone --use-mirror=~/repositories/linux-2.6 git://foo.example/linux-foo
> > 
> > This would first fetch everything from local source and then update that
> > from remote, likely being vastly faster.
> 
> I'm not clear in your example what ~/repositories/linux-2.6 is. Is it a
> repo? In that case, isn't that basically the same as --reference? Or is
> it a local mirror list?

Yes, it is a repo. No, it isn't the same as --reference. It is list
of mirrors to try first before connecting to final repository and can
be any type of repository URL (local, true smart transport, smart HTTP,
dumb HTTP, etc...)

Idea is that you have list of mirrors that are faster than the final
repository, but not necressarily complete. You want to download most of
the stuff from there.

> If the latter, then yeah, I think it is a good idea. Clients should
> definitely be able to ignore, override, or add to mirror lists provided
> by servers. The server can provide hints about useful mirrors, but it is
> up to the client to decide which methods are useful to it and which
> mirrors are closest.

This is essentially adding mirrors to mirror list (modulo that mirrors
are not assumed to be complete).

Security:

Confidentiality: The connection to mirror must transverse only trusted
links or be encrypted if material from mirror is sensitive.

Integerity: The same integerity as the connection to final repo (assuming
SHA-1 can't be collided) due to fact that git object naming is securely
unique.

> Of course there are some servers who will want to do more than hint
> (e.g., the gentoo case where they really don't want people cloning from
> the main machine). For those cases, though, I think it is best to
> provide the hint and to reject clients who don't follow it (e.g., by
> barfing on somebody who tries to do a full clone). You have to implement
> that rejection layer anyway for older clients.

With option like this, a client could do:

git clone --use-mirror=http://git.example.org/base/foo git://git.example.org/foo

To first grab stuff via HTTP (well-packed dumb HTTP is very light on the
server) and then continue via git:// (now much cheaper because client is
relatively up to date).

-Ilari
