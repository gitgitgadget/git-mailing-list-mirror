Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA80207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 19:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755711AbcI2TWD (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 15:22:03 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34065 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755381AbcI2TWB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:22:01 -0400
Received: by mail-pa0-f44.google.com with SMTP id dw4so16819379pac.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 12:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Oo4G8dptP8d8K5IK3PKlt/uAIFXgOrYUgorR+UFhbig=;
        b=EgulhE6C5EUxob9dy6MWPLM3y3FNsZgVH6HOaRsbUvdhSjGl6i2P+843RewHSwO7tN
         TFl18jocbbjREDywycKXHdYe+Ve718tyIbcty7A6DcKTF2hTohk9/4GnNWKTYlOzvT0e
         cLzpX52/98AzjuOKXA5vPKkjVL/GwhpqMt4txMLzb00VPLnevEM8REy702fMiT9Pb8ly
         DToWUwGsfdpaR4k3Bd6swdZg+KZHwjbE5rua7CJWyp0gB20MQAU5mcpjbn4xgFPBjswo
         O67ugOKCWO1AIJ7N4UgKhoXAXnSS48pFdnvqROQFMqCoOwS+ahJZpzJvgnfQnxHGvP3c
         dF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Oo4G8dptP8d8K5IK3PKlt/uAIFXgOrYUgorR+UFhbig=;
        b=G0COXPzQmLGVCJ+TE14ntncQxPNYwvL8S32DeZok/v9hzRNzVn4lciEhBUt6oHQs5I
         BHOSmCzJEdp0joheV2+e9kIN+t+CEd9RmuA3ux6R9uyESbWLH8ITWLYoOmwOkRR5bgIV
         6tJGmDwrc9xZ/5V2jI6t70UfkBw5g3lzd7mOtj44h/jhv+EFRV4EOpkaEEoJF6UFZTgT
         yfXPDpjRrD7WDK8s4GlfHsDBkbtb+JT0fyCFh0/NvM+MfuRwL12vpa0Y3aKkFeEptx5T
         dKCR6AwewysC3buightL8Y5sY0Mq5vGiSTmGSSsx4Rs38eNzmrnBto2btgwtKefsJtHp
         bsNA==
X-Gm-Message-State: AA6/9Rm7C6sBWuQbymLpYJUbrNBlTKcZ+Sg3qjT5Wtj+OUDoW/dsRDjvPxkcoitsPRorWPJc
X-Received: by 10.66.193.71 with SMTP id hm7mr5099176pac.164.1475176907210;
        Thu, 29 Sep 2016 12:21:47 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id e1sm22184087pap.11.2016.09.29.12.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 12:21:44 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC/PATCH 0/2] place cherry pick line below commit title
Date:   Thu, 29 Sep 2016 12:21:36 -0700
Message-Id: <cover.1475176070.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is somewhat of a follow-up to my previous e-mail with subject
"[PATCH] sequencer: support folding in rfc2822 footer" [1], in which I
proposed relaxing the definition of a commit message footer to allow
multiple-line field bodies (as described in RFC2822), but its strictness
was deemed deliberate.

Below is a patch set that allows placing the "cherry picked from" line
without taking into account the definition of a commit message footer.
For example, "git cherry-pick -x" (with the appropriate configuration
variable or argument) would, to this commit message:

  commit title

  This is an explanatory paragraph.

  Footer: foo

place the "(cherry picked from ...)" line below "commit title".

Would this be better?

[1] <1472846322-5592-1-git-send-email-jonathantanmy@google.com>

Jonathan Tan (2):
  sequencer: refactor message and origin appending
  sequencer: allow origin line below commit title

 Documentation/config.txt          |  4 +++
 Documentation/git-cherry-pick.txt | 15 ++++++++-
 builtin/revert.c                  | 38 ++++++++++++++++++++-
 sequencer.c                       | 69 +++++++++++++++++++++++++++++----------
 sequencer.h                       |  7 ++++
 t/t3511-cherry-pick-x.sh          | 59 +++++++++++++++++++++++++++++++++
 6 files changed, 172 insertions(+), 20 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

