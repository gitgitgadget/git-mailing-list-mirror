From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git checkout -b removes MERGE_HEAD
Date: Thu, 18 Nov 2010 14:26:47 -0500
Message-ID: <20101118192647.GD30438@sigill.intra.peff.net>
References: <456aec650e66bba518b8a5ec88c88a6b.squirrel@artax.karlin.mff.cuni.cz>
 <7vwroabhng.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 20:27:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJA8J-0002Ir-KX
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 20:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab0KRT0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 14:26:54 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37112 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753461Ab0KRT0y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 14:26:54 -0500
Received: (qmail 18363 invoked by uid 111); 18 Nov 2010 19:26:52 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 18 Nov 2010 19:26:52 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Nov 2010 14:26:47 -0500
Content-Disposition: inline
In-Reply-To: <7vwroabhng.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161708>

On Thu, Nov 18, 2010 at 10:39:31AM -0800, Junio C Hamano wrote:

> I think it was an oversight by the author of 91dcdfd (Make "git checkout"
> create new branches on demand, 2005-07-11) who forgot that he also did
> ef0bfa2 (Remove MERGE_HEAD in "git checkout/reset", 2005-06-21).  The
> rationale for the removal of MERGE_HEAD from the earlier commit is:
> 
>     [this command] will end up resetting the index to some specific
>     head, and any unresolved merge will be forgotten [hence there is no
>     point recording the result as a merge].
> 
> but when used with -b no such "resetting of the index" happens.

It is not necessarily about "-b" is it? It is about moving to a
different commit. So I would think that on branch "master":

  # should clear MERGE_HEAD
  git checkout foo

  # should not clear MERGE_HEAD; it's a no-op, and we have in the past
  # encouraged people to run this to see the ahead/behind count
  git checkout
  # or
  git checkout master

  # should clear MERGE_HEAD; we are moving to a new commit
  git checkout -b foo some_commit

  # should not clear MERGE_HEAD; this is Jan's case
  git checkout -b foo
  # or
  git checkout -b foo master

-Peff
