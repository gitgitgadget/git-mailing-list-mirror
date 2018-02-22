Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA5A1F576
	for <e@80x24.org>; Thu, 22 Feb 2018 09:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbeBVJun (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 04:50:43 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38658 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbeBVJub (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 04:50:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id z9so2509110wmb.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 01:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EU5JQA3gKHammWXx5qH0z1B2VRHzU41ukcpUFzI0dCU=;
        b=IlKtddIFe3iahYQq2AHp2yAVzFGDgXO7N5CXoHhq2QkhJDWMM+7KtIeVQRekCrPGJx
         83XYjU/e2kGZtWga374+E1dFr8ulYsNdPgoAsYfOdRk2VCErOIZfP0hMw7Vs8W3lev6Q
         h1jcK5pw3k9IFzKS1wfCBbRG0ZDovQgURK4us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EU5JQA3gKHammWXx5qH0z1B2VRHzU41ukcpUFzI0dCU=;
        b=HNB3lH3RaHGzH0mmEIXFvYCWQZFF7H63p8pJy9TIbbjdqPAvfN/HLFTKrWezAeMOlQ
         SJTGY+TBgAn5ub1xlJ7s/HpS4Xu2bj8iY1Lvxtkp6qiB/y5oJzL7Gi7li+Gsbml9HFQQ
         HrIvSq0hSsp1zbtw6xKnHkrkPaqM5DYGSv6yqX5VDQgVbhAezO1/GkNmRRbuH5FgLpoL
         oSCDsHhptv+DGAngcsuBRbzOq1Ev54nVgYYYthzz1imccbghrB3uLcx/yqtyiXkKrv2a
         mwTUKVuGdPqDp1BDeFFyAVmCjRMqVFEQBO/NigrxNl5pAlrOes7ULyDdr15FOyzBpHvQ
         2WHQ==
X-Gm-Message-State: APf1xPB5GOBO2rSZpuRPttGNOIZWqnXuOuHM5cnGEzMzeoq6I/3KHoxf
        TqU3+fK2Sn22AwnLhwFuHlzPO6WI
X-Google-Smtp-Source: AH8x227m2uuGX87iWVtbqRDhYXOcvjTdjAu7qt1594SPZKYqJGheZ9l9KThsez6rnBfmey08h6RRRg==
X-Received: by 10.28.112.21 with SMTP id l21mr2152677wmc.70.1519293029869;
        Thu, 22 Feb 2018 01:50:29 -0800 (PST)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id m187sm3022wmg.0.2018.02.22.01.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Feb 2018 01:50:29 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        miguel.torroja@gmail.com, gvanburgh@bloomberg.net,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/1] git-p4: add unshelve command
Date:   Thu, 22 Feb 2018 09:50:21 +0000
Message-Id: <20180222095022.6227-1-luke@diamand.org>
X-Mailer: git-send-email 2.15.1.272.gc310869385
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an initial attempt at adding an unshelve command to
git-p4.

For those not familiar with it, p4 shelve creates a "pending"
changelist, which isn't committed into the central repo but is
nonetheless visible to other develoeprs. The "unshelve" command
takes one of these pending changelists and applies it to your repo.
It is used quite a lot for code review.

git-p4 learned about shelving changelists recently; this completes
the picture by letting you unshelve them as well.

This was inspired by the stackoverflow answer here:

    https://stackoverflow.com/questions/41841917/git-p4-how-to-fetch-a-changelist

The secret is to use the "p4 print file@=N" syntax to get the
contents of a shelved changelist, which has long perplexed me.

I haven't used this a great deal, so it may still have a few rough
edges.

In particular, it currently puts the unshelved commit into
    refs/remotes/p4/unshelved/<N>

where <N> is the changelist being unshelved. That might not be
the best way to do this.


Luke Diamand (1):
  git-p4: add unshelve command

 Documentation/git-p4.txt |  22 ++++++++
 git-p4.py                | 128 +++++++++++++++++++++++++++++++++++------------
 t/t9832-unshelve.sh      |  67 +++++++++++++++++++++++++
 3 files changed, 186 insertions(+), 31 deletions(-)
 create mode 100755 t/t9832-unshelve.sh

-- 
2.15.1.272.gc310869385

