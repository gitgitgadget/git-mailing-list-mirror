Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E013EC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8142E20781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J659lMkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbgKJVVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKJVVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:21:39 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD01AC0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:39 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id d9so16109274oib.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KpNX+wwCCpr4iaWZMjvlrg28Zg7y+VdDuXlAvCwOuss=;
        b=J659lMkCdAFpH2bwXoebLweFi0v79p0X08ERcmDeP4BjD9kapfzC4A6IYA3vLOnFFn
         0NR/j9T8bVnTKmqhmT6h+3MKDbwpGnlzPS97n+AmbFI4XNELSR9xfB9PdDZgjqIFSFxF
         NxS2acc54iM9w7U/zUqjDBTA8rYMoQo41uwVKt9kphrawLux88ary5x1XO016z7wfmbA
         mXT+0maI3GhiKik0+y5BzJ+pe0xxNrzpZmSjEnmIwpyv9RTrIaEVceTbfUhblcUxhEQ5
         jLfsSFxUcHMYpBE9oe33LommuhRBUQ+ElW9iIB10NWAUfcJhfyi3LXS5BVt/e+iispf3
         QWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KpNX+wwCCpr4iaWZMjvlrg28Zg7y+VdDuXlAvCwOuss=;
        b=osbaqd0rofJtoCsszdnDQyhDQs5Qo2sik9ydX9OHEm/cbrUqloJAcao52+VNUQchjf
         V7rwhWtAmLQXGSs3+EXrZUlq1JDjIaM4JI/n0DjGxgBLq/5kZSe8HbQ2SQaxjcJJwcMk
         s7XWAlFgFtCxlQlexFQxCDkUEVYIFXW8QEmBls0BrJVdc+fmZKVfmMN28LnzeeK/lcPx
         5cA343KvpGHg3DYMUTK+Dg53zDxtZuw+4uhtpiCfiS8tvLB/ctfVMa7QV+75BlRPnArZ
         Y9NgsU9jbMbs6jXCbTZvbwOt4EkpdFpGzQdsbLV24rAU/Oxa1dGSQxtqNFgecYEN4J+K
         wAlg==
X-Gm-Message-State: AOAM530os+aeNHrulCjiinTlDlOr5ycQORYaEFNIEYuJiChPZk9yzPoT
        jiuR3UGwIy/xKZjjqu4O9zY1SX7n9uwAfw==
X-Google-Smtp-Source: ABdhPJwutTqJPi6Cq2eiDmSPCMmt6A/VcPNPDzM/EO+tMd6VesJjus2g5jMEyour6syNYudd+3MZug==
X-Received: by 2002:aca:d445:: with SMTP id l66mr44294oig.37.1605043298960;
        Tue, 10 Nov 2020 13:21:38 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id f34sm25479otb.34.2020.11.10.13.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:21:38 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/26] completion: bash: a bunch of fixes, cleanups, and reorganization
Date:   Tue, 10 Nov 2020 15:21:10 -0600
Message-Id: <20201110212136.870769-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found a couple of bugs and inconsistencies.

Also low-hanging fruit in terms of redundant code that can be merged and removed.

Tons of cleanups.

And refactoring the ancient _get_comp_words_by_ref.

Since v1:

 * Added bug fixes
 * A lot more reorganization


Felipe Contreras (26):
  completion: bash: fix prefix detection in branch.*
  completion: bash: add correct suffix in variables
  completion: bash: fix for suboptions with value
  completion: bash: do not modify COMP_WORDBREAKS
  test: completion: fix currently typed words
  test: completion: add run_func() helper
  completion: bash: remove non-append functionality
  completion: bash: get rid of _append() functions
  completion: bash: get rid of any non-append code
  completion: bash: factor out check in __gitcomp
  completion: bash: simplify equal suffix check
  completion: bash: refactor __gitcomp
  completion: bash: simplify __gitcomp
  completion: bash: change suffix check in __gitcomp
  completion: bash: improve __gitcomp suffix code
  completion: bash: simplify config_variable_name
  test: completion: switch __gitcomp_nl prefix test
  completion: bash: simplify _get_comp_words_by_ref()
  completion: bash: refactor _get_comp_words_by_ref()
  completion: bash: cleanup _get_comp_words_by_ref()
  completion: bash: trivial cleanup
  completion: bash: rename _get_comp_words_by_ref()
  completion: bash: improve __gitcomp description
  completion: bash: add __gitcomp_opts
  completion: bash: cleanup __gitcomp* invocations
  completion: bash: shuffle __gitcomp functions

 contrib/completion/git-completion.bash | 648 +++++++++++--------------
 contrib/completion/git-completion.zsh  |  20 +-
 t/t9902-completion.sh                  | 159 +++---
 3 files changed, 377 insertions(+), 450 deletions(-)

-- 
2.29.2

