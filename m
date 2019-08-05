Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5729B1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 08:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfHEICw (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 04:02:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45374 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEICw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 04:02:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so4464647wre.12
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 01:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZGtDr6YW9hf8SQRZ5OhxU6T1q9xlUWYVxXn2v+DuAY=;
        b=nrSfMc94lzisPNqumzd9HKSsQtI3OEVx/Mzxykw3ofwOu+U6S+QcxkYjyltVVrf/yA
         aB5Zb67Qk3emCIJpAwXcQ6bF2+5nK20uaEvXgojwJPuXB9vmtq4T4f3IXQEVDiB7Oyq3
         ug7ioCpXu+qju0/O6JoByq2Jaelt912ih500Iufoqf8Gpbfnu0uI+2c6MfhJXrn7fRxn
         HAxbMqdWiIF6TlCOJRQEiwJKoJ1VKvHTQRQNaZOCY0U0Mr+EZ9GSQZL+u2S+vQLXcfTl
         Lniec+Bs0fGPtCnC1ckzbxOApUyqSI1KdmvZ9XiK1IQwoiWpauQxiENDiFoDPXApyvyj
         K0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZGtDr6YW9hf8SQRZ5OhxU6T1q9xlUWYVxXn2v+DuAY=;
        b=o5ft+04+5bvhxO0fcBIGCXe19mxhJ/FA3v4wY+oRTSVItCVMbLmANd+0PVaGdeb9Zs
         MdioF+fJhuId5dHKafxGeGDO5UEd/vtn9mCxN2oAbOJWcjefMyPl/+9qpziXTlLcj+kK
         uTMeFWdRPvXKk0DXFdKnn9V27uU1o6EAH1/y1A8AD1yJdpkcPMkn6LR5WLKl5548kmKu
         hyIKQVlk0KVZrgsils2X3YptBCV+pCVB9HbXhPYp5RjZbMxVERJmaHmMXcD/sousv8sJ
         6qK8dQlZg5KaQEFhNbD9WwVgBnxlkuZmwoL1oTrvY1iCIUcXoTsE+4C6Pd/lT1PmVUa2
         d5jQ==
X-Gm-Message-State: APjAAAWWsBdXGVdb0wRkffCZl7rpwsKCsWcVBGMDlqdogvYQyA5VVp+p
        oY5FlLOlCeCqpOtTQFK/dqUntSP5srE=
X-Google-Smtp-Source: APXvYqzaeaSiOi27nLPVYK2pOeydaBasNirYPhSlDPwHWpAtzoJiN12MJsK+jVDCogM+d6LssOGANA==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr20203736wrw.96.1564992170821;
        Mon, 05 Aug 2019 01:02:50 -0700 (PDT)
Received: from localhost.localdomain (x4db4a28a.dyn.telefonica.de. [77.180.162.138])
        by smtp.gmail.com with ESMTPSA id v124sm89514573wmf.23.2019.08.05.01.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Aug 2019 01:02:50 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/3] commit-graph: error out on invalid commit oids in 'write --stdin-commits'
Date:   Mon,  5 Aug 2019 10:02:37 +0200
Message-Id: <20190805080240.30892-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.309.g896d8c5f5f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While 'git commit-graph write --stdin-commits' expects commit object
ids as input, it accepts and silently skips over any invalid commit
object ids, and still exits with success:

  $ echo not-a-commit-oid | git commit-graph write --stdin-commits
  $ echo $?
  $ ls -l .git/objects/info/commit-graph
  ls: cannot access '.git/objects/info/commit-graph': No such file or directory

The last patch in this series fixes this issue, with a bit of
preparatory refactoring in the second and a while-at-it cleanup in the
first patches.

SZEDER Gábor (3):
  t5318-commit-graph: use 'test_expect_code'
  commit-graph: turn a group of write-related macro flags into an enum
  commit-graph: error out on invalid commit oids in 'write
    --stdin-commits'

 builtin/commit-graph.c  | 10 ++++++----
 builtin/gc.c            |  2 +-
 commit-graph.c          | 40 +++++++++++++++++++++++-----------------
 commit-graph.h          | 15 ++++++++++-----
 t/t5318-commit-graph.sh | 14 +++++++++++---
 5 files changed, 51 insertions(+), 30 deletions(-)

-- 
2.23.0.rc1.309.g896d8c5f5f

