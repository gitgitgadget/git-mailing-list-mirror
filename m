From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Wed, 7 Feb 2007 17:55:32 -0500
Message-ID: <20070207225532.GA1970@spearce.org>
References: <20070206023111.GB9222@spearce.org> <45C81C33.6010704@gmail.com> <20070206061817.GB10508@spearce.org> <Pine.LNX.4.64.0702062347060.20138@iabervon.org> <20070207091351.GA1632@diana.vm.bytemark.co.uk> <Pine.LNX.4.63.0702071216330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 07 23:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvhZ-000055-Vt
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161303AbXBGWzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Feb 2007 17:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161475AbXBGWzm
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:55:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45825 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161474AbXBGWzl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Feb 2007 17:55:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEvhE-0003Ci-St; Wed, 07 Feb 2007 17:55:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9190020FBAE; Wed,  7 Feb 2007 17:55:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702071216330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38988>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 7 Feb 2007, Karl Hasselstr=F6m wrote:
> > In other words, general history rewriting, but fast.
>=20
> For this, it would be better to use a different approach: fast-import=
=20
> still hashes all the objects, which would not be necessary when rewri=
ting.=20
> I guess that is what cogito's tool is doing.

gfi doesn't require that it rehash blob objects.

If the blobs in question are already available in the repository
gfi is running against (say, from the old branch history) you
can just feed those blob SHA-1s at gfi in its 'M' commands when
making commits.  Yes gfi will need to recompute the tree hashes
from scratch, but those are certainly smaller and faster to create
than blobs.

So you probably could make a faster history rewriter by taking
the output of say `git log --pretty=3Draw --raw -z`, filter that and
reverse it, and stream it into gfi.  It probably would kick Cogito's
cg-admin-rewritefilter thing in the teeth, as you are forking just
one gfi process rather than a thousand git-commit-tree processes.

And if you are doing more complex pathname translations than just
picking out a subtree, it also completely avoids needing to read and
write index files via update-index, or tree objects by write-tree.

--=20
Shawn.
