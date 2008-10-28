From: Jeff King <peff@peff.net>
Subject: Re: problems with clone and .gitattributes
Date: Tue, 28 Oct 2008 01:50:59 -0400
Message-ID: <20081028055058.GB23195@sigill.intra.peff.net>
References: <ee2a733e0810271146r5b21213eg989045e4bf42d99a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 06:52:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuhVV-0006iy-3w
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 06:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbYJ1FvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 01:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbYJ1FvE
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 01:51:04 -0400
Received: from peff.net ([208.65.91.99]:3314 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbYJ1FvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 01:51:03 -0400
Received: (qmail 18025 invoked by uid 111); 28 Oct 2008 05:51:01 -0000
Received: from c-98-207-159-21.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (98.207.159.21)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 28 Oct 2008 01:51:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2008 01:50:59 -0400
Content-Disposition: inline
In-Reply-To: <ee2a733e0810271146r5b21213eg989045e4bf42d99a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99277>

On Mon, Oct 27, 2008 at 02:46:41PM -0400, Leo Razoumov wrote:

> There is a little catch-22 problem here. .gitattributes are stored
> in-tree and git clone does not know about these files existence until
> it checks the tree out, by that time it is already too late to apply
> filters.

Yes, this has been brought up on the list before.

> Of course, there could be several obvious workarounds:
> 
> (1) git clone can redo checkout when it finds files affected by gitattributes
> 
> (2) before doing checkout "git clone" inspects tree-object and looks
> for .gitattributes files. If found it checks them out first before all
> other files. Now it can apply the attributes found as the checkout
> process progresses.

I think (2) is closer to the right solution. Though instead of changing
checkout order, I think .gitattributes should simply be able to look in
an auxiliary tree (and checkout would feed the to-be-checked-out tree to
the attribute machinery). One concern, though, is how to handle
conflicts between the tree we're moving _to_ and what's already in the
working tree. I would think that the tree we're moving to would take
precedence.

I feel like Junio may have mentioned some of these issues in a mail the
last time this subject came up, but maybe I'm mis-remembering. Try
searching the archive.

-Peff
