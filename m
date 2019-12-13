Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB94C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8AF227BF
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekgK+X10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbfLMApC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:45:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42666 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731160AbfLMApC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:45:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so598234pgb.9
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiQOqQ+8qyOTJY7OJHhRpFbE2FiM8iJ1MxMtey5nAiE=;
        b=ekgK+X10x0NfL77gyhr2NCSgg8w6FZVUyA+P3lRsIVRplTuWr8YhAE2PFtCR6PTlmh
         mWaxKSQcLmKmJPBfujMhBr8MUHzCQiC87TjvguQ2wWbWWeSXjnCRuFH9KSTN2Dy7+CFz
         SN0XZkCTWUiVyZKTacQ6CxSQ89RsjvbP/zD3BGm77h+Jjs6Kr4DFTaLyIf1YyKXKhdik
         BRfLeHLZqzPZDEtIoNOwRdf8K3VHX+HVKXI3ScB/4n/Hv/vCHYMsFUs2Oer77G4EEnn0
         lwv37HAlda1qJ04hv8Xy6FWBdDrmx64kvGtMN4gR2q+JZC92ga3sCOoCsKWsUc9QJqNh
         kKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiQOqQ+8qyOTJY7OJHhRpFbE2FiM8iJ1MxMtey5nAiE=;
        b=cAsu1zgj+Z+1sHv84595/M77T0Zy9yqcM0M6K5pIPGfQ8+NTt/0EW86eJ4WA+m1djJ
         NP4qEKYOOhy5TgH+1sYL0fZy1Rc3Azxz4/qfiWvBOBeu5yQ0dOKGhRZpqFTUw2OeXNsS
         eA1/XIZQ8DfKHRx0SxXo1h2JYEmETue5IkP2FNaDNeuWheK+uTJe4e85BtGRCfDdgVmW
         TSeYLvrZezQ4DYBxB/BtGftOx4vyMsrogrrEn64VRD6uDVjlcoVNxpHlclkz4Xb3E/Jz
         qkyU5kP4P8rg//SmXC1xTa5qI0rhQD/bb5BGleMyyJ0u40raRO8lyT/6snyJHCUlZwFa
         FTgw==
X-Gm-Message-State: APjAAAXE4fkzt8EMjYAnzd6gF+MJ5Kll6MH/lcWQJeSWvx8z/SmdUVRe
        0uWBGZrfIuWK+f067xfwHD+8cJjs
X-Google-Smtp-Source: APXvYqzdcumP9+rCO92xO8PfE8Y1JqWtwvRgPvhDUIytu3k5apbGNZqR7LI7Ht0S65/aurSH5s4OGw==
X-Received: by 2002:aa7:9510:: with SMTP id b16mr12891507pfp.65.1576197901837;
        Thu, 12 Dec 2019 16:45:01 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id g17sm8995626pfb.180.2019.12.12.16.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 16:45:01 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     Denton Liu <liu.denton@gmail.com>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 0/2] gitk: match Git's 'reference' pretty format
Date:   Thu, 12 Dec 2019 16:44:48 -0800
Message-Id: <cover.1576197846.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.664.g198078bb5a
In-Reply-To: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com>
References: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently, the 'reference' pretty format was implemented in Git, which
has the same function as the 'Copy commit summary' feature in gitk.
Since Git now has a canonical way of doing this, update gitk to match
this.

Beat Bolli (1):
  gitk: rename "commit summary" to "commit reference"

Denton Liu (1):
  gitk: drop quotes in copysummary format

 gitk | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.24.1.664.g198078bb5a

