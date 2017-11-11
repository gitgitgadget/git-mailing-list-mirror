Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA8A1F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 13:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750767AbdKKN0Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 08:26:24 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:51586 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbdKKN0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 08:26:24 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:49114 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDVnj-0002tF-HW
        for git@vger.kernel.org; Sat, 11 Nov 2017 08:26:23 -0500
Date:   Sat, 11 Nov 2017 08:26:00 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] bisect: clarify that one can select multiple good commits
Message-ID: <alpine.LFD.2.21.1711110820370.8941@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Current man page for "bisect" is inconsistent explaining the fact that
"git bisect" takes precisely one bad commit, but one or more good
commits, so tweak the man page in a few places to make that clear.

rday

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  i also exercised literary license to reword an example to look for a
commit where performance was *degraded* rather than improved, since i
think that's the sort of thing that people would be more interested
in.

  also tried to keep line lengths consistent.

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 6c42abf07..545098e73 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -30,17 +30,17 @@ on the subcommand:
  git bisect help

 This command uses a binary search algorithm to find which commit in
-your project's history introduced a bug. You use it by first telling
-it a "bad" commit that is known to contain the bug, and a "good"
-commit that is known to be before the bug was introduced. Then `git
-bisect` picks a commit between those two endpoints and asks you
+your project's history introduced a bug. You use it by first telling it
+a "bad" commit that is known to contain the bug, and one or more "good"
+commits that are known to be before the bug was introduced. Then `git
+bisect` picks a commit somewhere in between those commits and asks you
 whether the selected commit is "good" or "bad". It continues narrowing
 down the range until it finds the exact commit that introduced the
 change.

 In fact, `git bisect` can be used to find the commit that changed
 *any* property of your project; e.g., the commit that fixed a bug, or
-the commit that caused a benchmark's performance to improve. To
+the commit that caused a benchmark's performance to degrade. To
 support this more general usage, the terms "old" and "new" can be used
 in place of "good" and "bad", or you can choose your own terms. See
 section "Alternate terms" below for more information.
@@ -58,7 +58,7 @@ $ git bisect bad                 # Current version is bad
 $ git bisect good v2.6.13-rc2    # v2.6.13-rc2 is known to be good
 ------------------------------------------------

-Once you have specified at least one bad and one good commit, `git
+Once you have specified one bad and one or more good commits, `git
 bisect` selects a commit in the middle of that range of history,
 checks it out, and outputs something similar to the following:

@@ -137,7 +137,7 @@ respectively, in place of "good" and "bad". (But note that you cannot
 mix "good" and "bad" with "old" and "new" in a single session.)

 In this more general usage, you provide `git bisect` with a "new"
-commit that has some property and an "old" commit that doesn't have that
+commit with some property and some "old" commits that don't have that
 property. Each time `git bisect` checks out a commit, you test if that
 commit has the property. If it does, mark the commit as "new";
 otherwise, mark it as "old". When the bisection is done, `git bisect`
@@ -145,19 +145,19 @@ will report which commit introduced the property.

 To use "old" and "new" instead of "good" and bad, you must run `git
 bisect start` without commits as argument and then run the following
-commands to add the commits:
+commands to identify the commits:

 ------------------------------------------------
-git bisect old [<rev>]
+git bisect old [<rev>...]
 ------------------------------------------------

-to indicate that a commit was before the sought change, or
+to identify commits before the sought change, or

 ------------------------------------------------
-git bisect new [<rev>...]
+git bisect new [<rev>]
 ------------------------------------------------

-to indicate that it was after.
+to indicate a single commit after that change.

 To get a reminder of the currently used terms, use


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
