From: Jeff King <peff@peff.net>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 07:04:03 -0400
Message-ID: <20080423110402.GA27437@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se> <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness> <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com> <20080422023918.GA5402@sigill.intra.peff.net> <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com> <20080423080826.GA11935@sigill.intra.peff.net> <480F1671.2060602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 13:04:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JocmT-0007Nr-5s
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 13:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbYDWLEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 07:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbYDWLEG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 07:04:06 -0400
Received: from peff.net ([208.65.91.99]:1189 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbYDWLEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 07:04:05 -0400
Received: (qmail 16136 invoked by uid 111); 23 Apr 2008 11:04:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 07:04:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 07:04:03 -0400
Content-Disposition: inline
In-Reply-To: <480F1671.2060602@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80210>

On Wed, Apr 23, 2008 at 12:58:57PM +0200, Johannes Sixt wrote:

> In practice, this is not sufficient. The blob filter must have an
> opportunity to decide what it wants to do, not just blindly munge every
> blob. The minimum is a path name, e.g. in $1:
> 
> 	new=$(git cat-file blob $sha1 |
> 		$SHELL_PATH -c "$filter_blob" ignored "$path" |
> 		git hash-object -w --stdin)

I intentionally left that out, because:

  - I assumed if you were going to do trickery with pathnames, you
    should just be doing an index filter

  - it violates the cache assumption, which is that blob $X is always
    transformed the same way

I assume you are wanting to do something like:

  git filter-branch --blob-filter '
    case "$1" in
      *.jpg) cat ;;
          *) tr a-z A-Z ;;
    esac
  '

Obviously it is unlikely to get the same blob sha1 as "foo.jpg" and
"foo.txt", but it just feels a little wrong.

-Peff
