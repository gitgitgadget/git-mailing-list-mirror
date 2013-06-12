From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/12] repack_without_ref(): split list curation and
 entry writing
Date: Wed, 12 Jun 2013 07:38:24 -0400
Message-ID: <20130612113823.GA20461@sigill.intra.peff.net>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
 <1370987312-6761-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 12 13:38:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmjNq-0004YW-Aw
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 13:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595Ab3FLLia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 07:38:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:36113 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883Ab3FLLi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 07:38:29 -0400
Received: (qmail 18090 invoked by uid 102); 12 Jun 2013 11:39:21 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Jun 2013 06:39:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jun 2013 07:38:24 -0400
Content-Disposition: inline
In-Reply-To: <1370987312-6761-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227600>

On Tue, Jun 11, 2013 at 11:48:21PM +0200, Michael Haggerty wrote:

> Split repack_without_ref() into multiple passes:
> 
> * collect the list of refnames that should be deleted from packed_refs
> 
> * delete those refnames from the cache
> 
> * write the remainder to the packed-refs file
> 
> The purpose of this change is to make the "write the remainder" part
> reusable.

It took me several reads to figure out what was going on here, because I
did not see the deleted ref passed to the list of items to delete from
packed_refs. The part I was missing is something like:

  The repack_without_ref() function first removes the deleted ref from
  the internal packed-refs list, then writes the packed-refs list to
  disk, omitting any broken or stale entries. This patch splits that
  second step into multiple passes:

     ...

Is that accurate?

-Peff
