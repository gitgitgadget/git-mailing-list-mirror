From: Jeff King <peff@peff.net>
Subject: Re: git commit -v does not removes the patch
Date: Thu, 20 Nov 2008 10:20:16 -0500
Message-ID: <20081120152015.GA6283@coredump.intra.peff.net>
References: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com> <20081110181023.GA22753@coredump.intra.peff.net> <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com> <7vej1j40x5.fsf@gitster.siamese.dyndns.org> <20081111000706.GA26223@coredump.intra.peff.net> <adf1fd3d0811102356u6e671dcfj6491f81cf462ec2e@mail.gmail.com> <20081111102914.GA30330@coredump.intra.peff.net> <7v4p2e2nkg.fsf@gitster.siamese.dyndns.org> <20081112081609.GA3720@coredump.intra.peff.net> <20081120130851.GA17608@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:22:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3BLb-0005BK-9w
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 16:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbYKTPUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2008 10:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754920AbYKTPUU
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 10:20:20 -0500
Received: from peff.net ([208.65.91.99]:3211 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754891AbYKTPUT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 10:20:19 -0500
Received: (qmail 18242 invoked by uid 111); 20 Nov 2008 15:20:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 20 Nov 2008 10:20:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2008 10:20:16 -0500
Content-Disposition: inline
In-Reply-To: <20081120130851.GA17608@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101451>

On Thu, Nov 20, 2008 at 02:09:28PM +0100, SZEDER G=C3=A1bor wrote:

> I always want to see the diff while editing a commit message, even if
> it's the commit message of a merge, a revert, a squash in rebase.
> Since these commands do not have an option equivalent to 'git commit
> -v', I wrote a little prepare-commit-msg hook to always append the
> appropriate diff to the end of the appropriate commit message file.
> This worked pretty well for the last couple of months, until 5/5 got
> into maint.

Hmm. I am sad that this change has broken somebody's existing workflow.
OTOH, I'm not convinced that workflow wasn't a little crazy to begin
with, depending on this undocumented munging.

> So, what is the/is there a preferred way to always include the diff i=
n
> the commit message template and get it removed automatically?  Are
> there any workarounds other than revert that commit locally?

How about:

    $ cat .git/hooks/prepare-commit-msg
    #!/bin/sh
    git diff --cached >>"$1"

    $ cat .git/hooks/commit-msg
    #!/bin/sh
    sed -i '/^diff --git/Q' "$1"

which is more or less the original behavior. The only downside I see is
that "--no-verify" will turn off the commit-msg hook, but not the
prepare-commit-msg hook.

-Peff
