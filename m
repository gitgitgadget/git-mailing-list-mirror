From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Fri, 24 Jul 2009 16:58:51 +0200
Message-ID: <20090724145851.GH4903@laphroaig.corp>
References: <20090723074104.GI4750@laphroaig.corp>
 <7veis7yxwx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 16:59:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUMF7-0005id-Nx
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 16:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbZGXO6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 10:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbZGXO6z
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 10:58:55 -0400
Received: from pan.madism.org ([88.191.52.104]:34361 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbZGXO6z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 10:58:55 -0400
Received: from laphroaig.corp (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by hermes.madism.org (Postfix) with ESMTPSA id AD32F40804;
	Fri, 24 Jul 2009 16:58:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7veis7yxwx.fsf@alter.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123918>

On Thu, Jul 23, 2009 at 12:58:06PM -0700, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > One of my most frequent use case for git-add -p is when I had an in=
tense
> > debug session with quite a lot of debug() traces added. I then want=
 only
> > to select the hunks corresponding to the bugfixes and throw away th=
e debug
> > ones.
>=20
> I do not particularly like this change.  "add -i", "add -p" and "add"=
 in
> general are about manipulating the index.  They are never meant to to=
uch
> the work tree contents.  Which means that even if you make a mistake =
in
> saying y/n, you won't damange the state you have in your work tree, a=
nd
> also means that you can recover safely by simply restarting "add -p"
> session if you really botched splitting of the patch.

Okay, fair enough, this is kind of mixing stuff together, I reckon. OTO=
H
this fills out a real need: sorting out the debug code from the non
debug one, it's particularily handy, and many people at work here have
applied my patch and it saves them lots of time.

So maybe we should see how to have a new command like git hunk-sort or
git hunk-triage or whatever, I don't really mind.

Another way, that is non destructive is to _not_ apply the reverting
patch, but only to generate it, and let the user apply it himself. E.g.
something along the lines of:

$ git add -p
=2E.. select your patches ...
info: you have selected hunks for removal from you tree
info: run the following command to make them go away:
  git apply -R --recount git-add-undo-12asWED.patch
$

And let the user cut & paste the command.

_I_ could live with that, and you lose the dangerous factor.

--=20
Intersec <http://www.intersec.com>
Pierre Habouzit <pierre.habouzit@intersec.com>
T=C3=A9l : +33 (0)1 5570 3346
Mob : +33 (0)6 1636 8131
=46ax : +33 (0)1 5570 3332
37 Rue Pierre Lhomme
92400 Courbevoie
