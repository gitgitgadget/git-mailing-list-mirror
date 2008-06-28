From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Sun, 29 Jun 2008 07:32:12 +0900
Message-ID: <20080629073212.6117@nanako3.lavabit.com>
References: <20080628090642.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 00:33:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCizJ-0000j5-TN
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 00:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbYF1Wcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 18:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbYF1Wcs
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 18:32:48 -0400
Received: from karen.lavabit.com ([72.249.41.33]:60770 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886AbYF1Wcq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 18:32:46 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 83FCBC893E;
	Sat, 28 Jun 2008 17:32:37 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id LFY8F09CWQLW; Sat, 28 Jun 2008 17:32:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=wBK7c2ksKeYZWqf7fIgo22rsxbfLlLW7jGPxu8wHK0kbDtQsukg3F0RZ0z8WrtLBqGcHAevdBZbgaKLUn4Vi9cO8PGvmD1HBXbCWQqveiI239ai/RUJBc5d3WraDzaYEGIB4mpi3yZYGGy+0atAxkVndQnZgwSQfh2PWVSYIPME=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting myself;
In-Reply-To: <20080628090642.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86747>

Quoting myself:

>>> Don't you also want to talk about distinction between --cached and
>>> --index that new people are often confused about?  These options are
>>> defined consistently across commands but people who do not know it bring
>>> up discussions to rename --cached to some commands to --index to make it
>>> inconsistent and waste your time every once in a while.
>
> Do you have any comment on the --index/--cached issue?

Junio, I haven't heard back from you yet and I take it you mean you are not interested in a vague suggestion but in a concrete patch, so here it is.

-- cut here -- 8< -- cut here --

Subject: [PATCH] gitcli: Document meaning of --cached and --index

We saw this explanation repeated on the git mailing list a
few times. Even though the description of individual options
to particular commands are explained in their manual pages,
the reason behind choosing which is which has been clearly
explained in none of the documentation.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Documentation/gitcli.txt |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 2316049..281a987 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -133,9 +133,45 @@ $ git describe --abbrev 10 HEAD  # NOT WHAT YOU MEANT
 ----------------------------
 
 
+NOTES ON FREQUENTLY CONFUSED OPTIONS
+------------------------------------
+
+Many commands that can work on files in the working tree
+and/or in the index can take `--cached` and/or `--index`
+options.  Sometimes people incorrectly think that, because
+the index was originally called cache, these two are
+synonyms.  They are _not_ --- these two options mean very
+different things.
+
+ * The `--cached` option is used to ask a command that
+   usually works on files in the working tree to _only_ work
+   with the index.  For example, `git grep`, when used
+   without a commit to specify from which commit to look for
+   strings in, usually works on files in the working tree,
+   but with the `--cached` option, it looks for strings in
+   the index.
+
+ * The `--index` option is used to ask a command that
+   usually works on files in the working tree to _also_
+   affect the index.  For example, `git stash apply` usually
+   merges changes recorded in a stash to the working tree,
+   but with the `--index` option, it also merges changes to
+   the index as well.
+
+`git apply` command can be used with `--cached` and
+`--index` (but not at the same time).  Usually the command
+only affects the files in the working tree, but with
+`--index`, it patches both the files and their index
+entries, and with `--cached`, it modifies only the index
+entries.
+
+See also http://marc.info/?l=git&m=116563135620359 and
+http://marc.info/?l=git&m=119150393620273 for further
+information.
+
 Documentation
 -------------
-Documentation by Pierre Habouzit.
+Documentation by Pierre Habouzit and others.
 
 GIT
 ---

-- 
1.5.6

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
