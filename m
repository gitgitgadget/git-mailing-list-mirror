From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Fri, 22 Jun 2007 13:51:17 -0400
Message-ID: <20070622175117.GA16921@yugib.highrise.ca>
References: <20070621030622.GD8477@spearce.org> <20070621131915.GD4487@coredump.intra.peff.net> <alpine.LFD.0.98.0706210910390.3593@woody.linux-foundation.org> <200706221619.30521.andyparkins@gmail.com> <Pine.LNX.4.64.0706221626450.4059@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	govindsalinas <govindsalinas@yahoo.com>, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 22 19:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1nI1-0000XG-Lb
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 19:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758644AbXFVRvU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 13:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758380AbXFVRvT
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 13:51:19 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:39778 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbXFVRvT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 13:51:19 -0400
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 9D217111E33;
	Fri, 22 Jun 2007 13:51:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706221626450.4059@racer.site>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50706>


--IuhbYIxU28t+Kd57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Johannes Schindelin <Johannes.Schindelin@gmx.de> [070622 13:34]:
> Hi,
> 
> On Fri, 22 Jun 2007, Andy Parkins wrote:
> 
> > What if two files with different filenames and content converge at some 
> > point in history, then diverge again?  If git is tracking renames merely 
> > by content and picks the wrong one, then the history of fileA suddenly 
> > becomes the history of fileB.
> 
> This is becoming highly ethereal. Like "I could imagine that some day in 
> future, some person could devise a device, that might allow you to do 
> something that I can not explain, because I have not even thought of it".
> 
> IOW show me a reasonable example, and we'll talk business.

The one time the "content-only" rename tracking bit me was the
after a merge, resulting in conflicts that were un-nessesary:

-*-*-*-*-A-B-C-D
	  \
	   *-E-*

At A, there were 2 files:
	dir1/foo
	dir2/foo
They were template files that happened to be the same in 2 themes.

In E, "foo" was renamed to "foo-bar" in all the template directories.
Git detected this not as 2 renames, but as:
	dir1/foo-bar renamed from dir1/foo
	dir2/foo-bar copied from dir1/foo
	dir2/foo deleted

Meanwhile, work was happening in B, C, and D, changing foo in both
templates identically.

When the branch with E was merged back into ABCD, there was a merge
conflict with dir2/foo being deleted in one branch, and editit in the
other.

In this case, the simple "basename" comparison wouldn't have even been
enough.  

But the merge was easy enough (because no edits were made in the E
branch to those files, just the renames) that I could resolve it easily.

I don't know if preventing this easy-to-fix merge conflict is worth the
necessary "likeness of names" necessary to avoid it...

a.

-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGfAwVuVxNPsxNPScRAlxcAJ0Wv1j+0KhP+xgQRu+BcChen3iDHgCfTTLn
cRkT0CoWamP/UUSpJvPJV9c=
=Z2tZ
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--
