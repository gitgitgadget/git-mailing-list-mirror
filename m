From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local
 changes without pushing
Date: Tue, 11 Jun 2013 17:37:22 -0400
Message-ID: <20130611213722.GA21203@sigill.intra.peff.net>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
 <20130609060807.GA8906@sigill.intra.peff.net>
 <CAETqRCiJmnz_1yjwvyWx+=kPkt3M+vKk--CnS=rnQcDA4wMSmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Q8OpbGVzdGlu?= Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?utf-8?Q?Beno=C3=AEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:37:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWFv-0003xR-JM
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053Ab3FKVh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 17:37:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:58723 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754697Ab3FKVh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 17:37:26 -0400
Received: (qmail 9957 invoked by uid 102); 11 Jun 2013 21:38:18 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Jun 2013 16:38:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jun 2013 17:37:22 -0400
Content-Disposition: inline
In-Reply-To: <CAETqRCiJmnz_1yjwvyWx+=kPkt3M+vKk--CnS=rnQcDA4wMSmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227517>

On Tue, Jun 11, 2013 at 11:31:31PM +0200, Beno=C3=AEt Person wrote:

> I've implemented this one for now but after a real-life meeting with
> Matthieu Moy we discussed the possibility to build a GitMediawiki.pm
> module. It seems more "clean" than the concatenation of perl scripts.
> Plus, it would force people to limit side effects inside the function=
s
> used in this package/utils file (I have in mind the mw_connect_maybe
> function here and a couple of others which directly *hope* for global
> vars to be set to a nice value before being called).
>=20
> What I find bad in the concatenating-thingy is the mandatory rename o=
f
> git-mw.perl into something like git-mw.unmerged.perl and
> git-remote-mediawiki.perl into git-remote-mediawiki.unmerged.perl.
> Otherwise, like you said, it would be hard to chain to git's Makefile
> after the merge.

Yeah, I agree it's very hacky.

> For now, I have really no idea which one is the best. If I may ask,
> what did you have in mind while saying:
>=20
> > You could make a Git::MediaWiki.pm module, but installing that woul=
d
> > significantly complicate the build procedure, and potentially be
> > annoying for users.
>=20
> Since my previous commit (ea07ec1 in next - use Git.pm functions for
> credentials), git-remote-mediawiki.perl already depends on the proper
> installation of the Git.pm package. In what ways the need for the
> installation of yet another package (GitMediawiki.pm) would annoy a
> user ?

I was thinking that you would be self-contained inside the
contrib/mw-to-git directory, and therefore you would have to teach your
code how to install the Git module, and you could not longer just "cp
git-remote-mediawiki" into the right place to install it.

But I think we have already crossed that bridge somewhat with Git.pm.
And if you add your module as perl/Git/MediaWiki.pm and use the existin=
g
perl build system, then it is not any extra effort from the build
system.

That is probably the most sane way to go.

-Peff
