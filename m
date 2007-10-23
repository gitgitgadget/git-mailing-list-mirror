From: martin f krafft <madduck@madduck.net>
Subject: Re: unmerging feature branches
Date: Tue, 23 Oct 2007 20:08:25 +0200
Message-ID: <20071023180825.GA20343@piper.oerlikon.madduck.net>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org> <20071023171611.GA18783@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0710231026011.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
To: Linus Torvalds <torvalds@linux-foundation.org>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 20:08:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkOBK-00020I-Jd
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 20:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbXJWSIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 14:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbXJWSIe
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 14:08:34 -0400
Received: from clegg.madduck.net ([82.197.162.59]:50453 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbXJWSId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 14:08:33 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id B5EA3A800D;
	Tue, 23 Oct 2007 20:08:40 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 034C19F13B;
	Tue, 23 Oct 2007 20:08:25 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id A8C4A4408; Tue, 23 Oct 2007 20:08:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710231026011.30120@woody.linux-foundation.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4574/Tue Oct 23 16:57:10 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62143>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Linus Torvalds <torvalds@linux-foundation.org> [2007.10.23.1940=
 +0200]:
> > > So you can revert the data, but then if you want to get it back, you'=
ll=20
> > > need to revert the revert - you cannot just merge the branch again.=
=20
> >=20
> > Ouch!
>=20
> Well, it's not necessarily "Ouch".

I said "ouch" only because I can foresee the confusion this may
cause in collaborative package maintenance. One party merges the
feature branch, another reverts it, and a third (or the first)
wonders why the feature isn't present despite having merged the
branch and must go through history to find the reverting commit,
which is tied to the commit it reverts through nothing else than
a log message, at best.

> In other words, think of what happens when you merge some
> development branch, and then "git revert" a single commit from
> that branch - the exact same thing will happen - future merges of
> that branch will *not* re-do the commit, because you "already have
> it", and you reverted it after-the-fact.
[...]
> When you revert the data from a merge, the exact same issue
> happens. A revert (whether done by "git revert", or by the
> sequence of events I described) very fundamentally undoes the
> *data* part, but leaves the history intact, and that has
> implications for future events that think about history - which is
> mostly "git merge", but there are other thigns too.

While this makes perfect sense, I am a bit thrown off now wrt two
earlier posts by you (in another thread), where you said:

  In other words, git never looks at individual commits when trying
  to merge. It doesn't try to figure out what the "meaning" of the
  changes are, it purely looks at the content.
    -- http://marc.info/?l=3Dgit&m=3D119198488411957&w=3D2

  Yes, history is interesting for historical reasons, and to explain
  what the context was, but in many ways, history is exactly the
  *wrong* thing to use when it comes to merging. You should look at
  the end result, since people can - and do - come to the same
  result through different ways.
    -- http://marc.info/?l=3Dgit&m=3D119204501428555&w=3D2

I master merged branch Foo, then reverted a commit introduced by
Foo, and then Foo would be re-merged, the content *will* differ. So
Git *has to* look at the list of commits in history to properly
handle reverts and *not* redo commits which have since been
reverted.

Is this correct?

> As an example of "other things" that take history into account, think=20
> about something like "git rebase". It's not a merge, but it also takes=20
> history into account in certain ways: in particular, it may be effectivel=
y=20
> a "series of cherry-picks", but it actually takes the history of both=20
> branches into account, and will not re-apply a patch that already exists=
=20
> in the target history.

In the light of the discussion in
(http://marc.info/?t=3D119198137100002&r=3D1&w=3D2), I am now completely
confused. Or well, not confused, but I simply don't know anymore
what Git does, and I thought I did.

> What does that mean? Let's say that both histories contain a patch X (not=
=20
> the same commit, but the same patch), but one history also contains the=
=20
> revert of X. Again, the revert reverts the data, but it does *not* revert=
=20
> the history, so when you cherry-pick all the stuff from the other branch,=
=20
> X will *not* happen - even if it would apply cleanly, and even if a plain=
=20
> "git cherry-pick" would have redone it!
>=20
> Why? History, again. Because "git rebase" sees that the commit already=20
> existed, it won't even try to apply it again, never mind that it could=20
> have worked. The "revert" didn't undo the history, just the data.

How can rebase know that the commit already existed when you're
saying above that it's about patch X, *not* the same commit?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"a woman begins by resisting a man's advances and ends by blocking
 his retreat."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHjiZIgvIgzMMSnURArNrAKDm8aNTh8da0/Ql7rm07nGSvyJ6ngCgiFwM
F7RCKOZ73fxNHogveynrhL8=
=mz68
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
