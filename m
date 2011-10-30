From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: imap-send badly handles commit bodies beginning with "From <"
Date: Sun, 30 Oct 2011 10:01:11 +0100
Message-ID: <20111030090111.GA1624@jpl.local>
References: <20111028180044.GA3966@foghorn.codeweavers.com>
 <20111028203256.GA15082@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Eikum <aeikum@codeweavers.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 30 10:05:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKRKD-0007oe-G4
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 10:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab1J3JBQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Oct 2011 05:01:16 -0400
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:40065 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab1J3JBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 05:01:15 -0400
Received: from iph3.telenor.se (iph3.telenor.se [195.54.127.134])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 897871476F
	for <git@vger.kernel.org>; Sun, 30 Oct 2011 10:01:13 +0100 (CET)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhsTALIRrU5T46eEPGdsb2JhbABDmWtDjEWCSxkBAQEBNzKBcgEBBAEyASMjBQsLGBwSFBgBDAotiAICBrFriCFhBKVu
X-IronPort-AV: E=Sophos;i="4.69,426,1315173600"; 
   d="scan'208";a="140015892"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by iph3.telenor.se with ESMTP; 30 Oct 2011 10:01:13 +0100
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id E88EF423AE; Sun, 30 Oct 2011 10:01:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111028203256.GA15082@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184468>

On Friday, October 28, 2011 at 22:32 CEST,
     Jeff King <peff@peff.net> wrote:

> On Fri, Oct 28, 2011 at 01:00:44PM -0500, Andrew Eikum wrote:
>=20
> > On the server side, it was split into two mails on either side
> > of that commit message's From line with neither mail actually
> > containing the From line. To fix it, I just changed it to "Copied
> > from <url>:" :-P
> >=20
> > Ain't mbox grand?
>=20
> Mbox does have this problem, but I think in this case it is a
> particularly crappy implementation of mbox in imap-send. Look at
> imap-send.c:split_msg; it just looks for "From ".

While there seems to be about a million different implementations of
mbox creation and parsing, the relevant RFC[0] points to [1] as an
authoritative source. The latter claims that lines matching "^From "
denote a message boundary and that lines within a message that match
the same pattern should be quoted with ">". That would suggest that
the problem isn't imap-send.c but whatever code produces the mbox
file in the first place. Of course, if that software isn't part of
Git I guess we'll have to deal with the situation anyway. And whatever
the RFCs say, we still need to be as compatible is possible with
whatever software is out there.

> It should at least check for something that looks like a timestamp,
> like git-mailsplit does. Maybe mailsplit's is_from_line should be
> factored out so that it can be reused in imap-send.

I guess that's a reasonable "liberal in what you accept" mitigation.

(As a sidenote, I'm getting the ">From" quoting in my maildir message
files where no such quoting is expected, so "From" lines are shown as
">From" in my MUA. I don't know if it's Procmail screwing things up or
what's going on.)

[0] http://tools.ietf.org/html/rfc4155
[1] http://qmail.org./man/man5/mbox.html

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
