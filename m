From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] fast textconv
Date: Sun, 28 Mar 2010 12:17:28 -0400
Message-ID: <20100328161728.GA2828@coredump.intra.peff.net>
References: <20100328145301.GA26213@coredump.intra.peff.net>
 <4BAF7F3F.5020604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Mar 28 18:17:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvvBR-0006BU-TE
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 18:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774Ab0C1QRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 12:17:39 -0400
Received: from peff.net ([208.65.91.99]:40001 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754768Ab0C1QRi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 12:17:38 -0400
Received: (qmail 24604 invoked by uid 107); 28 Mar 2010 16:18:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Mar 2010 12:18:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Mar 2010 12:17:28 -0400
Content-Disposition: inline
In-Reply-To: <4BAF7F3F.5020604@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143394>

On Sun, Mar 28, 2010 at 06:09:35PM +0200, Michael J Gruber wrote:

> Really, "Notes!" was my first thought even before reading 2. Happy to
> have found a like mind :)
> 
> This would still need a mechanism where the conv helper gets the blob's
> SHA1 - hey, it's there in your patch...
> 
> How about:
> 
> Set fasttextconv=notestextconv
> 
> notestextconv does the following:
> 
> - If $sha1 has a note in refs/notes/bikeshed display it.
> - If not create one and then display it.
> 
> In fact, the creation could be done using the textconv setting!

If I understand you right, you are proposing a separate program
that you would pass as a fasttextconv helper, and that would look in a
notes tree. So you would still have a per-diff fork/exec, and pipe all
the data.

I was thinking of actually doing it in-core, so cache hits would be as
lightweight as a notes lookup (and cache misses obviously would still
fork/exec a helper, but we don't care too much since the helper's time
to convert will dominate in that path).

> Pruning the cache is done be deleting the refs/notes/bikeshed ref,
> truncating it by truncating it's DAG (filter-branch...).

Yeah, that would work. It just means it's one more thing the user has to
deal with. I didn't want to have to introduce a "git textconv"
management helper. ;)

-Peff
