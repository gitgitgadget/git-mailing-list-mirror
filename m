From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] Documentation/notes: simplify treatment of default
 display refs
Date: Wed, 12 May 2010 07:23:43 -0400
Message-ID: <20100512112342.GA23847@coredump.intra.peff.net>
References: <20100509031357.GA7926@progeny.tock>
 <20100509033223.GF7958@progeny.tock>
 <20100509070022.GC23717@sigill.intra.peff.net>
 <20100509084325.GA9801@progeny.tock>
 <20100510060630.GC13340@coredump.intra.peff.net>
 <20100512105002.GB17740@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 13:23:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCA2c-0005UM-KA
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 13:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661Ab0ELLXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 May 2010 07:23:49 -0400
Received: from peff.net ([208.65.91.99]:56915 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608Ab0ELLXs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 07:23:48 -0400
Received: (qmail 2941 invoked by uid 107); 12 May 2010 11:23:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 May 2010 07:23:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 May 2010 07:23:43 -0400
Content-Disposition: inline
In-Reply-To: <20100512105002.GB17740@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146940>

On Wed, May 12, 2010 at 05:50:02AM -0500, Jonathan Nieder wrote:

> > Searching
> > for "conflict" even in just a list of options should come up with
> > "merge.conflictstyle", and I had always intended for such a gitconf=
ig.5
> > to have a full list.
>=20
> Makes sense.  So the breakdown of that page might be
>=20
>   Synopsis
>   Description
>     Syntax
>   Configuration items
>     Sections
>     Index
>   Core configuration
>   Identity
>   Suppressing advice
>   Command aliases
>   Colored output
>   Paginated output
>   Examples
>   See also

Yes, I think that is sane. One other option would be to put a few thing=
s
like "identity" into git(1) (where it would presumably be part of an
overall identity section covering the concepts, config options, and
environment variables).

> To keep this maintainable, I would like to have a single source file
> with a short and long description for each configuration item.  Then
> a script would process it into an index and snippets for the relevant
> command pages.

My plan was to actually include the config's long description in the
relevant manpage (so it will be close to point of use, and you can see
the context while editing), and then pull the information out of each
page for the index. Adding a short description would probably be
simplest as a specially formatted comment. E.g., in git-add.txt:

   add.ignore-errors::
   // @CONFIG: ignore errors on 'git-add'
           Continue adding files when some files cannot be added due to
           indexing errors. Equivalent to using '--ignore-errors'.

and then process it with something like:

  perl -ne '
    m{^// @CONFIG: (.*)} && print "$last - $1\n"; $last =3D $_
  ' git-*.txt >config-index.txt

So it's sort of literate programming for documentation. :) The comment
thing is obviously a hack, but it should work well in practice. You
might be able to do some semantic markup with special attributes in
asciidoc.

> I=E2=80=99m anxious to get started.  Thanks for the pointers.

I'm happy you're working on this. Thanks.

-Peff
