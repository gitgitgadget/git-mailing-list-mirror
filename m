From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Update the tracking references only if they were
	succesfully updated on remote
Date: Tue, 13 Nov 2007 02:52:40 -0500
Message-ID: <20071113075240.GA21799@sigill.intra.peff.net>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 08:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrqZx-0005da-EL
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 08:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbXKMHwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 02:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbXKMHwo
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 02:52:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2577 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbXKMHwn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 02:52:43 -0500
Received: (qmail 18203 invoked by uid 111); 13 Nov 2007 07:52:41 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 02:52:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 02:52:40 -0500
Content-Disposition: inline
In-Reply-To: <20071112213938.GC2918@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64762>

On Mon, Nov 12, 2007 at 10:39:38PM +0100, Alex Riesen wrote:

> It fixes the bug where local tracing branches were filled with zeroed SHA-1
> if the remote branch was not updated because, for instance, it was not
> an ancestor of the local (i.e. had other changes).
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> 
> Jeff, I think your change (334f4831e5a77) was either not complete or
> got broken some time later.

Yes, some of the error information placed in 'ret' was getting lost.
Daniel and I discussed some fixes, but haven't done a final patch yet.
Your patch doesn't work because the assumption that
is_null_sha1(refs->new_sha1) signals error is not correct. This is also
the case for deleted refs, which means that we are failing to update
tracking branches for successfully deleted refs.

I'd like to have a patch that accurately tracks per-ref errors,
including ones from the remote. That not only will give us more accurate
status reporting, but fixes like this will be much easier. Let me see if
I can put something together.

-Peff
