From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: fixing workdirs
Date: Fri, 9 Jul 2010 09:56:17 +0200
Message-ID: <20100709075617.GD2304@madism.org>
References: <20100708110842.GC12789@madism.org>
 <7v7hl5pxt0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 09:56:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX8Rc-00076O-E3
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 09:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab0GIH4T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 03:56:19 -0400
Received: from pan.madism.org ([88.191.52.104]:35921 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753133Ab0GIH4T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 03:56:19 -0400
Received: from madism.org (unknown [94.228.180.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7C6BD4EF56;
	Fri,  9 Jul 2010 09:56:18 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6D4C98C9BF; Fri,  9 Jul 2010 09:56:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7hl5pxt0.fsf@alter.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150646>

On Thu, Jul 08, 2010 at 12:40:11PM -0700, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@madism.org> writes:
>=20
> > for the first one, the fix is simple: workdirs have now a name, and
> > their HEAD reflog lives in the "master" git repository reflog names=
pace
> > under logs/workdir/$workdir_name/HEAD. The workdir HEAD reflog is t=
hen a
> > symlink to the masters.
>=20
> I think this is a sane thing to do, except for the "symlink" part but=
 that
> would be just a minor implementation detail.

What would you suggest instead of the symlink then ? (knowing that all
the workdir is just a full symlink farm at them moment).

> > For the second one, when a workdir is created, a [workdir "foo"] se=
ction
> > is added to the master directory, with a path configuration variabl=
e
> > pointing to the ... path of the working directory.
>=20
> Ok.

> > ... git checkout would check that no other workdir is currently "on
> > the same branch", and would refuse to checkout to a branch that is
> > already checkouted elsewhere.
>=20
> I am personally fine with this, but if there is no way to override th=
is
> refusal it may break some people's existing workflow.  I dunno.

Well it's probably fine to have a switch to override it of course, or
like it was suggested to prevent updating the reference instead. But
that sounds harder, and if you want to override it, it means that a lot
of commands will have to take a new argument (update-ref, commit, reset=
,
rebase, ...).

I'm more in favor of having checkout refusing to checkout if the
reference is already checkout-ed elsewhere, with a --ignore-workdirs or
similar switch to override this. git-checkout would still print out a
warning about the fact that /maybe/ the user is doing something crazy,
and then he'll be on his own. Plus it doesn't slow references updates
for the workdir case, only the branch switch which is way nicer.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
