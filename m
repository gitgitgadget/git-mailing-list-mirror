From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: check if server supports shallow clones
Date: Thu, 11 Jun 2015 10:32:07 -0400
Message-ID: <20150611143204.GA3343@peff.net>
References: <1433961320-1366-1-git-send-email-adgar@google.com>
 <20150610190512.GB22800@peff.net>
 <CACsJy8CiwiWgf2CarNNN5NgN7QbRB8oxGMmxF+VX8T=ZV2M1ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Edgar <adgar@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 16:32:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z33Wj-0005Z5-C6
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 16:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbbFKOcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 10:32:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:44832 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751052AbbFKOcL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 10:32:11 -0400
Received: (qmail 27659 invoked by uid 102); 11 Jun 2015 14:32:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Jun 2015 09:32:10 -0500
Received: (qmail 6755 invoked by uid 107); 11 Jun 2015 14:32:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Jun 2015 10:32:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jun 2015 10:32:07 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CiwiWgf2CarNNN5NgN7QbRB8oxGMmxF+VX8T=ZV2M1ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271408>

On Thu, Jun 11, 2015 at 08:02:33PM +0700, Duy Nguyen wrote:

> > I see that do_fetch_pack checks server_supports("shallow"). Is that
> > enough to cover all fetch cases? And if it is, why does it not cover the
> > matching clone cases?
> 
> I think this replacement check would do
> 
> if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
>         die("Server does not support shallow clients");

Oh, indeed, there is the depth flag I was looking for. :)

And from some rudimentary testing, I believe that:

  git init
  git fetch --depth=1 ...

is currently broken in the same way as clone (we are not shallow yet, so
it does not complain when the server does not support it). I think the
patch above fixes both that and the clone case.

Of course it's hard to add to the test suite, since we do not have a way
of hitting a server that does not understand shallow (I simply fudged
server_supports() to return false on the client).

-Peff
