From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] tutorial: clarify "pull" is "fetch + merge"
Date: Thu, 10 Jul 2008 14:01:57 -0700
Message-ID: <7vskuho3lm.fsf_-_@gitster.siamese.dyndns.org>
References: <dc5b80bf0807100652y394e655lfcdd819cc4506afa@mail.gmail.com>
 <alpine.DEB.1.00.0807101524440.18205@racer>
 <dc5b80bf0807100729h3e247f68qc48dafc9d0bb154f@mail.gmail.com>
 <alpine.DEB.1.00.0807101654080.18205@racer>
 <dc5b80bf0807100912rac7b730ga1ac035057d71d64@mail.gmail.com>
 <20080710164520.GZ10347@genesis.frugalware.org>
 <dc5b80bf0807101127q63e3132fw207baf0d88db3d9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ian Katz" <ifreecarve@gmail.com>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 23:03:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH3IL-0002MT-AH
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 23:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbYGJVCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 17:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbYGJVCS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 17:02:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbYGJVCS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 17:02:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E7051264E9;
	Thu, 10 Jul 2008 17:02:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 40E81264E7; Thu, 10 Jul 2008 17:02:09 -0400 (EDT)
In-Reply-To: <dc5b80bf0807101127q63e3132fw207baf0d88db3d9d@mail.gmail.com>
 (Ian Katz's message of "Thu, 10 Jul 2008 14:27:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7A5B023C-4EC3-11DD-8DF5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88012>

The document says that a fetch with a configured remote stores what are
fetched in the remote tracking branches "Unlike the longhand form", but
there is no longhand form "fetch" demonstrated earlier.

This adds a missing demonstration of the longhand form, and a new
paragraph to explain why some people might want to fetch before pull.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/gittutorial.txt |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index e71b561..38807f3 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -306,6 +306,32 @@ is the default.)
 The "pull" command thus performs two operations: it fetches changes
 from a remote branch, then merges them into the current branch.
 
+Note that in general, Alice would want her local changes committed before
+initiating this "pull".  If Bob's work conflicts with what Alice did since
+their histories forked, Alice will use her working tree and the index to
+resolve conflicts, and existing local changes will interfere with the
+conflict resolution process (git will still perform the fetch but will
+refuse to merge --- Alice will have to get rid of her local changes in
+some way and pull again when this happens).
+
+Alice can peek what Bob did without merging first, using the "fetch"
+command; this allows Alice to inspect what bob did, using a special
+symbol "FETCH_HEAD", in order to determine if he has anything worth
+pulling, like this:
+
+------------------------------------------------
+$ git fetch /home/bob/myrepo master
+$ git log -p ..FETCH_HEAD
+------------------------------------------------
+
+This operation is safe even if Alice has uncommitted local changes.
+
+After inspecting what Bob did, if there is nothing urgent, Alice may
+decide to continue working without pulling from Bob.  If Bob's history
+does have something Alice would immediately need, Alice may choose to
+stash her work-in-progress first, do a "pull", and then finally unstash
+her work-in-progress on top of the resulting history.
+
 When you are working in a small closely knit group, it is not
 unusual to interact with the same repository over and over
 again.  By defining 'remote' repository shorthand, you can make
@@ -315,7 +341,7 @@ it easier:
 $ git remote add bob /home/bob/myrepo
 ------------------------------------------------
 
-With this, Alice can perform the first operation alone using the
+With this, Alice can perform the first part of "pull" operation alone using the
 'git-fetch' command without merging them with her own branch,
 using:
 
