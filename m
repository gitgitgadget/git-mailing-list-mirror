From: Jeff King <peff@peff.net>
Subject: Re: can I always ignore a file during a merge?
Date: Tue, 3 Jul 2012 03:38:47 -0400
Message-ID: <20120703073847.GD16679@sigill.intra.peff.net>
References: <p06240817cc114629c20f@[192.168.1.122]>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 09:38:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlxhI-00008z-PF
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 09:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab2GCHiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 03:38:51 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52141
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277Ab2GCHiv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 03:38:51 -0400
Received: (qmail 19245 invoked by uid 107); 3 Jul 2012 07:38:58 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jul 2012 03:38:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2012 03:38:47 -0400
Content-Disposition: inline
In-Reply-To: <p06240817cc114629c20f@[192.168.1.122]>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200905>

On Wed, Jun 27, 2012 at 07:39:03PM -0400, Stephen Bannasch wrote:

> Is there a way to merge from branchA to branchB and from branchB to
> branchA while completely ignoring changes to a file that is tracked
> and exists in both branches?

No. Fundamentally, a commit object in git consists of a content state
(i.e., a pointer to a tree object) and a pointer to all previous history
(i.e., zero or more "parent" pointers to commit objects). The semantics
of a commit object can be thought of as "I have looked at all of the
history in all of the parent commits, and the state contained in my tree
pointer supersedes them all".

So you could make merge B into A, but keep A's copy of the file (e.g.,
using the "ours" strategy). But that is saying that you considered the
state of both A and B, and decided that A's version supersedes what
happened in B. If you later wanted to merge from A to B, B's version of
the file would not even be considered as an outcome for the merge.

There isn't really a clever way to work around this via a different
merge strategy; it's a fundamental aspect of git's data structure for
storing history.

-Peff
