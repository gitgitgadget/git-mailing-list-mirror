From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/4] real reachability checks for upload-archive
Date: Wed, 5 Jun 2013 18:35:51 -0400
Message-ID: <20130605223551.GF8664@sigill.intra.peff.net>
References: <20120111193916.GA12333@sigill.intra.peff.net>
 <20120111194232.GB12441@sigill.intra.peff.net>
 <loom.20130529T133942-310@post.gmane.org>
 <20130605163823.GE8664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ian Harvey <iharvey@good.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 00:36:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkMJD-00033U-54
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 00:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758029Ab3FEWfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 18:35:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:54309 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757840Ab3FEWfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 18:35:54 -0400
Received: (qmail 16717 invoked by uid 102); 5 Jun 2013 22:36:40 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Jun 2013 17:36:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2013 18:35:51 -0400
Content-Disposition: inline
In-Reply-To: <20130605163823.GE8664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226471>

On Wed, Jun 05, 2013 at 12:38:23PM -0400, Jeff King wrote:

>   2. Actually do a reachability check. Doing a full object check to
>      allow fetching an arbitrary tree by sha1 is probably prohibitively
>      expensive[2], but we could allow the form "<commit>[:<path>]", check
>      that "<commit>" is reachable, and then allow arbitrary paths within
>      it.

Thinking on this more, the full reachability check is no worse than what
a clone has to do to fetch the full repository. Here's a series that
does the full check. I'm not entirely happy with the performance,
though; details are in patch 3.

I think I'd be tempted to just go the more limiting "commit is
reachable" route, instead, which would solve your case (and most sane
cases).

  [1/4]: clear parsed flag when we free tree buffers
  [2/4]: upload-archive: restrict remote objects with reachability check
  [3/4]: list-objects: optimize "revs->blob_objects = 0" case
  [4/4]: archive: ignore blob objects when checking reachability

-Peff
