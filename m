From: Jeff King <peff@peff.net>
Subject: Re: Request: timeout option for remote operations, esp. "git fetch"
Date: Thu, 14 Nov 2013 03:01:22 -0500
Message-ID: <20131114080122.GA16327@sigill.intra.peff.net>
References: <527BC8DC.7010108@zytor.com>
 <20131110201751.GA18513@dcvr.yhbt.net>
 <52825EBF.3050603@zytor.com>
 <xmqq1u2likea.fsf@gitster.dls.corp.google.com>
 <5282748D.9000907@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 09:01:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgrrm-0005uR-35
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 09:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346Ab3KNIB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 03:01:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:38958 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751951Ab3KNIBY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 03:01:24 -0500
Received: (qmail 28837 invoked by uid 102); 14 Nov 2013 08:01:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 02:01:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 03:01:22 -0500
Content-Disposition: inline
In-Reply-To: <5282748D.9000907@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237816>

On Tue, Nov 12, 2013 at 10:33:49AM -0800, H. Peter Anvin wrote:

> > Which means that your original wish may not be granted with
> > SO_KEEPALIVE at all, no?  I was wondering if you wanted a forced
> > timeout based on alarm(2), something similar to what you added to
> > git-daemon in 960deccb (git-daemon: timeout, eliminate double DWIM,
> > 2005-10-19).
> > 
> 
> Yes, something more like that on the client end.  SO_KEEPALIVE is better
> than nothing, but not really good enough.

Would it be enough to just use timeout(1), like:

  timeout 10m git fetch

That will time the _whole_ fetch operation, which means a legitimately
gigantic but fast fetch would still fail. Setting a shorter timeout only
for periods of inactivity on the network socket would catch killed or
very laggy connections. But it would not catch a server that feeds you
data at a constant but ridiculously slow rate.

-Peff
