From: Jeff King <peff@peff.net>
Subject: Re: diff/Checking out by date specification
Date: Sun, 29 Jun 2008 23:27:45 -0400
Message-ID: <20080630032744.GA18930@sigill.intra.peff.net>
References: <486843C3.30402@rea-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Toby Corkindale <toby.corkindale@rea-group.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 05:29:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDA4n-0003GJ-5t
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 05:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbYF3D1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 23:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbYF3D1s
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 23:27:48 -0400
Received: from peff.net ([208.65.91.99]:3970 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbYF3D1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 23:27:48 -0400
Received: (qmail 24686 invoked by uid 111); 30 Jun 2008 03:27:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 29 Jun 2008 23:27:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jun 2008 23:27:45 -0400
Content-Disposition: inline
In-Reply-To: <486843C3.30402@rea-group.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86867>

On Mon, Jun 30, 2008 at 12:24:03PM +1000, Toby Corkindale wrote:

> `man git-rev-parse` seems to indicate that one can look at the state of  
> the repository by date (absolute or relative), and use this for diff or  
> checkout, etc.
> It includes examples such as "{yesterday}" and "{1979-02-26 18:30:00}".

It's a little bit more complex than that. The branch@{time} syntax means
"what was in _my_ branch at that time". And if you just cloned, your
branch doesn't go back very far.

If you want to say "find commits that happened before time T", you want
--until or --since (or their aliases --before and --after).

Would the documentation patch below have helped with the confusion?

-- >8 --
doc/rev-parse: clarify reflog vs --until for specifying revisions

The rev-parse manpage introduces the branch@{date} syntax,
and mentions the reflog specifically. However, new users may
not be familiar with the distinction between the reflog and
the commit date, so let's help them out with a "you may be
interested in --until" pointer.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-rev-parse.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 9e273bc..59e95ad 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -184,7 +184,10 @@ blobs contained in a commit.
   second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
   of the ref at a prior point in time.  This suffix may only be
   used immediately following a ref name and the ref must have an
-  existing log ($GIT_DIR/logs/<ref>).
+  existing log ($GIT_DIR/logs/<ref>). Note that this looks up the state
+  of your *local* ref at a given time; e.g., what was in your local
+  `master` branch last week. If you want to look at commits made during
+  certain times, see `--since` and `--until`.
 
 * A ref followed by the suffix '@' with an ordinal specification
   enclosed in a brace pair (e.g. '\{1\}', '\{15\}') to specify
-- 
1.5.6.1.202.g3a23.dirty
