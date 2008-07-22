From: Jeff King <peff@peff.net>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 03:46:32 -0400
Message-ID: <20080722074632.GA3999@sigill.intra.peff.net>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net> <48858D95.7060409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:47:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLCas-0005Ea-M5
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbYGVHqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbYGVHqe
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:46:34 -0400
Received: from peff.net ([208.65.91.99]:2744 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbYGVHqe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:46:34 -0400
Received: (qmail 3560 invoked by uid 111); 22 Jul 2008 07:46:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 03:46:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 03:46:32 -0400
Content-Disposition: inline
In-Reply-To: <48858D95.7060409@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89463>

On Tue, Jul 22, 2008 at 09:34:45AM +0200, Johannes Sixt wrote:

> > -		{ "diff-files", cmd_diff_files, RUN_SETUP },
> > +		{ "diff-files", cmd_diff_files, RUN_SETUP | FORBID_PAGER },
> 
> Every now and then I want to use 'git -p diff-files', and I think that is
> a valid use-case. But your suggested patch seems to forbid the pager even
> in this case. :-(

Actually, it doesn't. If you read earlier in the message, this applies
only to pager.* config. That being said, I think Junio's ultimate goal
was to not allow stupid people to accidentally set the pager on
plumbing, at the expense of any smart people who might want to do it for
a good reason.

Though I have to wonder why "git diff --raw" is not enough for you.

At any rate, I think this isn't the right route. We haven't actually
seen evidence of somebody setting pager.diff-files and complaining about
breakage. We have seen people complaining about the lost exit code from
"git status", which is not something that would be on the "forbid" list
anyway. The real solution is to preserve the exit code when spawning the
pager, which I just posted a patch for.

-Peff
