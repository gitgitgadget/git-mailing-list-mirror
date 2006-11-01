X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Introduce git-mirror, a tool for exactly mirroring
 another repository.
Date: Wed, 1 Nov 2006 15:18:59 +0300
Message-ID: <20061101151859.0e984d3f.vsu@altlinux.ru>
References: <20060925044641.GB15757@spearce.org>
	<20061031174225.3c7c1e77.vsu@altlinux.ru>
	<7vac3covlf.fsf@assigned-by-dhcp.cox.net>
	<ei8s19$e04$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__1_Nov_2006_15_18_59_+0300_j=nXxbYLuS3lXL1v"
NNTP-Posting-Date: Wed, 1 Nov 2006 12:19:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ei8s19$e04$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; i586-alt-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30633>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfF3r-0005sV-Ak for gcvg-git@gmane.org; Wed, 01 Nov
 2006 13:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946844AbWKAMTG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 07:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946819AbWKAMTG
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 07:19:06 -0500
Received: from mivlgu.ru ([81.18.140.87]:17625 "EHLO mail.mivlgu.ru") by
 vger.kernel.org with ESMTP id S1946844AbWKAMTE (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 07:19:04 -0500
Received: from center4.mivlgu.local (center4.mivlgu.local [192.168.1.4]) by
 mail.mivlgu.ru (Postfix) with SMTP id D921A804E; Wed,  1 Nov 2006 15:19:01
 +0300 (MSK)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

--Signature=_Wed__1_Nov_2006_15_18_59_+0300_j=nXxbYLuS3lXL1v
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 01 Nov 2006 02:08:08 +0100 Jakub Narebski wrote:

> Junio C Hamano wrote:
> > Sergey Vlasov <vsu@altlinux.ru> writes:
> >> BTW, I was thinking about the possibility to save removed refs under,
> >> e.g., refs/old/`date -I`/; maybe even non-fast-forward refs could be
> >> saved there - this will ensure that no object will ever disappear from
> >> the mirror, no matter what is done on the master side.  Obviously, in
> >> this case remote refs like refs/old/* should be filtered.
> >
> > I do not think that belongs to git-mirror.  It might be better to
> > have that option in update-ref machinery so that you would even
> > be protected from a `git branch -d` ran by mistake.

I agree - this would be even better.

What name format should be used for such saved refs?  refs/old/`date -I`
is not unique enough; probably `date --utc +%Y.%m.%d-%H.%M.%S`?  And it
would be good if multiple refs which were deleted or modified in a
non-fast-forward way during a single operation (like git-mirror) would
be saved together - which may be tricky if they are saved at the lower
level (in update-ref).

Adding the fast-forward check into update-ref also does not look nice,
but this check is required for full safety.

> Perhaps just don't remove log when branch is deleted. I tend for example
> to be careful when reordering commits on a branch, and use git branch -f
> instead of deleting and recreating branch to not lose reflog.

Keeping the reflog does not help - reflog entries are not refs, and do
not keep the referenced objects live in the repository.  Therefore old
objects will be lost when the repository is repacked and pruned.

Also, the reflog really must be deleted together with the ref itself -
otherwise it may cause a file/directory conflict when another ref is
created.  Of course, if the ref is renamed instead of deleting, the
corresponding reflog may be renamed too.

--Signature=_Wed__1_Nov_2006_15_18_59_+0300_j=nXxbYLuS3lXL1v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFSJC1W82GfkQfsqIRAmaNAJwOUZSk5VgbHFtuBKLrXmhlFsbx1ACfe0gq
Urr/cHYt2IktHfS4GVBI3lE=
=XMAg
-----END PGP SIGNATURE-----

