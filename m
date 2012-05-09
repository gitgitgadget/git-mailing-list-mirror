From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_name: support sha1^{note} to return note sha-1
Date: Wed, 9 May 2012 13:26:47 -0400
Message-ID: <20120509172647.GA30487@sigill.intra.peff.net>
References: <1336482870-30842-1-git-send-email-pclouds@gmail.com>
 <20120508161126.GB26838@sigill.intra.peff.net>
 <CACsJy8AfD-N6L6nZNDG3uw4s6jAdYqkuQ8Jt2XRXRGzRwt1ncQ@mail.gmail.com>
 <CALKQrgdGCoKooM7KayNMQ_+Fg9=-1YnwNE_9NHzpX0jfoRjT_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed May 09 19:26:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSAf9-00015y-VB
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 19:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760559Ab2EIR0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 13:26:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37975
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760509Ab2EIR0u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 13:26:50 -0400
Received: (qmail 18408 invoked by uid 107); 9 May 2012 17:27:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 May 2012 13:27:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 May 2012 13:26:47 -0400
Content-Disposition: inline
In-Reply-To: <CALKQrgdGCoKooM7KayNMQ_+Fg9=-1YnwNE_9NHzpX0jfoRjT_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197480>

On Wed, May 09, 2012 at 04:09:35PM +0200, Johan Herland wrote:

> > No idea. I have never worked/used notes until yesterday (and these
> > patches were the result). I will look into it.
> 
> IIRC, the initialization loads the top-level notes tree object into
> memory. Subtrees (if any) are loaded on demand. FTR, if you have less
> then ~256 notes in the notes tree, there will be no subtrees. As the
> number of notes grows, the number of subtree levels grow roughly
> logarithmically with the total number of notes (see determine_fanout()
> for more details).

Ah, right. I was thinking back to my original crappy implementation that
didn't do fanout. So I don't think an init is that bad. It does look up
the ref each time, but it will only load the top-level tree object
(which you would need to do a lookup anyway).

So it is probably OK to just do an init/lookup/free each time if it
makes the code simpler (and I think it does). We probably won't be
looking up sha1^{note} in a tight loop, anyway, since sha1 expressions
like that generally come from the command line.

-Peff
