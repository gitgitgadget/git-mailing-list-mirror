From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Question about 'branch -d' safety
Date: Sat, 10 Jul 2010 08:55:49 +0200
Message-ID: <20100710065549.GA24296@localhost>
References: <20091230065442.6117@nanako3.lavabit.com>
 <20091229223123.GA12965@vidovic>
 <20091230121238.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 10 08:57:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXTzv-00047c-Fx
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 08:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568Ab0GJG5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 02:57:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52091 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab0GJG5J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 02:57:09 -0400
Received: by wwb24 with SMTP id 24so5615989wwb.1
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 23:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=CYBRWHIc7b2FQyYveHaBzuoJEHMQ87xYDB3YPGmtVoc=;
        b=EGmW6DZznZCZuuW49R7q7H6N+/jTRw3yN8idxFFfzW76YIkHF+RXD80arOYBb7692a
         xQ4pyYtQt9otYHYB7TdKGNf0i+k13VaBun5oRe36wkzfz809MhV9S8AlbANuGBNYPjAt
         lYv7Zt71ZqKaBpcFw+p3bYVjA+WRmlIVTFk7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=OLZOoo/hItEjTRWRQku1FqOs6vGYDsTClBZWNwo5DB9fF/CK4XRP421uDorhFLUZlc
         twxeserhFxenmGmEZqg99jQuV13JVHL/CY0Je3es3R5ocrqZfi1cmTbfTxrlDvaxDKEl
         YrXv+2gF3h793fslnfXp1CSsk1nhLB62jiQMA=
Received: by 10.216.156.72 with SMTP id l50mr5407541wek.82.1278745025582;
        Fri, 09 Jul 2010 23:57:05 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id v59sm14731998eeh.10.2010.07.09.23.57.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 23:57:04 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OXTyX-0006TP-Hp; Sat, 10 Jul 2010 08:55:49 +0200
Content-Disposition: inline
In-Reply-To: <20091230121238.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150713>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm sorry to revive this old thread. But I recently hit this
behavior myself, using the workflow described below, and I ended up
deleting an unmerged branch with git branch -d.

This discussion is about v1.7.0-rc0~18^2 (branch -d: base the
"already-merged" safety on the branch it merges with, 2009-12-29),
which teaches 'git branch' to delete a branch with -d, if it is
merged into the branch it is tracking, even if it is not merged
into any local branch.

On Wed, Dec 30, 2009 at 12:12:38PM +0900, Nanako Shiraishi wrote:
> Quoting Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
>=20
> > But even with it, we would hit some foreign workflow. Think: Bob
> > directly push to Alice and Alice does the same to Bob. I don't use this
> > kind of workflow myself but I consider them to be sensible enough to
> > have our attention.
>=20
> Here is what I think about your scenario.
>=20
> Bob directly pushes to Alice and Alice does the same to Bob, both
> to their refs/remotes/<other person>/ tracking branches, and
> their own local branches fork from the remote tracking branches
> that keep track of other person's work. You would still want the
> check based on that tracking branch, not based on 'master' that
> has no relationship with the branches they are exchanging.

So I had a branch 'topic' in two repositories, neither of which was
in any way authoritative. They were both upstreams to each other.
And the 'topic' branch in each tracked the 'topic' branch in the
other.

At some point, I used branch -d to delete branch 'topic' in one
repo. Later, I did the same in the other. I then realized that
after I do git remote prune origin, the branch will be gone,
without ever having being merged into another branch.

I often use branch -d simply to check if I still forgot something
about this branch, or if it has become redundant. With the above
scenario, I can not rely on branch -d safety any more.

On the other hand, I do think the new behavior is quite useful in
general. Maybe the real solution is a reflog for deleted branch
heads, rather than being too careful about whether or not a branch
can be deleted.

Clemens

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMOBlxAAoJELKdZexG8uqMWdsH/A9nxSeTO1zShGEoNUT1RpIt
swR8fylsvIh8v30wwBX4S0ICsOAmleiNyUgPxmunmsJYgXHgcyWReOHi+oxFSNPu
Ygv65zyj9FDvACY4m1qdGMXBjRAZOV091x8h2nHrgCTJ+r3JiD7HNCIw2P1LYKoV
j/tNw2GfA9UbjYGguLP7BXQQWH09196du8DDIXv8SAv8fkPBGi4Q2T+7JTTTI8Dh
Z7I60MvvBi9AP+Y1UfpGOE3AWaT9dTWzPJ4f7gxPC9QYkkAxhMgZr1kAJnmh6BI/
EYtmdBo5la2C4o3mIJm/sJ+BpiG5Xr6cOawb/4tF0oIu04lMnZJPrAtsBZduOBE=
=XatX
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
