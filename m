Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F1020437
	for <e@80x24.org>; Wed, 11 Oct 2017 02:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756580AbdJKCjk (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 22:39:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63576 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752099AbdJKCjj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 22:39:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DA21A6734;
        Tue, 10 Oct 2017 22:39:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=92H8NywE2A99lm/JaYXDAlmznOo=; b=tTlEZ0
        oG2QYkzrc1FCJYB1JAa1Zky9ZikfL8OPqwRSnCiNndSsp0LuCA05qdmkaxAhHPVA
        JYhedN2ZvAdmVW5oou93o4uN0kFArmQSeyoF3tJdB5XMlwlcpKDUPihTffrzS+Al
        aalOzUZXW9K4Pfvmql06r0nSamoZ7Q3wet9yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DsDaAf4eNc162Lmwwni+OKERcoLbY7Lq
        np8Bvg+e5l9ZK3hPzORsXD/E6uH6BiRRWOsQ4MLEmgsNJqtLjARMdHWx7l0Qgxal
        MP7bA9sUPDzy2ZKfrf6Vlvvj/yclAmFlsz8MCitrHiDsaOzhfJfurbXbptAzzsND
        a2bqoUXF6x0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35B34A6732;
        Tue, 10 Oct 2017 22:39:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5CE2A6730;
        Tue, 10 Oct 2017 22:39:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Mailing list <git@vger.kernel.org>
Cc:     Kevin Daudt <me@ikke.info>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH] checkout doc: clarify command line args for "checkout paths"  mode
References: <alpine.LFD.2.21.1709300523190.27819@localhost.localdomain>
        <20170930143258.GA20886@alpha.vpn.ikke.info>
        <alpine.LFD.2.21.1709301800060.7869@localhost.localdomain>
        <xmqqo9prv86l.fsf@gitster.mtv.corp.google.com>
        <alpine.LFD.2.21.1710010603340.17338@localhost.localdomain>
        <xmqqtvzis87i.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 11 Oct 2017 11:39:36 +0900
In-Reply-To: <xmqqtvzis87i.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 02 Oct 2017 09:29:37 +0900")
Message-ID: <xmqqefqao1av.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D335982-AE2D-11E7-8A3C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are "git checkout [-p][<tree-ish>][--][<paths>...]" in the
SYNOPSIS section, and "git checkout [-p][<tree-ish>][--]<paths>..."
as the header for the section that explains the "check out paths
from index/tree-ish" mode.  It is unclear if we require at least one
path, or it is entirely optional.

Actually, both are wrong.  Without the "-p(atch)" option, you must
have <pathspec> (otherwise, with a commit that is a <tree-ish>, you
would be checking out that commit to build a new history on top of
it).  With it, it is already clear that you are checking out paths,
it is optional.  In other words, you cannot omit both.

The source of the confusion is that -p(atch) is described as if it
is just another "optional" part and its description is lumped
together with the non patch mode, even though the actual end user
experience is vastly different.

Let's split the entry into two, and describe the regular mode and
the patch mode separately.  This allows us to make it clear that the
regular mode MUST be given at least one pathspec, that the patch
mode can be invoked with either '-p' or '--patch' but one of these
must be given, and that the pathspec is entirely optional in the
patch mode.

Also, revamp the explanation of "checkout paths" by removing
extraneous description at the beginning, that says "checking out
paths is not checking out a branch".  Explaining what it is for and
when the user wants to use it upfront is the most direct way to help
the readers.

Noticed-by: Robert P J Day
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * As people burned braincycles discussing this earlier already,
   let's try to tie the loose end to help future readers of the
   manual.

 Documentation/git-checkout.txt | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d6399c0af8..8e77a9de49 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
-'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
+'git checkout' [<tree-ish>] [--] <pathspec>...
+'git checkout' (-p|--patch) [<tree-ish>] [--] [<paths>...]
 
 DESCRIPTION
 -----------
@@ -78,20 +79,13 @@ be used to detach HEAD at the tip of the branch (`git checkout
 +
 Omitting <branch> detaches HEAD at the tip of the current branch.
 
-'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
-
-	When <paths> or `--patch` are given, 'git checkout' does *not*
-	switch branches.  It updates the named paths in the working tree
-	from the index file or from a named <tree-ish> (most often a
-	commit).  In this case, the `-b` and `--track` options are
-	meaningless and giving either of them results in an error.  The
-	<tree-ish> argument can be used to specify a specific tree-ish
-	(i.e.  commit, tag or tree) to update the index for the given
-	paths before updating the working tree.
-+
-'git checkout' with <paths> or `--patch` is used to restore modified or
-deleted paths to their original contents from the index or replace paths
-with the contents from a named <tree-ish> (most often a commit-ish).
+'git checkout' [<tree-ish>] [--] <pathspec>...::
+	Restore modified or deleted paths in the working tree by
+	replacing with their original contents from the index, or
+	the contents from a named <tree-ish> (most often a
+	commit-ish). When a <tree-ish> is given, the paths that
+	match the <pathspec> are updated both in the index and in
+	the working tree.
 +
 The index may contain unmerged entries because of a previous failed merge.
 By default, if you try to check out such an entry from the index, the
@@ -101,6 +95,14 @@ specific side of the merge can be checked out of the index by
 using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
 
+'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
+	This is similar to the "check out paths to the working tree
+	from either the index or from a tree-ish" mode described
+	above, but lets you use the interactive interface to show
+	the "diff" output and choose which hunks to use in the
+	result.
+
+
 OPTIONS
 -------
 -q::
-- 
2.15.0-rc0-211-g82b28a23bd

