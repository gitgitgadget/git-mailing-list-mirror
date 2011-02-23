From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/4] tag: speed up --contains calculation
Date: Wed, 23 Feb 2011 11:39:38 -0500
Message-ID: <20110223163938.GB10042@sigill.intra.peff.net>
References: <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705123335.GA25699@sigill.intra.peff.net>
 <AANLkTinL-gN3sCkUzzsBbzwxo1AYx1NURjKaE8D4TgvU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tytso@mit.edu, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 17:39:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsHkg-0003Tc-7c
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 17:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab1BWQjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 11:39:41 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50137 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734Ab1BWQjk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 11:39:40 -0500
Received: (qmail 14280 invoked by uid 111); 23 Feb 2011 16:39:39 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 23 Feb 2011 16:39:39 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Feb 2011 11:39:38 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinL-gN3sCkUzzsBbzwxo1AYx1NURjKaE8D4TgvU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167700>

On Wed, Feb 23, 2011 at 04:51:02PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Mon, Jul 5, 2010 at 14:33, Jeff King <peff@peff.net> wrote:
> > When we want to know if commit A contains commit B (or any
> > one of a set of commits, B through Z), we generally
> > calculate the merge bases and see if B is a merge base of A
> > (or for a set, if any of the commits B through Z have that
> > property).
>=20
> On a work repo with around 10k tags after and before this patch:
> [...much speed improvement...]
> I'd love to have this merged downwards from pu. It's the single
> biggest usability improvement in my Git workflow for as long as I can
> remember.

Yeah, I have been meaning to revisit the topic. I got sidetracked by
looking at clock skew issues, and there was some debate over whether th=
e
strict depth-first traversal was the best way to do it (although if you
trust the commit timestamps, I think you stop going down dead-ends
pretty quickly in practice; and I think we do implicitly trust the
commit timestamps in the regular merge base traversals). If we can do a
multi-headed merge base, that would be better, but I'll have to think o=
n
it.

I'll try to take a look this week and see what I can come up with.

-Peff
