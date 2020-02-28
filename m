Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD201C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 15:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13EB2469D
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 15:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZxEHbtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgB1Po2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:44:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51445 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgB1Po2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 10:44:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id t23so3679266wmi.1
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 07:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQHwYPCUJsNG0lGsjWTF2YbtE6QCzTVF78AdmPk8gA4=;
        b=JZxEHbtCwZY6xz8HA6Kghm8RyLuAuJ94pc3KbYQfOYMI8V7+0oqeXUA0HPiBlxL9at
         1YCpFtqoIsq5m5YVmTRe3FgJiZrXVKXAdpmZ+ZLGwKHCUoSfbV/QOdZNmMxMoSWNCQXT
         K+SvAlci0fCYT9FYDgS5ADMR+7A7cfOa75ZTpQIDMQOHm2VUy3Sz9fYYSYjAUQGsa7hk
         cwBRAs4AwPbOVCR2orqrBipzzAR0ol6MvgiMlS6vee9rl5BZRe3PnNQ/0HuebwlG3Mic
         tJxUS2+IaWq3D3smzz07Kol3cuAynEZHhV1wWTOpqxiprsNK3ZvpCt3xM0vz1gl+GYK5
         6fGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQHwYPCUJsNG0lGsjWTF2YbtE6QCzTVF78AdmPk8gA4=;
        b=S7N51Hy6MbLiGokakrGGKaXZmnp+lF6JEi/rgnhQ5BGapegsKMuKT/tu0hAqOUCRd6
         n6BJ6olYqblysYoGBI4IGrTUvw2m2n3oUnc+XcIrHC2/i3l0Ll9MRLgYjKLlYrACnUb1
         fsEzs4qNpKaawe5mYBOg34DphoTT7T9LHHQgx5r1T7L/9l9m+KqU2CPdbQdCgZrhi+rj
         WkBE6+aK6g3ongGPKCSBaqS24jSBwy3zIFBFOrFe534Fm4/1RC92Ex/zKVe4PCGfWUkm
         UnLvxp0EVu/6DcGc/PEmKw7iLwl1Wn29WWgG9tqd7sFkNtdBcem3TOlaOCxKrc9zzeGD
         CLdA==
X-Gm-Message-State: APjAAAVp7qzxcdSJxHNNdVx4Ho7UFFFlMITsJQHe6nHlgmIs7krlL9Gw
        NxQ3PWXmfRbU/LznGGUuPEbUnuekNSc=
X-Google-Smtp-Source: APXvYqz/8Cj01yrg1LR4yBkabtduwCt+ah3O5H0M/COOU+jziTYgRVh3c0gm+1SsDwd3v+8oVLmOFw==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr5365638wml.55.1582904666660;
        Fri, 28 Feb 2020 07:44:26 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id z6sm12815549wrw.36.2020.02.28.07.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:44:25 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH 0/2] Documentation of pack and repack
Date:   Fri, 28 Feb 2020 16:43:55 +0100
Message-Id: <20200228154357.1710521-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch update the documentation, the second patch is a small clean
up I found when reading the source to try to understand the behaviour of
pack-objects when writing the documentation.

Damien Robert (2):
  doc: update the documentation of pack-objects and repack
  pack-objects: change the name of add_objects_in_unpacked_packs

 Documentation/git-pack-objects.txt | 27 +++++++++----
 Documentation/git-repack.txt       | 61 +++++++++++++++++++-----------
 builtin/pack-objects.c             |  4 +-
 3 files changed, 60 insertions(+), 32 deletions(-)

-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

