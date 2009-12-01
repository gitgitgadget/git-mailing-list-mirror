From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Tue, 1 Dec 2009 19:19:08 +0200
Message-ID: <20091201171908.GA15436@Knoppix>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
 <20091201165245.GF21299@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 18:19:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFWNl-0006n2-Jh
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 18:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbZLARTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 12:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbZLARTH
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 12:19:07 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:55199 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbZLARTG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 12:19:06 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 3CC0CC7C83;
	Tue,  1 Dec 2009 19:19:12 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A07E3939DDF; Tue, 01 Dec 2009 19:19:12 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id BCB632BD44;
	Tue,  1 Dec 2009 19:19:08 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20091201165245.GF21299@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134231>

On Tue, Dec 01, 2009 at 08:52:45AM -0800, Shawn O. Pearce wrote:
> Sverre Rabbelier <srabbelier@gmail.com> wrote:
> > On Tue, Dec 1, 2009 at 14:57, Ilari Liusvaara
> > <ilari.liusvaara@elisanet.fi> wrote:
> > > This series implements extensions to remote helpers for carrying smary
> > > transports. It is against next, because master doesn't contain necressary
> > > patches (the allow specifying remote helper in url one).
> > 
> > Could you please explain how this relates to Shawn's smart http series
> > and the sr/vcs-helper series?

Ability to easily implement smart transports with underlying full-duplex
connection. The smart http stuff has loads of code to reimplement smart
transport client side.

> Or better, why this is even necessary?
> 
> I thought git:// over TCP is pretty simple and efficient, and fairly
> widely deployed.  Smart http(s):// will be in 1.6.6 and available
> soon, and isn't all that ugly.

I consider the authentication parts of smart http pretty ugly. TLS has some
nicer methods, but support for those is nonexistent. Also, I consider piggy-
backing on HTTP when you can have full-duplex connectivity ugly.
 
> Since the introduction of git:// nobody has asked for another
> protocol... other than wanting to make http:// as efficient as
> git:// is.  Which is now done.

Incorrect. I have seen requests for gits:// (and in fact, I have plans to
implement that protocol).

> So why do we need this?

For instance, to support new types of authentication for smart transports
without patching client git binaries (SSH has lots of failure modes that
are quite nasty to debug) or abusing GIT_PROXY (yuck). 

If the server can also handle authentication, it has a lot better idea
where things go wrong and can give better errors to logs or to client
(of course, not too much can be leaked to client or it will be too useful
for attack, but that's seperate topic).

> The sr/vcs-helper series makes sense if you want to make SVN, Hg,
> or P4 remotes act transparently like Git remotes.  But that's not
> embedding the git:// protocol inside of another protocol, its doing a
> full up conversion from a non-Git set of semantics to Git semantics.

This is not about embedding git:// protol inside another. Its about
carrying the subprotocols. These transports share with git:// as much
as file:// and ssh:// share with git:// (note that service request is
given as command, not inside data pipe).

And IIRC, the only thing this needs from sr/vcs-helper is the patch to
allow selecting helper with URL. The first versions of series did contain
self-standing functionality equivalent to that, but that got dropped as
equivalent functionality appeared in upstream.

-Ilari
