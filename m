From: Jeff King <peff@peff.net>
Subject: Re: imap-send badly handles commit bodies beginning with "From <"
Date: Fri, 28 Oct 2011 13:32:57 -0700
Message-ID: <20111028203256.GA15082@sigill.intra.peff.net>
References: <20111028180044.GA3966@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Eikum <aeikum@codeweavers.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 22:33:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJt6w-0002u7-6e
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 22:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab1J1UdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 16:33:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57303
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829Ab1J1UdA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 16:33:00 -0400
Received: (qmail 16002 invoked by uid 107); 28 Oct 2011 20:38:47 -0000
Received: from c-67-169-41-183.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.41.183)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Oct 2011 16:38:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Oct 2011 13:32:57 -0700
Content-Disposition: inline
In-Reply-To: <20111028180044.GA3966@foghorn.codeweavers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184431>

On Fri, Oct 28, 2011 at 01:00:44PM -0500, Andrew Eikum wrote:

> On the server side, it was split into two mails on either side of that
> commit message's From line with neither mail actually containing the
> From line. To fix it, I just changed it to "Copied from <url>:" :-P
> 
> Ain't mbox grand?

Mbox does have this problem, but I think in this case it is a
particularly crappy implementation of mbox in imap-send. Look at
imap-send.c:split_msg; it just looks for "From ".

It should at least check for something that looks like a timestamp, like
git-mailsplit does. Maybe mailsplit's is_from_line should be factored
out so that it can be reused in imap-send.

Want to work on a patch?

-Peff
