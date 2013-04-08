From: Jeff King <peff@peff.net>
Subject: Re: commit-message attack for extracting sensitive data from
 rewritten Git history
Date: Mon, 8 Apr 2013 17:54:57 -0400
Message-ID: <20130408215457.GB11227@sigill.intra.peff.net>
References: <CAFY1edbNPjs5JGOPRxzB+ie4w=SvR+rUeePhsEnpr0tWtZpeHg@mail.gmail.com>
 <7vehelyqrv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Roberto Tyley <roberto.tyley@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:55:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPK1u-0007OP-Mb
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936383Ab3DHVzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:55:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34371 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936362Ab3DHVzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:55:03 -0400
Received: (qmail 16941 invoked by uid 107); 8 Apr 2013 21:56:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 17:56:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 17:54:57 -0400
Content-Disposition: inline
In-Reply-To: <7vehelyqrv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220526>

On Mon, Apr 08, 2013 at 08:40:36AM -0700, Junio C Hamano wrote:

> With or without the security issue, leaving old object names that
> will become irrelevant in the rewritten history will make the
> resulting history less useful, simply because people cannot look at
> the objects these messages refer to. The same argument is behind the
> reason why "cherry-pick -x" was originally the default, found to be
> a mistake and made optional.
> 
> filter-branch provides "map" helper function to help mapping old
> object names to rewritten object names, but stops there; it leaves
> it up to the message filter script to identify what string in the
> message is an object name to be rewritten.
> 
> It can be taught to be more helpful to the message filter writers,
> and you seem to have done so in BFG, which is very good.

Yeah, it would make sense for filter-branch to have a "--map-commit-ids"
option or similar that does the update. At first I thought it might take
two passes, but I don't think it is necessary, as long as we traverse
the commits topologically (i.e., you cannot have mentioned X in a commit
that is an ancestor of X, so you do not have to worry about mapping it
until after it has been processed).

-Peff
