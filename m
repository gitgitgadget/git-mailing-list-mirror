From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] hash: Remove useless init_hash()
Date: Tue, 27 Jul 2010 15:49:46 -0400
Message-ID: <20100727194946.GA11682@coredump.intra.peff.net>
References: <1280208970-23394-1-git-send-email-bebarino@gmail.com>
 <m3fwz5kykn.fsf@localhost.localdomain>
 <AANLkTimrKzDOlJzGpzaHWF24lwfr67bmh8RrKj6uMYWB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 21:49:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odq9z-00033I-Pi
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 21:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab0G0Ttv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 15:49:51 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48646 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331Ab0G0Ttu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 15:49:50 -0400
Received: (qmail 17712 invoked by uid 111); 27 Jul 2010 19:49:48 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 27 Jul 2010 19:49:48 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jul 2010 15:49:46 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimrKzDOlJzGpzaHWF24lwfr67bmh8RrKj6uMYWB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151978>

On Tue, Jul 27, 2010 at 10:36:09AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> >> -static inline void init_hash(struct hash_table *table)
> >> -{
> >> - =C2=A0 =C2=A0 table->size =3D 0;
> >> - =C2=A0 =C2=A0 table->nr =3D 0;
> >> - =C2=A0 =C2=A0 table->array =3D NULL;
> >> -}
> >
> > *This* could be replaced by memset.
>=20
> No it couldn't? The second argument to memset is just an int, so
> setting the memory area to 0 isn't portable to systems where the
> representation of NULL isn't "0".
>=20
> (It's early so I may be misremembering my C..)

You're remembering your C correctly. It isn't portable, but it is so
unlikely on modern machines that we simply don't care (and you will see
memsets zero-ing pointers like this all through the git code, so this i=
s
certainly not introducing anything new).

That being said, I agree with the comments that removing init_hash
actually makes the code _less_ readable. You could just replace these
three lines with a memset, but why? It's just code churn.

-Peff
