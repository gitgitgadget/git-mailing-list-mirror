Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10494C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 19:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62B12467B
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 19:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPH1CXA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLFTDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:03:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54834 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFTDk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 14:03:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so8899803wmj.4
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 11:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BsbhYTt+QHAP7hxMrig5jB+47VmNnu4lEzk0JrWjSk4=;
        b=mPH1CXA9OnyuUVEStDvrUCNr7fDCIQErWI5MGxvy2WuLBrr8tdaXmPKK9bz3Fe5qPe
         OwBCSgKLmM4WNxzgGs2iEGdu1oF7vdE9WGWwc+a9/+o6WS0h60KIO2Z9NUM8VuX1pRc5
         GPU/29UET8NCRdwnoI42CPuB5aZZYBivtS+kd76srdBnmRpHKJCPGCpjSGgLw20mkyHp
         kEnZDIyCQ+nZwwE9GSq4yHECII8Kx6sODCjXNgjNg7nUV/3NCT04kCXt2nTUcezjNOWF
         Tzxt0BOBiW3uhzoJsC6c1kW1LodLG03xN0oLGd+tm1w6K9YCfYwb845OAUQjAkC1y2AL
         qHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsbhYTt+QHAP7hxMrig5jB+47VmNnu4lEzk0JrWjSk4=;
        b=GNGAt0lFDWehcGHiPhN/ApJ4FlhZdJX9jOn6DVFd5q0tJgPpW9W7lh3sYmsQDN5bNL
         0CN9dhTBi7aDSE4f1D+Kt5wHF0hwo/w+cfZqxz3BuC9QlmLnYObMy45L9zG1f6CYinB2
         n/09saCaeeEqGv0g7JytqYhCad5TxjC7ev5up5uRtHzhj4BP/+UMQq2oL9/Z9Xzm2ZYc
         41t0t3YM816JV7etP0X1ZOgtBniNwp3akhyIjMllxLWIKb+NnC+QmYobGwt7UaAgLh+v
         +1+PeY7mCiZABTL/mS36dZ6+b36zdsTW66JsqCi6LsuXR24l9hpBY8ovNDqUuCVwTlhc
         0wuw==
X-Gm-Message-State: APjAAAV6EeNctlyM7VIpmHLaxxeAH+N1stpo+5X8bWOvkL1u0YFuGMxP
        n0bbZMN7ZqwWKa1IZ0OJGYPJHkJj
X-Google-Smtp-Source: APXvYqwi47UfL7qOg23LG7WhI4aUzHLjrAEPHmUaSDfYkLb+wVSO14+d/lqrD4BethKx1HgfYIObgw==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr11964205wmk.116.1575659018566;
        Fri, 06 Dec 2019 11:03:38 -0800 (PST)
Received: from localhost.localdomain (x4d0c7a95.dyn.telefonica.de. [77.12.122.149])
        by smtp.gmail.com with ESMTPSA id d19sm4399100wmd.38.2019.12.06.11.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Dec 2019 11:03:37 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/2] t9300-fast-import: don't hang if background fast-import exits too early
Date:   Fri,  6 Dec 2019 20:03:29 +0100
Message-Id: <20191206190331.29443-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191130104644.17350-1-szeder.dev@gmail.com>
References: <20191130104644.17350-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The five tests checking 'git fast-import's checkpoint handling in
't9300-fast-import.sh', all with the prefix "V:" in their test
description, can hang indefinitely if 'git fast-import' unexpectedly
dies early in any of these tests.

Changes since v1:

  - The first patch is new, and refactors those tests to store the PID
    of the background 'git fast-import' process in a shell variable
    instead of in a pidfile.

  - The second patch is conceptually the same as the only patch v1,
    but it has been updated to store the PID of the background
    subshell in a variable as well.

SZEDER Gábor (2):
  t9300-fast-import: store the PID in a variable instead of pidfile
  t9300-fast-import: don't hang if background fast-import exits too
    early

 t/t9300-fast-import.sh | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

-- 
2.24.0.801.g241c134b8d

