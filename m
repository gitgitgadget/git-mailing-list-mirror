From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH 3/9] http-fetch: Abort requests for objects which arrived in packs
Date: Mon, 6 Feb 2006 15:11:24 -0800
Message-ID: <20060206231124.GJ3873@reactrix.com>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk> <20060201114430.5042.5144.stgit@metalzone.distorted.org.uk> <20060201171225.GI3873@reactrix.com> <slrndu1rk9.2i8.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 00:12:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6FX0-00029l-Vj
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 00:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWBFXMY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 18:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWBFXMY
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 18:12:24 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:21411 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932363AbWBFXMX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2006 18:12:23 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k16NBPYJ029158;
	Mon, 6 Feb 2006 15:11:25 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k16NBPK0029156;
	Mon, 6 Feb 2006 15:11:25 -0800
To: Mark Wooding <mdw@distorted.org.uk>
Content-Disposition: inline
In-Reply-To: <slrndu1rk9.2i8.mdw@metalzone.distorted.org.uk>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15668>

On Wed, Feb 01, 2006 at 05:23:21PM +0000, Mark Wooding wrote:

> I'm by no means a Curl expert.  But I scoured the docs for another way
> of interrupting the current fetch and I couldn't find anything.  It
> really didn't seem like a good idea to leave the handle as it was,
> having (possibly) half-fetched a thing we weren't actually interested in
> -- that way lies confusion.

My impression from the curl documentation was that removing the curl
handle from the multi session was enough, but the documentation doesn't
describe what happens to such a request.

> Besides, in practice, what's happened is that the object we asked for is
> in a pack which we've just collected.  Unless the upstream repository
> hasn't been git-prune-packed, our fetch is going to fail with a 404
> anyway, at which point Curl /will/ close the connection and make another
> one next time.  So, in real life, it makes no difference.

Good point, and it does seem safer to fully clean up the connection
rather than leave it in a questionable state.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
