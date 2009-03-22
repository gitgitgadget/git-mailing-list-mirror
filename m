From: Jeff King <peff@peff.net>
Subject: Re: Disallow amending published commits?
Date: Sat, 21 Mar 2009 22:42:26 -0400
Message-ID: <20090322024226.GA6766@coredump.intra.peff.net>
References: <885649360903211056u38ff6cabxbe1a17d57faaa0c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 03:44:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlDfN-0003zZ-5j
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 03:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbZCVCmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 22:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbZCVCmb
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 22:42:31 -0400
Received: from peff.net ([208.65.91.99]:54937 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331AbZCVCmb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 22:42:31 -0400
Received: (qmail 9194 invoked by uid 107); 22 Mar 2009 02:42:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 21 Mar 2009 22:42:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Mar 2009 22:42:26 -0400
Content-Disposition: inline
In-Reply-To: <885649360903211056u38ff6cabxbe1a17d57faaa0c4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114109>

On Sat, Mar 21, 2009 at 10:56:26AM -0700, James Pickens wrote:

> I wanted to have a pre-commit hook that would prevent users from
> amending a commit that had already been published, but I couldn't
> find any way in the pre-commit hook to figure out if --amend was
> used.  Is there a way to do that?  Or any better way to disallow
> amending published commits?

I don't think so; as somebody already mentioned, the usual time to
resolve such issues is at push-time. However, I can see how it would be
convenient to catch such a problem early, since by the time you push, it
may be much later and you don't remember exactly why you amended instead
of building on top (or as you indicated, your workflow may involve
pulling).

I suspect the right way to go about this is to inform the pre-commit
hook about the parents of the proposed commit. It already knows the
current branch (since it is in HEAD), and from there you should be able
to implement any policy logic regarding changing the shape of history
(including your request).

Right now that information is totally contained within the git-commit
process; probably the simplest thing would be to export a
space-separated list of SHA-1's to the hook.

-Peff
