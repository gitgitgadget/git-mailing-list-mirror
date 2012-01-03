From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Tue, 3 Jan 2012 13:40:22 -0500
Message-ID: <20120103184022.GA20926@sigill.intra.peff.net>
References: <4EF9ED58.8080205@tu-clausthal.de>
 <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org>
 <4EFA5F08.2060705@tu-clausthal.de>
 <7vpqf91kqo.fsf@alter.siamese.dyndns.org>
 <4EFAF241.9050806@tu-clausthal.de>
 <7v39c41keo.fsf@alter.siamese.dyndns.org>
 <7vpqf8z8a6.fsf@alter.siamese.dyndns.org>
 <4F00B7F3.1060105@tu-clausthal.de>
 <7vzke4vebl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 19:40:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri9Hj-0000TM-3J
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 19:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab2ACSk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 13:40:26 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55479
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582Ab2ACSkY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 13:40:24 -0500
Received: (qmail 8438 invoked by uid 107); 3 Jan 2012 18:47:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jan 2012 13:47:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2012 13:40:22 -0500
Content-Disposition: inline
In-Reply-To: <7vzke4vebl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187871>

On Tue, Jan 03, 2012 at 10:19:42AM -0800, Junio C Hamano wrote:

> For people who have been used to interact with git-svn from the terminal
> but has *_ASKPASS for reasons other than their use of git-svn in their
> environment, the change to the username codepath is technically a
> regression, as they used to be able to see and correct typo while giving
> their username but with the patch *_ASKPASS will kick in and they have to
> type in bline, but I am not particularly worried about it. It is something
> you type very often and committed to your muscle memory anyway.

There is one difference between how git and ssh use the ASKPASS
variable. In git, we try it _first_, and fall back to asking on the
terminal.  For ssh, they first try the terminal, and fall back to
askpass only when the terminal cannot be opened.

If we tried the terminal first, then it wouldn't be a big deal to use
*_ASKPASS more frequently, since it's a fallback. Of course, that in
itself might be a regression for some people.

I wonder if we should make the order:

  1. GIT_ASKPASS

  2. terminal

  3. SSH_ASKPASS

to help make our use SSH_ASKPASS better match that of ssh. I dunno. I am
not an askpass user these days, so I don't know what people expect or
want.

-Peff
