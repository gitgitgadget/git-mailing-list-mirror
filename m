From: Jeff King <peff@peff.net>
Subject: Re: Missing MIME-headers in git-email-tool ..
Date: Tue, 30 Oct 2007 10:06:30 -0400
Message-ID: <20071030140630.GC21342@coredump.intra.peff.net>
References: <20071030095338.GZ6372@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matti Aarnio <matti.aarnio@zmailer.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 15:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imrjz-00009m-LQ
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 15:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbXJ3OGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 10:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405AbXJ3OGe
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 10:06:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4374 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbXJ3OGd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 10:06:33 -0400
Received: (qmail 881 invoked by uid 111); 30 Oct 2007 14:06:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Oct 2007 10:06:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2007 10:06:30 -0400
Content-Disposition: inline
In-Reply-To: <20071030095338.GZ6372@mea-ext.zmailer.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2007 at 11:53:38AM +0200, Matti Aarnio wrote:

> The  git-send-email  does send posts without any sort of MIME labeling:
> 
>   From: / To: removed
> 
>   Subject: [PATCH 0/2] Blackfin I2C/TWI driver updates
>   Date: Tue, 30 Oct 2007 17:33:15 +0800
>   Message-Id: <1193736797-9005-1-git-send-email-bryan.wu@analog.com>
>   X-Mailer: git-send-email 1.5.3.4
>   Precedence: bulk
> 
> 
> which per MIME rules means that the message in question is equivalent
> to one with header labels:
> 
>   MIME-Version: 1.0
>   Content-Type: text/plain; charset=US-ASCII
>   Content-Transfer-Encoding: 7bit

As Johannes explained, this happens only when there are no >7bit
characters in the email, so that interpretation is correct. Though I am
not opposed to sending those headers all the time, for clarity's sake.

> What would be a problem ?   Some of us have names that are encoded
> in 8-bit form,  and some receiving systems get all mighty upset when
> they receive unlabelled email carry 8-bit encoded texts.
> (Thanks to chinese and russian spammers..)

Then git-send-email should be generating the MIME headers if there are
8-bit characters. Can you produce a test case where the most recent
version of git-send-email it does not?

> Now if the  git-send-email would add following three lines in all
> outgoing email headers, things would be 99% correct for a long time..
> 
>   MIME-Version: 1.0
>   Content-Type: text/plain; charset=ISO-8859-15
>   Content-Transfer-Encoding: 8BIT

No, this is just wrong. If git-send-email isn't adding headers when it
should to 8-bit output, then it's a bug. But papering over it with a
randomly chosen, possibly incorrect charset is not the right answer.

-Peff
