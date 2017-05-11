Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2892018D
	for <e@80x24.org>; Thu, 11 May 2017 13:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755742AbdEKNxC (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:53:02 -0400
Received: from relay01.pair.com ([209.68.5.15]:36334 "EHLO relay01.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755604AbdEKNwl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:52:41 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 May 2017 09:52:41 EDT
Received: from orac.inputplus.co.uk (unknown [84.93.78.16])
        by relay01.pair.com (Postfix) with ESMTP id A98AFD01203
        for <git@vger.kernel.org>; Thu, 11 May 2017 09:45:01 -0400 (EDT)
Received: from orac.inputplus.co.uk (orac.inputplus.co.uk [IPv6:::1])
        by orac.inputplus.co.uk (Postfix) with ESMTP id 4EA9E20162;
        Thu, 11 May 2017 14:45:00 +0100 (BST)
To:     git@vger.kernel.org
From:   Ralph Corderoy <ralph@inputplus.co.uk>
Subject: git-log(1) Doesn't Describe -L start,end Fully.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Date:   Thu, 11 May 2017 14:45:00 +0100
Message-Id: <20170511134500.4EA9E20162@orac.inputplus.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Arch Linux's git 2.12.2-4's git-log(1) says

    -L <start>,<end>:<file>, -L :<funcname>:<file>
        Trace the evolution of the line range given by "<start>,<end>"
        (or the function name regex <funcname>) within the <file>.  You
        may not give any pathspec limiters.  This is currently limited
        to a walk starting from a single revision, i.e. you may only
        give zero or one positive revision arguments.  You can specify
        this option more than once.

	<start> and <end> can take one of these forms:

	number
            If <start> or <end> is a number, it specifies an absolute
            line number (lines count from 1).

It doesn't say one or both of start and end may be omitted.  Thus `-L
,:foobar.c' is valid with start defaulting to 1 and end to the number of
lines in foobar.c.  

Nor does it explain if 1,42 covering all of foobar.c as it is now swells
to be 1,314 as the commits are walked to larger versions of foobar.c.

This was noticed because I've started with foo.c and bar.c, and each was
`git mv'd to foobar.c in separate commits that were then each merged.
I'm trying to `git log' HEAD's foobar.c and have it walk past the merges
to show be foo.c and bar.c's history.

`git log HEAD -- foobar.c foo.c bar.c' works, but one has to specify all
the old names.  `git log -L ,:foobar.c' works for a simple test case,
but I don't know if changes outside of foobar.c's current 1,42 lines
would always show up.  And also -L triggers patches and --no-patch
doesn't stop that;  bug?  The -L logic seems particular to `git log' so
I can't have git-rev-list(1) do that work to provide the commits and
then log them separately.

-- 
Cheers, Ralph.
https://plus.google.com/+RalphCorderoy
