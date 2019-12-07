Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6DBC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7D8205ED
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="wnIC5j1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLGAdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:33:46 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:35043 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfLGAdp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:33:45 -0500
Received: by mail-pl1-f178.google.com with SMTP id s10so3415705plp.2
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BtRLMaegDNW+zoDqZZivxwAeliQRsm0pPccSmTfCiyY=;
        b=wnIC5j1WIdUEmjEmWA/g/6PexItc8jtYLE5hoP8YSanfNus6kLK7Uejfng5nXqgyfX
         5psjXty2mLfVO/1J16QsI0+5APMv6d1gCGqhsnfUKq+vNNu/BGThIklV8XrN00vZ4CbY
         +BZQqPHtTTeNfPX4XtiYpHyuiTy5otrvP1GLRA+19eaWOlXW1oYIeJIC++2vmO13rxt3
         lVP710fUzusTFGqfIuSvEsT1KWD6nhzakhsmsdl0roDIPlWWL1viQlrO+VV0h50Y1iJo
         SmfK9FUt82mswkhwwt0Ax44etPZVAhmC83uBIpQKaxoyWcXf6rOvYLqs4jKQN7yED9qo
         UMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BtRLMaegDNW+zoDqZZivxwAeliQRsm0pPccSmTfCiyY=;
        b=cSwgU/8gWVuApNBDHmNBJFK6gDOU/g4S7GifXDAitSnS9+rx8JpoT+aZJktvwr3tPR
         oC12KeCTrxTvsfZhwdumc194d+Wum3LkWNWlwvXPcEqePka48rcqE/2rzjPRRAFsHTXO
         p0LWgWl5jajf8jyjMzv/H2Yuf82RWhq/q1I3KX/2l6g/oPc/9zHey69xrLugq++87kfP
         pVIylKmFNQ6z4jViGNnYAodM8DyUed8uF1uoGmRnl0PASlQDhcsYHx/cvKugz0ME2xdx
         xlHHQOKXGzIJahLbSR772Ryqhy0Y2KHwjW0W/s82qEicuyVyQwFf1DMuVL86S0scXIWd
         a+KA==
X-Gm-Message-State: APjAAAXlwP2b2kN+kQIOBXykebAxhWswEh7GLpSLOJYP7DnPFGcSLBJr
        Bb4AQQwWbqzvZDg/zW2q4XwK9vX6VS7jHg==
X-Google-Smtp-Source: APXvYqwiR1KmWOCz7RfZYWnpSTjtBTRH8SA5SwjDy4XZJLtGmIu9dxX5ilNZJHGgZ/uHYJ5mpEKFFQ==
X-Received: by 2002:a17:90a:c24b:: with SMTP id d11mr19795010pjx.128.1575678824455;
        Fri, 06 Dec 2019 16:33:44 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:43 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 00/13] git-p4: python3 compatibility
Date:   Fri,  6 Dec 2019 16:33:18 -0800
Message-Id: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset adds python3 compatibility to git-p4.

While some clean-up refactoring would have been nice, I specifically avoided
making any major changes to the internal API, aiming to have passing tests
with as few changes as possible.

CI results can be seen from this GitHub PR: https://github.com/git/git/pull/673

(As of writing, the CI pipelines are intermittently failing due to reasons
that appear unrelated to code. I do have python3 tests passing locally on
a Gentoo host.)

Yang Zhao (13):
  ci: also run linux-gcc pipeline with python-3.7 environment
  git-p4: make python-2.7 the oldest supported version
  git-p4: simplify python version detection
  git-p4: decode response from p4 to str for python3
  git-p4: properly encode/decode communication with git for python 3
  git-p4: convert path to unicode before processing them
  git-p4: open .gitp4-usercache.txt in text mode
  git-p4: use marshal format version 2 when sending to p4
  git-p4: fix freezing while waiting for fast-import progress
  git-p4: use functools.reduce instead of reduce
  git-p4: use dict.items() iteration for python3 compatibility
  git-p4: simplify regex pattern generation for parsing diff-tree
  git-p4: use python3's input() everywhere

 azure-pipelines.yml |  11 +++
 git-p4.py           | 195 ++++++++++++++++++++++++++++----------------
 2 files changed, 136 insertions(+), 70 deletions(-)

-- 
2.21.0.windows.1

