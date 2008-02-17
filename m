From: Jeff King <peff@peff.net>
Subject: Re: [RFC] sending errors to stdout under $PAGER
Date: Sun, 17 Feb 2008 07:35:38 -0500
Message-ID: <20080217123538.GB26031@sigill.intra.peff.net>
References: <7vbq6g90gy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 13:36:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQiki-0003iW-W7
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 13:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbYBQMfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 07:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755303AbYBQMfl
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 07:35:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4741 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755190AbYBQMfl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 07:35:41 -0500
Received: (qmail 23825 invoked by uid 111); 17 Feb 2008 12:35:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 17 Feb 2008 07:35:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Feb 2008 07:35:38 -0500
Content-Disposition: inline
In-Reply-To: <7vbq6g90gy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74123>

On Sat, Feb 16, 2008 at 11:15:41AM -0800, Junio C Hamano wrote:

> Because we spawn the pager as the foreground process and feed
> its input via pipe from the real command, we cannot affect the
> exit status the shell sees from git command when the pager is in
> use (I think there is not much gain we can have by working it
> around, though).  But at least it may make sense to show the
> error message to the user sitting in front of the pager, perhaps
> like this.
> 
> What do people think?  Have I overlooked any downsides?

I think this makes sense. It could be annoying if chatty stderr output
got mixed in with the actual output, making things harder to read. But
git is not very chatty in general, and the point is that things sent to
stderr _should_ grab the user's attention.

The only downside I see is that it disrupts the parsing of the output.
In most cases, this doesn't matter, since anything parsing the output
will disable the pager. The notable exception is something like 'tig',
which I believe can act as a git pager which understands the output; it
can potentially be confused by the extra lines on stdout.

-Peff
