From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] fix git-archive with empty trees
Date: Sun, 10 Mar 2013 21:31:24 -0400
Message-ID: <20130311013123.GA11692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 02:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UErak-0007ua-BU
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 02:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466Ab3CKBb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 21:31:28 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45560 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425Ab3CKBb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 21:31:27 -0400
Received: (qmail 9496 invoked by uid 107); 11 Mar 2013 01:33:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Mar 2013 21:33:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Mar 2013 21:31:24 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217845>

I noticed that "git archive" will barf when the root tree is empty.
Instead, it should probably return an empty archive. I doubt many people
really care about this corner case in practice, but it seems like we
should handle it more gracefully (and it's an easy fix).

It came to my attention because we track failed git-archive invocations
at GitHub, and a particular repo had a two commits: adding some content,
then reverting the original commit. You can also get there with "commit
--allow-empty" on a new branch (which is what the tests do).

I didn't bother even looking at empty subtrees. AFAIK, git should never
produce them (it omits the tree entirely if there is no content in it).
You would have to fake it using hash-object manually. I suspect it would
work just fine, as we already exercise the empty-dir code paths in the
tests I did add.

  [1/2]: test-lib: factor out $GIT_UNZIP setup
  [2/2]: archive: handle commits with an empty tree

-Peff
