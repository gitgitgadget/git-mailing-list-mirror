Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B683E1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 10:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeKNUtQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 15:49:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33548 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNUtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 15:49:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id u9-v6so16737379wrr.0
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 02:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyfLM89oLHVhRmVTHBSQjpliBBm4X2GYJzE0sxUdahk=;
        b=QQZFayNfIjJi9TzoTxsOz9sSGsU59RuaCTnB8JlvxoFzZ+xBZV0wYWgcCK+wZTxMC9
         WWCMSdDGzE0Ha72LafMrtqB2BvYxoYhCliFmmqikvcVCHBlj5c7PyvBkzoMcL/KRI57r
         ASHvdTk21UpjQjtagbZB374hhxfjxdUgmIrdjup7/sre5iSKIz/Aw5AQTr2kyMNcf4pK
         7Nqi/fbuCdOVonMO3E+T7r/ahSr8GKJodXX6Br6BCDp54xCMivmGuUXMH71CIl1TpWmR
         fGgT/CzY0Sl7SOXPgc2wx9pOYYLsWXV5F5+KWLuWW22q7P1hWc0GuSg5irs49pmnlYy9
         iZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyfLM89oLHVhRmVTHBSQjpliBBm4X2GYJzE0sxUdahk=;
        b=UmyDA2Lop8JtwxV6eY8LdHl7XTsCAy81enDsr10Qo/FkycoOeU4TUMA2FF/7nsCHRC
         qWtmiXL2skNBJqoKl8+kZ+MY48ie4Q7OxZaMH/rb8H/z29i0eMwbBlmjZzJ0OJ9MJVi5
         90/lAHbzEUoSzqFZzrspFvvWVBPjkKVSe8L7IeWHHiW18u51z5CiRa0DDjY0l+Q9PhMm
         VgaClRket3p6sODAE8oeyFKoFqqdQhV++KorTPGmGoRBfGVYtB2OMYG03YQ3SCnNJ4as
         W5ZRl5HweKPDi3EpxFepoD+a4azvJQX/HmLsH9qmRHgRIc8qJgpzmxz1D5ia3Q9cyuLH
         rJbg==
X-Gm-Message-State: AGRZ1gIUrlj1DHn0y/wPJm2Dx34hdUh0UUwAvoE2SKs3pF3PvdgYvC/R
        FrubxPB1H0Nl33DJ3q0jwcQ=
X-Google-Smtp-Source: AJdET5cYv52DxSWZ7st4VW6kimVRWr3JqLDbgaNiZVYKWB6GB59rGW9SEt//m1AH2O/dzNE+rppxvw==
X-Received: by 2002:adf:9563:: with SMTP id 90-v6mr1444736wrs.60.1542192392432;
        Wed, 14 Nov 2018 02:46:32 -0800 (PST)
Received: from localhost.localdomain (x4db1d05b.dyn.telefonica.de. [77.177.208.91])
        by smtp.gmail.com with ESMTPSA id p188-v6sm11274079wmp.31.2018.11.14.02.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 02:46:31 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/3] clone: respect configured fetch respecs during initial fetch
Date:   Wed, 14 Nov 2018 11:46:17 +0100
Message-Id: <20181114104620.32478-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.gbfcc7ed3e6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The initial fetch during a clone doesn't transfer refs matching
additional fetch refspecs given on the command line as configuration
variables, e.g. '-c remote.origin.fetch=<refspec>'.  This contradicts
the documentation stating that configuration variables specified via
'git clone -c <key>=<value> ...' "take effect immediately after the
repository is initialized, but before the remote history is fetched"
and the given example specifically mentions "adding additional fetch
refspecs to the origin remote".

The second patch in this series makes it work.  The other two are
while-at-its: the first is a little cleanup, and the last one
documents other known ignored configuration variables (but whose
functionality is available through command line options).


This patch series should have been marked as v6, but I chose to reset
the counter, because:

  - v5 was sent out way over a year ago [1], and surely everybody has
    forgotten about it since then anyway.  But more importantly:

  - A lot has happened since then, most notably we now have a refspec
    API, which makes this patch series much simpler (now it only
    touches 'builtin/clone.c', the previous version had to add stuff
    to 'remote.{c,h}' as well).


[1] For reference, though I actually doubt it's worth looking up:
    https://public-inbox.org/git/20170616173849.8071-1-szeder.dev@gmail.com/T/#u


SZEDER Gábor (3):
  clone: use a more appropriate variable name for the default refspec
  clone: respect additional configured fetch refspecs during initial
    fetch
  Documentation/clone: document ignored configuration variables

 Documentation/git-clone.txt |  6 +++++
 builtin/clone.c             | 33 +++++++++++++++-----------
 t/t5611-clone-config.sh     | 47 +++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 14 deletions(-)

-- 
2.19.1.1182.gbfcc7ed3e6

