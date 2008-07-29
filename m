From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 10:21:35 +0200
Message-ID: <20080729082135.GB32312@artemis.madism.org>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com> <20080728205545.GB10409@artemis.madism.org> <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com> <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="LpQ9ahxlCli8rRTG";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Benjamin Collins <aggieben@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:22:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNkTg-0003Su-RK
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 10:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbYG2IVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 04:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbYG2IVj
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 04:21:39 -0400
Received: from pan.madism.org ([88.191.52.104]:45983 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbYG2IVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 04:21:38 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id C43253BD4E;
	Tue, 29 Jul 2008 10:21:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6E8545AD30C; Tue, 29 Jul 2008 10:21:35 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Benjamin Collins <aggieben@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90598>


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2008 at 05:51:31AM +0000, Benjamin Collins wrote:
> I try to keep all my submodules on (no branch) as much as possible.
> In a way, I feel like that kind of relieves me of the chore of keeping
> mapping superproject branches to submodule branches in my head.

  Why would _you_ map them to superproject branches ? I mean it's pretty
much Git's matter. In fact, maybe calling them branches is not a
brilliant idea, what I would like would probably rather be some kind of
reflog like thing, but with one reflog per submodule and supermodule
branch.

  I agree with you than when you don't have to do any change in the
submodule, detached HEADs just work. But when you often have to push
fixes in, it's a nightmare. Instead of just having to:

  $EDITOR mysubmodule/file.c
  git commit mysubmodule/file.c # that would ideally do a commit in the
                                # submodule then update the submodule
                                # state in the supermodule

  git submodule mysubmodule push origin HEAD # push the submodule mysubmodu=
le
                                             # changes to the appropriate b=
ranch
  git push origin HEAD

  You have to:

      cd submodule
      git branch -D master
      git checkout -b master
      git commit file.c
      cd ..
      git commit submodule
      cd submodule
      git push origin HEAD:remote/branch/we/want/to/push/to
      cd ..
      git push origin HEAD

      *phew*

  I'm sorry but this is nowhere near a good UI. Of course the detached
head *currently* prevents you to shoot yourself in the foot, because
submodules are _that_ dangerous. But those also are tedious to work
with, like a lot, which makes currently our answer to big projects "do
not have GB-big repositories, split them in submodules" a bad joke,
because their ergonomy is nowhere near what you have with a monolithic
repository yet.


  I'm trying to see what to do better. I believe we _need_ those things:

  * a way to name the successive states of the submodule, a branch looks
    like a good idea, but maybe we can "invent" some different idea so
    that it looks and tastes like a branch, but is more automagic in the
    sense that it's just a prettier name than a sha1.

    This would allow to inspect the submodule history using=20
    `gitk $this_name`. The $PS1 thing is nice, but you have to cd into
    the submodule to see where it currently lives. So you rather need
    something else.


  * a way to remember where you want to push changes you do in the
    submodule to. That's a bit like branch tracking, but not quite. This
    is required so that we can (and I strongly believe we want that in
    the end) make many porcelain commands act on the full
    (super+sub)modules in a unified way, somehow hiding the submodules
    boundaries.

    For example, git commit file1 file2 file3 ... would do the
    submodules commits if any, and then the supermodule one. Alternatively,=
 if
    you have e.g.:

      $ git add mysubmodule/file1.c
      $ git add superfile.c
      $ git add mysubmodule     # tell the supermodule we want to commit wh=
at
                                # is in the submodule index at the same time
      $ git commit

    Then if you run:

      $ git push                # fails complaining that mysubmodule is
                                # not pushed

      $ git submodule mysubmodule push
      $ git push                # works


  * What you "track" must be a per supermodule branch thing, so that if
    you do things like that:

    # you are in master in the supermodule with non pushed commits in
    # the submodule

    <.. oh crap there is a bug in the supermodule that I need to fix in
        the production branch..>

    $ git checkout production # would checkout in the submodule what
                              # matches
    $ $EDITOR mysubmodule/something
    $ git commit !$
    $ ..push everything..

    <.. okay let's now go back to master ..>

    $ git checkout master

    <... hack hack hack to finish the current WIP ...>
    <... okay we're ready to merge production in ...>

    $ git merge production    # will DWYM with the submodules, IOW merge the
                              # `production` state into the current `master=
` one.
    $ git sm mysubmodule push
    $ git push


    Try to write the same workflow with the current submodules, you'll
    end up with a script at least 3 times as long, because you would
    need to do everything by hand, including switching submodules,
    naming temporary branches in them so that you can work decently and
    perform the merges and so on.



--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiO0w8ACgkQvGr7W6Hudhzf8gCfQ/zfGl8XRbrWOOoDC0qJNG/m
gwsAn0NX4kd32bxmfMcg1wtrAjK4yQdb
=fexR
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
