Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D341DC54FCF
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 13:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CB820732
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 13:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0TTAjBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgCVNS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:18:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35204 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgCVNS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 09:18:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id g6so4695587plt.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dcoGOx2Z4oeTjswzrvEWbFpxM1lKZCLvsGY282wuFNc=;
        b=X0TTAjBxnkrUobgHpkAoUGBxCY3VBeFy+ecOlavzeRrcBepxoOePyMnPLmWjC3IoB/
         EZbIL9pDQg7n1XnWBqCytBbYTxADHO6+Ku/4wAowiyUwKKap6wD/xLdE80xUbAjxgl8b
         80+/NtMJS2wOO5bJKmg9rsl9uIckZJ272Q0S2J4dO+VBO9bZ++2QYALFMnWTzuLeh0DL
         1X5Gjr6rhMqBt3wwy0OU3ZRqDk2aO8aywG3Pw/p1RBBQwWjJu2a4g69svks+Bmfb5sNH
         6gRO3TKwf2yMCqPIdVaWec7mHcvn3p6tgkeI+kLmuknFJfeGIoSNlmxfwWwSjU1jESky
         tlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dcoGOx2Z4oeTjswzrvEWbFpxM1lKZCLvsGY282wuFNc=;
        b=QP6kvQKR4mN0ANAWDXLSdWfW9RTflN2QkdjrSFQR/s2qToe23XulkTOvw/IKYRPCPf
         0ZSfh1lH8IqpfEwALNq3GQlg/IhD0ZVGfalIdL5dXEcrT+Tbsc3SIoPIvoYNqyzl3bK4
         lsFlXqYckPoQ3fqo+w/4BUXiGDza0MefhPyetUCGGv7Sd+BqxEhSS24nKWLcg/zjjBcH
         lJAd/8E57yerdAd7i8KFWMSt6/1tU5KZTf6LLJwY2dvu363kJlBowiEOoEdVQ83NsSpz
         NWFJbRmeI8VjnHYFuRiXHB9qn0LIkahpKZNQO4PaUnMOTEExxMwYP5edgOTriqRT1fBs
         Ih3A==
X-Gm-Message-State: ANhLgQ3NJ3gvsYK/ozZk+QQ2wk4UiJwRVzIjY83BkKNSdU82h2dWwsLO
        NCwnxNtshwtDpb0qKcnlLWDMdRHf
X-Google-Smtp-Source: ADFU+vtJvslZ/ZDh5OuD6Cs3kse93xNhdWLlyRGzY0hRufePp9uj9+YauyjJF0mbC8VtNOSy8Tstxw==
X-Received: by 2002:a17:902:a9c5:: with SMTP id b5mr17320514plr.126.1584883105731;
        Sun, 22 Mar 2020 06:18:25 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id nh4sm9456432pjb.39.2020.03.22.06.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 06:18:25 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 0/5] New proc-receive hook for centralized workflow
Date:   Sun, 22 Mar 2020 09:18:10 -0400
Message-Id: <20200322131815.11872-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200313122318.78000-1-zhiyou.jx@alibaba-inc.com>
References: <20200313122318.78000-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2 and v3:

* Implement a on-the-wire protocol, and add new test helper to test
  the on-the-wire protocol. See patch 2/5.

* Refactor report() on both server and client side for reporting of
  proc-receive. See patch 5/5.


Jiang Xin (5):
  transport: not report a non-head push as a branch
  receive-pack: add new proc-receive hook
  refs.c: refactor to reuse ref_is_hidden()
  receive-pack: new config receive.procReceiveRefs
  receive-pack: refactor report for proc-receive

 Documentation/config/receive.txt |  14 +
 Makefile                         |   1 +
 builtin/receive-pack.c           | 323 ++++++++++-
 refs.c                           |  11 +-
 refs.h                           |   1 +
 t/helper/test-proc-receive.c     | 164 ++++++
 t/helper/test-tool.c             |   1 +
 t/helper/test-tool.h             |   1 +
 t/t5411-proc-receive-hook.sh     | 954 +++++++++++++++++++++++++++++++
 transport.c                      |  28 +-
 10 files changed, 1478 insertions(+), 20 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh

-- 
2.26.0.rc1.33.g4914ba4bcf

