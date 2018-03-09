Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4C31F404
	for <e@80x24.org>; Fri,  9 Mar 2018 15:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932092AbeCIPHX (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 10:07:23 -0500
Received: from continuum.iocl.org ([217.140.74.2]:52086 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbeCIPHW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 10:07:22 -0500
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id w29F7Jb30743;
        Fri, 9 Mar 2018 16:07:19 +0100
Date:   Fri, 9 Mar 2018 16:07:19 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Subject: git submodule update - reset instead of checkout?
Message-ID: <20180309150719.GA30596@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I've been reading up on the current state of git submodules
(our customer's customers want to use them, causing a slight
groan from our customer).

The usability thing I wonder about - with git submodule update,
is it necessary to detach the head to the current (or upstream)
head, instead of resetting the current branch to that state?

Primary interest in the question: Seeing 'detached head' scares
almost everybody. To brainstorm:

- as we can already use 'submodule update --remote' to update
  to the remote head of a branch, it would be logical to have
  that branch checked out locally (and unfortunately, potentially
  have that branch's name conflict with the remote branch setup).

- when developers more or less accidentally commit on the detached
  head, all is not lost yet (I remember this being differently),
  but if the next 'submodule update' just resets again, the commit
  just made is still dropped, just as in the detached head state.

- So, we'd need to have 'submodule update' act closer to the pull or
  rebase counterparts and refuse to just lose commits (or uncommitted
  changes).

Having a checked-out branch in the submodule would have the advantage
that I can 'just' push local commits. At the moment, doing that requires
a relatively intricate dance, not at all similar to working in the
base (parent) module.

I'm working on hooks that automatically update the submodules after
a commit change (merge, pull, checkout) in the parent module, but
with the additional feature of (a) keeping a branch checked out
and (b) avoid discarding local changes. Probably means I shouldn't
invoke 'submodule update' at all, and deal with everyting myself.

Any thoughs/comments/helpful hints?

(Addional complexity: egit/jgit is in use as well, and the work model
we will arrive at probabaly needs to work with the current egit.)

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
