From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 15:29:40 -0500
Message-ID: <20140123202940.GB329@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <20140123195206.GU18964@google.com>
 <20140123200311.GA31920@sigill.intra.peff.net>
 <20140123202342.GZ18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:29:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QuI-0003nA-H0
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbaAWU3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:29:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:37744 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753184AbaAWU3m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:29:42 -0500
Received: (qmail 29635 invoked by uid 102); 23 Jan 2014 20:29:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 14:29:42 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 15:29:40 -0500
Content-Disposition: inline
In-Reply-To: <20140123202342.GZ18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240947>

On Thu, Jan 23, 2014 at 12:23:42PM -0800, Jonathan Nieder wrote:

> > The memcpy solution is taken from read-cache.c, but as we noted, it
> > probably hasn't been used a lot. The blk_sha1 get_be may be faster, as
> > it converts as it reads.
> 
> I doubt there's much difference either way, especially after an
> optimizer gets its hands on it.  According to [1] ARM has no fast
> byte swap instruction so with -O0 the byte-at-a-time implementation is
> probably faster there.  I can try a performance test if you like.

If you're curious and have time, go ahead and benchmark what I posted
against what you posted (with your fix). But you'll probably need a big
repo like the kernel to notice anything.

But I don't mind that much if we just use the memcpy trick for now. It's
nice and obvious, and we can always change it later if somebody has
numbers (I doubt it will be all that noticeable anyway; this isn't
nearly as tight a loop as the BLK_SHA1 code).

-Peff
