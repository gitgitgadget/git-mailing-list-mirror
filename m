Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DD7C7EE23
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjFKS3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFKS3P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:29:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3288E6
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:29:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30fb7be435dso520564f8f.1
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686508151; x=1689100151;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqWJJjj09uqdc3QxIIvI+Qm2gWkJQsk4CkHXhi+WM2U=;
        b=BXW4AE1NCPNBCs8sGAbT37Vits9xGJjrmf7ornhavg/5aT/oeMnUwUP8ycfR5I1XYt
         b7HptH3/NmEmhySnMtWB7TpEi1B3zBBWW0dyaEq4tjoi/MnaU1KroRhWMoEs8AbS37O8
         cQR8SIiPX/m4e/5jJ+JN70MRmGytuF6RAdUvOMm6cWA8BxBvOKAt7lud4tmkZV00Opg8
         DK7v6dXJuaMTDBgF5+sjQCQ8NQCT5TaxI8pG4DGBRcIg7a9l713HiGvxV5Nr6joDs+qu
         FI1u9KbVSjbEG9CzPXDJMuAj41wlUUZee9q4SCMYBQwDFS0v136nWRcDINlRZhHvSblR
         K+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686508151; x=1689100151;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqWJJjj09uqdc3QxIIvI+Qm2gWkJQsk4CkHXhi+WM2U=;
        b=AsAx+nhDYES33ERLNj6FmL7gBm0FhIY8hagrvXxrFz6IrfRPDaqC91Nrvrs0B081B3
         6yJ27WZf80l9CDCGgn5EeqW38c5ufBbFDO7q8Qo7KItXKXj7DLf9n+e4ieTWbeFMHrbu
         kEYlxuTxMEcXBErEWKfHi9kfvfPW0i+R//PdMr+EQQY/T95mM7yJmz0PCy6F+BUK9n12
         cY5nHGCAEK2SWK1qENgAUd8ED5mAPR45V+M5XDKoj6EmBrnFluaOm3Ajtr8JC5eagDiz
         l17amKNVFctkpGFZ8Z6Ojm5KVbbx8xqUrm+ClHAW5/R7SimWa2mfsanggmjR/49q4+wA
         oX+A==
X-Gm-Message-State: AC+VfDxFYt2ji5My/aYP4ctrPOachvi7FsqR5OHlzabXrObM/h3R9KsP
        WvOScd09SnP/u1WJbDJT68IkCXmOmn4=
X-Google-Smtp-Source: ACHHUZ6QWJzicNTM5qtvOxwfuPK77NzlQKxEtAeIjqx0Kck1sArR9HXJfCT4C12vBt0DgMmpWNBgPg==
X-Received: by 2002:adf:f84e:0:b0:30a:e66d:25b7 with SMTP id d14-20020adff84e000000b0030ae66d25b7mr2590066wrq.13.1686508151062;
        Sun, 11 Jun 2023 11:29:11 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id y22-20020a7bcd96000000b003f7f2a1484csm9051597wmj.5.2023.06.11.11.29.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 11:29:10 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: tests: mark as passing with SANITIZE=leak
Message-ID: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Date:   Sun, 11 Jun 2023 20:29:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
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

Each of the commits (except 11/11) fixes a leak.  They have no
dependencies on each other.  As a result, they can be reordered.

To review one leak, the commit can be moved to the tip or reverted.
E.g. to review: "branch: fix a leak in check_tracking_branch", this can
be used:

  $ git revert --no-edit HEAD~3
  $ make SANITIZE=leak test T=t3200-branch.sh 

Also, each commit have a minimal script in the message that can be used
to reproduce the leak.

Rubén Justo (11):
  rev-parse: fix a leak with --abbrev-ref
  config: fix a leak in git_config_copy_or_rename_section_in_file
  remote: fix a leak in query_matches_negative_refspec
  branch: fix a leak in dwim_and_setup_tracking
  branch: fix a leak in setup_tracking
  branch: fix a leak in cmd_branch
  branch: fix a leak in inherit_tracking
  branch: fix a leak in check_tracking_branch
  branch: fix a leak in setup_tracking
  config: fix a leak in git_config_copy_or_rename_section_in_file
  tests: mark as passing with SANITIZE=leak

 branch.c                              | 14 +++++++++-----
 builtin/branch.c                      |  2 +-
 builtin/rev-parse.c                   |  7 +++++--
 config.c                              |  2 ++
 remote.c                              |  2 +-
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
 16 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.40.1
