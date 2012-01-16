From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test_interactive: interactive debugging in test scripts
Date: Mon, 16 Jan 2012 15:19:22 -0500
Message-ID: <20120116201922.GB18699@sigill.intra.peff.net>
References: <4F133069.10308@web.de>
 <20120115232413.GA14724@sigill.intra.peff.net>
 <20120116154953.GA21238@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 21:19:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmt1f-0007Hb-K5
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 21:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070Ab2APUTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 15:19:25 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39443
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755957Ab2APUTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 15:19:25 -0500
Received: (qmail 17803 invoked by uid 107); 16 Jan 2012 20:26:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jan 2012 15:26:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2012 15:19:22 -0500
Content-Disposition: inline
In-Reply-To: <20120116154953.GA21238@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188650>

On Mon, Jan 16, 2012 at 10:49:53AM -0500, Pete Wyckoff wrote:

> And it is necessary to export any test variables you want to use
> in the debug shell.  I often cut-n-paste lines containing
> TEST_DIRECTORY and TRASH_DIRECTORY; there could be others,
> in test scripts and helper libraries too.

Yeah, exporting a few common ones would be helpful. I really wish there
was a way to ask a shell to stop running the script and start doing
interactive things in the current shell context, but no such thing
exists AFAIK (you can hack it with a read-eval loop, but you are missing
many of the useful input-handling bits like tab completion. Hmm, I
wonder if bash's "read -e" would be enough, though).

I kind of wonder if that is over-engineering, though. I'd like a perfect
debugging environment, but the fact of the matter is that writing,
maintaining, and making it work in every case that comes up is probably
a lot more work than just fiddling with the scripts now and then. This
code isn't even meant to be run except in such fiddling circumstances.

> While it would be nice to use:
> 
>     test_interactive gdb --args git ...
> 
> the path is setup to invoke the script in bin-wrappers/git,
> requiring either --with-dashes or something like
> 
>     test_interactive gdb --args "$GIT_EXEC_PATH"/git ...

Yeah. I have before patched the bin-wrappers script to accept a
GIT_WRAPPER_PREFIX variable, so you can just set that and have it run
gdb on your invocation. But even that's not enough for externals. I've
been tempted to actually carry around a run-time option to exec
externals via gdb, but I didn't want to pollute the regular code base
(and you can usually get by with just running "gdb git-foo" directly).

-Peff
