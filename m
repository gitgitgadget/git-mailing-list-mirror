From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault found while fuzzing .pack file under 2.7.0.rc3
Date: Thu, 25 Feb 2016 09:12:46 -0500
Message-ID: <20160225141245.GA17651@sigill.intra.peff.net>
References: <568BC8D1.3080201@gmail.com>
 <20160105152436.GA1205@sigill.intra.peff.net>
 <xmqqr3ht41w8.fsf@gitster.mtv.corp.google.com>
 <xmqqtwmp2e6d.fsf@gitster.mtv.corp.google.com>
 <20160224110548.GA21620@sigill.intra.peff.net>
 <xmqqegc2t05g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacek Wielemborek <d33tah@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 15:12:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYwf0-0005pe-Ir
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 15:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760161AbcBYOMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 09:12:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:49114 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760085AbcBYOMt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 09:12:49 -0500
Received: (qmail 6168 invoked by uid 102); 25 Feb 2016 14:12:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 09:12:48 -0500
Received: (qmail 21308 invoked by uid 107); 25 Feb 2016 14:12:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 09:12:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Feb 2016 09:12:46 -0500
Content-Disposition: inline
In-Reply-To: <xmqqegc2t05g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287389>

On Wed, Feb 24, 2016 at 10:48:27AM -0800, Junio C Hamano wrote:

> >> We do not check if the offset of individual objects are within the
> >> corresponding .pack file, either, and nth_packed_object_offset()
> >> does return the data read from .idx file that is not checked for
> >> sanity.  use_pack(), which is the helper used by the callers of
> >> nth_packed_object_offset() that finds the offset in the packfile for
> >> each object, avoids allowing a read access to mapped pack data
> >> beyond the end of it, so it is OK to return bogus value that was
> >> read from the .idx file from this function, but there is one
> >> computation the function itself does using a possibly bogus value
> >> read from the disk: to find out where in the secondary offset table
> >> in the .idx file the offset in the packfile is stored.
> >
> > Looks like this topic got dropped. I was reminded of it when somebody
> > pointed me to a similar case[1] today which segfaults in a similar way (but
> > this time was caused by actual filesystem corruption).
> >
> > Did you ever push the patch below further along?
> 
> I do not think so, as I didn't "dig"; I recall trying to be explicit
> that it was an illustration to prevent two extra and unnecessary
> changes I alluded to in the earlier parts of the thread, not a real
> patch.

Thanks. I was planning to dig further, but I didn't want to duplicate
any work. I've got a series which I'll post momentarily.

-Peff
