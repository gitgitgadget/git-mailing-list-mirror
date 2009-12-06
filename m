From: Jeff King <peff@peff.net>
Subject: Re: git reset --hard in .git causes a checkout in that directory
Date: Sat, 5 Dec 2009 23:18:40 -0500
Message-ID: <20091206041839.GB23983@coredump.intra.peff.net>
References: <4B17A166.60306@gmail.com>
 <20091204111158.GE27495@coredump.intra.peff.net>
 <7vocmdutph.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Maarten Lankhorst <m.b.lankhorst@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 05:18:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH8a7-0006uH-2U
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 05:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933545AbZLFESh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 23:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758096AbZLFESg
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 23:18:36 -0500
Received: from peff.net ([208.65.91.99]:57222 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758071AbZLFESf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 23:18:35 -0500
Received: (qmail 28414 invoked by uid 107); 6 Dec 2009 04:23:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Dec 2009 23:23:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Dec 2009 23:18:40 -0500
Content-Disposition: inline
In-Reply-To: <7vocmdutph.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134644>

On Sat, Dec 05, 2009 at 11:06:02AM -0800, Junio C Hamano wrote:

> > Junio, I think the following should go to maint (I didn't bother
> > splitting the --merge and --hard code; --merge is in v1.6.2. I assumed
> > we don't care about maint releases that far back).
> 
> Although I'll apply your patch to 'maint' and will merge it for 1.6.6, I
> am not quite sure if this is the best fix in the longer run.  Shouldn't we
> go back to the top of the work tree and running what was asked there?

I actually considered that, too, when writing the patch. But that would
be inconsistent with all of the other commands that use SETUP_WORK_TREE.
For example:

  $ git init && cd .git && git clean
  fatal: This operation must be run in a work tree

So I think we are better to be consistent with the other commands. If
somebody wants to make a separate patch to discover the work tree while
in the $GIT_DIR and chdir to it, that should then be applied to all
commands.  I'm not opposed to it, but I also don't see it as a
particularly pressing need.

-Peff
