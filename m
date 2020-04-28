Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665C1C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 10:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD27206A1
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 10:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS2d0+0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgD1Ktf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726312AbgD1Kte (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 06:49:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19EAC03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 03:49:34 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e6so960792pjt.4
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ydqQhZoCFcZknZEKf9D7IqDt71AroPw5JranPhkoNd8=;
        b=kS2d0+0dXKBWnA866f5HpSmPRRTaVAl6/tZVb4fUh0Ct86XaXdJMvU2VGjgnlBbqwC
         yexqeRU88ln4fha5n0i7LhjHeOEqOWMpSNwGghww3ELDlvLzB6c4o9yPXKgfnCph+zPa
         vtH9xglddmlXl6IUTMTayXemO+Rp5QZ2zicoi0OJO3xzgFStrdyQrhQfjDKMtx0BJC3i
         yB6ggG2QSCgaRxKNAP/37htLkfwnWiydJ40AG4AbdjjEsxP/k6zb3+fkjzZaTnoMEDaA
         ALezgDxqHGV5DkWoeB+E9z9iQQ/TmUjpwGgo03tr99xzbs7rihWIlmpZrQfSVgWO5Wxo
         Rl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydqQhZoCFcZknZEKf9D7IqDt71AroPw5JranPhkoNd8=;
        b=jXNdoTBTUBlvJCsXuGMXo8wWmXIf2bLPmqlBQELYUSab9EIazRTxc4Ezbt3YkFtDAn
         reEFg92AYi12YQcooRAkV4atutS0xbxmpIGfvDYFRNGbF3F9ZkBZ0n+tNAg+vrnXSO2C
         9ZjedDqm/QPDVlX9KB4EZ3j6ZErgQNO3STF3ZbkFvOnJPhgpJz0aWp2nJsEb+dKJRs59
         5AnDTvBeeWVCFK7TJ8tNG+Wumqddz/wIx/ccinQk8bh9nEvnqLkOKq2EICaeorRMqIuT
         qdvhyTT2Dxp1IJlQVgWdQKVcdhJHZuD0He6iip4Ogrcxsp3IF6NuvfX7MLTLlF7Db9Oz
         Y1RQ==
X-Gm-Message-State: AGi0PuZnnC2iJK+PJM9lQDUxO552T+dXw5nLdM1tgkQUAPk2rkUnPx19
        siXaIOzAk71JduklWg8sL5CDKEgsdms=
X-Google-Smtp-Source: APiQypL5A1T3VYnL2ri5TMX9BFZoPQBWT47DIg2pi3fQuOC/qmSEUQf3ILYxAzIE6XINpaEqOaI23w==
X-Received: by 2002:a17:90a:558a:: with SMTP id c10mr4304118pji.53.1588070973189;
        Tue, 28 Apr 2020 03:49:33 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id y63sm9074823pfg.138.2020.04.28.03.49.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 03:49:32 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v4 0/4] credential-store: prevent fatal errors
Date:   Tue, 28 Apr 2020 03:48:58 -0700
Message-Id: <20200428104858.28573-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <20200427125915.88667-1-carenas@gmail.com>
References: <20200427125915.88667-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

with the added checks for invalid URLs in credentials, any locally
modified store files which might have empty lines or even comments
were reported[1] as failing to parse as valid credentials.

document better the format for the credential file and make sure
any failures are still handled gently by the new code as a first
step to allow people to upgrade without having first to fix their
corrupted credential files.

[1] https://stackoverflow.com/a/61420852/5005936

Carlo Marcelo Arenas Belón (2):
  git-credential-store: skip empty lines and comments from store
  credential-store: make sure there is no regression with missing scheme

Jonathan Nieder (1):
  git-credential-store: fix (WIP)

Junio C Hamano (1):
  credential-store: document the file format a bit more

 Documentation/git-credential-store.txt |  4 ++++
 credential-store.c                     |  4 ++--
 t/t0302-credential-store.sh            | 32 ++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.26.2.569.g1d74ac4d14

