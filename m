From: Jeff King <peff@peff.net>
Subject: Re: hitting home directory's parent
Date: Sat, 22 Aug 2009 14:16:07 -0400
Message-ID: <20090822181607.GA25823@coredump.intra.peff.net>
References: <20090821200503.GA19660@panix.com>
 <fcaeb9bf0908212110o5ed1233ek11183fa37b474a06@mail.gmail.com>
 <20090822150542.GA29507@panix.com>
 <fcaeb9bf0908220920g29ec24e9v23d0504d10ca6cfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Convissor <danielc@analysisandsolutions.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 20:16:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mev8U-0002kn-1s
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 20:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933109AbZHVSQI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Aug 2009 14:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933100AbZHVSQI
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 14:16:08 -0400
Received: from peff.net ([208.65.91.99]:55306 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933092AbZHVSQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 14:16:07 -0400
Received: (qmail 9197 invoked by uid 107); 22 Aug 2009 18:16:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 22 Aug 2009 14:16:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Aug 2009 14:16:07 -0400
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0908220920g29ec24e9v23d0504d10ca6cfb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126815>

On Sat, Aug 22, 2009 at 11:20:39PM +0700, Nguyen Thai Ngoc Duy wrote:

> > I did read a bit farther in the manual and initialized a new reposi=
tory.
> > Issuing "git --help" once inside that new repository works. =C2=A0R=
equiring
> > the --help command to be called from inside a repository, or even t=
hat
> > it's looking for a repository at all, seems unwise. =C2=A0All it sh=
ould do is
> > display the usage information and exit.
>=20
> For simple things like --help, I agree Git should not do extra work
> such as searching for Git repository, which is the cause. That was on
> Jeff's plan IIRC.

Without looking, I would not be surprised if it is a side effect of
git trying to look up help-related config. So I don't think it is a
problem exactly that it checks to see if it is in a repo (which would
impact config lookup), but that inability to find a repo is a hard
error.

Probably it is calling "setup_git_directory_gently" and ignoring an
error return, but there is a die() inside that function. The bug
then is that the _gently form is calling die().

As for fixing the setup code, I am sadly way behind on my git queue and
not likely to catch up to this anytime soon. So if anybody feels like
taking a stab at it, that would be very welcome.

-Peff
