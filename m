From: Jeff King <peff@peff.net>
Subject: Re: Lift --stdout restriction for using reachability bitmap in
 pack-objects?
Date: Tue, 17 Feb 2015 05:13:44 -0500
Message-ID: <20150217101344.GA5343@peff.net>
References: <CACsJy8AC5ZcsB2_qS4k-+6fJt2_e7m=o8C9UAEcywh=P_4HXAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <tanoku@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:13:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNfA8-0000Ua-AG
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 11:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbbBQKNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 05:13:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:49813 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754812AbbBQKNr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 05:13:47 -0500
Received: (qmail 16596 invoked by uid 102); 17 Feb 2015 10:13:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 04:13:47 -0600
Received: (qmail 5866 invoked by uid 107); 17 Feb 2015 10:13:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 05:13:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2015 05:13:44 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8AC5ZcsB2_qS4k-+6fJt2_e7m=o8C9UAEcywh=P_4HXAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263941>

On Tue, Feb 17, 2015 at 05:07:36PM +0700, Duy Nguyen wrote:

> Commit 6b8fda2 (pack-objects: use bitmaps when packing objects -
> 2013-12-21) turns off reachability bitmap optimization if --stdout is
> not specified. I wonder if we could lift this restriction?

I'm not sure what else would break if we did. For instance, would
bitmaps kick in when doing the "Counting objects" phase of "git repack
-ad". And if so, what would the resulting pack look like?

So I'm not opposed to it in principle, but I suspect there's some
cleanup work to be done. But...

> My use case is debugging pack-objects in gdb (repeatedly) where this
> optimization could really save time. But specifying --stdout would
> clutter gdb interface.. I don't know this code well enough to judge,
> but I think the worst thing is we don't write .idx file out (maybe
> because it would involve a lot more work).

If the only reason is for gdb, then perhaps:

  set args pack-objects --stdout </dev/null >/dev/null

in gdb would help?

-Peff
