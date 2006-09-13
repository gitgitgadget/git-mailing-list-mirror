From: Daniel Carosone <dan@geek.com.au>
Subject: Re: [Monotone-devel] cvs import
Date: Thu, 14 Sep 2006 09:52:27 +1000
Message-ID: <20060913235227.GW29625@bcd.geek.com.au>
References: <45084400.1090906@bluegap.ch> <20060913225200.GA10186@frances.vorpus.org> <20060913232139.GU29625@bcd.geek.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p5RmKVcV08d4tiXP"
X-From: git-owner@vger.kernel.org Thu Sep 14 01:52:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNeX5-0006sI-2o
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 01:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWIMXwc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 19:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWIMXwb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 19:52:31 -0400
Received: from geek.com.au ([203.17.37.1]:65276 "EHLO geek.com.au")
	by vger.kernel.org with ESMTP id S1751255AbWIMXwb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 19:52:31 -0400
Received: by geek.com.au (Postfix, from userid 106)
	id D447849F7B; Thu, 14 Sep 2006 09:52:27 +1000 (EST)
To: Markus Schiltknecht <markus@bluegap.ch>, monotone-devel@nongnu.org,
	dev@cvs2svn.tigris.org, Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Markus Schiltknecht <markus@bluegap.ch>,
	monotone-devel@nongnu.org, dev@cvs2svn.tigris.org,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060913232139.GU29625@bcd.geek.com.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26965>


--p5RmKVcV08d4tiXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2006 at 09:21:39AM +1000, Daniel Carosone wrote:
> > I have no particular idea on how to handle tags and branches here;
> > I've never actually wrapped my head around CVS's model for those :-).
> > I'm not seeing any obvious problem with handling them, though.
>=20
> Tags could be modelled as another 'event' in the file graph, like a
> commit. If your frontier advances through both revisions and a 'tag
> this revision' event, the same sequencing as above would work.

Likewise, if we had "file branched" events in the file lifeline (based
on the rcs id's), then we would be sure to always have a monotone
revision that corresponded to the branching event, where we could
attach the revisions in the branch.

Because we can't split tags, and can't split branch events, we will
end up splitting file commits (down to individual commits per file) in
order to arrive at the revisions we need for those.

Because tags and branches can be across subsets of the tree, we gain
some scheduling flexibility about where in the reconstructed sequence
they can come.

Many well-managed CVS repositories will use good practices, such as
having a branch base tag.  If they do, then they will help this
algorithm produce correct results.

Once we have a branch with a base starting revision, we can pretty
much treat it independently from there: make a whole new set of file
lifelines along the RCS branches and a new frontier for it.

--
Dan.

--p5RmKVcV08d4tiXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (NetBSD)

iD8DBQFFCJm7EAVxvV4N66cRAi6nAJkB2QmmuvdzlSnasEbFiZQMz+0FWACgr/m0
lbtrtu9qM987BzxuSr68JMM=
=MKw8
-----END PGP SIGNATURE-----

--p5RmKVcV08d4tiXP--
