From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] merge-one-file and GIT_WORK_TREE
Date: Thu, 28 Apr 2011 18:38:22 -0400
Message-ID: <20110428223822.GA16004@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aman Gupta <themastermind1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 00:38:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFZqy-0007mb-1Y
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 00:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933540Ab1D1WiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 18:38:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49417
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932595Ab1D1WiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 18:38:25 -0400
Received: (qmail 6675 invoked by uid 107); 28 Apr 2011 22:40:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Apr 2011 18:40:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2011 18:38:22 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172412>

[argh, resend, actually remembering to cc the list this time]

At GitHub, we're using read-tree, merge-index, and merge-one-file to do
trivial content-level merges from bare repositories (without having to
check out the entire repository contents each time).

However, we noticed a bug in git-merge-one-file when used with
GIT_WORK_TREE; it can silently create bogus results that ignore the
"theirs" side of files needing content-level merging.

The problem is that merge-one-file simply assumes it is in the root of
the working tree without any checking.  The only two places we use
merge-one-file in git itself are in the octopus and resolve strategies.
I think normal use is fine, because "git merge" will have changed to the
toplevel of the worktree already.

So I doubt anybody else is being affected by this. But we do expose the
commands for general use, with no disclaimer or check on the working
tree status or location. And the resulting bogus merge is a nasty
surprise.

  [1/2]: add tests for merge-index / merge-one-file
  [2/2]: merge-one-file: fix broken merges with GIT_WORK_TREE

-Peff
