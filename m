Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C6D1F424
	for <e@80x24.org>; Wed, 20 Dec 2017 11:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755105AbdLTLuZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 06:50:25 -0500
Received: from waltz.apk.li ([185.177.140.48]:54926 "EHLO waltz.apk.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754767AbdLTLuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 06:50:24 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2017 06:50:24 EST
Received: from continuum.iocl.org (localhost [127.0.0.1])
        by waltz.apk.li (Postfix) with ESMTP id C920B598041
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 12:43:10 +0100 (CET)
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id vBKBhAN02179;
        Wed, 20 Dec 2017 12:43:10 +0100
Date:   Wed, 20 Dec 2017 12:43:10 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git merge commits staged files (when two trees are identical)
Message-ID: <20171220114310.GA2049@inner.h.apk.li>
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

we just stumbled over a situation in which a merge commits
staged changes into the merge commit. This happens when the
merged-in branch does have commits ('main') but has the same
tree ('--allow-empty') as the merge base:

    git init
    echo eins >a
    git add a
    git commit -m initial
    git branch sub
    git commit -m main --allow-empty
    git checkout sub
    : two
    echo zwei >>a
    git add a
    git commit -m underway
    : three
    echo drei >>a
    git add a              # important
    git status
    git diff --cached
    git merge master -m 'merge'
    git status
    git log --cc -1

If the change isn't staged (comment out the '# important' line)
the change survives as unstaged.

That is a bug?

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
