From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] xdiff/xprepare: improve O(n*m) performance in
 xdl_cleanup_records()
Date: Tue, 16 Aug 2011 22:21:47 -0700
Message-ID: <20110817052147.GA11253@sigill.intra.peff.net>
References: <7vd3g5i7ci.fsf@alter.siamese.dyndns.org>
 <1313546037-4104-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 07:22:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtYZl-0004Gk-V6
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 07:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090Ab1HQFV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 01:21:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60282
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848Ab1HQFV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 01:21:56 -0400
Received: (qmail 8942 invoked by uid 107); 17 Aug 2011 05:22:35 -0000
Received: from 206.111.142.135.ptr.us.xo.net (HELO sigill.intra.peff.net) (206.111.142.135)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Aug 2011 01:22:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2011 22:21:47 -0700
Content-Disposition: inline
In-Reply-To: <1313546037-4104-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179501>

On Wed, Aug 17, 2011 at 09:53:57AM +0800, Tay Ray Chuan wrote:

> > Could we have some benchmarks to let the readers get a feel of how much
> > improvement this patch brings in?
> 
> On my msysgit machine with Marat's problematic repo
> (git://slonopotamus.org/git-diff):
> 
>  rctay@TEST-123 /tmp/slono
>  $ time git show >/dev/null
> 
>  real    0m8.538s
>  user    0m0.000s
>  sys     0m0.031s
> 
>  rctay@TEST-123 /tmp/slono
>  $ time /git/git show >/dev/null
> 
>  real    0m0.672s
>  user    0m0.031s
>  sys     0m0.031s

Wait, what? It was using 0 seconds of user time before, but still taking
8.5 seconds? What was it doing? Did you actually warm up your disk cache
before taking these measurements?

-Peff
