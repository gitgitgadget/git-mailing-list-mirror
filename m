Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002EB1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 08:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeFEI3E (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 04:29:04 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:45896 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeFEI3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 04:29:03 -0400
Received: by mail-wr0-f181.google.com with SMTP id o12-v6so1376509wrm.12
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AvpYShYeWwKN9ilEHVcgLKH0Zz3zIE1f9ckgT5dqbWc=;
        b=bhWnlxqTrnsLW+chB+IyjPh7ehErkOrE85dSsSVMY13oFMCO52nf0azAdpBiKCbCtz
         MwV1aSAZHwPVozYI0/VRDC776J58Dq4hZoDyGZQb4VNqaNwfenFm8Zmggv9DQd5qQuEr
         OG+10Jud6nYyntuWoSMdiCHnscgTGKAUsNev0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AvpYShYeWwKN9ilEHVcgLKH0Zz3zIE1f9ckgT5dqbWc=;
        b=B/l+qHeP14koYcn1QOOwMrvM5S/8EbIsrvK16ru2jE0OLl7LJD8jCm77UzneLzacgC
         vP8ZUA7KuzsPdJTUUpJInLA+RrNWjt/A3FjGx5oCG6E6rNVhrTb8rHmqbSveNe07GdMb
         wlQMG1VWwnwDKcfI7WY7NZsN9lq5pbVknOvqS6bcGHgulnwU4m5YdF5c8G49E98ZGkFS
         McFbbhOrFnyxpJMvYCWZ1SxVRBSrgYONK9wSHkvHWf8GWr+XPCb1DzeKcgB7z4kkXLH/
         S8S/aY75yz+q76fgcBBiK1bsk57em8QJmJ4Ms/Z1DmgN7wcZFxwfWiuVnPBa4lvxRKWr
         oaig==
X-Gm-Message-State: APt69E1VaWPua1L8/JS7OaXptrwUnF0Y7+zjEZy3iCrUxJgifbBueLLL
        qFUJroZTlGddPYVjbBac7oY3HdFE
X-Google-Smtp-Source: ADUXVKKy60Z9Pyf0BM7S6X58iaE4RX0YvN0PeEV3bpwr+aX6IJxceLoge6iA7cPK1Beclbej9SgATw==
X-Received: by 2002:adf:bc03:: with SMTP id s3-v6mr6919685wrg.211.1528187342418;
        Tue, 05 Jun 2018 01:29:02 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id u3-v6sm25988533wrm.60.2018.06.05.01.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 01:29:01 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 0/2] git-p4: disable sync after submit
Date:   Tue,  5 Jun 2018 09:28:52 +0100
Message-Id: <20180605082854.17090-1-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small patch to git-p4 to disable the automatic sync after
submit.

In my day-to-day work, I have a central git-p4 repo which is
automatically kept up-to-date, so the repos where I actually work and
submit from don't even need the sync. I usually end up hitting Ctrl-C
partway through the sync.

I imagine other people with large git-p4 projects do something similar
and have the same problem.

This also updates Merland's recent submit-selection change so that both
options can be set via configuration rather than being set on the
command line.

Luke Diamand (2):
  git-p4: disable-rebase: allow setting this via configuration
  git-p4: add option to disable syncing of p4/master with p4

 Documentation/git-p4.txt | 13 ++++++++++++-
 git-p4.py                | 33 +++++++++++++++++++++------------
 2 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.17.0.392.gdeb1a6e9b7

