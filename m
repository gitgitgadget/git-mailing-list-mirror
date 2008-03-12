From: Jeff King <peff@peff.net>
Subject: Re: Solaris test failure for git-1.5.4.4 -- t0021-conversion.sh
Date: Wed, 12 Mar 2008 08:48:25 -0400
Message-ID: <20080312124825.GA8447@coredump.intra.peff.net>
References: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com> <alpine.DEB.1.00.0803110954360.4428@alchemy.localdomain> <8ec76080803111014w209e1ceep9baf6d5c8c7f6a20@mail.gmail.com> <20080311173536.GA14687@sigill.intra.peff.net> <20080311174045.GB14687@sigill.intra.peff.net> <7vhcfc8tu7.fsf@gitster.siamese.dyndns.org> <20080312124336.GA7873@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Asheesh Laroia <asheesh@asheesh.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 13:49:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZQOa-0005Dp-7b
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 13:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbYCLMs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 08:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbYCLMs2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 08:48:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1115 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbYCLMs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 08:48:28 -0400
Received: (qmail 31487 invoked by uid 111); 12 Mar 2008 12:48:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 08:48:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 08:48:25 -0400
Content-Disposition: inline
In-Reply-To: <20080312124336.GA7873@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76948>

On Wed, Mar 12, 2008 at 08:43:36AM -0400, Jeff King wrote:

> It seems that /usr/bin/tr silently removes NULs from the input stream:
> 
>   $ printf 'foo\000bar' | xxd
>   0000000: 666f 6f00 6261 72                        foo.bar
>   $ printf 'foo\000bar' | /usr/bin/tr '\000' 'Q' | xxd
>   0000000: 666f 6f62 6172                           foobar
> 
> I don't think there is an easy way around this; we might have to switch
> to using perl.

Even more exciting, /usr/bin/tr actually works going the opposite
direction, but /usr/ucb/tr doesn't:

  $ echo x | /usr/bin/tr x '\000' | xxd
  0000000: 000a                                     ..
  $ echo x | /usr/ucb/tr x '\000' | xxd
  0000000: 780a                                     x.

but other characters seem to work:

  $ echo x | /usr/ucb/tr x '\012' | xxd
  0000000: 0a0a                                     ..

-Peff
