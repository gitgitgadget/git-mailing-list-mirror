From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Mon, 7 Nov 2011 16:01:34 -0500
Message-ID: <20111107210134.GA7380@sigill.intra.peff.net>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
 <20111107172218.GB3621@sigill.intra.peff.net>
 <CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
 <20111107183938.GA5155@sigill.intra.peff.net>
 <CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 22:01:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNWK6-0001my-CM
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 22:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565Ab1KGVBi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 16:01:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35923
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352Ab1KGVBg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 16:01:36 -0500
Received: (qmail 29898 invoked by uid 107); 7 Nov 2011 21:01:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 16:01:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 16:01:35 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185025>

On Mon, Nov 07, 2011 at 10:51:10PM +0200, Felipe Contreras wrote:

> > What I don't understand is why it is not:
> >
> > =C2=A0git push --mirror <URL|remote>
>=20
> Because that pushes *everything*.

Ahh, I think I see. It is doing --mirror, but only on a reduced refspec=
?

In that case, is there a reason that:

  git push --prune <URL|remote> refs/heads/*

would not do what you want (note that "--prune" does not exist, but I
think it should).

> > That's what I don't understand from your proposal. Your command is =
just
> > pushing something to the remote, right? Why isn't "push" the comman=
d,
> > and your sync options become options to push?
>=20
> How exactly? --sync-prune, --sync-new, --sync-all? But actually, I wa=
s
> thinking on adding an option to sync the other way around; to get all
> the remote branches and have them locally.

If I understand correctly, you have three modes:

  1. update remote refs with local values, prune anything remote that w=
e
     don't have locally (--sync-prune)

  2. update remote refs with local values, including pushing anything
     new that we don't have locally (--sync-new)

  3. push new and prune (i.e., 1 and 2 together)

If we had "git push --prune" as above, those would be:

  1. git push --prune <remote> :

     I.e., use the "matching" refspec to not push new things, but turn
     on pruning.

  2. git push <remote> refs/heads/*

     Turn off pruning, but use an explicit refspec, not just "matching"=
,
     which will push all local branches.

  3. git push --prune <remote> refs/heads/*

     Turn on both features.

> Well, I usually have quite a lot of branches in my local repositories=
,
> like a dozen of so. And I like to back them up in some remote
> repository, however, not all the branches all the time. git push
> --mirror not only pushes branches, but also tags (and I don't want
> that), and even other refs. Does that clarifies things?

That makes sense. But I think it fits in with git's current UI to do
this via a combination of push options and refspecs. Even if we want to
wrap it in some "git remote" command for convenience, I think what
you're asking should be implemented as part of "git push".

-Peff
