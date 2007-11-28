From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 11:10:34 -0500
Message-ID: <20071128161033.GA20308@coredump.intra.peff.net>
References: <20071127211730.GA11861@midwinter.com> <7v4pf7b20b.fsf@gitster.siamese.dyndns.org> <49EB8C6F-8100-48C1-BB2D-A8F6023BACAD@midwinter.com> <Pine.LNX.4.64.0711272143470.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:21:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxPfB-0001pu-EZ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:21:25 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxPVw-0001NP-80
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:11:52 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxPVn-0004lB-Q6
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317AbXK1QKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 11:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755349AbXK1QKh
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:10:37 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1472 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763AbXK1QKg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:10:36 -0500
Received: (qmail 11692 invoked by uid 111); 28 Nov 2007 16:10:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 11:10:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 11:10:34 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711272143470.5349@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 0670901383C81F5FFBCBCD4F486E2FBD5C02A73C
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 45 total 725230 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66365>

On Tue, Nov 27, 2007 at 10:25:32PM -0500, Daniel Barkalow wrote:

> > It would of course be better if git-push could notice that it needs
> > to do an actual fetch. I think it'd be sufficient to transmit the
> > final remote ref SHA1 back to git-push, and if it doesn't match what
> > was pushed, that's a sign that a fetch is needed. But that change
> > wouldn't be mutually exclusive with this patch, I believe.
> 
> Couldn't you do this with a status message? ("ok <refname> changed by 
> hook" or something.)

Having just touched this code, I believe the answer is yes. receive-pack
has always sent just "ok <refname>\n", so we could start interpreting
anything after the <refname> bit freely (I think "ok <refname>
changed-to <hash>" is even more informative, but perhaps not useful
given that the sender probably doesn't have that commit object).

-Peff
