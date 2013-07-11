From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/10] cat-file: split --batch input lines on whitespace
Date: Thu, 11 Jul 2013 07:36:53 -0400
Message-ID: <20130711113653.GD6015@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
 <20130710114828.GH21963@sigill.intra.peff.net>
 <CALkWK0mGMZPWowZ0ULNuGKD8w2Q=kN0nEGaOkuWoYKmzD5zGrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 13:37:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxFBT-0008WA-Sr
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 13:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465Ab3GKLg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 07:36:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:57278 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868Ab3GKLgz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 07:36:55 -0400
Received: (qmail 27547 invoked by uid 102); 11 Jul 2013 11:38:12 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Jul 2013 06:38:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jul 2013 07:36:53 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0mGMZPWowZ0ULNuGKD8w2Q=kN0nEGaOkuWoYKmzD5zGrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230091>

On Wed, Jul 10, 2013 at 08:59:51PM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> >   git rev-list --objects HEAD |
> >   git cat-file --batch-check='%(objectsize) %(text)'
> 
> If anything, I would have expected %(rest), not %(text).  This atom is
> specific to commands that accept input via stdin (i.e. not log, f-e-r,
> branch, or anything else I can think of).

I considered %(rest) as well. I don't have a strong preference.

> Also, this makes me wonder if %(field:0), %(field:1), and probably
> %(field:@) are good ideas.  Even if we go down that road, I don't
> think %(rest) is a problem per-se.

I don't have a use for them, and even if we want to add them later, you
would still want to support %(rest) for when the user wants to take the
rest of the line verbatim without caring about field-splitting.

To be honest, I do not see %(field) as all that useful. If you want to
go about rearranging or selecting fields, that is what "cut" (or "awk")
is for.  Having fields means you need to specify field separators, and
how runs of separators are treated. Other tools already do this.

So it would (at best) save you from an extra cut invocation, whereas
%(rest) gets you out of doing something much more difficult. Without it,
information is lost from your pipeline (so you have to have tee to a
separate pipeline, and then reassemble the pieces).

-Peff
