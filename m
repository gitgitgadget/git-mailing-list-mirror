From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Thu, 22 Mar 2007 03:31:31 -0700
Message-ID: <7vr6rhtvr0.fsf@assigned-by-dhcp.cox.net>
References: <20070321120643.GI20583@mellanox.co.il>
	<7v648u38ws.fsf@assigned-by-dhcp.cox.net>
	<20070322043604.GA6303@mellanox.co.il>
	<7vd531yicx.fsf@assigned-by-dhcp.cox.net>
	<20070322062805.GD6303@mellanox.co.il>
	<7vaby5wxyn.fsf@assigned-by-dhcp.cox.net>
	<20070322074051.GA29341@mellanox.co.il>
	<7vlkhpvgc7.fsf@assigned-by-dhcp.cox.net>
	<20070322083757.GC29341@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu Mar 22 11:31:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUKa2-0004yS-Tp
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 11:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbXCVKbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 06:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbXCVKbf
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 06:31:35 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57907 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030403AbXCVKbe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 06:31:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322103134.PTWD321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 22 Mar 2007 06:31:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dmXZ1W00e1kojtg0000000; Thu, 22 Mar 2007 06:31:34 -0400
In-Reply-To: <20070322083757.GC29341@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 22 Mar 2007 10:37:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42856>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> Specifically, as far as a *user* is concerned:
> 1. the fact that "---" separates commit message from patch, and
>    that text after "---" is ignored seems to be undocumented
> 2. the fact that message subject is appended to the log,
>    the rules for removing [PATCH] etc from subject seem to be undocumented
> 3. if I want to have some text coming *before* the commit
>    message ignored, there's no way to do this
> 4. there's no way to override the subject from within the message
>    (like there is with author/From line)

How about this?  Also check t5100 and its sample mailbox,
especially the "third patch" from A U Thor, which I forwarded
with the subject "another patch".

---

 Documentation/git-am.txt |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 13a7389..148ce40 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -87,6 +87,33 @@ default.   You could use `--no-utf8` to override this.
 DISCUSSION
 ----------
 
+The commit author name is taken from the "From: " line of the
+message, and commit author time is taken from the "Date: " line
+of the message.  The "Subject: " line is used as the title of
+the commit, after stripping common prefix "[PATCH <anything>]".
+It is supposed to describe what the commit is about concisely as
+a one line text.
+
+The body of the message (iow, after a blank line that terminates
+RFC2822 headers) can begin with "Subject: " and "From: " lines
+that are different from those of the mail header, to override
+the values of these fields.
+
+The commit message is formed by the title taken from the
+"Subject: ", a blank line and the body of the message up to
+where the patch begins.  Excess whitespaces at the end of the
+lines are automatically stripped.
+
+The patch is expected to be inline, directly following the
+message.  Any line that is of form:
+
+* three-dashes and end-of-line, or
+* a line that begins with "diff -", or
+* a line that begins with "Index: "
+
+is taken as the beginning of a patch, and the commit log message
+is terminated before the first occurrence of such a line.
+
 When initially invoking it, you give it names of the mailboxes
 to crunch.  Upon seeing the first patch that does not apply, it
 aborts in the middle, just like 'git-applymbox' does.  You can
