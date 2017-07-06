Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A440202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 13:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbdGFN1u (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 09:27:50 -0400
Received: from continuum.iocl.org ([217.140.74.2]:59867 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbdGFN1t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 09:27:49 -0400
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id v66DRiJ01383;
        Thu, 6 Jul 2017 15:27:44 +0200
Date:   Thu, 6 Jul 2017 15:27:44 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Flurries of 'git reflog expire'
Message-ID: <20170706132744.GA1216@inner.h.apk.li>
References: <20170704075758.GA22249@inner.h.apk.li> <87podgbkqi.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87podgbkqi.fsf@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 04 Jul 2017 11:43:33 +0000, Ævar Arnfjörð Bjarmason wrote:
...
> You can set gc.auto=0 in the repo to disable auto-gc, and play with
> e.g. the reflog expire values, see the git-gc manpage.
> 
> But then you need to run your own gc, which is not a bad idea anyway
> with a dedicated git server.

Actually, bitbucket should be doing this. Although I can't quite
rule out the possibility that we reenabled GC in this repo some
time ago.

> But it would be good to get to the bottom of this, we shouldn't be
> running these concurrently.

Indeed. Unfortunately this isn't easily reproduced in the test instance,
so I will need to get a newer git under the production bitbucket.

There are quite some of

          \_ /usr/bin/git receive-pack /opt/apps/atlassian/bitbucket-data/shared/data/repositories/68
          |   \_ git gc --auto --quiet
          |       \_ git reflog expire --all

in the process tree, apparently a new one gets started even though previous
ones are still running. The number of running expires grew slowly, in the
order of many minutes.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
