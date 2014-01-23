From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 15:26:45 -0500
Message-ID: <20140123202645.GA329@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <CAJo=hJtQG_u4=SjPAgU8h4Wew9LjaXUxnHqTT3Q9E1=_5LJ6Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:26:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QrT-0002cI-04
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbaAWU0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:26:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:37735 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751499AbaAWU0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:26:46 -0500
Received: (qmail 29436 invoked by uid 102); 23 Jan 2014 20:26:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 14:26:46 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 15:26:45 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJtQG_u4=SjPAgU8h4Wew9LjaXUxnHqTT3Q9E1=_5LJ6Sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240946>

On Thu, Jan 23, 2014 at 12:14:03PM -0800, Shawn Pearce wrote:

> > Yes, the mmap'd buffers aren't necessarily word-aligned. I don't think
> > we can fix that easily without changing the on-disk format (which comes
> > from JGit anyway).
> 
> Ouch, sorry about that. JGit doesn't mmap the file so we didn't think
> about the impact of words not being aligned. I should have caught
> that, but I didn't.

Looking over the format, I think the only thing preventing 4-byte
alignment is the 1-byte XOR-offset and 1-byte flags field for each
bitmap. If we ever have a v2, we could pad the sum of those out to 4
bytes. Is 4-byte alignment enough? We do treat the actual data as 64-bit
integers. I wonder if that would have problems on Sparc64, for example.

-Peff
