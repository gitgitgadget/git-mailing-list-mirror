Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5784C2034E
	for <e@80x24.org>; Wed, 20 Jul 2016 21:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbcGTVKX (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:10:23 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:64473 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbcGTVKS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 17:10:18 -0400
Received: from localhost.localdomain ([92.22.79.77])
	by smtp.talktalk.net with SMTP
	id PykwbXvjRHGLwPykwbEmcY; Wed, 20 Jul 2016 22:10:16 +0100
X-Originating-IP: [92.22.79.77]
X-Spam:	0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=YfJyJ16zsu2qLTmLoX9DvA==:117
 a=YfJyJ16zsu2qLTmLoX9DvA==:17 a=k-K6jKogr27bNNYs8c4A:9
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 0/8] Name for A..B ranges?
Date:	Wed, 20 Jul 2016 22:09:59 +0100
Message-Id: <20160720211007.5520-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160711202518.532-1-philipoakley@iee.org>
References: <20160711202518.532-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfAG6nCF+GvZ+GufoMiQso74mqJ3HN2N+sPhQo5T8MPxvd933fOn2ubRsb0gq7g2rCuVZljnsQa2VkYkQkSu/nbrUJwTUlYG89lGPxMOJ8AaBs/t3TBei
 GOCY8Jz/A+dMYk6cT2vmd6qAt8U+DBF8vDsoMGpcROybe0+sRIr+nagWYs4YPH52QTA/kRgo9TMyrBIr+5cjvC6WECcGL98yx4P8srqw84tE/LGgKOh1fqyO
 mJD4aSy5zJvIFagauif+L1cn4E3YOXFIyqZRQ6h+AXGScz3zZXxEuFDDcE23jQUB
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is the V4 re-roll of the po/range-doc (2016-07-01) 3 commits and its
follow on patch.

Capitalisation has been fixed.
Heading levels for man pages has been fixed.
Quoting of the caret has been fixed.
The extra width wise 'caret' shorthands now mention their applicability to merge commits.

No change in the number of patches. Interdiff below.

The patches carefully tease out the clarification of
reachability. Reachability is defined relative the ancestry chain thus
(hopefully) avoiding misunderstandings.

The final patch updates the summary examples, and the tricky (for the
untutored reader) two dots case of a linear development where r1..r2
excludes r1 itself.

The patches can be squashed together if required.

Original discussion starts at: $gmane/297908
V1 patch series $gmane/298223
V2 patch series $gmane/298689
V3 patch series $gmane/299293


Philip Oakley (8):
  doc: use 'symmetric difference' consistently
  doc: revisions - name the left and right sides
  doc: show the actual left, right, and boundary marks
  doc: give headings for the two and three dot notations
  doc: gitrevisions - use 'reachable' in page description
  doc: gitrevisions - clarify 'latter case' is revision walk
  doc: revisions  - define `reachable`
  doc: revisions - clarify reachability examples

 Documentation/gitk.txt             |  2 +-
 Documentation/gitrevisions.txt     |  6 +--
 Documentation/pretty-formats.txt   |  2 +-
 Documentation/rev-list-options.txt |  4 +-
 Documentation/revisions.txt        | 83 ++++++++++++++++++++++++--------------
 5 files changed, 59 insertions(+), 38 deletions(-)

 interdiff:
 
 diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index dba4fc6..14622cc 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -241,35 +241,38 @@ of commits, not just a single commit.
 
 For these commands,
 specifying a single revision, using the notation described in the
-previous section, means the `reachable` set of commits of the given
+previous section, means the set of commits `reachable` from the given
 commit.
 
-A commit's reachable set is the commit itself and the commits of
+A commit's reachable set is the commit itself and the commits in
 its ancestry chain.
 
 
-The '{caret}' (caret) notation
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-To exclude commits reachable from a commit, a prefix '{caret}'
-notation is used.  E.g. '{caret}r1 r2' means commits reachable
-from 'r2' but exclude those reachable from 'r1' (i.e. 'r1' and its
-ancestors).
-
-The '..' (two-dot) range notation
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-The '{caret}r1 r2' set operation appears so often that there is a shorthand
-for it.  When you have two commits 'r1' and 'r2' (named according
-to the syntax explained in SPECIFYING REVISIONS above), you can ask
-for commits that are reachable from r2 excluding those that are reachable
-from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
-
-The '...' (three dot) Symmetric Difference notation
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-A similar notation 'r1\...r2' is called symmetric difference
-of 'r1' and 'r2' and is defined as
-'r1 r2 --not $(git merge-base --all r1 r2)'.
-It is the set of commits that are reachable from either one of
-'r1' (Left side) or 'r2' (Right side) but not from both.
+Commit Exclusions
+~~~~~~~~~~~~~~~~~
+
+'{caret}<rev>' (caret) Notation::
+ To exclude commits reachable from a commit, a prefix '{caret}'
+ notation is used.  E.g. '{caret}r1 r2' means commits reachable
+ from 'r2' but exclude the ones reachable from 'r1' (i.e. 'r1' and
+ its ancestors).
+
+Dotted Range Notations
+~~~~~~~~~~~~~~~~~~~~~~
+
+The '..' (two-dot) Range Notation::
+ The '{caret}r1 r2' set operation appears so often that there is a shorthand
+ for it.  When you have two commits 'r1' and 'r2' (named according
+ to the syntax explained in SPECIFYING REVISIONS above), you can ask
+ for commits that are reachable from r2 excluding those that are reachable
+ from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
+
+The '...' (three dot) Symmetric Difference Notation::
+ A similar notation 'r1\...r2' is called symmetric difference
+ of 'r1' and 'r2' and is defined as
+ 'r1 r2 --not $(git merge-base --all r1 r2)'.
+ It is the set of commits that are reachable from either one of
+ 'r1' (left side) or 'r2' (right side) but not from both.
 
 In these two shorthand notations, you can omit one end and let it default to HEAD.
 For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
@@ -278,10 +281,10 @@ is a shorthand for 'HEAD..origin' and asks "What did the origin do since
 I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
 empty range that is both reachable and unreachable from HEAD.
 
-Additional '{caret}' Shorthand notations
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-Two other shorthands for naming a set that is formed by a commit
-and its parent commits exist.
+Special '<rev>{caret}' Shorthand Notations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Two other shorthands exist, particularly useful for merge commits, is
+for naming a set that is formed by a commit and its parent commits.
 
 The 'r1{caret}@' notation means all parents of 'r1'.
 

-- 
2.9.0.windows.1

