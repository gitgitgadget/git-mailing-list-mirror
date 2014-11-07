From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Fri, 7 Nov 2014 14:15:55 -0500
Message-ID: <20141107191554.GA5695@peff.net>
References: <20141107081324.GA19845@peff.net>
 <20141107083805.GA26365@peff.net>
 <CACsJy8CPLvmbcdHHmfu6g0dUXJVQ8NhwqfGPD=-kcBmzF_ha6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 20:16:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmp0s-0005sa-IP
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbaKGTP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:15:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:37683 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752474AbaKGTP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:15:57 -0500
Received: (qmail 29347 invoked by uid 102); 7 Nov 2014 19:15:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Nov 2014 13:15:57 -0600
Received: (qmail 24819 invoked by uid 107); 7 Nov 2014 19:16:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Nov 2014 14:16:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2014 14:15:55 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CPLvmbcdHHmfu6g0dUXJVQ8NhwqfGPD=-kcBmzF_ha6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 07, 2014 at 05:13:47PM +0700, Duy Nguyen wrote:

> > By the way, one other thing I wondered while looking at this code: when
> > we checkout a working tree file, we unlink the old one and write the new
> > one in-place. Is there a particular reason we do this versus writing to
> > a temporary file and renaming it into place?  That would give
> > simultaneous readers a more atomic view.
> >
> > I suspect the answer is something like: you cannot always do a rename,
> > because you might have a typechange, directory becoming a file, or vice
> > versa; so anyone relying on an atomic view during a checkout operation
> > is already Doing It Wrong.  Handling a content-change of an existing
> > path would complicate the code, so we do not bother.
> 
> Not a confirmation, but it looks like Linus did it just to make sure
> he had new permissions right, in e447947 (Be much more liberal about
> the file mode bits. - 2005-04-16).

Thanks for digging that up. I think that only gives us half the story,
though. That explains why we would unlink/open instead of relying on
just open(O_TRUNC). But I think opening a new tempfile would work the
same as the current code in that respect.

-Peff
