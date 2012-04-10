From: Nick Douma <n.douma@nekoconeko.nl>
Subject: Migrating SVN to Git, and preserve merge information
Date: Tue, 10 Apr 2012 17:18:11 +0200
Message-ID: <4F844F33.5000004@nekoconeko.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7F477C31AFC0C148AD9C0126"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 17:28:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHczd-0000q9-VF
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 17:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab2DJP2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 11:28:25 -0400
Received: from genome.nekoconeko.nl ([93.94.224.72]:59045 "EHLO
	genome.nekoconeko.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab2DJP2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 11:28:24 -0400
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Apr 2012 11:28:24 EDT
Received: from localhost (localhost [127.0.0.1])
	by genome.nekoconeko.nl (Postfix) with ESMTP id 2C0AA22179
	for <git@vger.kernel.org>; Tue, 10 Apr 2012 17:20:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at genome.nekoconeko.nl
Received: from genome.nekoconeko.nl ([127.0.0.1])
	by localhost (genome.nekoconeko.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JyY8tHwDO3Qp for <git@vger.kernel.org>;
	Tue, 10 Apr 2012 17:20:19 +0200 (CEST)
Received: from [IPv6:2001:838:300:41e::2] (cl-1055.ams-01.nl.sixxs.net [IPv6:2001:838:300:41e::2])
	by genome.nekoconeko.nl (Postfix) with ESMTPSA id A3EF122138
	for <git@vger.kernel.org>; Tue, 10 Apr 2012 17:20:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nekoconeko.nl;
	s=genome; t=1334071219;
	bh=7gqagroPSHFr/TKfAIRqMNrjShWL4uydcKG6mkRoOYs=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:Content-Type;
	b=jr1JSsjOXMTJySUcoUwd2rbbDndXnDpiM+cdFfdsXOHhx0SSWi9d/Lvk/3QnOlLTX
	 fPVMH4uK5SQqP/rWbQtzTwyPlG8/BcZAZF487myQcylf0a1PgH1eNQb1nxGZ68p58f
	 JF8LBgeIjDQ4GSPNW/uix/BfTz0BHXJexu2Wg/Ag=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
X-Enigmail-Version: 1.4
OpenPGP: id=AB001628;
	url=http://nekoconeko.nl/pub_0xAB001628.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195094>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7F477C31AFC0C148AD9C0126
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I currently have two SVN repositories I'm looking to convert to Git.
While the process itself isn't all that hard (following this guide[1]),
I'm looking to do a bit more than just convert raw commits.

The repositories basically have two main branches at a time, for example:=


* trunk
* current version, for example 3.5

Our SVN workflow consisted of working on trunk, and then manually
merging single commits from trunk to the other branch. We quite
consistently mentioned the merged commits in the SVN commit message, and
I'm looking to use this information to generate a more accurate tree in
Git. The commit messages are for example:

trunk  rev 100: Fixed important bug
branch rev 101: Merged r100 from trunk

Or more elaborate:

branch rev 200: Merged r100,r101,r.... from trunk

In these examples, tools like gitk or git log should show a line from
rev 100 to rev 101 in the first example, and lines from r100, r101,rn to
rev 200 in example two.

I have tried to create a custom grafts file to create the parent-child
relations above, and basically finds all merge commits and converts them
into graft lines like so:

<merge commit sha hash> <original git parent sha hash> <sha hash of
merged rev 1> ... <sha hash of merged rev n>

This all works to a certain extent, but the problem arises when trying
to view older history in these repositories. If I use the grafts file,
and do `gitk --all`, gitk freezes. Gitg doesn't show commits before a
certain point. tig and `git log --graph` all show a huge amount of
parentless commits near the bottom. All of this leads me to the
conclusion that something is wrong with the method of using grafts,
rather than problems in the individual tools.


Can someone find something obvious that I'm missing in the above
approach? Or alternatively suggest another more appropriate method of
achieving the same results in Git?

Kind regards,

Nick Douma



[1]: http://john.albin.net/git/convert-subversion-to-git


--------------enig7F477C31AFC0C148AD9C0126
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+ETzQACgkQkPq5zKsAFij/RgCfapjTSRd2mIyKWArFARfsh3uS
rmkAoItN4vWN0XKVgWd7Kv6VrYtLZJfB
=uon5
-----END PGP SIGNATURE-----

--------------enig7F477C31AFC0C148AD9C0126--
