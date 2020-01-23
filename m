Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B37C33CB6
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9319121569
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="0fb36Nru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAWTAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:00:24 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:39961 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWTAX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 14:00:23 -0500
Received: by mail-qv1-f48.google.com with SMTP id dp13so2006634qvb.7
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 11:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MZjcyvItQBvNxC/Cix/qv8ry5gSCOzQvD1VN6y2nT0=;
        b=0fb36NruaVobgsYjY3pauKnPRU9bru/QQUIpNbLqXSpKeO/tsx6oTa+hO8OIuoavGg
         QGL3tjOoN0XuwnHENmZAMKS2tQ4XT2/Qpsp4CPwXEKz0lmpH9QUaLnjFNn2iqUqtK1IH
         ku8ugWKh4jAWgFkacEsK467iH6HOi8QDDA0FJH9l24R10VXC3l3BHiiunAfluSTxK8dA
         D3jgNS8/YT5MIax7mBGN6LP8oET0scSombUarKbw475QHTY6nLQOExFF4lievke4uY8V
         vfe4Rwe2mLjtFAX8CjddKLf3igqIiw56mCbrpe5AukGOTtoLxtzv5ymFMvNrXQLk5DkW
         QM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MZjcyvItQBvNxC/Cix/qv8ry5gSCOzQvD1VN6y2nT0=;
        b=BXB8vmx8a1KDUvqDQ2qjOA2LeqXS7NhVI080OS7ccviYsOHZ3eGul1nlOEjYEl1Hw4
         Vy4wkUBJ/+747/TYXWQorO53hI+b0v/dnwrciw36ajgQQotcIrARzOfwxKNfY5Kwf0w7
         vKF8MbG5ulFG2owE9LaxzSHTSh2uPkq9Gp6Ix65NkUGdCiS57fAkAVQIcRSF2M3UOi02
         o44WB1niddbCRLNMTzvHBnccUa3Mx7qSdGpruPxdpUVABNMDYyFPuzw2v12wToSTTrnm
         DuqA6v72L7LeTqg0tF57M4F/db8zD+wRPiPpldV4Uz08Y3izdTjHilOptZBCTzft+m6E
         F3FQ==
X-Gm-Message-State: APjAAAVXYyeoUi8kPHw1pEZJL8ge6L2xGnzwzm1bUpiJH7XhmIrXDiQG
        hCq0pZ8rY2+qkWP/ucameQou+rUM1fg=
X-Google-Smtp-Source: APXvYqx69UJ4xc3gEc6zI+rleu8TNuFLok633ZeuStesMQsf0MfoNXjypbhjP/MI+78cbdvbh1lIMQ==
X-Received: by 2002:ad4:478b:: with SMTP id z11mr17857191qvy.185.1579806021732;
        Thu, 23 Jan 2020 11:00:21 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id l6sm1363821qkc.65.2020.01.23.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:00:21 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/2] sparse-checkout: add completion and --cone to docs
Date:   Thu, 23 Jan 2020 16:00:01 -0300
Message-Id: <cover.1579805218.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds completion for the sparse-checkout command and mention the
init's --cone option in the doc file. I know this command might change
in the near future, so I'm not sure whether these changes are worth
right now; but since they were simple to do, I decided to send them and
ask for your comments.

travis build: https://travis-ci.org/matheustavares/git/builds/641012914

Matheus Tavares (2):
  doc: sparse-checkout: mention --cone option
  completion: add support for sparse-checkout

 Documentation/git-sparse-checkout.txt  |  4 ++++
 contrib/completion/git-completion.bash | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

-- 
2.25.0

