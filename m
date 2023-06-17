Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3516FEB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 06:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjFQGhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 02:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjFQGhI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 02:37:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D2D19BB
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 23:37:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3112902f785so330727f8f.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686983826; x=1689575826;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILuoH7RmgSLlkF1tiSu8gfkID+EV8m8uKJvKpZBMfgk=;
        b=gnLeAaurhyFEcUa+4KF48aXNDBSrVhWFj9yp7w6DxVNZZ6kSH5F1NXRd4IjHKjfXYd
         MVikFmlPjh8zzKKFQ0uelQLNYYuGgRZpcxpEaASgV7Hv29pSMbQ/MVJN/xx95pe3nFHu
         mbvyaeIGnINdDzV1fBzhNmC01DFu0d1ZTFo6Jdx6sMSSMznmD9XMmEQsJ95bPnavXICo
         fi4Y8z9XPtRbTYWcg+NCeRBBsuLdwjnUDZJ+8Aakor09QN9jCOZrnrBxuSxOXjwiE6cZ
         XemGGSKE6FMfrez7SSxfMYtmmZxtLGi6Rea0oZlm4D61p8e95oYICahkku23U/eWQ6Gq
         ePBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686983826; x=1689575826;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILuoH7RmgSLlkF1tiSu8gfkID+EV8m8uKJvKpZBMfgk=;
        b=U/WnM9ovwWH3aQCdG654h+2yvBZqaFUzyELiPuWvTSaT/DEW6anzj38UneSM3K2qqN
         GClxGThGN7OLD8i1859rnu6UZHoky3AY9URFZrzldqxpksvawy1wjguOg+ja/oBNTshK
         reUn381PQorYeC2Snl5xt6UfSPwpiRy9XqZwulAXI37f7ke7xvsY7yRPnUFgyfsPhi+k
         qwCEYGueiaZ7GoAFKaFnN1K5VlEwrmHc8TPnzFlkFfSC4vDSkG3JK1jrPjEgR86jlvuM
         2ddU4tAAzRTiasm3GStyB25i9ORKkyU9yKkKzce1k6wjmvYvt5UK8ogXQmIWfQdPU0wf
         9mIw==
X-Gm-Message-State: AC+VfDzuDtfECI+AaErz+kCsKgDy6/qPNpdEXd3Tk4z6fawdQUEVE7Nx
        Q0HFr17regrYKpmVuGgOsHc=
X-Google-Smtp-Source: ACHHUZ6DNlNQrADvBQLn4Ho82KdmsSmxARoEyez1wNZZ0zVh7KINy8YUNJMkJ6sTk2U0C/dCp58H8w==
X-Received: by 2002:adf:dd8a:0:b0:30f:cdf7:9f05 with SMTP id x10-20020adfdd8a000000b0030fcdf79f05mr8491454wrl.27.1686983825771;
        Fri, 16 Jun 2023 23:37:05 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b003f60a9ccd34sm4030533wmj.37.2023.06.16.23.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 23:37:05 -0700 (PDT)
Subject: [PATCH v3 0/5] tests: mark as passing with SANITIZE=leak
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
Message-ID: <71b49be1-eeef-2f60-38f1-cfcbe4c8252f@gmail.com>
Date:   Sat, 17 Jun 2023 08:37:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The goal in this series is to pass t3200 with SANITIZE=leak.

As a result of the fixes, other tests also pass.

This is the list of tests that no longer trigger any leak after this
series:

   + t1507-rev-parse-upstream.sh
   + t1508-at-combinations.sh
   + t1514-rev-parse-push.sh
   + t2027-checkout-track.sh
   + t3200-branch.sh
   + t3204-branch-name-interpretation.sh
   + t5404-tracking-branches.sh
   + t5517-push-mirror.sh
   + t5525-fetch-tagopt.sh
   + t6040-tracking-info.sh
   + t7508-status.sh

Each of the commits (except 5/5) fixes a leak.  They have no
dependencies on each other.  As a result, they can be reordered.

To review one leak, the commit can be moved to the tip or reverted.
E.g. to review: "branch: fix a leak in setup_tracking", this can
be used:

  $ git revert --no-edit HEAD~3
  $ make SANITIZE=leak test T=t3200-branch.sh

Also, each commit have a minimal script in the message that can be used
to reproduce the leak.

This is the third version of this series.  The refactoring in config.c
has been reverted, and will be sent outside of this series.

Sorry for the noise of a quick re-roll.

Thanks.

Rubén Justo (5):
  rev-parse: fix a leak with --abbrev-ref
  branch: fix a leak in setup_tracking
  branch: fix a leak in cmd_branch
  config: fix a leak in git_config_copy_or_rename_section_in_file
  tests: mark as passing with SANITIZE=leak

 branch.c                              | 2 +-
 builtin/branch.c                      | 2 ++
 builtin/rev-parse.c                   | 5 ++++-
 config.c                              | 1 +
 t/t1507-rev-parse-upstream.sh         | 1 +
 t/t1508-at-combinations.sh            | 1 +
 t/t1514-rev-parse-push.sh             | 1 +
 t/t2027-checkout-track.sh             | 1 +
 t/t3200-branch.sh                     | 1 +
 t/t3204-branch-name-interpretation.sh | 1 +
 t/t5404-tracking-branches.sh          | 1 +
 t/t5517-push-mirror.sh                | 1 +
 t/t5525-fetch-tagopt.sh               | 1 +
 t/t6040-tracking-info.sh              | 1 +
 t/t7508-status.sh                     | 1 +
 15 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.40.1
