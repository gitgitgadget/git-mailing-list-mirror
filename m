Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8334FC10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEC920749
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqampyX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgCMMXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:23:38 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37047 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgCMMXi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 08:23:38 -0400
Received: by mail-pj1-f68.google.com with SMTP id ca13so4281730pjb.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YuDoT8aicUf+Wa5RWbHH6Y5/Eg8GhAlfHgqixCe8/sY=;
        b=jqampyX0BC0G1kYh2H0NF3m+8QLlm6h6T9Gl/CHBtdZ1pO2eMlVbTwS9xYZ6Ne8nvC
         fr/ek6yHC4j4PhwWo0ra/VgOEMHHwGj5c0ofxw68ukXXF3cA046J+h46nglsLfcKiHRE
         lt1puaboa9gbAxWR6HyO94BPxpryzXWIkGjgNK/VUEETyMu35u3bEenem1Da5GLeOwgY
         JkODka/rMsSkaNk8FB5HBND7uTD9+3a/yoBaRTvXt2K0B65P6j0ZxwV7Bkt8O6AWyjE7
         dXZgH6HuDq75SKFuLII/lxKdDD+jw0wDeoxRMk96BQ7IUC8VcZlA1i1kZHH0SDC4jxXM
         M/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YuDoT8aicUf+Wa5RWbHH6Y5/Eg8GhAlfHgqixCe8/sY=;
        b=UoS3UKCDufp4Ym9NaYHryoj0FnwN5FZvC5Xq7Yuf+MEC0Yp8rRI9gymqYnqsTi2jB8
         FeorfYD9jaVl9PNB3EHLzruKhmXpVqJ+mxuBw3fSvBRT2C50YvJdY6OnHapIcpwv5HFf
         v+159HC038ubUs9K4Q43b0sPZUXPedvFqzaVmLAR16UETkDUsUZACjWuSW8K9csCcNLp
         cbUlJ3Fekz2eUWXgrXHnw99J8lAmcLn6psO/cPTYsQeNV+cmvUDiqOanMTC8pHwof7Gw
         y+hCpLcDDKIXUBOuQqBakO2wEK5pQF+0LtpRL9GHRRiI2unYbbGg5GZCvDCj2zFx+a0l
         dSWA==
X-Gm-Message-State: ANhLgQ2PdPjQGZpwhdJxTLt16lkqO5zauUzODdEc4g1I9GI9jAIgPdas
        6tbWDOERmaoO7VvMqye00JYIn+wVidk=
X-Google-Smtp-Source: ADFU+vvMzoJOFwnJyn6tbpAFL8kRkRplIwCett82cnYAhqhm19CbQDLqoziL9INRiK5dfYQPLpNL/A==
X-Received: by 2002:a17:902:ff0e:: with SMTP id f14mr12395222plj.247.1584102217338;
        Fri, 13 Mar 2020 05:23:37 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id 134sm5346690pfy.27.2020.03.13.05.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:23:36 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 0/4] New proc-receive hook for centralized workflow
Date:   Fri, 13 Mar 2020 20:23:14 +0800
Message-Id: <20200313122318.78000-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.rc1.5.gca1e965b06
In-Reply-To: <CANYiYbHvqLX_OozgAXJ8MbuLipqUdj4CpbExe0oiCcyUyb=Osw@mail.gmail.com>
References: <CANYiYbHvqLX_OozgAXJ8MbuLipqUdj4CpbExe0oiCcyUyb=Osw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before writing test cases, I want to make sure whether it is on the
right direction.

Changes since v2:

* Implement a on-the-wire protocol, see commit 1/4.

* Refactor report() on both server and client side for reporting of
  proc-receive.

--

Jiang Xin (4):
  receive-pack: add new proc-receive hook
  receive-pack: refactor report for proc-receive
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.procReceiveRefs

 Documentation/config/receive.txt |  14 ++
 builtin/receive-pack.c           | 294 ++++++++++++++++++++++++++++++-
 refs.c                           |  11 +-
 refs.h                           |   1 +
 transport.c                      |  33 +++-
 5 files changed, 332 insertions(+), 21 deletions(-)

-- 
2.26.0.rc1.5.gca1e965b06

