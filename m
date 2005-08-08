From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Request for help from binary packaging people.
Date: Mon, 8 Aug 2005 22:20:51 +0400
Message-ID: <20050808222051.275984ff.vsu@altlinux.ru>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
	<7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>
	<7vacjsdcbj.fsf@assigned-by-dhcp.cox.net>
	<7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__8_Aug_2005_22_20_51_+0400_1d_sV/xsOxS3bUcK"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 20:23:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2CGD-0004xj-9g
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 20:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVHHSWB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 14:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVHHSWB
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 14:22:01 -0400
Received: from mail.murom.net ([213.177.124.17]:31939 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S932174AbVHHSWB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 14:22:01 -0400
Received: from [172.17.7.8] (helo=procyon.home)
	by ns1.murom.ru with esmtp (Exim 4.42)
	id 1E2CFu-0004zN-Al; Mon, 08 Aug 2005 22:21:46 +0400
Received: by procyon.home (Postfix, from userid 500)
	id 9CD18E51111; Mon,  8 Aug 2005 22:20:54 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Signature=_Mon__8_Aug_2005_22_20_51_+0400_1d_sV/xsOxS3bUcK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 08 Aug 2005 10:38:44 -0700 Junio C Hamano wrote:

> For RPM, from my lack of RPM expertise (and RPM capable
> environment until recently), I have not updated the "Prereq:"
> field in git-core.spec.in at all.

That "Prereq:" should be "Requires:" instead.  "Prereq:" also
enforces installation ordering between packages; it is required
when the package has some installation scripts (%pre, %post) -
in this case all packages which are needed to execute these
scripts must be listed in "Prereq:".  In case of git-core there
are no such scripts (at least for now), so "Requires:" should be
used - then the package manager will be free to install packages
in any order as long as all dependencies will be satisfied in
the end.

> I would appreciate somebody to sanity check the list of
> dependencies.  The dependency list Debian side has is more
> up-to-date and I am reasonably sure it is accurate.  It lists
> patch, diff, and rcs (for the "merge" command) as the
> essential dependency (aside from the shared libraries like
> libc), and libmail-sendmail-perl, rsync, curl, ssh, and
> libemail-valid-perl as the recommended dependency.  I do not
> even know if RPM has the notion of such multi-tier
> dependencies, but the latter list is meant to mean "you could
> live without these, but to exercise this package fully you may
> want them" (in our case of git-core, you could live without
> the networking if you do not do multi-user, multi-repository).

RPM does not have "Suggests" and "Recommends" like dpkg - all
RPM dependencies are strict.  Because of this limitation, a
single RPM package is often split into several binary
subpackages.

> If RPM spec file has a way to say something like that, I would
> like to see these packages (probably their names are different
> between Debian and RPM) listed on the recommended dependency
> list; otherwise I would want to see them added to the main
> "Prereq:" list.

Not only the names of packages are different between Debian and
RPM - the names of similar RPM packages are different between
different RPM-based distributions. :(

E.g., in ALT Linux distributions /usr/bin/ssh is contained in
the openssh-clients package; SuSE 9.3 seems to have it in the
package named "openssh".  There are lots of such differences.

Most modern RPM-based distributions have some mechanism to find
dependencies automatically (e.g., by scanning all Perl scripts
in the package for "use" statements).  But these mechanisms are
incompatible between different distributions too.

Different distributions also have different RPM packaging
conventions, different RPM macros, etc etc...

So the best thing you can really do is to provide an RPM package
for some distribution you choose, which would then be used as a
basis for packages on other distributions.

--Signature=_Mon__8_Aug_2005_22_20_51_+0400_1d_sV/xsOxS3bUcK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC96KGW82GfkQfsqIRAjTkAJ4x/u1ibXvws2pQKbYaGohWZirYGwCfe4s5
3vc4ank8jyHheYtg0r3suG0=
=LHHn
-----END PGP SIGNATURE-----

--Signature=_Mon__8_Aug_2005_22_20_51_+0400_1d_sV/xsOxS3bUcK--
