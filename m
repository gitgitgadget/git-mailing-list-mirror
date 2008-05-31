From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Revision walking documentation: document most important functions
Date: Sat, 31 May 2008 02:18:08 +0200
Message-ID: <1212193088-5420-1-git-send-email-vmiklos@frugalware.org>
References: <7vej7kocrl.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 31 02:19:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2EoH-00068n-Dl
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 02:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbYEaASG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 20:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbYEaASF
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 20:18:05 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:55660 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbYEaASE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 20:18:04 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 9C41B1DDC5B;
	Sat, 31 May 2008 02:18:00 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 20BD418E2A7; Sat, 31 May 2008 02:18:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <7vej7kocrl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83360>

Unfortunately the list is not complete, but includes the essential ones.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, May 29, 2008 at 05:29:18PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> I think this paragraph is easier to read if it is in its own
> subsection
> "Calling Sequence" (see api-diff.txt for an example).

Done.

> > +`prepare_revision_walk`::
> > +
> > +   Prepares the rev_info structure for a walk. You should check if
> > it
> > +   returns any error (positive return code) and if it does not, you
> > can
>
> s/positive/non-zero/;

Fixed.

 Documentation/technical/api-revision-walking.txt |   60 +++++++++++++++++++++-
 1 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/api-revision-walking.txt b/Documentation/technical/api-revision-walking.txt
index 01a2455..996da05 100644
--- a/Documentation/technical/api-revision-walking.txt
+++ b/Documentation/technical/api-revision-walking.txt
@@ -1,9 +1,67 @@
 revision walking API
 ====================
 
+The revision walking API offers functions to build a list of revisions
+and then iterate over that list.
+
+Calling sequence
+----------------
+
+The walking API has a given calling sequence: first you need to
+initialize a rev_info structure, then add revisions to control what kind
+of revision list do you want to get, finally you can iterate over the
+revision list.
+
+Functions
+---------
+
+`init_revisions`::
+
+	Initialize a rev_info structure with default values. The second
+	parameter may be NULL or can be prefix path, and then the `.prefix`
+	variable will be set to it. This is typically the first function you
+	want to call when you want to deal with a revision list. After calling
+	this function, you are free to customize options, like set
+	`.ignore_merges` to 0 if you don't want to ignore merges, and so on. See
+	`revision.h` for a complete list of available options.
+
+`add_pending_object`::
+
+	This function can be used if you want to add commit objects as revision
+	information. You can use the `UNINTERESTING` object flag to indicate if
+	you want to include or exclude the given commit (and commits reachable
+	from the given commit) from the revision list.
++
+NOTE: If you have the commits as a string list then you probably want to
+use setup_revisions(), instead of parsing each string and using this
+function.
+
+`setup_revisions`::
+
+	Parse revision information, filling in the `rev_info` structure, and
+	removing the used arguments from the argument list. Returns the number
+	of arguments left that weren't recognized, which are also moved to the
+	head of the argument list. The last parameter is used in case no
+	parameter given by the first two arguments.
+
+`prepare_revision_walk`::
+
+	Prepares the rev_info structure for a walk. You should check if it
+	returns any error (non-zero return code) and if it does not, you can
+	start using get_revision() to do the iteration.
+
+`get_revision`::
+
+	Takes a pointer to a `rev_info` structure and iterates over it,
+	returning a `struct commit *` each time you call it. The end of the
+	revision list is indicated by returning a NULL pointer.
+
+Data structures
+---------------
+
 Talk about <revision.h>, things like:
 
 * two diff_options, one for path limiting, another for output;
-* calling sequence: init_revisions(), setup_revsions(), get_revision();
+* remaining functions;
 
 (Linus, JC, Dscho)
-- 
1.5.6.rc0.dirty
