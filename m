From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Adding a cache of commit to patch-id pairs to speed up
	git-cherry
Date: Mon, 2 Jun 2008 02:42:18 -0400
Message-ID: <20080602064218.GA15144@sigill.intra.peff.net>
References: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com> <alpine.DEB.1.00.0806020649110.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geoffrey Irving <irving@naml.us>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 02 08:43:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K33lD-0002hn-5Y
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 08:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbYFBGmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 02:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbYFBGmV
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 02:42:21 -0400
Received: from peff.net ([208.65.91.99]:1900 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048AbYFBGmV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 02:42:21 -0400
Received: (qmail 9641 invoked by uid 111); 2 Jun 2008 06:42:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 02 Jun 2008 02:42:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jun 2008 02:42:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806020649110.13507@racer.site.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83497>

On Mon, Jun 02, 2008 at 07:13:14AM +0100, Johannes Schindelin wrote:

> I do not think that this "read-the-entire-table-into-memory" paradigm is a 
> wise choice. mmap()ing, I would have understood, but reading a potentially 
> pretty large table into memory?

When I was just a git-youth, I wrote a fast mmap-based cache for storing
SHA1 pairs. It might give some direction. You should be able to find it
here:

  http://mid.gmane.org/20060629035849.GA30749@coredump.intra.peff.net

It mmaps and binary searches a sorted list. New entries are added to an
in-memory list, and then at the end of a run, the two sorted lists are
merged to create the new on-disk version.

-Peff
