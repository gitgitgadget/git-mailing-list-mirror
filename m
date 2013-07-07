From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap
 format
Date: Sun, 7 Jul 2013 05:46:46 -0400
Message-ID: <20130707094646.GA18120@sigill.intra.peff.net>
References: <1372116193-32762-10-git-send-email-tanoku@gmail.com>
 <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
 <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
 <7vtxkl28m7.fsf@alter.siamese.dyndns.org>
 <CAFFjANRqZ0U5tGhgjACUtquyVKCyuHiS3CC2Xxwo0J1UJVrf=g@mail.gmail.com>
 <CAJo=hJtJoizQUubriTPvs2bsjvw+N82MCPvw263fUB8vv8_VVA@mail.gmail.com>
 <CAFFjANSr2QRLE8DSPP2zZ_baEZUqR8dzkPzMwqyEqgFX=8cnog@mail.gmail.com>
 <20130627024521.GA6936@sigill.intra.peff.net>
 <CAJo=hJvOq=CATrDeYAwi+jgkPpqjywWhuKeC1TVYeCXr6NVM6w@mail.gmail.com>
 <CAFFbUKKm89n0HG6xUhYMLs_yjRJ8n0jFtOEEN=vXxJfWKLx5FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Vicent =?utf-8?B?TWFydMOt?= <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Colby Ranger <cranger@google.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 11:46:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvlYY-00063w-KZ
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 11:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab3GGJqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 05:46:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:46666 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab3GGJqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 05:46:53 -0400
Received: (qmail 11647 invoked by uid 102); 7 Jul 2013 09:48:07 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Jul 2013 04:48:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Jul 2013 05:46:46 -0400
Content-Disposition: inline
In-Reply-To: <CAFFbUKKm89n0HG6xUhYMLs_yjRJ8n0jFtOEEN=vXxJfWKLx5FA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229758>

On Mon, Jul 01, 2013 at 11:47:32AM -0700, Colby Ranger wrote:

> > But I think we are comparing
> > apples to steaks here, Vincent is (rightfully) concerned about process
> > startup performance, whereas our timings were assuming the process was
> > already running.
> >
> 
> I did some timing on loading the reverse index for the kernel and it
> is pretty slow (~1200ms). I just submitted a fix to do a bucket sort
> and reduced that to ~450ms, which is still slow but much better:

On my machine, loading the kernel revidx in C git is about ~830ms. I
switched the qsort() call to a radix/bucket sort, and have it down to
~200ms. So definitely much better, though that still leaves a bit to be
desired for quick commands. E.g., "git rev-list --count A..B" should
become fairly instantaneous with bitmaps, but in many cases the revindex
loading will take longer than it would have to simply do the actual
traversal.

-Peff
