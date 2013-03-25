From: Jeff King <peff@peff.net>
Subject: Re: propagating repo corruption across clone
Date: Mon, 25 Mar 2013 16:07:52 -0400
Message-ID: <20130325200752.GB3902@sigill.intra.peff.net>
References: <20130324183133.GA11200@sigill.intra.peff.net>
 <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
 <20130324192350.GA20688@sigill.intra.peff.net>
 <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net>
 <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net>
 <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff Mitchell <jeffrey.mitchell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 21:08:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDgt-0002OR-Rw
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088Ab3CYUH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:07:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39305 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932801Ab3CYUHz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 16:07:55 -0400
Received: (qmail 27629 invoked by uid 107); 25 Mar 2013 20:09:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 16:09:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 16:07:52 -0400
Content-Disposition: inline
In-Reply-To: <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219075>

On Mon, Mar 25, 2013 at 12:32:50PM -0400, Jeff Mitchell wrote:

> I think what was conflating the issue in my testing is that with
> --mirror it implies --bare, so there would be checking of the objects
> when the working tree was being created, hence --mirror won't show the
> error a normal clone will -- it's not a transport question, it's just
> a matter of the normal clone doing more and so having more data run
> through checks.

Exactly.

> However, there are still problems. For blob corruptions, even in this
> --no-hardlinks, non --mirror case where an error was found, the exit
> code from the clone was 0. I can see this tripping up all sorts of
> automated scripts or repository GUIs that ignore the output and only
> check the error code, which is not an unreasonable thing to do.

Yes, this is a bug. I'll post a series in a minute which fixes it.

> For commit corruptions, the --no-hardlinks, non --mirror case refused
> to create the new repository and exited with an error code of 128. The
> --no-hardlinks, --mirror case spewed errors to the console, yet
> *still* created the new clone *and* returned an error code of zero.

I wasn't able to reproduce this; can you post a succint test case?

> It seems that when there is an "error" as opposed to a "fatal" it
> doesn't affect the status code on a clone; I'd argue that it ought to.

Agreed completely. The current behavior is buggy.

-Peff
