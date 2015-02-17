From: Jeff King <peff@peff.net>
Subject: Re: Multi-threaded 'git clone'
Date: Mon, 16 Feb 2015 19:56:32 -0500
Message-ID: <20150217005632.GA13001@peff.net>
References: <CACSCj9yoso1oLHzySx1F3O+DFAPiz-XEz1YNCEUMu1pj7KmX7w@mail.gmail.com>
 <alpine.DEB.2.02.1502160521030.23770@nftneq.ynat.uz>
 <20150216150305.GA8279@peff.net>
 <alpine.DEB.2.02.1502160727480.23770@nftneq.ynat.uz>
 <20150216154745.GA10120@peff.net>
 <CACsJy8Brnu7rBxtCq_ac58BW7dOK=wtzMxVL-gsOUXJB2Jss9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Lang <david@lang.hm>,
	Koosha Khajehmoogahi <koosha.khajeh@gmail.com>,
	git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:56:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNWSu-0007eB-A7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 01:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbbBQA4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 19:56:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:49703 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751555AbbBQA4f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 19:56:35 -0500
Received: (qmail 25456 invoked by uid 102); 17 Feb 2015 00:56:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 18:56:35 -0600
Received: (qmail 2757 invoked by uid 107); 17 Feb 2015 00:56:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 19:56:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 19:56:32 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8Brnu7rBxtCq_ac58BW7dOK=wtzMxVL-gsOUXJB2Jss9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263927>

On Tue, Feb 17, 2015 at 06:16:39AM +0700, Duy Nguyen wrote:

> On Mon, Feb 16, 2015 at 10:47 PM, Jeff King <peff@peff.net> wrote:
> > Each clone generates the pack on the fly
> > based on what's on disk and streams it out. It should _usually_ be the
> > same, but there's nothing to guarantee byte-for-byte equality between
> > invocations.
> 
> It's usually _not_ the same. I tried when I wanted to produce stable
> packs. The first condition is single-threaded pack-objects. Otherwise
> thread scheduler could make object order unpredictable.

True. If you keep your server repositories fully packed, that eliminates
the delta search (and/or makes it feasible to turn pack.threads to 1 to
make it deterministic). But any change in the repository (e.g., somebody
else pushing, even to a ref you are not fetching) can cause unexpected
changes in the bytes.

-Peff
