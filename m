Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54C5B20281
	for <e@80x24.org>; Thu,  5 Oct 2017 17:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbdJERcl (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 13:32:41 -0400
Received: from q.apk.li ([78.47.221.71]:38358 "EHLO q.apk.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbdJERcl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 13:32:41 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Oct 2017 13:32:41 EDT
Received: from continuum.iocl.org (localhost.localdomain [127.0.0.1])
        by q.apk.li (Postfix) with ESMTP id 2BA62120761
        for <git@vger.kernel.org>; Thu,  5 Oct 2017 19:25:53 +0200 (CEST)
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id v95HPqg11814;
        Thu, 5 Oct 2017 19:25:52 +0200
Date:   Thu, 5 Oct 2017 19:25:52 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     Git Users <git@vger.kernel.org>
Subject: Regression in 'git branch -m'?
Message-ID: <20171005172552.GA11497@inner.h.apk.li>
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

I got something that looks like a regression somewhere since 2.11.
This script

  set -xe
  rm -rf repo
  git init repo
  cd repo
  git commit -m nix --allow-empty
  git branch -m master/master
  git rev-parse HEAD
  git branch
  git status

causes .git/HEAD to still contain 'ref: refs/heads/master' and to fail
in the rev-parse step with

  + git rev-parse HEAD
  HEAD
  fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

This is with 2.15.0.rc0; with 2.11.0 (and 2.11.0.356.gffac48d09) it still works.

I'm going to do a bisect on this as battery permits.

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
