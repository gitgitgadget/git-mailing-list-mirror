From: Jeff King <peff@peff.net>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 8 Jun 2011 11:01:06 -0400
Message-ID: <20110608150106.GB7805@sigill.intra.peff.net>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: thomas@xteddy.org, git@vger.kernel.org
To: =?utf-8?B?SsOpcsOpbWll?= NIKAES <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:01:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKG1-0002w3-9u
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab1FHPBL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 11:01:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37594
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab1FHPBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 11:01:09 -0400
Received: (qmail 30869 invoked by uid 107); 8 Jun 2011 15:01:16 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 11:01:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 11:01:06 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175377>

On Wed, Jun 08, 2011 at 03:45:43PM +0200, J=C3=A9r=C3=A9mie NIKAES wrot=
e:

> my $mw =3D MediaWiki::API->new();
> $mw->edit( {
>         action =3D> 'edit',
>         title =3D> 'Main_page',
>         text =3D> '=C3=A9t=C3=A9',
> } ) ;
> [...]
> While googling (a lot), I found that utf8 was pretty tricky in perl..=
=2E
> The only thing that seems to solve things is a simple addition of 'us=
e
> encoding utf8' at the top of our script.
> However
> A) Adding this line requires that I remove 'use strict;'
> B) I found some information about this pragma encoding and it seems t=
o
> be unadvised to use it

=46rom the "utf8" man page:

  Do not use this pragma for anything else than telling Perl that your
  script is written in UTF-8.

which is what you are doing here, since you are telling perl that the
string constant is in utf8. So from my understanding, "use utf8" is the
right solution.

That being said, this is probably just a small test case, and you are
more likely to be reading the data from a file.

=46or file contents, you can use:

  binmode($handle, ":utf8");

to read everything in as utf8.

=46or file names themselves, I think it depends where you get them.
Presumably from readdir() or from a glob. I think you can use
utf8::upgrade($string) on the result to make sure they are interpreted
as utf8 (if you already know that is how the bytes in the filename
should be interpreted).

But I admit I am not an expert on such matters, and every time I do utf=
8
things in perl, I end up with a lot of trial and error.

-Peff
