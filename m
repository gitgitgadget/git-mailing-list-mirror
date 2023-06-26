Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39EAEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 12:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjFZMQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 08:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjFZMQX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 08:16:23 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1E510DC
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 05:15:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-54fbcfe65caso2813912a12.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687781685; x=1690373685;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ame4NAMHIkIZWY+OOiGiN4mO/rmoh5JhG8XxqUemE8=;
        b=IAp7lHxJM6bGmvfJLq0kvrSXNJBItD0RwSEhFsOryDkxOV8b2teS+qU4+JgZKtxPAR
         HyBW+aPbZR3a0gqeTVcTiMvJUgl+1w/2rXSJ5YxvHaKfYKCSJoiDInXLfPD/RoEBkPGG
         Lh9TLahOv89MjrbJi+Jp12AHSs8V4xU/quYLkOvko6cM/Onkp4yMYbj9z4HMVwNniqN+
         yTiEXyHhLHHcykao0X2TlA6KF+820YO7hEdp/6Xg3+ZRtaIs1mr+fTCSW1Rm8RBSqZAq
         01A9Y9nYgNPoP1i6rla/0ZAQ6hWF/fMC85WcvGN4aZ29pMpsfCqlDT/nloWmY9WsgREJ
         K6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687781685; x=1690373685;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ame4NAMHIkIZWY+OOiGiN4mO/rmoh5JhG8XxqUemE8=;
        b=VFeSWRH+cMXjlefUQ7mAVGFlB1u4pDWS/uN0yUWmOwBLClFlUGg+aBe8lRpFypLrmw
         xRaQS3P1/bzgtsc0rPdYxLNloEXGNLdFQrMSY3E7P4DH8X4e0+O15v3mXNIyhkeLhjKa
         Lym1mSLSG5DYUDiMOozD7JXSphEpoEPiaXx3ZPR7+eB0YVvsW7HrUI9zsKP01qOZPOqE
         uvSC4Pm1bmwcQdGRTA9AN+fUhV4UXLwv8y5gEULV/zuFhUcoqOTucXvzG5sHQ/0wK+yZ
         Y/5DB7C9zFihAi2TwlAx1AU+Ehk7QfgOEILW+yrknSioAAbAdt1G/Xwe+TxZPGPooFzt
         VpuQ==
X-Gm-Message-State: AC+VfDz1Jdqik983hVQui4C6x+cvwIWOwUT6sWs7tIxLHEnlnxsX4RLx
        WxpISfDIsrs9HyucX9ch6ODP0EMlmHygKNOZldqigKWvNdU=
X-Google-Smtp-Source: ACHHUZ53/3NRmyHJYJRALYngH0EbJrRZCGBCCrA+Irg5fb8B9QB0SYNHHCtZgP/Kj5r/EPucDSA2t1GEIEMnsg8XSdc=
X-Received: by 2002:a17:90a:189:b0:256:675f:1d49 with SMTP id
 9-20020a17090a018900b00256675f1d49mr39399363pjc.0.1687781684806; Mon, 26 Jun
 2023 05:14:44 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?SXbDoW4gRXhww7NzaXRv?= <byjokese@gmail.com>
Date:   Mon, 26 Jun 2023 14:14:33 +0200
Message-ID: <CAPDGPD5UK8+Z0ksX-tv2Rs8ESZ+LCY-Tic-dZSGV0QNStFN=Pg@mail.gmail.com>
Subject: Git question rewarding git merge and its exit codes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, my name is Ivan.

Recently, we have been working on some automations for Git, especially
auto-merging some branches. Just noticed that when using: git merge
--commit --no-ff -m "test message", and no changes are needed, git
returns  "Already up-to-date" with exit code 0. Is this correct? Git
hasn't done anything, so not sure how correct is to return 0 for
success when nothing has been done. We have here a problem because the
only way we can detect if a commit has been made or not is to check
the return text, which is not the best idea for future-proof, or
changes in the return text.

Is this exit code as defined, or maybe is something we would need to
look into for future improvements? Is there any other alternatives to
detect what has happened, not comparing the standard output text?

Thanks for your work, If any information is needed, don't hesitate to
contact me.

Thanks,
Ivan
