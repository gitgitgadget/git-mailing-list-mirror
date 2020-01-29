Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D4EC33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49DE207FF
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="WtG6et5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgA2LMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:12:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41522 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgA2LMw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 06:12:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so19698845wrw.8
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 03:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbcWE9agD73M7mI+wqsHaDcovUoOWigYeJFrUhe256s=;
        b=WtG6et5MfcBvKORAePqkgv4mqFMwJkn66pdbBCdQ8aNcyPq6PnJHqOaEBS0x1xBe4Z
         UrponX3G1vBZyYhag2TXUPCLcxojiJbPcyIxADo2E1w5xqSjXxWRju9CYa5LJpVvW742
         pEW/q3074FXGt04kFCxSeP6zozqkRrpw8/E7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbcWE9agD73M7mI+wqsHaDcovUoOWigYeJFrUhe256s=;
        b=olxC09x4lgTnNdm7n6Bpzo5WJ90/R4+t0II3FCyRDJbBqHEdlNX9Rye1ytS6wRLwzP
         DI2K4cJ50hRnpTwY08bQlQ3cYdfBb++vURcX+k6suj7gyS/gX1MOrTtVbUIF+Zrj4FON
         EVtrASNBxYLSrPAkFvn0f2Hml+x1JDlHV3NHqRFq9EOMDYmDbX58FwhnWGzCQJ6078X8
         HLsw85T99zNZbf3vATRwoHMPMqEWXjgByEOktPd9zoLVvpvtc5Bxl5WOtn1fSW7ym8q7
         IiMcSiBq1r/HuE1N5ueZFt+EwqN0ITP96JlUrN5MFwrUxDy2KLcCKt9jY38YCg/6o256
         alSg==
X-Gm-Message-State: APjAAAXK84GrnLIO+7UzKzFvwgI10sXmppY2B/DQlJqUR9B+yCdFNL/I
        nf80e00Q9hgz/MKga1GAA2ckRPtZd/8=
X-Google-Smtp-Source: APXvYqyL9avfTrPzGc4f4Tai+6tFI3wAyF1bp95UXTTh0H0dKc+7y4pg5PhlvSe0n+gTt/dpoP/OFQ==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr34638795wru.122.1580296370641;
        Wed, 29 Jan 2020 03:12:50 -0800 (PST)
Received: from ethel.corp.roku ([85.118.3.105])
        by smtp.gmail.com with ESMTPSA id z6sm2226241wrw.36.2020.01.29.03.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 03:12:50 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 0/6] git-p4: wait() for child processes better
Date:   Wed, 29 Jan 2020 11:12:40 +0000
Message-Id: <20200129111246.12196-1-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 handles most errors by calling die(). This can leave child
processes still running, orphaned.

    https://public-inbox.org/git/20190227094926.GE19739@szeder.dev/

This is not a problem for humans, but for CI, it is.

This change improves things by raising an exception and cleaning up
further up the stack, rather than simply calling die().

This is only done in a few places, such that the tests pass with the changes
suggested in the link (adding sleep strategically) but there are still
plenty of places where git-p4 calls die().

This also adds some pylint disables, so that we can start to run pylint
on git-p4.

Luke Diamand (6):
  git-p4: make closeStreams() idempotent
  git-p4: add P4CommandException to report errors talking to Perforce
  git-p4: disable some pylint warnings, to get pylint output to
    something manageable
  git-p4: create helper function importRevisions()
  git-p4: cleanup better on error exit
  git-p4: check for access to remote host earlier

 git-p4.py | 180 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 109 insertions(+), 71 deletions(-)

-- 
2.20.1.390.gb5101f9297

