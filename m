Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D5A1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeHaAIp (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:08:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:34536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726674AbeHaAIp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:08:45 -0400
Received: (qmail 8803 invoked by uid 109); 30 Aug 2018 20:04:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 20:04:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30964 invoked by uid 111); 30 Aug 2018 20:05:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 16:05:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 16:04:53 -0400
Date:   Thu, 30 Aug 2018 16:04:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 4/4] branch: make "-l" a synonym for "--list"
Message-ID: <20180830200452.GB22407@sigill.intra.peff.net>
References: <20180622092327.GA8361@sigill.intra.peff.net>
 <20180622092459.GD13573@sigill.intra.peff.net>
 <87wos8cjt8.fsf@evledraar.gmail.com>
 <xmqq4lfb667c.fsf@gitster-ct.c.googlers.com>
 <87in3rd422.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87in3rd422.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:25PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > In the SYNOPSIS section we still see "[-l]" listed; that also must
> > be replaced with "--create-reflog", or just dropped, as that is the
> > default.
> 
> Oh yes, it seems all of the doc indeed wasn't updated!

Sorry, this is my fault. Patch is below (which would go on top of
jk/branch-l-1-repurpose).

> > I do not know if the documentation that is shipped in 2.20 should
> > talk about how the old world looked like, though.  `-l` was a short
> > for `--create-reflog` is worth saying, but I do not see much value
> > in talking about the warning given in 2.19.
> 
> I'm anticipating that there will be users in the wild with similar -l
> invocations, noting this helps them, because they'll be wondering what
> some script that does "git branch -l <name>" is trying to do while
> reading our docs.

I don't have a strong opinion either way. If we do mention it, it should
probably be short ("Until Git v2.20, the `-l` option was a synonym for
`--create-reflog").

-Peff

-- >8 --
Subject: [PATCH] doc/git-branch: remove obsolete "-l" references

The previous commit switched "-l" to meaning "--list", but a
few vestiges of its prior meaning as "--create-reflog"
remained:

  - the synopsis mentioned "-l" when creating a new branch;
    we can drop this entirely, as it has been the default
    for years

  - the --list command mentions the unfortunate "-l"
    confusion, but we've now fixed that

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-branch.txt | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 5552dfcec3..bf5316ffa9 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	[(--merged | --no-merged) [<commit>]]
 	[--contains [<commit]] [--no-contains [<commit>]]
 	[--points-at <object>] [--format=<format>] [<pattern>...]
-'git branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
+'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -159,10 +159,6 @@ This option is only applicable in non-verbose mode.
 	List branches.  With optional `<pattern>...`, e.g. `git
 	branch --list 'maint-*'`, list only the branches that match
 	the pattern(s).
-+
-This should not be confused with `git branch -l <branchname>`,
-which creates a branch named `<branchname>` with a reflog.
-See `--create-reflog` above for details.
 
 -v::
 -vv::
-- 
2.19.0.rc1.546.g3fcb3c0d7c

