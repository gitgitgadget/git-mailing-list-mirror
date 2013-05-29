From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] patch-ids: check modified paths before calculating
 diff
Date: Wed, 29 May 2013 14:36:58 -0400
Message-ID: <20130529183658.GA15616@sigill.intra.peff.net>
References: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
 <20130529062007.GA11955@sigill.intra.peff.net>
 <7vip21u09d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Kevin Bracey <kevin@bracey.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 20:37:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhlFD-0005Ku-DX
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 20:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965518Ab3E2ShC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 14:37:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:41192 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206Ab3E2ShA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 14:37:00 -0400
Received: (qmail 16660 invoked by uid 102); 29 May 2013 18:37:40 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 13:37:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 14:36:58 -0400
Content-Disposition: inline
In-Reply-To: <7vip21u09d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225862>

On Wed, May 29, 2013 at 11:08:46AM -0700, Junio C Hamano wrote:

> This has rather interesting ramifications on cherry-pick and rebase,
> though.  Both command can handle changes that come from an old tree
> before some paths were renamed, but strict patch-id would not spot
> equivalent changes we already have in our history if our change
> happened after a rename, i.e.
> 
>    Z
>   /
>  O---R---X---Y
> 
> where Z updates path F, R moves F to G and X changes G the same way
> as Z changes F, and we are trying to cherry-pick Z on top of Y.  The
> cherry-pick filter will see different patch-id for Z and X.

True. That is a problem with the current patch-id system, no? Though my
proposal would make it harder to change it in the future (as does
John's).

With mine, I wonder if you could use a different "loose" definition that
does not take the filenames into account.  Using something like the
changes in file sizes would be unique, but would not properly map to
strict cases (a patch-id that adds 5 lines to the end of a 100-byte file
may match one that adds the same five lines to the end of a 200-byte
file).

-Peff
