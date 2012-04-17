From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 0/3] fetch: Only call a new ref a "branch" if it's
 under refs/heads/.
Date: Tue, 17 Apr 2012 15:29:59 -0700
Message-ID: <20120417222959.GD10797@sigill.intra.peff.net>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
 <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Wed Apr 18 00:30:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGuX-0003W1-O7
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 00:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683Ab2DQWaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 18:30:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37421
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab2DQWaC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 18:30:02 -0400
Received: (qmail 9424 invoked by uid 107); 17 Apr 2012 22:30:11 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Apr 2012 18:30:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Apr 2012 15:29:59 -0700
Content-Disposition: inline
In-Reply-To: <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195822>

On Mon, Apr 16, 2012 at 06:08:47PM -0400, marcnarc@xiplink.com wrote:

> 
> It turns out that ref->peer_ref is always NULL in update_local_ref().  So I
> made its caller pass in the full remote ref as a new parameter.  I also added
> a unit test.

Hrm. So yeah, it is because the "struct ref" we create is not from the
ref_map, but is a newly created ref based on the local side (and I had
my refs backwards before; the remote ref is the "real" ref, and the
local version is found in peer_ref, not the other way around).

But I couldn't help but notice that store_updated_refs already has this
exact same "what do we call it to the user" logic in it, which is what
goes into FETCH_HEAD. Shouldn't we just be passing this "kind" flag down
to update_local_ref, and then this copy of the logic can go away
entirely?

-Peff
