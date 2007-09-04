From: Daniel Hulme <st@istic.org>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 17:20:19 +0100
Message-ID: <20070904162019.GA10441@istic.org>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com> <20070904025153.GS18160@spearce.org> <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:20:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISb8f-0000Fa-H6
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbXIDQU0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbXIDQUZ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:20:25 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:47679 "EHLO mail3.uklinux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679AbXIDQUY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:20:24 -0400
Received: from presteign (cpc2-cmbg3-0-0-cust106.cmbg.cable.ntl.com [86.7.28.107])
	by mail3.uklinux.net (Postfix) with ESMTP
	id 6CCEE1F6B28; Tue,  4 Sep 2007 17:20:20 +0100 (BST)
Received: from z1 by presteign with local (Exim 4.67)
	(envelope-from <st@istic.org>)
	id 1ISb8V-0002uf-G1; Tue, 04 Sep 2007 17:20:19 +0100
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57608>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2007 at 11:26:30PM -0400, Jon Smirl wrote:
> This is something that has always bugged me about file systems. File
> systems force hierarchical naming due to their directory structure.
> There is no reason they have to work that way. Google is an example of
> a giant file system that works just fine without hierarchical
> directories. The full path should be just another attribute on the
> file. If you want a hierarchical index into the file system you can
> generate it by walking the files or using triggers. But you could also
> delete the hierarchical directory and replace it with something else
> like a full text index. Directories would become a computationally
> generated cache, not a critical part of the file system. But this is a
> git list so I shouldn't go too far off into file system design.

Am I the only one who thinks that this idea of moving filenames from
tree objects into blobs does the *opposite* of what you're trying to
achieve?

It seems, though I could be completely misinterpreting what you're
saying, that you want to be able to get rid of directories and replace
them with some other index into your files: maybe a full-text index,
maybe a spatial index for geographic data, maybe something else
entirely. As things stand, you could do that by editing the core to
introduce a new object type 'fulltext' whose contents maybe look like

aardvark <sha1 of a blob> <sha1 of another blob>
abacus <sha1>
=2E..
zebra <yet another sha1> <maybe the same sha1 I mentioned before>

or even something hierarchical, with each index mapping from the first
letter of the index term to the sha1 of another index, which in term
maps second letters, and so on. Whatever. The point is, it works
parallel to tree. You could have the blobs referenced by your fulltext
object also be referenced by a tree object. If you really don't like
directory trees, you can dispense with tree objects in your repo
entirely. Either way you have a mapping from keys to blobs.

Then you could have your commits and tags include sha1's of fulltext
objects rather than (or as well as) tree objects, and you get your wish.

OTOH, imagine if you move filenames into the blobs. Now, no matter what
other index types you introduce, they'll always be secondary to the
traditional, path-and-filename method of finding files. Crucially, you
can't introduce new blobs into the repo without giving them filenames.

As you said in your other thread,

> Integrating indexing into the data is not normally done in a database.

But isn't this exactly what integrating filenames into blobs would do?

--=20
There is no such thing as a small specification change.
http://surreal.istic.org/            Forcing the lines through the snow.

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG3YXDgoQ42ohbFw0RAk+OAJ4paDoJD71rOwYUsBxwfjZ+Z1I/sACfeMju
Fn4ZqZC/SumoYdte+GwTYRM=
=7R6G
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
