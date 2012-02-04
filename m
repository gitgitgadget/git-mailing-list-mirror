From: Jeff King <peff@peff.net>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sat, 4 Feb 2012 18:20:15 -0500
Message-ID: <20120204232015.GB1170@sigill.intra.peff.net>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <20120202084859.GC3823@burratino>
 <7v8vklvxwh.fsf@alter.siamese.dyndns.org>
 <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
 <20120204182611.GA31091@sigill.intra.peff.net>
 <CAMP44s2r-fcnfpdT4u5U7TwF1z6Abp+J1U7oqfsSrYMuD6weOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 00:20:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtouG-0006AT-PV
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 00:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab2BDXUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 18:20:19 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57863
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab2BDXUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 18:20:18 -0500
Received: (qmail 13242 invoked by uid 107); 4 Feb 2012 23:27:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Feb 2012 18:27:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Feb 2012 18:20:15 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s2r-fcnfpdT4u5U7TwF1z6Abp+J1U7oqfsSrYMuD6weOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189920>

On Sat, Feb 04, 2012 at 09:30:42PM +0200, Felipe Contreras wrote:

> > but it feels like the fix should go into map_user. =C2=A0I tried a =
few things,
> > like "git log -1 --format=3D%aE", and couldn't find other code path=
s with
> > this problem. So presumably they are all feeding email addresses wi=
thout
> > the closing ">" (so one option is to just say "map_user needs to ge=
t
> > NUL-terminated strings).
>=20
> Perhaps, but I though the idea was to make it efficient. I think the
> above fix should be ok.

Because of the calling convention of map_user, the buffer with the inpu=
t
must also be writable (since it holds the result). So there should be n=
o
loss of efficiency to convert the ">" into a "\0" (and in fact, the
simplest fix is probably to just have map_user "tie off" any ">" it
detects).

> We should have tests for this though, to make sure it doesn't get
> broken again. I'm on that.

Definitely. Thanks for working on it.

-Peff
