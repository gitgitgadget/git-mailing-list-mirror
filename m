Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F96C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE5E206EE
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="chqWqT3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLMXxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36620 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMXxU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so258441pgc.3
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPIkhEutB6WFKRyrcZUK8/1eqfpdrTLaoz9DAB/g5e4=;
        b=chqWqT3jc6HUbDvZRbAgTyotNToIMgF20KxHd2Z7Z0XgT684dQLkWeMN/2Z5+sTsXL
         UFhJgxbwSNXp8Giwe8fEHO+Vt9gTrMq73yZlFhzYmt53WkcqguzCna0sRM55a8MccxS6
         w5076KICzZRtP4ozSbzF2wk82Q3JNneu39bVZqBpcJiwdPS8C4nFVdnr6MM4LS89WHEk
         DsE6tbB1aWVocUh4YT5eZk1pCr07A6hcBKIqyKtLkd3CiOTjb3BLDvzvsumsHsqEkMBD
         U4QZIBg1EpOLSDBgNwV8ewf2e1vl/OrKk0kdqXG219CTg7wNWV64lSDnfcKXlwV9FdX/
         7gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPIkhEutB6WFKRyrcZUK8/1eqfpdrTLaoz9DAB/g5e4=;
        b=ds9bnMhJ5KrlNVhfnAyL9du9nwWLip4VdMdb0duPVv2FIGOl/qiRSYgA07rIaNnAMC
         3+Cj8WwS4dNP6h93tu+CDVQy2S9hXoDiNqL4+h1GMp9I+MJnmE0hBQ6Gwy9K6Jt7++El
         b22aXGoFMBmTb8CVlZpdlQaj0AJ4HdQAl9yri1FDI2duRHN23JiBNf2MtGGRPr+ifB8k
         sxbSTTKRWTg6IWuylWnAUxieO6MJB1NWq3q1PyzARneaGQAh6lzEr6V2bpt0hUHOjLab
         CVQA0Z6UaSqg0AfwmWPM9oHiLhm4uwQReRa+sXkLbR6Ngz/bslYaEHflpJfOvGueOk4i
         /NRQ==
X-Gm-Message-State: APjAAAXKquka6PEu7OhJX8JgUU3CLxppwqLkeoLH6OfH+aMHMR2GsSu8
        /LV5vzNl1gF9INQU+yeCwwZfE5I3eKrGNFCW
X-Google-Smtp-Source: APXvYqyWWv+9VJ0m6IPycMjH6mIzMn5W93KMQS8UVIKOdaKmaxZmeqFsLfz8LMGoNAUq5DulRuJ0WQ==
X-Received: by 2002:a63:6b82:: with SMTP id g124mr2440654pgc.418.1576281198977;
        Fri, 13 Dec 2019 15:53:18 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:18 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com
Subject: [PATCH v2 00/14] git-p4: python3 compatibility
Date:   Fri, 13 Dec 2019 15:52:34 -0800
Message-Id: <20191213235247.23660-2-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This patchset adds python3 compatibility to git-p4.

While further clean-up refactoring would have been nice, I specifically avoided
making any major changes to the internal API, aiming to have passing tests
with as few changes as possible.

CI results can be seen from this GitHub PR: https://github.com/git/git/pull/673

Changes since v1:
  - incorporate Ben's change on dropping usage of basestring
  - don't alias string types based on python verson
  - use feature detection instead of version checking to detect python3
  - CI patch now at end of series; needs further discussion
  - some general clean-up to commit messages

Ben Keene (1):
  git-p4: change the expansion test from basestring to list

Yang Zhao (13):
  git-p4: make python2.7 the oldest supported version
  git-p4: remove string type aliasing
  git-p4: encode/decode communication with p4 for python3
  git-p4: encode/decode communication with git for python 4
  git-p4: convert path to unicode before processing them
  git-p4: open .gitp4-usercache.txt in text mode
  git-p4: use marshal format version 2 when sending to p4
  git-p4: fix freezing while waiting for fast-import progress
  git-p4: use functools.reduce instead of reduce
  git-p4: use dict.items() iteration for python3 compatibility
  git-p4: simplify regex pattern generation for parsing diff-tree
  git-p4: use python3's input() everywhere
  ci: also run linux-gcc pipeline with python3.5 environment

 azure-pipelines.yml |  11 ++
 git-p4.py           | 237 ++++++++++++++++++++++++++------------------
 2 files changed, 152 insertions(+), 96 deletions(-)

-- 
2.21.0.windows.1

