From: Jeff King <peff@peff.net>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 18:47:49 -0400
Message-ID: <20090831224749.GA24190@sigill.intra.peff.net>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net>
 <vpqskf8z0rj.fsf@bauges.imag.fr>
 <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com>
 <20090831164146.GA23245@coredump.intra.peff.net>
 <vpqocpvevzx.fsf@bauges.imag.fr>
 <20090831191032.GB4876@sigill.intra.peff.net>
 <20090831201911.GA24989@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 01 00:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiFfQ-0007cV-1N
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 00:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbZHaWru convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2009 18:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbZHaWrt
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 18:47:49 -0400
Received: from peff.net ([208.65.91.99]:51220 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbZHaWrt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 18:47:49 -0400
Received: (qmail 28908 invoked by uid 107); 31 Aug 2009 22:48:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 31 Aug 2009 18:48:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2009 18:47:49 -0400
Content-Disposition: inline
In-Reply-To: <20090831201911.GA24989@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127503>

On Mon, Aug 31, 2009 at 10:19:11PM +0200, Bj=C3=B6rn Steinbrink wrote:

> I see the problem here, too.
>=20
> doener@atjola:~ $ (mkdir a; cd a; git init)
> Initialized empty Git repository in /home/doener/a/.git/
>=20
> doener@atjola:~ $ git clone localhost:a b
> Initialized empty Git repository in /home/doener/b/.git/
> warning: You appear to have cloned an empty repository.
> fatal: The remote end hung up unexpectedly
>=20
> doener@atjola:~ $ ssh localhost git --version
> git version 1.6.4.2.236.gf324c

OK, it is definitely not about mixed versions, and it is definitely
reproducible, even without ssh. The local clone optimization manages to
avoid it, but you can see it with:

  git clone file://$PWD/a b

It also happens with git://, except that it is the _remote_ side
producing the message, so git-daemon gets "the remote end hung up
unexpectedly" on its stderr channel.

AFAICT, this problem goes back to v1.6.2, the first version which
handled empty clones. So I blame Sverre. ;)

-Peff
