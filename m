From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Mon, 4 Jan 2010 23:20:47 -0500
Message-ID: <20100105042046.GC12574@coredump.intra.peff.net>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
 <4B421766.4040506@kdbg.org>
 <7vhbr1bagk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 05:21:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS0ue-0002Pl-30
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 05:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776Ab0AEEUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 23:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753577Ab0AEEUu
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 23:20:50 -0500
Received: from peff.net ([208.65.91.99]:56247 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab0AEEUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 23:20:49 -0500
Received: (qmail 26607 invoked by uid 107); 5 Jan 2010 04:25:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 04 Jan 2010 23:25:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2010 23:20:47 -0500
Content-Disposition: inline
In-Reply-To: <7vhbr1bagk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136158>

On Mon, Jan 04, 2010 at 05:35:07PM -0800, Junio C Hamano wrote:

> > 1. My patch "t0021:..." contains an unrelated change to t4030 (it
> > changes a /bin/sh to $SHELL_PATH) that is not necessary. I included it
> > in my first version of the patch, but later noticed that we already
> > have many similar uses of /bin/sh instead of $SHELL_PATH in test
> > scriptlets and decided to remove the change, but I only changed the
> > commit message and forgot to unstage t4030.
> 
> While you are technically correct that the change you made in t4030 is not
> justified by the commit log message in the sense that the "hexdump" script
> will go through run_command() interface and is not subject to the special
> rules filter writers need to keep in mind, the patch text itself is a good
> change, isn't it?  Do you want me to split the commit into two (one with
> the current message with a patch only to t0021, and another to t4030 with
> a justification like "SHELL_PATH is what the user told us to use")?

If we are going to do the t4030 change, there are a ton of other spots
that use /bin/sh directly (I counted 38 with

  grep -n /bin/sh * | grep -v :1:

). Should we be changing all of them?

It is slightly just code churn, because the scripts are so simple that
even broken shells like Solaris /bin/sh run them just fine. The only
real advantage is that it slightly future-proofs them against somebody
making them more complex.

-Peff
