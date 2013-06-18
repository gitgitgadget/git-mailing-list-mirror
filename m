From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] builtin/checkout.c: don't leak memory in
 check_tracking_name
Date: Tue, 18 Jun 2013 02:15:01 -0400
Message-ID: <20130618061500.GF5916@sigill.intra.peff.net>
References: <1371519650-17869-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>, johan@herland.net
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 08:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UopCD-0002vB-7H
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 08:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237Ab3FRGPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 02:15:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:34528 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049Ab3FRGPF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 02:15:05 -0400
Received: (qmail 23322 invoked by uid 102); 18 Jun 2013 06:16:02 -0000
Received: from mobile-032-141-227-127.mycingular.net (HELO sigill.intra.peff.net) (32.141.227.127)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Jun 2013 01:16:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2013 02:15:01 -0400
Content-Disposition: inline
In-Reply-To: <1371519650-17869-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228158>

On Mon, Jun 17, 2013 at 06:40:49PM -0700, Brandon Casey wrote:

> From: Brandon Casey <drafnel@gmail.com>
> 
> remote_find_tracking() populates the query struct with an allocated
> string in the dst member.  So, we do not need to xstrdup() the string,
> since we can transfer ownership from the query struct (which will go
> out of scope at the end of this function) to our callback struct, but
> we must free the string if it will not be used so we will not leak
> memory.
> 
> Let's do so.

Thanks, looks obviously correct. I wonder if other callers of
remote_find_tracking make the same mistake. It looks like
check_tracking_branch does. And add_branch_for_removal. and
append_ref_to_tracked_list. Yeesh.

-Peff
