From: Jeff King <peff@peff.net>
Subject: Re: A typesetting problem with git man pages
Date: Wed, 29 Oct 2008 15:39:59 -0400
Message-ID: <20081029193958.GA12856@sigill.intra.peff.net>
References: <87skqfus7v.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:41:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvGuu-0005LE-Pz
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 20:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbYJ2TkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 15:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753558AbYJ2TkE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 15:40:04 -0400
Received: from peff.net ([208.65.91.99]:2677 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753599AbYJ2TkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 15:40:03 -0400
Received: (qmail 30491 invoked by uid 111); 29 Oct 2008 19:40:01 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 29 Oct 2008 15:40:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Oct 2008 15:39:59 -0400
Content-Disposition: inline
In-Reply-To: <87skqfus7v.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99394>

On Wed, Oct 29, 2008 at 09:16:52PM +0200, Teemu Likonen wrote:

> I compile git and its man pages myself and I just noticed that the man
> pages (invoked with "git help log", for example) have a typesetting
> problem. There are ".ft" commands here and there, like this:

I think this is Yet Another docbook or asciidoc issue. The resulting XML
from asciidoc is:

  <literallayout>
  &#10;.ft C&#10;
  ... the actual example contents ...
  &#10;.ft&#10;
  </literallayout>

which kind of seems wrong to me, since it implies that that is part of
the literal layout, and would be subject to quoting. It gets rendered
into git-log.1 as:

  \&.ft C
  ... the actual examples contents
  \&.ft

so the problem is the extra \&. But I don't know why that is being
generated. It _should_ be part of the character entity, I thought, but
xmlto seems to be rendering it as the newline character entity _plus_
the ampersand.

So it seems like a bug to me in the XML parser, but it is more likely
that I'm somehow clueless about XML.

-Peff
