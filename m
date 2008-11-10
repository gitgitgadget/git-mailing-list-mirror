From: Michal Nazarewicz <mina86@tlen.pl>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 18:38:12 +0100
Message-ID: <8763mvlbwb.fsf@erwin.mina86.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com>
	<m3iqqvefmo.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 18:40:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzajk-00013k-HS
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 18:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbYKJRiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 12:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbYKJRiY
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 12:38:24 -0500
Received: from ik-out-1112.google.com ([66.249.90.179]:20124 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbYKJRiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 12:38:23 -0500
Received: by ik-out-1112.google.com with SMTP id c29so2039332ika.5
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :x-url:x-pgp-fp:x-pgp:date:message-id:user-agent:mime-version
         :content-type:sender;
        bh=v8J6///08gsOVz1gLrked8l0W4K1khyG3Y7sI4LTGKI=;
        b=hUOezhpMRyso58SjJyOlOh5k2M8iqw5vGQJpEFexIglmaw3gHXOqa4LCbZf/0sHjWy
         T45NqqHN14p/08e3IsjjBnwsaXxTvdDewEqgC89Uih+B2ZqKAcieHI1feUhUk77mLhvY
         YeI0H85NvK99o08hTNOndbF/nQsrIXLzYyR9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:x-url:x-pgp-fp:x-pgp:date:message-id
         :user-agent:mime-version:content-type:sender;
        b=L2rRByJJs1NmRQe1GTkvwQTlTZNTpQN8k2SCUrbDc6GQtpsAvsJXYFlxxWTLf8lM0P
         0+vfNVnh1uBFgU3LnjHWcwZLHbxBhBdkPWDdsK75SgpuW3BDhRVEDlEHHlS23/4XGnf7
         /fkq839qQYCjI/rDpayTFGyq667l3i7YFrXi4=
Received: by 10.210.50.5 with SMTP id x5mr7891786ebx.167.1226338701280;
        Mon, 10 Nov 2008 09:38:21 -0800 (PST)
Received: from erwin.piotrekn (cnr161.neoplus.adsl.tpnet.pl [83.31.171.161])
        by mx.google.com with ESMTPS id 3sm203187eyj.3.2008.11.10.09.38.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Nov 2008 09:38:20 -0800 (PST)
X-Url: http://mina86.com/
X-PGP-FP: 9134 06FA 7AD8 D134 9D0C  C33F 532C CB00 B7C6 DF1E
X-PGP: B7C6DF1E
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0 (Slckware Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100534>

--=-=-=
Content-Transfer-Encoding: quoted-printable

Jakub Narebski <jnareb@gmail.com> writes:

> The reason why git doesn't support keywords like $Revision$ or $Date$
> is performance: the $Revision$ and $Date$ are keywords related to
> _commit_ data, not blob data.=20

In my case identifying content not commit would be even better.

> 1. You can try to use either hooks (post-commit, post-update I think)
>    or smudge / clean filters (via gitattributes) to do keyword
>    expansion. This hits performance, and you probably would have the
>    problems CVS ad with keyword expansion.

Earlier in the thread there was following code for a pre-commit hook
mentioned:

#v+
files=3D$(git diff-index --name-only --diff-filter=3DAM HEAD)
perl -pi -e 's/\$Id.*?\$/\$Id: '$(TZ=3DUTC date +%s)' \$/g' $files
git add $files
#v-

Now, this meats all my needs except that (i) it adds all the files that
were modified (ie. makes `git commit` work like `git commit -a`) and
(ii) it modifies files even if the commit was aborted.

So, it seems that, what I need is: (i) a pre-commit-post-message-hook
and (ii) a way to get a list of files that are being committed.

> 2. You can use `export-subst` gitattribute and make git-archive do
>    keyword expansion, which can include things like '$Format:%aD$'
>    for commit date (equivalent of $Date:$?).
>
> 3. You can run some local equivalent of GIT-VERSION-GEN script git
>    and Linux kernel uses, and make your build system (Makefile)
>    replace '@@VERSION@@' or '++VERSION++' keywords / placeholders
>    as part of compiling process.

That would work but the thing is I'd like to have visioning without the
need of creating releases or doing some other voodoo magic -- simply `scp
file remote:file` or attach to an email.

=2D-=20
Best regards,                                         _     _
 .o. | Liege of Serenly Enlightened Majesty of      o' \,=3D./ `o
 ..o | Computer Science,  Michal "mina86" Nazarewicz   (o o)
 ooo +--<mina86*tlen.pl>--<jid:mina86*jabber.org>--ooO--(_)--Ooo--

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkYcYoACgkQUyzLALfG3x4M2QCeKhgjJfZdUlfdlxzyscBfRHc0
dAEAoKndL9bilVG5ig4k5uPSXEzKvmcB
=rbOh
-----END PGP SIGNATURE-----
--=-=-=--
