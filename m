Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4616EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 23:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345372AbjFPX14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 19:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345135AbjFPX1y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 19:27:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0543C05
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:27:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f9002a1a9bso3263795e9.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686958068; x=1689550068;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOaGc3MGQAfXM0NjM9693D7ztm8pCB+OEa19J4st7nA=;
        b=NN9aiHzak7Rnc9M1tCIcue+ZGXMHL6unfToqI0muaIgUhIa9jlwpXmpsgw90la3fV/
         tPZcUvH9/AJhMc483++7czanwmPT3GfQkhEdqEtRT5/FNUJ4mL/UJD8FCMwP2lCQAMfM
         h8GcYZudGIo2z0FGJtBISpdtTjLqKLcLXHBZ1ECmvOT4WiRBDvE+Dob4QqhxYYQZsz+w
         hrwCef63i/m6omAWsDpBZ1jpOmyFaGIq9D94ABgSwk0VjVOwmo9DZhp9BA7JuGUJh8nh
         7n6GFUnPYiaCkC47TLZ+y2ExZapxhG3kJYJ+QzK2W9yQVWr6TZEaEvlFZ8z6OtdntpE9
         B43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686958068; x=1689550068;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOaGc3MGQAfXM0NjM9693D7ztm8pCB+OEa19J4st7nA=;
        b=lU7+COUXbrvc23G18jpUBwq/sd829YYqK5KJWaW9mWMBbqKC2BXJR5/wR5Q3byKGt/
         va7zIcTQqRZA/2X3lHPm7cydluGaVYLeK/vfVqb+ySgmdqnUosXsKsicb0PMsIqmWwlM
         6Hv8fEuWLEOY5vkuctWrZf3iY5w+eqFY/7jLVlmdk2L95jYf1KSrhv0TKRTzX0RDfrzJ
         Onj2Zppy6qus7NABa8NnoimhII46sYbR+3jcHAbUfafLM0VN+vVDqjT6sWh3Qycw7C+6
         i/u1Lt9xYqJhi+is7SzuQIsapjHqhKgTP5lNCLiWsvfIFjfsxEAo6WWvLcJSWXxZWWvI
         VIbA==
X-Gm-Message-State: AC+VfDzjsHZ0aSoQNVnY/WxBpNqz8jbJiFgx1+aKIG33Nu5MT/m/VL90
        7Nzr58KYmPdhLAFWHb83XWo=
X-Google-Smtp-Source: ACHHUZ46h2VyTOatu0TDkoHLCKBlVBwbWRsx77/h/gnkN5ZapdNKxzL+bBjdWB88DDT8+IoAxR9obA==
X-Received: by 2002:adf:e98b:0:b0:30f:befc:d864 with SMTP id h11-20020adfe98b000000b0030fbefcd864mr2600899wrm.62.1686958068347;
        Fri, 16 Jun 2023 16:27:48 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d4e0d000000b002fb60c7995esm24764614wrt.8.2023.06.16.16.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 16:27:48 -0700 (PDT)
Subject: [PATCH v2 0/5] tests: mark as passing with SANITIZE=leak
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Message-ID: <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
Date:   Sat, 17 Jun 2023 01:27:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
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

This is the second version of this series.  However, a subset of the
patches from the first version have already been merged to 'next'.
Therefore, those are not included here.

These are the rest of them, which address Peff's reviews.

Thanks.

Rubén Justo (5):
  rev-parse: fix a leak with --abbrev-ref
  branch: fix a leak in setup_tracking
  branch: fix a leak in cmd_branch
  config: fix a leak in git_config_copy_or_rename_section_in_file
  tests: mark as passing with SANITIZE=leak

 branch.c                              |  2 +-
 builtin/branch.c                      |  2 ++
 builtin/rev-parse.c                   |  5 ++++-
 config.c                              | 29 ++++++++++++++-------------
 t/t1507-rev-parse-upstream.sh         |  1 +
 t/t1508-at-combinations.sh            |  1 +
 t/t1514-rev-parse-push.sh             |  1 +
 t/t2027-checkout-track.sh             |  1 +
 t/t3200-branch.sh                     |  1 +
 t/t3204-branch-name-interpretation.sh |  1 +
 t/t5404-tracking-branches.sh          |  1 +
 t/t5517-push-mirror.sh                |  1 +
 t/t5525-fetch-tagopt.sh               |  1 +
 t/t6040-tracking-info.sh              |  1 +
 t/t7508-status.sh                     |  1 +
 15 files changed, 33 insertions(+), 16 deletions(-)

-- 
2.40.1
