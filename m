From: Jeff King <peff@peff.net>
Subject: Re: 'git log' escape symbols shown as ESC[33 and ESC[m
Date: Tue, 4 Feb 2014 20:33:30 -0500
Message-ID: <20140205013330.GB3923@sigill.intra.peff.net>
References: <52D87A79.6060600@rawbw.com>
 <20140117014758.GF7249@sigill.intra.peff.net>
 <52F192E7.1000301@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yuri <yuri@rawbw.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 02:33:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WArMu-000760-Ut
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 02:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbaBEBdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 20:33:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:44746 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754204AbaBEBdc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 20:33:32 -0500
Received: (qmail 26951 invoked by uid 102); 5 Feb 2014 01:33:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Feb 2014 19:33:32 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Feb 2014 20:33:30 -0500
Content-Disposition: inline
In-Reply-To: <52F192E7.1000301@rawbw.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241591>

On Tue, Feb 04, 2014 at 05:24:55PM -0800, Yuri wrote:

> I think the 'experimental' approach is simpler and better.
> When the git command requiring pager is first run, git would run the
> pager with some simple one line escape sequence, and see if sequence
> is preserved.

See how? If less's stdout is not connected to a terminal, it simply
passes through the output as-is. E.g., try:

  foo() {
    # blue foo
    printf '\x1b[34mfoo\x1b[m'
  }

  unset LESS
  foo | less

which has the problematic output. Now try:

  foo | less | cat

which passes through the ANSI codes unscathed. I have no idea how other
pagers behave. So I think this is going back down the road of
hard-coding lots of pager-specific behaviors.

-Peff
