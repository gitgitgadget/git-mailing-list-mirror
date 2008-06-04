From: Jeff King <peff@peff.net>
Subject: Re: [tig] Feeding specific revisions to tig
Date: Wed, 4 Jun 2008 15:29:16 -0400
Message-ID: <20080604192916.GB17327@sigill.intra.peff.net>
References: <ae63f8b50806041152v11a2997y9411c5ea3ebc9598@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jean-Baptiste Quenot <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 21:30:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ygX-00055Q-2P
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 21:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbYFDT3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 15:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbYFDT3T
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 15:29:19 -0400
Received: from peff.net ([208.65.91.99]:4225 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341AbYFDT3T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 15:29:19 -0400
Received: (qmail 21641 invoked by uid 111); 4 Jun 2008 19:29:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 04 Jun 2008 15:29:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jun 2008 15:29:16 -0400
Content-Disposition: inline
In-Reply-To: <ae63f8b50806041152v11a2997y9411c5ea3ebc9598@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83813>

On Wed, Jun 04, 2008 at 08:52:14PM +0200, Jean-Baptiste Quenot wrote:

> Ideally I'd like to feed this list of commits to tig, so that I can
> watch the commit diff and summary easily and switch from one commit to
> another.  But tig only behaves as a pager, and does not help for this.

I think there are two issues here, but both are solvable:

  1. You want to see _just_ these commits, but not the whole ancestry
     chain. In that case, you want to use --no-walk. E.g.:

       tig --no-walk commit1 commit2 ...

     Though it seems there are a few display artifacts. If I do

       tig --no-walk tig-0.1 tig-0.2

     I get the 2 commits I expect, but also two "extra" blank
     commits at the bottom.

  2. tig works like a pager when stdin is not a tty. You can work
     around this by using xargs to give the commits to it on the
     command line, and then redirect stdin from the tty.

       ... | xargs sh -c 'tig --no-walk "$@" </dev/tty'

     which is kind of a lot to type. It might be nice for "tig -T"
     to open /dev/tty unconditionally instead of looking at stdin,
     so you could just do:

       ... | xargs tig -T --no-walk

-Peff
