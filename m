From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/17] add_to_alternates_file: don't add duplicate entries
Date: Tue, 11 Aug 2015 05:54:35 -0400
Message-ID: <20150811095435.GC10238@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
 <20150810093446.GD30981@sigill.intra.peff.net>
 <55C97354.7080008@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jim Hill <gjthill@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 11 11:54:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP6Gb-0002vs-OY
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 11:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934113AbbHKJyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 05:54:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:43526 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933788AbbHKJyk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 05:54:40 -0400
Received: (qmail 25203 invoked by uid 102); 11 Aug 2015 09:54:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 04:54:40 -0500
Received: (qmail 14088 invoked by uid 107); 11 Aug 2015 09:54:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 05:54:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Aug 2015 05:54:35 -0400
Content-Disposition: inline
In-Reply-To: <55C97354.7080008@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275679>

On Tue, Aug 11, 2015 at 06:00:20AM +0200, Michael Haggerty wrote:

> > Instead of using hold_lock_file_for_append, let's copy the
> > file line by line, which ensures all records are properly
> > terminated. If we see an extra line, we can simply abort the
> > update (there is no point in even copying the rest, as we
> > know that it would be identical to the original).
> 
> Do we have reason to expect that a lot of people have alternates files
> that already contain duplicate lines? You say that this function is only
> called from `git clone`, so I guess the answer is "no".
> 
> But if I'm wrong, it might be friendly to de-dup the existing lines
> while copying them.

You're right; this is not something we expect. There's not really any
way to get an alternates file inside the running clone, except by
putting it in your "templates/" directory.

So I think it is OK to not worry about cleaning up an existing mess.

-Peff
