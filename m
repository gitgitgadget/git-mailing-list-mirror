From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rev-list: fix place holder %N (notes) in user format
Date: Sat, 24 Mar 2012 20:55:04 -0400
Message-ID: <20120325005504.GA27651@sigill.intra.peff.net>
References: <1332617911-8281-1-git-send-email-jukka.lehtniemi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 01:55:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBbkP-0003pz-7m
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 01:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab2CYAzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 20:55:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58741
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217Ab2CYAzM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 20:55:12 -0400
Received: (qmail 29874 invoked by uid 107); 25 Mar 2012 00:55:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 24 Mar 2012 20:55:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Mar 2012 20:55:04 -0400
Content-Disposition: inline
In-Reply-To: <1332617911-8281-1-git-send-email-jukka.lehtniemi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193852>

On Sat, Mar 24, 2012 at 09:38:31PM +0200, Jukka Lehtniemi wrote:

> Signed-off-by: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
> ---
> 
>  Fixes a bug where the place holder for notes (%N) was not expanded 
>  in rev-list. To reproduce the bug:
>    $ git notes add -m foo
>    $ git rev-list --notes --format=format:%N HEAD ^HEAD^

This explanation should probably go in the commit message.

I am not sure the behavior afterwards is right, though. With git-log, I
see the following behaviors:

  1. With --notes, notes are displayed.

  3. With --no-notes, notes are not displayed.

  3. With no options, notes are displayed (i.e., we default to --notes).

  4. With --format=%N, notes are displayed (automatically, without
     having to use "--notes").

Shouldn't rev-list behave exactly the same way, except for (3)? That is,
it should respect the options in the same way, but default to not
showing notes?

Even with your patch, we seem to be violating points (1) and (4).
"--notes" does nothing by itself, and you need to use it to make "%N"
work.

For (4), you need to use userformat_find_requirement, as git-log does.
I'm not sure without digging how to make (1) work.

-Peff
