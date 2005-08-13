From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Fwd: Re: git checkout -f branch doesn't remove extra files
Date: Sat, 13 Aug 2005 16:10:53 +0400
Message-ID: <20050813161053.29593972.vsu@altlinux.ru>
References: <20050813041737.GB25236@redhat.com>
	<Pine.LNX.4.58.0508122151120.19049@g5.osdl.org>
	<20050813110050.GA5608@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__13_Aug_2005_16_10_53_+0400_w5CvMoT9ESAJj7tr"
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 14:11:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3uri-0007qd-H8
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 14:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVHMMLw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 08:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVHMMLv
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 08:11:51 -0400
Received: from mail.murom.net ([213.177.124.17]:51887 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S932155AbVHMMLu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 08:11:50 -0400
Received: from [172.17.7.8] (helo=procyon.home)
	by ns1.murom.ru with esmtp (Exim 4.42)
	id 1E3uqw-00013Q-8b; Sat, 13 Aug 2005 16:11:06 +0400
Received: by procyon.home (Postfix, from userid 500)
	id 4E7B6E3CF1C; Sat, 13 Aug 2005 16:10:57 +0400 (MSD)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050813110050.GA5608@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Signature=_Sat__13_Aug_2005_16_10_53_+0400_w5CvMoT9ESAJj7tr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 13 Aug 2005 13:00:51 +0200 Petr Baudis wrote:

> Dear diary, on Sat, Aug 13, 2005 at 07:05:11AM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> told me that...
[...]
> > 	snap=git-snapshot-$(date +"%Y%m%d")
> > 	git-tar-tree HEAD $snap | gzip -9 > $snap.tar.gz
> > 
> > which is even easier, and a hell of a lot more efficient.
> 
> To put my two cents too, Cogito has cg-export for this:
> 
> 	cg-export tmp-dir
> 
> to export to a temporary directory and
> 
> 	cg-export git-snapshot.tar.gz
> 
> to export to a gzipped tarball (it can also do .tar, .tgz and .tar.bz2).

However, cg-export is buggy - if you use the second argument
(cg-export DESTFILE TREE_ID), the resulting tar file is different
from what git-tar-tree produces for the same TREE_ID (unless that
TREE_ID actually points to a tree - but in practice a commit or even
tag ID is typically used).

The problem is in this line:

id=$(tree-id "$2")

This converts the passed commit or tag to the underlying tree, which
is then passed to git-tar-tree.  However, git-tar-tree can follow
such links itself, and, what's more important, it actually uses some
information from the passed commit (it writes the commit ID to the
tar file as an extended header, and sets timestamp of all archive
members to the time of the commit).  Therefore reducing the ID
passed to git-tar-tree to a plain tree ID is wrong - if a commit ID
is available, it should be used.

-- 
Sergey Vlasov

--Signature=_Sat__13_Aug_2005_16_10_53_+0400_w5CvMoT9ESAJj7tr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC/eNQW82GfkQfsqIRAsixAJ4xjA0TjI2Bc9OH8OXewu6aWpflwwCfUOjK
MURi7xYSLORQxmzDLP1kbj8=
=Drea
-----END PGP SIGNATURE-----

--Signature=_Sat__13_Aug_2005_16_10_53_+0400_w5CvMoT9ESAJj7tr--
