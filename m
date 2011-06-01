From: Jeff King <peff@peff.net>
Subject: Re: speed of git reset -- file
Date: Wed, 1 Jun 2011 15:58:31 -0400
Message-ID: <20110601195831.GA30070@sigill.intra.peff.net>
References: <20110531190015.GA12113@gnu.kitenet.net>
 <20110531212639.GA13234@sigill.intra.peff.net>
 <7v62oqignm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:58:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRrYt-0002ED-ML
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 21:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759955Ab1FAT6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 15:58:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47977
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759920Ab1FAT6d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 15:58:33 -0400
Received: (qmail 17119 invoked by uid 107); 1 Jun 2011 19:58:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 15:58:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 15:58:31 -0400
Content-Disposition: inline
In-Reply-To: <7v62oqignm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174899>

On Tue, May 31, 2011 at 04:39:25PM -0700, Junio C Hamano wrote:

> "git reset" has always refreshed the index. If somebody _really_ wants to
> introduce a slight inconsistency to "git reset" so that only in "per-path"
> mode it doesn't refresh, the call to refresh_index() can easily be removed
> from update_index_refresh(). There is no "we end up having to".
> 
> IOW, we refresh by choice, design and inertia ;-).

Ah, yeah, I really wasn't thinking of the fact that refreshing is a
user-facing operation. These days most of the porcelain commands will do
it for you automatically, so it's easy to forget.

So implementing the "optimization" to drop the refresh here doesn't seem
worth it. It inroduces an awful inconsistency, and it probably isn't
saving much in practice. Lots of other commands will end up stat'ing
everything, anyway. Users with giant repos or slow stat calls are
probably better off using assume-unchanged, which would help this and
many other situations.

-Peff
