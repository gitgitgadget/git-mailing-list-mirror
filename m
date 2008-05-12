From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git show documentation: no longer refer to git-diff-tree
 options
Date: Mon, 12 May 2008 16:10:09 -0700
Message-ID: <7vzlqvw23y.fsf@gitster.siamese.dyndns.org>
References: <1210545443-12665-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nanako3@bluebottle.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue May 13 01:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvhAo-0006iG-Nf
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 01:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbYELXK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 19:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbYELXKZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 19:10:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbYELXKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 19:10:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 20E6C503D;
	Mon, 12 May 2008 19:10:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 03DFA503B; Mon, 12 May 2008 19:10:17 -0400 (EDT)
In-Reply-To: <1210545443-12665-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Mon, 12 May 2008 00:37:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 994E9CC2-2078-11DD-95C0-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81964>

Miklos Vajna <vmiklos@frugalware.org> writes:

> This patch implements this, I hope.
>
> (Sorry for the delay, BTW.)

No problem.  Thanks.

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 13234fa..af7846d 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -17,6 +17,7 @@ ifdef::git-format-patch[]
>  	Generate patches without diffstat.
>  endif::git-format-patch[]

Hmm.  The symbol git-diff-core is defined for git-show and we say --raw is
the default for git-show because of it?

How about doing it this way instead?

---
 Documentation/diff-options.txt |   22 +++++++++++++++++-----
 Documentation/git-show.txt     |   14 ++++++++------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 13234fa..a478612 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -7,21 +7,33 @@
 ifndef::git-format-patch[]
 ifndef::git-diff[]
 ifndef::git-log[]
+ifndef::git-show[]
 :git-diff-core: 1
+endif::git-show[]
 endif::git-log[]
 endif::git-diff[]
 endif::git-format-patch[]
 
+ifdef::git-diff[]
+:git-diff-p-is-default: 1
+endif::git-diff[]
+ifdef::git-show[]
+:git-diff-p-is-default: 1
+endif::git-show[]
 ifdef::git-format-patch[]
+:git-diff-p-stat-is-default: 1
+endif::git-format-patch[]
+
+ifdef::git-diff-p-stat-is-default[]
 -p::
 	Generate patches without diffstat.
-endif::git-format-patch[]
+endif::git-diff-p-stat-is-default[]
 
-ifndef::git-format-patch[]
+ifndef::git-diff-p-stat-is-default[]
 -p::
 	Generate patch (see section on generating patches).
-	{git-diff? This is the default.}
-endif::git-format-patch[]
+	{git-diff-p-is-default? This is the default.}
+endif::git-diff-p-stat-is-default[]
 
 -u::
 	Synonym for "-p".
@@ -72,7 +84,7 @@ endif::git-format-patch[]
 
 --patch-with-stat::
 	Synonym for "-p --stat".
-	{git-format-patch? This is the default.}
+	{git-diff-p-stat-is-default? This is the default.}
 
 -z::
 	NUL-line termination on output.  This affects the --raw
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index dccf0e2..6b5c3fb 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -25,12 +25,6 @@ with \--name-only).
 
 For plain blobs, it shows the plain contents.
 
-The command takes options applicable to the linkgit:git-diff-tree[1] command to
-control how the changes the commit introduces are shown.
-
-This manual page describes only the most frequently used options.
-
-
 OPTIONS
 -------
 <object>::
@@ -38,6 +32,14 @@ OPTIONS
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
 
+-s, --quiet::
+	Don't show a textural diff for commits.
+
+
+:git-show: 1
+include::diff-options.txt[]
+
+
 include::pretty-options.txt[]
 
 
