From: Jeff King <peff@peff.net>
Subject: Re: Git global usage and tests
Date: Tue, 31 May 2011 11:04:55 -0400
Message-ID: <20110531150455.GA2594@sigill.intra.peff.net>
References: <754E784F-51C6-4B8D-B15D-3FF8B7AF1321@gmail.com>
 <20110530153620.GA24431@sigill.intra.peff.net>
 <B369AA28-DEF2-48F3-8E4E-F387E8A57D26@gmail.com>
 <20110530161230.GA25291@sigill.intra.peff.net>
 <7v7h97la4s.fsf@alter.siamese.dyndns.org>
 <BANLkTinW_se8VAhF9wk3KyzNHVc_wH_PqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Romain Geissler <romain.geissler@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 17:05:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRQVE-0004FH-SS
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 17:05:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609Ab1EaPE7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2011 11:04:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45418
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348Ab1EaPE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 11:04:58 -0400
Received: (qmail 25410 invoked by uid 107); 31 May 2011 15:05:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 May 2011 11:05:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2011 11:04:55 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinW_se8VAhF9wk3KyzNHVc_wH_PqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174804>

On Tue, May 31, 2011 at 01:52:31PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> > IIRC, libgit2 has a lot looser license than ours, and the core GPLv=
2 part
> > of C git cannot be directly copied without authors' consent; relice=
nsing
> > of necessary parts of C git needs to be arranged.
>=20
> Seems like a PITA:

Some of the permission has already been granted. There is a file in
libgit2 documenting who has done so.  The set difference is:

  $ git log --format=3D%an parse-options.[ch] | sort -u >need
  $ perl -lne 'print $1 if /^ok\s+(.*) </' libgit2/git.git-authors >hav=
e
  $ comm -23 need have >remaining; cat remaining
  Alex Riesen
  Andreas Schwab
  Carlos Rica
  Gary V. Vaughan
  Giuseppe Scrivano
  Jake Goulding
  Jonathan Nieder
  Mark Lodato
  Michael J Gruber
  Michele Ballabio
  Mike Ralphson
  Miklos Vajna
  Nanako Shiraishi
  Olivier Marin
  Stephen Boyd
  Thomas Rast
  Tuncer Ayaz

which gets us halfway there. A few of the remaining contributions are
quite small, too:

  $ git blame --line-porcelain parse-options.c |
      perl -lne 'print $1 if /author (.*)/' |
      sort | uniq -c |
      perl -pe 's/(\d+) /$1\t/' >count
  $ join -1 1 -2 2 -t "`printf '\t'`" -o "2.1 2.2" remaining count
      4 Alex Riesen
      3 Andreas Schwab
     23 Giuseppe Scrivano
     16 Jake Goulding
     38 Jonathan Nieder
     16 Mark Lodato
      7 Michele Ballabio
      1 Nanako Shiraishi
      1 Olivier Marin
     46 Stephen Boyd
     24 Thomas Rast
     22 Tuncer Ayaz

=46ixing a typo or tweaking the "static" designator on a function is
probably not copyrightable. And some of the medium-sized bits could
possibly be dropped. Still, it is nice to be mindful of the
contributions of others and get permission from everyone.

At any rate, the parse-options code would be linked into the new git2
binary, which should probably be GPL'd, anyway.

-Peff
