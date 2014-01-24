From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: turn off bitmaps when skipping objects
Date: Thu, 23 Jan 2014 21:28:22 -0500
Message-ID: <20140124022822.GC4521@sigill.intra.peff.net>
References: <52E080C1.4030402@fb.com>
 <20140123225238.GB2567@sigill.intra.peff.net>
 <52E1A99D.6010809@fb.com>
 <52E1AB78.1000504@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Siddharth Agarwal <sid0@fb.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 03:28:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6WVQ-0006og-NY
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 03:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbaAXC2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 21:28:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:37972 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751162AbaAXC2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 21:28:24 -0500
Received: (qmail 17219 invoked by uid 102); 24 Jan 2014 02:28:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 20:28:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 21:28:22 -0500
Content-Disposition: inline
In-Reply-To: <52E1AB78.1000504@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240994>

On Thu, Jan 23, 2014 at 03:53:28PM -0800, Siddharth Agarwal wrote:

> On 01/23/2014 03:45 PM, Siddharth Agarwal wrote:
> >
> >The worry is less certain objects not being packed and more the old
> >packs being deleted by git repack, isn't it? From the man page for
> >git-index-pack:
> 
> This should probably be "new pack" and not "old packs", I guess. Not
> knowing much about how this actually works, I'm assuming the scenario
> here is something like:
> 
> (1) git receive-pack receives a pack P.pack and writes it to disk
> (2) git index-pack runs on P.pack
> (3) git repack runs separately, finds pack P.pack with no refs
> pointing to it, and deletes it
> (4) everything goes wrong
> 
> With a keep file, this would be averted because
> 
> (1) git receive-pack receives a pack P.pack and writes it to disk
> (2) git index-pack writes a keep file for P.pack, called P.keep
> (3) git repack runs separately, finds pack P.pack with a keep file,
> doesn't touch it
> (4) git index-pack finishes, and something updates refs to point to
> P.pack and deletes P.keep

I think your understanding is accurate here. So we want repack to
respect keep files for deletion, but we _not_ necessarily want
pack-objects to avoid packing an object just because it's in a pack
marked by .keep (see my other email).

-Peff
