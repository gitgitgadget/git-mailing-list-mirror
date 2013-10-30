From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] sha1_file.c:create_tmpfile(): Fix race when creating
 loose object dirs
Date: Wed, 30 Oct 2013 05:19:27 -0400
Message-ID: <20131030091927.GQ11317@sigill.intra.peff.net>
References: <1382873743-4648-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 10:19:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbRw8-0003RT-5x
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 10:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab3J3JTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 05:19:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:58352 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751902Ab3J3JTa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 05:19:30 -0400
Received: (qmail 20882 invoked by uid 102); 30 Oct 2013 09:19:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 04:19:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 05:19:27 -0400
Content-Disposition: inline
In-Reply-To: <1382873743-4648-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237005>

On Sun, Oct 27, 2013 at 12:35:43PM +0100, Johan Herland wrote:

> I didn't see this in the latest "What's cooking", so here's a resend, with
> an expanded commit message to reflect our discussion. The patch itself is
> unchanged.

Thanks, your expanded description looks correct to me.

> In order to fix the remaining race, I assume we have to ensure the dir
> creation obeys the same rules as the object creation, i.e. that there are
> only two possible states at any time:
> 
>  - The directory does not exist
> 
>  - The directory exists with the correct permissons
> 
> To achieve this, I guess we have to follow the same procedure we do for
> loose object creation:
> 
>  1. Create a temporary directory with a unique name (mkdtemp?)
> 
>  2. Adjust permissions
> 
>  3. Rename into place
> 
> Can this be done sufficiently atomically across all platforms?

Yeah, I think that is the only way to do it. I do not know offhand of
any platforms that have problems with atomic directory renames, though I
would not be surprised if some network filesystems don't handle it well.

I'd also be fine if you want to simply leave it at your patch for now
and let somebody who cares more about the other race worry about it
later.

-Peff
