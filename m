Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9E2C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B075206DA
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utpfx7ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLTSnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:43:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39777 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTSnY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:43:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id q10so5677515pfs.6
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oTJsXYVxb+JSWCt/WnS6At5Zg8tT9pnv4Ap9ege61oM=;
        b=Utpfx7ac6CVXD+ScghZ/HUqsYnYxsI0Qw8+bS2e08tPuPJbvKlDOOke+DdVhujGEzn
         wE726ThiYi8Q6suWzX6Kt/j43tlDfYWC69ZGFvgdP30UO7Zeymp2H+oqCQV/JM1SfSO8
         wdXT71kHbIAyvOZy22/B5oeaLQIm0iR48YFF7iJ4NZiTGwLpJpmkFgzdS94zVwfG5Vxu
         5cl9RodOvcNqu9wwl4K6+JACVhvlywTrvyZWpCNIw8ADWBqqgAEvH4KdCGlhhU0mWL76
         QEgkl9Z7FgVunRsdn//qn7ou0nL29VOGRJdUx42EcstR8CliMrQgLgutk50POeoECj8r
         gVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oTJsXYVxb+JSWCt/WnS6At5Zg8tT9pnv4Ap9ege61oM=;
        b=Q0FVMyxaqK2bI0YU8FlYPFSuHVnQqXCf4hycXEJeXDvJpzF0irXCum5+Y/e7fad7WU
         uDOqHSg4lv8FD8YdzPRv1COnqpvsPb6K7j7UGOELd6haTnmD+8/oX3ROiVJcK9zYdn8c
         7txHK3sdSc7Nwa3kEXlfqSybypEOpQNeCFwjd7EIVr3JmnTExIDAiRRiejB5QxHuoZvC
         4hYv1JXSj132JmEArKpYLqa9Kxt3UAG4Yz1e0EGpwmtGMUfcmvWhqnwlC/PAsSWhR+xW
         i4cpP3mER+EJKrATsDLhdNHS3acg94t5KcG1W07aVUcG9l4b4k+S/TLKRE1T4kZaB+Iq
         /Qcg==
X-Gm-Message-State: APjAAAVm1xzeeqhdLB7TnTDrrk+Z4gvQOZpvfWvT5WcmkmUJkxTPQLow
        UkDb1oxBaUVAZCG13yAoHPnJqa5i
X-Google-Smtp-Source: APXvYqxvhF+0utCL4jL8RTcfaeMpcXCccSa0Vppl71iH1jPI0LhdTVC6gcTncIaIiT7ecLMLn4UXMQ==
X-Received: by 2002:a62:1cd6:: with SMTP id c205mr17621761pfc.179.1576867403221;
        Fri, 20 Dec 2019 10:43:23 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id ce15sm11403553pjb.4.2019.12.20.10.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:43:22 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>, Jeff King <peff@peff.net>
Subject: [RESEND PATCH 0/2] contrib/credential/netrc: Makefile + script cleanup
Date:   Fri, 20 Dec 2019 10:44:59 -0800
Message-Id: <cover.1576867467.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576531851.git.liu.denton@gmail.com>
References: <cover.1576531851.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently switched my workflow to use this credential helper and I
noticed a couple of problems:

1. The interpreter path was hardcoded to #!/usr/bin/perl

2. The script refuses to run outside of a Git repository

This patch series should fix these problems.

Denton Liu (2):
  contrib/credential/netrc: make PERL_PATH configurable
  contrib/credential/netrc: work outside a repo

 contrib/credential/netrc/.gitignore           |  1 +
 contrib/credential/netrc/Makefile             | 26 +++++++++++++++++--
 ...ential-netrc => git-credential-netrc.perl} |  2 +-
 3 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 contrib/credential/netrc/.gitignore
 rename contrib/credential/netrc/{git-credential-netrc => git-credential-netrc.perl} (99%)

-- 
2.24.1.703.g2f499f1283

