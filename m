From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 04/12] refs: implement simple transactions for the
 packed-refs file
Date: Thu, 20 Jun 2013 07:55:09 -0400
Message-ID: <20130620115508.GB773@sigill.intra.peff.net>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
 <1371628293-28824-5-git-send-email-mhagger@alum.mit.edu>
 <7vfvwdzz6k.fsf@alter.siamese.dyndns.org>
 <51C2B41F.2050708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 20 13:55:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpdSS-00047d-D0
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 13:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965322Ab3FTLzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 07:55:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:56142 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965178Ab3FTLzM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 07:55:12 -0400
Received: (qmail 14375 invoked by uid 102); 20 Jun 2013 11:56:11 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 06:56:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 07:55:09 -0400
Content-Disposition: inline
In-Reply-To: <51C2B41F.2050708@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228484>

On Thu, Jun 20, 2013 at 09:49:51AM +0200, Michael Haggerty wrote:

> [I just noticed that lock_ref_sha1_basic() leaks a struct lock_file
> every time that it is called.]

I noticed that recently, too. I have a patch series about 90% complete
that abstracts the tempfile handling (the ultimate goal of which is to
optionally clean up tmp_* files in the objects/ directory). It refactors
the lockfile cleanup, and it would not be too hard to have a committed
or rolled-back lockfile actually remove itself from the "to clean at
exit" list.

Which would make it perfectly safe to have a lockfile as an automatic
variable as long as you commit or rollback before leaving the function.

-Peff
