From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/1] jgit: create a tag command
Date: Thu, 17 Jul 2008 21:45:20 +0000
Message-ID: <20080717214520.GB2798@spearce.org>
References: <200807070041.35873.robin.rosenberg.lists@dewire.com> <20080712030104.GB15838@spearce.org> <20080712034206.GA16101@spearce.org> <200807172331.18059.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 23:46:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJbIt-0003gw-Rn
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 23:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761102AbYGQVpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 17:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbYGQVpW
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 17:45:22 -0400
Received: from george.spearce.org ([209.20.77.23]:39386 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932507AbYGQVpV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 17:45:21 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9D6B5382A4; Thu, 17 Jul 2008 21:45:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200807172331.18059.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88925>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> l=C3=B6rdagen den 12 juli 2008 05.42.06 skrev Shawn O. Pearce:
> > Probably the state-of-the-arg is args4j:
> >=20
> >   https://args4j.dev.java.net/
> >=20
> > It uses Java 5 annotations to setup the argument parsing:
>=20
> But it doesn't use GNU getOpt's long/short style parsing which is a B=
IG loss. Maybe
> we could contribute it? Or at least not design options incompatible w=
ith such an option
> parser.

I'm already using long style options, "--git-dir", "$path" works,
and I taught a subclass wrapper to split "--git-dir=3D$path" into
the two argument format so we can handle the GNU style long options.

Short style options are harder.  You can alias "-h" to "--help"
and have both respond, but you cannot get option clusters like
"-ar" to expand to "-a","-r" and then parse.  I could have the same
wrapper handle splitting "-ar" into "-a","-r" but it cannot handle
"-C80r" as "-C80","-r" as it doesn't have any information about
what options take values, and which don't.


Getting "--" to terminate the end of options is supported, but
making it handle `git log ref -- path` was interesting.  I had to
make "--" actually an option name, and have it eat all values after
"--" as path specs to implement git-log style arguments.

Looking at the code further its fairly simple.  I don't think it
would be difficult for us to tweak what we need, and try to push
patches upstream.  Well worthwhile actually.  The parser made our pgm
package shorter, and we didn't have to waste time writing our own.
Its well built, and was (mostly) easily extended to handle fully
transparent String->RevCommit or String->RevTree parsing.  So its
worth the few minutes to improve it further.

--=20
Shawn.
