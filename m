From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick applies some other changes than the specified one?
Date: Mon, 21 Mar 2011 13:54:31 -0700
Message-ID: <7vsjugnqig.fsf@alter.siamese.dyndns.org>
References: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com>
 <7vwrjssbfk.fsf@alter.siamese.dyndns.org> <4D877FAD.9000807@viscovery.net>
 <4D879516.3060204@gmail.com> <20110321195846.GA4277@elie>
 <4D87B00D.2010905@gmail.com> <7v62rcp6m6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:55:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1m7q-0008Iy-RB
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab1CUUyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 16:54:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab1CUUyp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 16:54:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B1294C52;
	Mon, 21 Mar 2011 16:56:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w/tZcDOZD+lMfsqKDLk81QR510w=; b=Dxfzro
	/xBFcPerNfDGHO0qR655MwAfVEPe9R+qrk1irZsqAurThCyqNS0riij7bgOOcjD9
	GKX9iXZHy6UTC/82SQ9NpofO1DSjyxHe0IQpzMB6qvoVhRM7ERinAVIBuKX5iBVa
	pkK0zKFWzrVKNLU8xzaAc6LqxizdYxh+kgTrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rHHXzVx8+lDWnE6sKGzQywicYB16yKrc
	/WjoqKAg0nXu+WSy4t/BCS63NnGS+XU4lD0hiPgdvMEi6MUbrWzks+mLSUYb0O2W
	tMyXZRaF8H1GaTFHEq2zEL+bnwtLczTmg7hoqi9SzUO94Occ35NypHcTMBg7i9fP
	dhtontkyq6E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 27D274C4D;
	Mon, 21 Mar 2011 16:56:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 834704C4A; Mon, 21 Mar 2011
 16:56:12 -0400 (EDT)
In-Reply-To: <7v62rcp6m6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 21 Mar 2011 13:21:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAEF12B6-53FD-11E0-8AA3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169670>

Junio C Hamano <gitster@pobox.com> writes:

>> Thanks, didn't know about that (and it's not documented in diff man page).
>
> These "compare a particular stage against working tree file" modes
> only make sense when you are comparing the index and the working tree, so
> the description is in "git diff-files" manpage but hasn't been ported to
> the documentation of generic "git diff" frontend.
>
> Perhaps we should.

And here is a quick attempt to do so.

This just leaves the details of what -c/--cc are about to the combined
diff format section in diff-generate-patch.txt, which I updated in the
separate patch.

 Documentation/diff-options.txt   |   31 +++++++++++++++++++++++++++++++
 Documentation/git-diff-files.txt |   19 -------------------
 Documentation/git-diff-tree.txt  |   20 --------------------
 3 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c93124b..19ce302 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -24,6 +24,37 @@ ifndef::git-format-patch[]
 --patch::
 	Generate patch (see section on generating patches).
 	{git-diff? This is the default.}
+
+-1 --base::
+-2 --ours::
+-3 --theirs::
+-0::
+	These make sense only when comparing the index and the working
+	tree (i.e. `git diff-files` or `git diff <path>...`) and compares
+	against the "base" version, "our branch" or "their
+	branch" respectively.  With these options, diffs for
+	merged entries are not shown.
++
+The default is to diff against our branch (-2) and the
+cleanly resolved paths.  The option -0 can be given to
+omit diff output for unmerged entries and just show "Unmerged".
+
+-c::
+--cc::
+	Produce "combined diff" (and "dense combined diff" showing how the
+	result is different compared to more than one original.
++
+When used in showing a merge commit (i.e. `git show <merge>`, 
+`git diff-tree <merge>` or when feeding a merge commit
+to `git diff-tree --stdin`), compare the parent commits of the
+merge with the merge commit.
++
+When used in comparison between the index and the working tree
+(i.e. `git diff` during a conflicted merge or rebase),
+compare stage 2 (our branch), stage 3 (their
+branch) and the working tree file and outputs a combined
+diff.
+
 endif::git-format-patch[]
 
 -U<n>::
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 8d48194..82d2e2e 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -21,25 +21,6 @@ OPTIONS
 -------
 include::diff-options.txt[]
 
--1 --base::
--2 --ours::
--3 --theirs::
--0::
-	Diff against the "base" version, "our branch" or "their
-	branch" respectively.  With these options, diffs for
-	merged entries are not shown.
-+
-The default is to diff against our branch (-2) and the
-cleanly resolved paths.  The option -0 can be given to
-omit diff output for unmerged entries and just show "Unmerged".
-
--c::
---cc::
-	This compares stage 2 (our branch), stage 3 (their
-	branch) and the working tree file and outputs a combined
-	diff, similar to the way 'diff-tree' shows a merge
-	commit with these flags.
-
 -q::
 	Remain silent even on nonexistent files
 
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 4e5f127..ebcfcfb 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -88,26 +88,6 @@ include::pretty-options.txt[]
 	'git diff-tree' outputs a line with the commit ID when
 	applicable.  This flag suppressed the commit ID output.
 
--c::
-	This flag changes the way a merge commit is displayed
-	(which means it is useful only when the command is given
-	one <tree-ish>, or '--stdin').  It shows the differences
-	from each of the parents to the merge result simultaneously
-	instead of showing pairwise diff between a parent and the
-	result one at a time (which is what the '-m' option does).
-	Furthermore, it lists only files which were modified
-	from all parents.
-
---cc::
-	This flag changes the way a merge commit patch is displayed,
-	in a similar way to the '-c' option. It implies the '-c'
-	and '-p' options and further compresses the patch output
-	by omitting uninteresting hunks whose the contents in the parents
-	have only two variants and the merge result picks one of them
-	without modification.  When all hunks are uninteresting, the commit
-	itself and the commit log message is not shown, just like in any other
-	"empty diff" case.
-
 --always::
 	Show the commit itself and the commit log message even
 	if the diff itself is empty.
