From: Jeff King <peff@peff.net>
Subject: Re: Centralized processes in git
Date: Tue, 21 Aug 2007 02:13:36 -0400
Message-ID: <20070821061336.GC7323@coredump.intra.peff.net>
References: <31FEEAE6-58A6-4A74-9DB7-E6F9D56D1C48@rlb3.com> <20070820192947.GD8542@efreet.light.src> <46CA3398.9060803@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, Robert Boone <robert@rlb3.com>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 08:13:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INMzn-0004V9-Iw
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 08:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbXHUGNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 02:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbXHUGNk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 02:13:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1710 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505AbXHUGNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 02:13:40 -0400
Received: (qmail 32417 invoked by uid 111); 21 Aug 2007 06:13:39 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 21 Aug 2007 02:13:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2007 02:13:36 -0400
Content-Disposition: inline
In-Reply-To: <46CA3398.9060803@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56281>

On Tue, Aug 21, 2007 at 08:36:40AM +0800, Steven Grimm wrote:

> I wonder if it makes sense to expose a repository locking mechanism for this 
> kind of application. The builtin git commands would test for the lock and 
> block (waiting up to some configurable timeout) until it went away, but 
> wouldn't necessarily ever actually lock things themselves. Or maybe a 
> shared/exclusive lock (aka an rwlock) would be appropriate here; the 
> repository-altering commands would grab a shared lock.

For this use case, I don't think you need to touch the core git commands
at all. Since we're just talking about a repo that people are pushing
into, why not just grab the lock in a hook before accepting the push?

That serializes the push, but each push can do arbitrary work while
holding the lock.

-Peff
