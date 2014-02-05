From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] repack.c: rename and unlink pack file if it exists
Date: Wed, 5 Feb 2014 15:12:43 -0500
Message-ID: <20140205201243.GA16899@sigill.intra.peff.net>
References: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com>
 <20140205011632.GA3923@sigill.intra.peff.net>
 <xmqq1tzh494e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 21:12:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB8q5-00086L-Du
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 21:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbaBEUMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 15:12:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:45260 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755452AbaBEUMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 15:12:45 -0500
Received: (qmail 15691 invoked by uid 102); 5 Feb 2014 20:12:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 14:12:45 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 15:12:43 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1tzh494e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241651>

On Wed, Feb 05, 2014 at 12:06:41PM -0800, Junio C Hamano wrote:

> > Actually, since 1190a1ac, if you have repacked and gotten the same pack
> > name, then you do not have to do any rename dance at all; you can throw
> > away what you just generated because you know that it is byte-for-byte
> > identical.
> >
> > You could collide with a pack created by an older version of git that
> > used the original scheme, but that is quite unlikely (on the order of
> > 2^-160).
> 
> Yes, so in that sense this is not so urgent, but I'm tempted to
> split the original patch into two and merge only the first one to
> 'master' before -rc3 (see below).  The renaming of the variables
> added enough noise to cause me fail to spot a change mixed within.

That sounds very sensible. The only reason I did not follow-up 1190a1ac
immediately with a patch to drop the rename code was that it is a
sensitive area, and I wanted to be very sure there would be no other
fallouts. And then of course I didn't get around to it yet. But
following the same logic, trying to do it during -rc would be a terrible
idea. :)

The minimal fix you posted below does make sense to me as a stopgap, and
we can look into dropping the code entirely during the next cycle. It
would be nice to have a test to cover this case, though.

-Peff
