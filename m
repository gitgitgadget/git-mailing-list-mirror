From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 09:06:53 -0500
Message-ID: <20120220140653.GC5131@sigill.intra.peff.net>
References: <8762f9k5sg.fsf@thomas.inf.ethz.ch>
 <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
 <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 15:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzTtN-0004Tn-D1
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 15:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab2BTOG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 09:06:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43790
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788Ab2BTOG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 09:06:56 -0500
Received: (qmail 885 invoked by uid 107); 20 Feb 2012 14:06:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 09:06:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 09:06:53 -0500
Content-Disposition: inline
In-Reply-To: <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191070>

On Mon, Feb 20, 2012 at 09:25:00AM +0100, Piotr Krukowiecki wrote:

> Is the cache set? Not sure how to check it. t0090-cache-tree.sh uses
> test-dump-cache-tree and executes "read-tree HEAD" to establish the
> cache, but in my case read-tree does not make the cache dumpable (but
> it improves status performance).
> 
> $ test-dump-cache-tree  | wc -l
> 0
> $ git read-tree HEAD
> $ test-dump-cache-tree  | wc -l
> 0
> $ echo 3 | sudo tee /proc/sys/vm/drop_caches && time git status -- .
> [...]
> real	0m1.085s

Hmm. I would think test-dump-cache-tree would do it. I don't know why
read-tree wouldn't fill it in, though.

Interestingly, on my git.git repo, I had an empty cache. Running "git
read-tree HEAD" filled it (according to test-dump-cache-tree). It seems
that running "git checkout" empties the cache.  So perhaps git could do
better about keeping the cache valid over time.

-Peff
