From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: please pull ppc64-2.6.git
Date: Wed, 31 Aug 2005 17:08:52 +0400
Message-ID: <20050831170852.2f549318.vsu@altlinux.ru>
References: <17170.25803.413408.44080@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508291006440.3243@g5.osdl.org>
	<17171.39652.237263.484079@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508291706230.3243@g5.osdl.org>
	<1125438048.9705.43.camel@localhost>
	<7v8xyjhxkd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__31_Aug_2005_17_08_52_+0400_OOsjg8EaJ+qJ1cFu"
Cc: Christian Meder <chris@absolutegiganten.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 15:11:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EASKz-0005lx-BU
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 15:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVHaNJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 09:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVHaNJG
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 09:09:06 -0400
Received: from mivlgu.ru ([81.18.140.87]:50841 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S964775AbVHaNJF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2005 09:09:05 -0400
Received: from master.mivlgu.local (master.mivlgu.local [192.168.1.230])
	by mail.mivlgu.ru (Postfix) with SMTP
	id 66D978175A; Wed, 31 Aug 2005 17:08:57 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xyjhxkd.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7975>

--Signature=_Wed__31_Aug_2005_17_08_52_+0400_OOsjg8EaJ+qJ1cFu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 30 Aug 2005 15:25:22 -0700 Junio C Hamano wrote:

> Christian Meder <chris@absolutegiganten.org> writes:
> 
> > Is alternates unthinkable with URLs (e.g. remote alternates).
> 
> In order to read an object data, the low level core GIT layer
> does open()/mmap() of a file on the locally mounted filesystem.
> It also does opendir()/readdir()/closedir() to find what's
> available.
> 
> If you can arrange to automount via luserfs (or whatever; we do
> not care much about particular implementation) so that it can do
> these filesystem operations, git will happily use it.
> 
> Even in that case, the alternate you would tell git should look
> like a local filesystem path --- your automounting from remote
> specified with URL for such a path would happen outside GIT.

All this means that currently there is no clean way to publish a partial
GIT repository, unless you place it at the same server where the base
repository is located (and even in that case needing to use something
like "echo /pub/scm/linux/kernel/git/torvalds/linux-2.6/objects >
objects/info/alternates" looks like a horrible hack).

What if we create a mapping layer from URLs to local mirrors of
corresponding repositories?  Store this mapping, e.g., in
~/.git-core/mirrors, then if git reads an URL instead of an absolute
local path from objects/info/alternates, it will consult that file and
either use the specified local mirror, or complain that a local copy of
the base repository is not available.  The partial repository will then
contain no system-specific paths and could be published without
problems.

--Signature=_Wed__31_Aug_2005_17_08_52_+0400_OOsjg8EaJ+qJ1cFu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDFavoW82GfkQfsqIRApALAJ9lttH7d03+KASAhHwJ1vPv6asj7wCfbWKi
idoFLRvimJiMoTBaAE5hSGY=
=DNzD
-----END PGP SIGNATURE-----

--Signature=_Wed__31_Aug_2005_17_08_52_+0400_OOsjg8EaJ+qJ1cFu--
