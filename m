From: Jeff King <peff@peff.net>
Subject: Re: [RFC] notes: avoid recommitting identical trees
Date: Tue, 31 Aug 2010 12:01:45 -0400
Message-ID: <20100831160145.GC11014@sigill.intra.peff.net>
References: <4C7CD65F.10509@atlas-elektronik.com>
 <bc44b3393db4018487bb956d00a12fa73f04ca9e.1283267564.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	stefan.naewe@atlas-elektronik.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:01:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTHF-0003Eo-70
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720Ab0HaQB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 12:01:28 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52861 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab0HaQB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 12:01:27 -0400
Received: (qmail 28469 invoked by uid 111); 31 Aug 2010 16:01:27 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 31 Aug 2010 16:01:27 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Aug 2010 12:01:45 -0400
Content-Disposition: inline
In-Reply-To: <bc44b3393db4018487bb956d00a12fa73f04ca9e.1283267564.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154927>

On Tue, Aug 31, 2010 at 05:16:17PM +0200, Michael J Gruber wrote:

> Currently, "git notes" behaves like "git commit --allow-empty" when
> committing notes trees. In particular, removing nonexisting notes leads
> to empty commits "commits with no diff".
> 
> Change this to avoid unnecessary notes commits.

Is this a sufficient check in the case of notes? Is it possible that we
re-balanced the fanout of the notes tree and got a different tree sha1,
even though there is nothing interesting to commit?

> +	if (!parent || parse_commit(parent->item) || parse_tree(parent->item->tree) ||
> +		hashcmp(parent->item->tree->object.sha1, tree_sha1)) {

I didn't check, but I can imagine you can drop the parse_tree here. We
should know the object sha1 once the commit is parsed.

-Peff
