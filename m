Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DDCC64E7B
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 07:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 363B221D93
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 07:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfeBxp/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392790AbgK0Hvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 02:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392783AbgK0Hvw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 02:51:52 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B923C0613D1
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 23:51:51 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id m9so3928273iox.10
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 23:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPSRdLERwR3dxD7iVRGVDwMemMtUxqykSeXeWQrqwZg=;
        b=HfeBxp/E+cO4+f6VjJiRh0Uln8u6rrrbnyw5ZggyWO2NXP4vT7HZh6FSq9ajwU/sZy
         dGJPOOtii7wLBqLkUQZbDfUstQqFE032CEQjMR7WtcjosB6shWk3w+FTlVdWdxHSl2+X
         7OyH48tZ5J4oGTfGxRS0GmHtjrnd66sVUwDnWKRdezLiZNGdTfpYrTvrDFST0zI0jlOW
         uuYlptp61z18+bV+0YVP6v1R1d9Tsd4pt8fFwURLhTX7lPIVJm2lnoosM/riXFvzaRig
         t2IU5g6GvpqDwt9en5EtYWf4zJTRg6+xN5rw1+IwOd2mBJYU9RX5KeO8IhKIGOrutSla
         oQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=KPSRdLERwR3dxD7iVRGVDwMemMtUxqykSeXeWQrqwZg=;
        b=ofzXs/fPGePBR4tFYnj/xN4EyiJMkkwQSVSoHd2i0VlDcq0eGnJ4YG8amWjUqBDTGz
         spUN8U0I+0JOcUSKXKuhsr6eTX0oauRJoU2i35RtUIhpQs0TC69OAqawE8K5t6zTNrKc
         9bXj0TwJSLNIgTpLd6lJEHr6E1a6MOOQUNxsvsVNkNknGvyYQW+lHiEL9xp7h4PlqD4t
         u+hv5oqWioPgmTkA9zolvmsGrNTvRn60/H8kqbKZ8Rs8Rp2iVSTydnPk3uNWo9C9cOhQ
         qCY3SigmZXIzSxrIHxhWeLcao/rnRbvbdMRH/vcie41st8YU13bdv8UkCse5d88edlrJ
         BoAw==
X-Gm-Message-State: AOAM531NFtO0vNr3A3e4IKOeRIJmUG7o3+Ixu6+OC4yb9KJZn73416E4
        TizK9T4Ye5Sz3fNUxW3OIumXYdzmLmE=
X-Google-Smtp-Source: ABdhPJxsPvUMX4mNn5CHJ1YuduV0ooQNtHiuSKzHbKohShAOultPSzYuBN1Jdf3Kso/yzoWqQ4Er+Q==
X-Received: by 2002:a02:290e:: with SMTP id p14mr6527685jap.105.1606463510189;
        Thu, 26 Nov 2020 23:51:50 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id 10sm4652447ill.75.2020.11.26.23.51.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Nov 2020 23:51:49 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] make macOS `git maintenance` test work on Windows
Date:   Fri, 27 Nov 2020 02:50:51 -0500
Message-Id: <20201127075054.31174-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git maintenance start` and `git maintenance stop` tests -- with one
minor exception -- have been carefully crafted to work correctly on any
platform despite the fact that those commands necessarily invoke
platform-specific scheduling utilities. The exception is that the
macOS-specific test fails on Windows, thus is presently disabled on that
platform. This patch series addresses that shortcoming.

This series is built atop ds/maintenance-part-4.

Eric Sunshine (3):
  t7900: fix test failures when invoked individually via --run
  test-tool: add `getuid` subcommand
  t7900: make macOS-specific test work on Windows

 Makefile               |  1 +
 t/helper/test-getuid.c |  7 +++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t7900-maintenance.sh | 13 +++++++------
 5 files changed, 17 insertions(+), 6 deletions(-)
 create mode 100644 t/helper/test-getuid.c

-- 
2.29.2.576.ga3fc446d84

