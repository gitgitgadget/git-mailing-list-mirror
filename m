From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] make the new block-sha1 the default
Date: Tue, 25 Aug 2009 00:18:59 -0400
Message-ID: <20090825041859.GA10033@coredump.intra.peff.net>
References: <alpine.LFD.2.00.0908242249420.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 06:19:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfnV0-0006PA-5A
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 06:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbZHYETA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 00:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbZHYETA
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 00:19:00 -0400
Received: from peff.net ([208.65.91.99]:54498 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbZHYES7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 00:18:59 -0400
Received: (qmail 13694 invoked by uid 107); 25 Aug 2009 04:19:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 Aug 2009 00:19:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2009 00:18:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0908242249420.6044@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126995>

On Mon, Aug 24, 2009 at 11:04:37PM -0400, Nicolas Pitre wrote:

> ... and remove support for linking against the openssl SHA1 code.
> 
> The block-sha1 implementation is not significantly worse and sometimes 
> even faster than the openssl SHA1 implementation.  This allows for

Is there a reason not to leave the option of linking against openssl?

I'm still getting better numbers for OpenSSL over block-sha1 when doing
"git fsck --full" in some repos. Particularly those with large files and
few deltas, where the time is heavily influenced by sha-1 performance.
I'm seeing up to 20% speed improvement using OpenSSL on those repos, and
about 8% on linux-2.6 (the processor is a Conroe Core 2, git compiled
with -O2).

But what really kills me is that I usually compile git with '-O0'
because I am often investigating bugs and I like the debugger to act
sanely. The performance hit is usually not noticeable, but in this case
it is: my "git fsck --full" times jump from ~8.2s (OpenSSL) and ~10.3s
(block-sha1, -O2) to ~18.2s (block-sha1, -O0).

Certainly you can argue that it is idiotic to benchmark anything at -O0.
But right now, it is perfectly reasonable to compile git with -O0 and
assume OpenSSL is compiled with sane optimizations. I'd rather not take
that away without a good reason.

-Peff
