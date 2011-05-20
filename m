From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] receive-pack: eliminate duplicate .have refs
Date: Fri, 20 May 2011 03:42:09 -0400
Message-ID: <20110520074209.GB3663@sigill.intra.peff.net>
References: <20110519213231.GA29702@sigill.intra.peff.net>
 <20110519213446.GC29793@sigill.intra.peff.net>
 <7vaaei5avn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 09:42:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNKLh-0003Uj-KR
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 09:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934230Ab1ETHmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 03:42:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55357
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934154Ab1ETHmM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 03:42:12 -0400
Received: (qmail 26320 invoked by uid 107); 20 May 2011 07:44:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 May 2011 03:44:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 May 2011 03:42:09 -0400
Content-Disposition: inline
In-Reply-To: <7vaaei5avn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174046>

On Thu, May 19, 2011 at 08:06:20PM -0700, Junio C Hamano wrote:

> At first I thought you are going to insert the object names into a sorted
> list and handle dups while doing so, but it makes a lot more sense to
> append first and then sort at the end, and skip the dups while scanning,
> which is what you did.

I considered doing that, but I was worried that the constant
memmove()ing to insert into the sorted array would be inefficient.  As
it is, this uses a little more memory than necessary since we store all
the duplicates temporarily in memory (but we are not talking about a
lot, and I'm pretty sure they are all stored as a linked list elsewhere,
anyway, so it's not a huge deal).

The "right" data structure would be something like a tree or a hash. But
our hash is so painful to use for simple things like this (you have to
handle collision and creation of a linked list yourself!), that I just
went with the sorted list.

-Peff
