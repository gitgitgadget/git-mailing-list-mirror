From: Jeff King <peff@peff.net>
Subject: Re: history missing
Date: Mon, 8 Nov 2010 13:28:02 -0500
Message-ID: <20101108182801.GC30428@sigill.intra.peff.net>
References: <AANLkTikFB5HNOmg0iTdjHxtrhU9vdua5O8btgFzpg-2F@mail.gmail.com>
 <m3mxpkeyh4.fsf@localhost.localdomain>
 <AANLkTin2-WAHMjKFKVqq7Wbzvjg-KzMkBh1kCGxDH6Mf@mail.gmail.com>
 <201011081448.10723.jnareb@gmail.com>
 <AANLkTi=eFJ5qTWLD-AdczeDtSAtxs9xihuO+QQ8tVLyj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Vitaliy Semochkin <vitaliy.se@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 19:27:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFWR0-0002di-7m
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab0KHS1I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 13:27:08 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51303 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479Ab0KHS1H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:27:07 -0500
Received: (qmail 31015 invoked by uid 111); 8 Nov 2010 18:27:06 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 08 Nov 2010 18:27:06 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Nov 2010 13:28:02 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=eFJ5qTWLD-AdczeDtSAtxs9xihuO+QQ8tVLyj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160965>

On Mon, Nov 08, 2010 at 09:14:27AM -0500, Martin von Zweigbergk wrote:

> On Mon, Nov 8, 2010 at 8:48 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> > On Mon, 8 Nov 2010, Martin von Zweigbergk wrote:
> >> Sorry, maybe I misunderstood what the confusion was about. What I =
was
> >> referring to was the confusion caused by 'git fetch origin master'=
 not
> >> updating 'refs/remotes/origin/master'.
> >
> > Should it really do it? =C2=A0What if it does not exist? =C2=A0What=
 if <remote>
> > is specified via URL?
>=20
> I would probably not expect it to be updated (even if the URL matches=
 a
> configured remove). If the reference does not yet exist, I think I wo=
uld
> expect it to be created.

Yeah, the patch I posted a while back (and referenced below) does not
convert URLs into remote names (nor do I think it should). But if you
give it the name of a configured remote, and it is fetching a ref from
the remote that is mentioned on the LHS of a configured fetch refspec,
it will update the matching RHS of that refspec opportunistically.

So it should be pretty unsurprising to the user (see the thread below
for some discussion of when it could be surprising).

> Also see http://thread.gmane.org/gmane.comp.version-control.git/12716=
3/.
> Junio, Jeff and Avery can argue much better for and against this than=
 I
> can. I read it at some point, but I don't quite remember now if they =
did
> discuss the historical reasons for the current behavior in that threa=
d.

I took a look at cleaning up the patch from that thread. It causes 4 of
the test scripts to fail. Most disturbing is this one:

  $ grep explicit.fetch t/t5510-fetch.sh
  test_expect_success 'explicit fetch should not update tracking' '

which checks for the direct opposite of the behavior we are discussing.
The test was added by Junio in late 2007. However, I can't seem to find
any discussion on the mailing list about it. Junio, do you remember
anything about this?

-Peff
