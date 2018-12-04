Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B44D211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 16:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeLDQfR (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 11:35:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42714 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDQfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 11:35:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so16635027wrx.9
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYCa8rqvAr+0JQslqJe17bvJNfJO0zqFfKWj584X6Og=;
        b=mOY3TVZD7wvjRmuTrCvC4dmmis6Yu49JA3RADbJaccUynWK54q+QxkyXkINDpubJms
         +63dVoyhBKssmaVB4KdgI/jv+KKiXlAjlHrpnFWUXzsCQ6Du8MqLbb4Jp/YQujaLryJm
         cPwaylATVhw6MLNwoDQ4gQoJUUSIjO1/9dxvv3sCoEare5CwYNQYdVwXg37gYGs9eF5H
         Es4yJNWj9uFqCTXdepqbcaXPigERoAMpVm1vV0ukqgrXtJ7PShS6HVXscuPoKf2kaqMf
         JrYBT0rzUNsJ+Mn5Dcj3vf7tP98QSqUCQRDBYcT0e8tGbudpE8Xzb4a3YuE093mvbQRT
         f4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYCa8rqvAr+0JQslqJe17bvJNfJO0zqFfKWj584X6Og=;
        b=CmGavwKlcOKutVt268jtdvM9n8lwUyHKOLPGM8wWitGlhut2/KCGj41XNe+bIgcToo
         q3P36qi5f7AiF8HaxxytYWgWbz3Ln1g9Ismw9lx2rMY32PA5jzlS8xumhX/BtgVJ8CR6
         Uapsc0d6rlUd9VzQWy5dgy+0MB0rE7Ev9OsAm2E556dHBPouWOM4xalDtjzOneV2gYZL
         tEH8gzj7ZnsZ9RAIKm1duxuUCU7LM2ir+QVT3qcQ242VKWJs2tBc1S3MSzpx0G/gW2WY
         ub8OccFvRX4RNV3GRrLlxugFojyDZFShUhbmh3v6/nhJurpCEoEYEUdMbRIUnqJJki8Z
         Y1OQ==
X-Gm-Message-State: AA+aEWbnJvkftw+6GBbyw9xo2cGQt3a4FiHLAyZqLRgPaiJ1pj697D+b
        2qKb/qvgFEsm0viJXKAebXL1v5E0
X-Google-Smtp-Source: AFSGD/VcQxVvnYnkA3JA9XmHnB6WIEwx9WUdqMcH6mrHPGZ0mDwhaUhOu95OzRvoUZ30FlmlebE5iw==
X-Received: by 2002:adf:f211:: with SMTP id p17mr18399352wro.293.1543941315515;
        Tue, 04 Dec 2018 08:35:15 -0800 (PST)
Received: from localhost.localdomain (x4db19e3e.dyn.telefonica.de. [77.177.158.62])
        by smtp.gmail.com with ESMTPSA id f130sm7911389wme.41.2018.12.04.08.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 08:35:14 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 0/3] test-lib: add the '--stress' option to help reproduce occasional failures in flaky tests
Date:   Tue,  4 Dec 2018 17:34:54 +0100
Message-Id: <20181204163457.15717-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.156.g5a9fd2ce9c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Inspired by Peff's 'stress' script mentioned in:

  https://public-inbox.org/git/20181122161722.GC28192@sigill.intra.peff.net/

the last patch in this series brings that functionality to our test
library to help to reproduce failures in flaky tests.  So

  ./t1234-foo --stress
  
will run that test script repeatedly in multiple parallel invocations,
in the hope that the increased load creates enough variance in the
timing of the test's commands that a failure is evenually triggered.


SZEDER Gábor (3):
  test-lib: consolidate naming of test-results paths
  test-lib-functions: introduce the 'test_set_port' helper function
  test-lib: add the '--stress' option to run a test repeatedly under
    load

 t/README                 | 13 +++++-
 t/lib-git-daemon.sh      |  2 +-
 t/lib-git-p4.sh          |  9 +---
 t/lib-git-svn.sh         |  2 +-
 t/lib-httpd.sh           |  2 +-
 t/t0410-partial-clone.sh |  1 -
 t/t5512-ls-remote.sh     |  2 +-
 t/test-lib-functions.sh  | 39 ++++++++++++++++
 t/test-lib.sh            | 99 +++++++++++++++++++++++++++++++++++-----
 9 files changed, 143 insertions(+), 26 deletions(-)

-- 
2.20.0.rc2.156.g5a9fd2ce9c

