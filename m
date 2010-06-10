From: Jeff King <peff@peff.net>
Subject: Re: Misterious warning about file system boundaries [It's a bug,
 not a mystery.]
Date: Thu, 10 Jun 2010 07:02:58 -0400
Message-ID: <20100610110258.GA17290@coredump.intra.peff.net>
References: <4C0FF7B9.8040007@drmicha.warpmail.net>
 <4C109C4F.1030809@op5.se>
 <4C10AAC4.90405@drmicha.warpmail.net>
 <AANLkTimwhDGNTMiOaW8_AGGd4PvFtyILEikePdC4zGDo@mail.gmail.com>
 <4C10C02E.50502@drmicha.warpmail.net>
 <AANLkTikle0gxLvKkhr-APkt_6QCB0hVu7bIGm0sRcjVK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, kusmabite@gmail.com,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 13:03:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMfXV-0000rg-4v
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 13:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559Ab0FJLDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 07:03:07 -0400
Received: from peff.net ([208.65.91.99]:57566 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849Ab0FJLDF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 07:03:05 -0400
Received: (qmail 4327 invoked by uid 107); 10 Jun 2010 11:03:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 10 Jun 2010 07:03:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jun 2010 07:02:58 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikle0gxLvKkhr-APkt_6QCB0hVu7bIGm0sRcjVK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148855>

On Thu, Jun 10, 2010 at 10:52:40AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Thu, Jun 10, 2010 at 10:36, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> > I guess we need --I-really-mean-it-refresh.
> >
> > In fact, not even after recompiling with USE_STDEV=3Dy that
> > --really-refresh helps which stomps me.But what do I know.
>=20
> The real problem here is the assumption in 52b98a7 that stat's st_dev
> will stay the same for a given device, clearly that's not the case on
> Linux if you reboot your machine.
>=20
> Is there some way of working around that?

We could simply drop the warning. The real point of the original patch
was to stop cross-device traversal in setup_git_directory, which doesn'=
t
care about crossing reboots. I believe the index check and warning are
just there as an early suggestion. When you actually fail to cross the
device boundary looking for .git in the future, it will complain and
mention GIT_DISCOVERY_ACROSS_FILESYSTEM then.

Since the early-warning suggestion is generating false positives, and I
don't think there is a portable and reliable way around it, dropping it
makes sense to me.

-Peff
