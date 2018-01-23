Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75D01F576
	for <e@80x24.org>; Wed, 24 Jan 2018 07:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbeAXHML (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 02:12:11 -0500
Received: from waltz.apk.li ([185.177.140.48]:61547 "EHLO waltz.apk.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752355AbeAXHMK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 02:12:10 -0500
Received: from continuum.iocl.org (localhost [127.0.0.1])
        by waltz.apk.li (Postfix) with ESMTP id 1BB4D598054
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 08:12:08 +0100 (CET)
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id w0NKauU27168;
        Tue, 23 Jan 2018 21:36:56 +0100
Date:   Tue, 23 Jan 2018 21:36:56 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Subject: Speed of git branch --contains
Message-ID: <20180123203656.GA27016@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everybody,

I'm just looking at some scripts that do a 'git branch --contains $id --remote'
for each new commit in a repo, and unfortunately each invokation already
takes four minutes.

It feels like git branch does the reachability detection separately
for each branch potentially listed. The alternative would be to

- invert the parent map to a child map,
- use that to compute the set of commits that contain $id,
- then use that as predicate whether to show a given branch
  (show iff its head is in the set)

That would speed things up considerably,
but what are the chances to see that change in git?

I can do that as well within the script, with the additional
benefit that I only need to do the inversion once, but I might
instead take a stab at git branch.

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
