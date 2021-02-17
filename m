Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDD3C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 14:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A6964E28
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 14:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhBQO4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 09:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhBQO4R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 09:56:17 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51044C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 06:55:37 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s11so16822943edd.5
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/1iCoeMD2Ymc63T0GX8w2MZgNHKzEzXLjWorN8G4Ss=;
        b=DJghnbYd0kgtVyf98YTSHFYs6Hfc15TnuiDefklDnMMl9Nca8NQbr5/d4m93C7P8YV
         a1xTHB8v1/XJas/X8lI3VOizBRXzG6MPUyK4SSHmNh8jTLbHfLQIu6uS4ibqz5jvz1+j
         +3KZH8e5IRoZy8Fon+jByo7JAsm08e11rO9jmPf55O7PsaINyHcp3Q4lkhFGb0KjmfmA
         Auvtxod4oMjATwxIpbPtXfFf6SHd6OX5IEMOIOBc/C4UslCzOPqRepxdpur8r9ao/kr/
         3DJhBTV3mJgTl2o/pCv5eIyTeCBEwjR2O5gG0XkF1H8mx8QM4KzBiB4OpapRpVHdody6
         nB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/1iCoeMD2Ymc63T0GX8w2MZgNHKzEzXLjWorN8G4Ss=;
        b=YjMYLtWRyQdsb4xKVGjPtCnL4oESnViUI14Leq0rWFaJOsnoAf165DU/QY4bF/Pqes
         IrkW/TqPjAqZWRhjsNAnFWaMHoSeDmuVzgwu7/HEPrQmxRxWPdrGjsxXexwVmtabvgYn
         1aUZCN4WqB6nK12gvHUtRc92U6iKi100KfrjpIrvvZnHphYRHkA/TvJvsQk2+WtD9EvQ
         GDVyXDXtCuwRz6B2hIesyCtOQjPxbn5GT4WlflZ6E/2/1/orVST+kPIkjRZPbagAB/s3
         D+BQGCCXy6rXTrQQOIqzXqkgPqzXcJgplf+8Zko9DcATjnupKspC9pdUb781ZYcPLG5g
         hCoQ==
X-Gm-Message-State: AOAM530a7Bk5quOHzvkzij2+Fr2a9mcEILLkc5p3KItXN3T3Q+VzdLSh
        kPrKLO+nu5Wwk3uhsbY4zWJ+N70r8VUkYy0P
X-Google-Smtp-Source: ABdhPJy84FWWQ+5+WzFAPsXi6wcFhSDSKf0EwQXcfQPw6oSKgXXJr7oM2CfBDiyv5rOogmXT2Lbczw==
X-Received: by 2002:a05:6402:304f:: with SMTP id bu15mr6183254edb.259.1613573735642;
        Wed, 17 Feb 2021 06:55:35 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.26])
        by smtp.gmail.com with ESMTPSA id t19sm1133092ejc.62.2021.02.17.06.55.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 06:55:34 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 0/1] blame: remove unnecessary use of get_commit_info()
Date:   Wed, 17 Feb 2021 15:54:42 +0100
Message-Id: <20210217145443.36764-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.1.850.g2d41e9e789
In-Reply-To: <20210216163151.76307-1-rafaeloliveira.cs@gmail.com>
References: <20210216163151.76307-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Taylor, Derrick and Junio for reviewing v1. I've updated the
patch's message to include one of the performance reports that was
previously only on the cover-letter as suggested.

Rafael Silva (1):
  blame: remove unnecessary use of get_commit_info()

 builtin/blame.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  e0c698370e ! 1:  4d70ce9545 blame: remove unnecessary use of get_commit_info()
    @@ Commit message
         structure and remove the internal call to get_commit_info() thus
         cleaning up and optimizing the code path.
     
    +    Enabling Git's trace2 API in order to record the execution time for
    +    every call to determine_line_heat() function:
    +
    +       + trace2_region_enter("blame", "determine_line_heat", the_repository);
    +         determine_line_heat(ent, &default_color);
    +       + trace2_region_enter("blame", "determine_line_heat", the_repository);
    +
    +    Then, running `git blame` for "kernel/fork.c" in linux.git and summing
    +    all the execution time for every call (around 1.3k calls) resulted in
    +    2.6x faster execution (best out 3):
    +
    +       git built from 328c109303 (The eighth batch, 2021-02-12) = 42ms
    +       git built from 328c109303 + this change                  = 16ms
    +
         Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
     
      ## builtin/blame.c ##
-- 
2.30.1.850.g2d41e9e789

