Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6E631F461
	for <e@80x24.org>; Wed, 15 May 2019 09:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfEOJst convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 15 May 2019 05:48:49 -0400
Received: from mx1.cnes.fr ([194.199.174.200]:58350 "EHLO mx1.cnes.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfEOJst (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 05:48:49 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2019 05:48:47 EDT
X-IronPort-AV: E=Sophos;i="5.60,472,1549929600"; 
   d="scan'208";a="7795174"
X-IPAS-Result: =?us-ascii?q?A2GzGQAW3dtc/wEBeApkHAECGAcEAQYBgU0CgShnWBFdF?=
 =?us-ascii?q?RIoCrFsFIFnCQEBAQEBAQEBARsQCQECAQGEQAKCKCM1CA4BAwEBAQQBAQEBA?=
 =?us-ascii?q?gEBAgJpHAELhgw6FwEFEBUUQiYBBBsSgwmCDgutGxqKEQaBMQIBAQEBgVyMB?=
 =?us-ascii?q?YERRoVrAgIYgTAZgzqCJgSnWQcCgShjAoIHhBiMWG+LUwOJKYw0hliQKwI1K?=
 =?us-ascii?q?YEuMxongzgShWyKU0IwgSEIjiUBgSABAQ?=
X-URL-LookUp-ScanningError: 1
From:   Poughon Victor <Victor.Poughon@cnes.fr>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Feedback on git-restore
Thread-Topic: Feedback on git-restore
Thread-Index: AdULAFKqnkLnGEocQ2u/tbNZsZu2bQ==
Date:   Wed, 15 May 2019 09:38:59 +0000
Message-ID: <3E55146A6A81B44A9CB69CAB65908CEA6B91353C@TW-MBX-P01.cnesnet.ad.cnes.fr>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-as-product-ver: SMEX-11.0.0.4255-8.100.1062-24614.006
x-tm-as-result: No--8.543200-8.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I came across a description of a new git command currently in development called 'git restore'. Since it's still not out, and the original poster [1] seemed to ask for feedback, I though I'd send some here. Hope that's ok!

Reading the documentation [2] I find it very confusing. In particular when comparing the following two commands:

$ git restore --staged file
$ git restore --worktree file

With the current proposal, the first will restore the index from HEAD, while the second will restore the worktree from the index. In other words, the source for the restore is different in both commands, even though neither specify a source! This means that git-restore really does two different things depending on some other not obvious context. Unfortunately that's typical of the (often criticized) obscure interface of git. To be fair that behavior is documented in [2]. But still, having a variable default value for --source depending on other arguments is very confusing.

So in summary, I'd make two recommendations for this command's UX:
1. Make --source default value always HEAD if unspecified
2. Rename --staged to --index

Some examples of those:

$ git restore --index file # reset the index from HEAD
$ git restore --worktree file # reset the worktree from HEAD
$ git restore --worktree --source=index file # reset the worktree from the index
$ git restore --index --worktree file # reset both the index and worktree from HEAD
$ git restore file # reset the worktree from HEAD 

[1] https://news.ycombinator.com/item?id=19907960
[2] https://github.com/git/git/blob/pu/Documentation/git-restore.txt

Best,
Victor



