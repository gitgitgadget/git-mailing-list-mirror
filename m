From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9902: protect test from stray build artifacts
Date: Thu, 24 Jan 2013 20:13:49 -0500
Message-ID: <20130125011349.GB27657@sigill.intra.peff.net>
References: <201301212330.10824.jn.avila@free.fr>
 <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
 <20130122003954.GA23297@sigill.intra.peff.net>
 <7vehha89j5.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 02:14:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyXsJ-0007ml-AZ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 02:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab3AYBOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 20:14:05 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48735 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144Ab3AYBNv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 20:13:51 -0500
Received: (qmail 30196 invoked by uid 107); 25 Jan 2013 01:15:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Jan 2013 20:15:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2013 20:13:49 -0500
Content-Disposition: inline
In-Reply-To: <7vehha89j5.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214476>

On Thu, Jan 24, 2013 at 03:07:42PM -0800, Junio C Hamano wrote:

> When you have random build artifacts in your build directory, left
> behind by running "make" while on another branch, the "git help -a"
> command run by __git_list_all_commands in the completion script that
> is being tested does not have a way to know that they are not part
> of the subcommands this build will ship.  Such extra subcommands may
> come from the user's $PATH.  They will interfere with the tests that
> expect a certain prefix to uniquely expand to a known completion.
> 
> Instrument the completion script and give it a way for us to tell
> what (subset of) subcommands we are going to ship.
> 
> Also add a test to "git --help <prefix><TAB>" expansion.  It needs
> to show not just commands but some selected documentation pages.
> 
> Based on an idea by Jeff King.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/completion/git-completion.bash | 11 ++++++++++-
>  t/t9902-completion.sh                  | 25 ++++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 2 deletions(-)

This looks good to me.

The only thing I might add is a test just to double-check that "git help
-a" is parsed correctly. Like:

  test_expect_success 'command completion works without test harness' '
           GIT_TESTING_COMMAND_COMPLETION= run_completion "git bun" &&
           grep "^bundle\$" out
  '

(we know we are running bash here, so the one-shot variable is OK to be
used with a function).

-Peff
