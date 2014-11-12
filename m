From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Clean stale environment pointer in
 finish_command()
Date: Wed, 12 Nov 2014 05:59:11 -0500
Message-ID: <20141112105911.GA31608@peff.net>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
 <cover.1415630072.git.johannes.schindelin@gmx.de>
 <df1b16208e443416f7185c8c8c110e637ea97ac4.1415630072.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.1411101539091.13845@s15462909.onlinehome-server.info>
 <20141111031636.GE21328@peff.net>
 <xmqqr3x97mv4.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1411121142480.13845@s15462909.onlinehome-server.info>
 <20141112105229.GA29101@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 12 11:59:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoVdt-00016a-Hv
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 11:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbaKLK7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 05:59:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:39462 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752017AbaKLK7M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 05:59:12 -0500
Received: (qmail 2771 invoked by uid 102); 12 Nov 2014 10:59:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Nov 2014 04:59:13 -0600
Received: (qmail 6033 invoked by uid 107); 12 Nov 2014 10:59:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Nov 2014 05:59:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2014 05:59:11 -0500
Content-Disposition: inline
In-Reply-To: <20141112105229.GA29101@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 12, 2014 at 05:52:29AM -0500, Jeff King wrote:

> > However, my personal taste says that reusing the same memory is more
> > elegant than to waste extra memory unnecessarily, so I will go with the
> > child_process_init() solution.
> 
> I do not mind much either way. But I doubt that a single extra struct on
> the stack will break the bank, compared to the fact that we are forking
> and execing a new program. I'd also not be surprised if a smart compiler
> could notice that the variables are used exclusively in non-overlapping
> bits of the code, and just reuse the stack space.

Actually, I take that back. We are passing a pointer to a struct, rather
than by-value, so the compiler cannot know that the sub-function does
not store that pointer in a static variable, and reference it in the
next call. It must use two variables if it cannot see the definition of
run_command.

I still think it's pointless optimization to worry about, and you should
write whichever is the most readable and maintainable.

-Peff
