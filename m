From: Jeff King <peff@peff.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 17:54:10 -0400
Message-ID: <20080910215410.GA24432@coredump.intra.peff.net>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl> <20080910151015.GA8869@coredump.intra.peff.net> <20080910215045.GA22739@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Tso <tytso@MIT.EDU>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 23:55:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdXek-0007hz-I6
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 23:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbYIJVyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 17:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752873AbYIJVyN
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 17:54:13 -0400
Received: from peff.net ([208.65.91.99]:1713 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbYIJVyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 17:54:12 -0400
Received: (qmail 2492 invoked by uid 111); 10 Sep 2008 21:54:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 10 Sep 2008 17:54:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Sep 2008 17:54:10 -0400
Content-Disposition: inline
In-Reply-To: <20080910215045.GA22739@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95559>

On Wed, Sep 10, 2008 at 11:50:45PM +0200, Stephen R. van den Berg wrote:

> >There was a proposal at some point for a "notes" feature which would
> >allow after-the-fact annotation of commits. I don't recall the exact
> >details, but I think it stored its information as a git tree of blobs.
> >You could choose whether or not to transfer the notes based on
> >transferring a ref pointing to the notes tree.
> 
> The idea is nice, but if we were to use it to store the origin link
> information, the following happens:
> - Origin link information is rare.
> - Yet during a log/gitk/blame run the information might need to
>   be queried for at every commit.
> - Since in most cases the origin information does not exist, this
>   will cause misses to fill the dentry cache for directory lookups, and
>   thus killing performance.
> - In order to make this efficient, a different database lookup system is
>   needed that is fast for misses.

I think you are misunderstanding what I meant by "git tree" here. It is
literally a git tree object, so you don't ask the filesystem at all. You
are looking up within the single object file. If it's a miss, you know
after seeing that object. If not, then you dereference the blob object
that contains the notes.

-Peff
