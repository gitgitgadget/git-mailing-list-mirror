Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C76EC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A1264E3B
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhBJLjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhBJLi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 06:38:27 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25044C0613D6
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:37:36 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u11so1034298plg.13
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0azAcR+61Kk2jHaRyGZ4M23REc4kDg8hIxQx4Va/rKU=;
        b=Mn7UDIB2InepndCP9UwRBSOOqnYjg4N2t/jsHYipePY0wodBydT7r10PD9BvFK47Dz
         0MWBdJPqAKQ4xVWh5d0Nkp2yWJSjPV1qwTl4Upo0mjmmosMYcp6XMtYQORayjstA8uZJ
         990CbUbK4dUoPyV2uxdGVr2JG1GBcilCwSPMluCNE9IadLNUJxBU3txHerYXDzoJCmWg
         G3724c1cC2xixkOf/4xULJnE1WuaUGZEyzImcEJhenN4jtnh4wW1WBLEyMCUAdasYv7P
         s3zpLjLn9ewcxSgml1VddWoz7uGI4xZ1yGQrA5RBAW03Ee85hHSD8nyl5pOmR0KUTaiG
         L4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0azAcR+61Kk2jHaRyGZ4M23REc4kDg8hIxQx4Va/rKU=;
        b=eSTIHOxcfhxUcCAYCIT4sTNCbNVvx+Sq0OQL5TnxsSJiALzAefqkoBOvXrsHg5rNqO
         MRUmN1rw6GvVNVfTLIEAoksctkoQmJK0eOxtFpZG7HOVHrKmAU0qUejQfQPScNxdcHXZ
         npIO+Magu7S2Luw+cqQVjy7cQtob2JjWr9WpHOXadtD+031eMjX0MyJAc84CRU2jUjsD
         hqEArHPhYZG7iDa36uuMYsXTIIP4kH0uQEV2KnzfKBX5BfZT1rE4snc+y6ivLJLrzvcH
         YlL0D2ATuuTPUirDySELbRaS+d9JT00Nl7OTqSGAi9x++tcWWDBZ3Eg3wcPcN8KxhrN/
         EaSw==
X-Gm-Message-State: AOAM532GG5cbHcNgSPST9Z+XvSY3T6HkVal4Lww8joa5VeBOjhMVrg8t
        /r27Urmmzop3MTi0SbBO32F1sXaVoGXLsA==
X-Google-Smtp-Source: ABdhPJwwjlVNw6a7ENfH5Ze0qMTPp5Mhotl8rCfo+IbP/mNnwCZw2NJNukGx9/JRNZsUvQPaxUw4IA==
X-Received: by 2002:a17:90a:ad09:: with SMTP id r9mr2719645pjq.51.1612957056277;
        Wed, 10 Feb 2021 03:37:36 -0800 (PST)
Received: from localhost.localdomain ([171.76.0.223])
        by smtp.googlemail.com with ESMTPSA id y3sm2123731pfr.125.2021.02.10.03.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:37:35 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v3 00/11][Outreachy] Improve the 'fixup [-C | -c]' in interactive rebase
Date:   Wed, 10 Feb 2021 17:06:40 +0530
Message-Id: <20210210113650.19715-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is build on the top of "cm/rebase-i" in the 'next' branch and
improves it. It fixup the source code of 'fixup [-C | -c]' command in the
sequencer, do some fixes in rebase -i, improves the 'fixup_-C' like commands
in lib-rebase.sh, update the test-script 't3437' and fixes a typo in the
documentation.

Changes from v2 :
* Update the rebase-todo help
* Remove the changes and resets to fixup_-* command
* Update the documentation of FAKE_LINES
* Move the changes of "unnecessary curly braces in test" to the other patch
  (from v2-9/11 to v2-5/11)

Thanks all for the suggestions.

Charvi Mendiratta (11):
  sequencer: fixup the datatype of the 'flag' argument
  sequencer: rename a few functions
  rebase -i: clarify and fix 'fixup -c' rebase-todo help
  t/lib-rebase: update the documentation of FAKE_LINES
  t/t3437: fixup here-docs in the 'setup' test
  t/t3437: remove the dependency of 'expected-message' file from tests
  t/t3437: check the author date of fixed up commit
  t/t3437: simplify and document the test helpers
  t/t3437: use named commits in the tests
  t/t3437: fixup the test 'multiple fixup -c opens editor once'
  doc/rebase -i: fix typo in the documentation of 'fixup' command

 Documentation/git-rebase.txt    |   2 +-
 rebase-interactive.c            |   9 +--
 sequencer.c                     |  23 +++---
 t/lib-rebase.sh                 |   7 +-
 t/t3437-rebase-fixup-options.sh | 122 +++++++++++++++++---------------
 5 files changed, 87 insertions(+), 76 deletions(-)

--
2.29.0.rc1

