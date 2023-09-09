Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAF8EEB58B
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 12:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244357AbjIIMzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 08:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjIIMzH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 08:55:07 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10071CDE
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 05:55:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so47896721fa.3
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694264101; x=1694868901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIzbCH7upS5tmj+ryyfK3md3MNmYj1nkHmQM8nhvDzI=;
        b=JLKRWyf7BTy9TMQFul59doiaFHxK6fSOjYVsIBj61FOtWGk7v34jVRiOaw34UZ2+ZD
         jk1c+9sVC6aj8Q+MRC9WGtZeg0O5W7MOYNFqFtui/DWCswBn8IWTABgAS5QuORBS4a4S
         lUF/f7tBJ3UGSJw80bpG8Wh6yrjWfhSPSRsRThPPqfEzIwYQwVDBidL0InD8XhcAy9UI
         Fa0Y8qpCFc+OjKF9x6N3nux1Csd10z7VTyQC/ABCccDIha+J2nEbdU4rTqkJRjxduHou
         QhiFZWjh9scy3Q+IOHiZKenRC5cl2B00ryb4zHK7JUYK+dCiCgRhTqTF/ibzIgXKRtdK
         gBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694264101; x=1694868901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIzbCH7upS5tmj+ryyfK3md3MNmYj1nkHmQM8nhvDzI=;
        b=CYF89x7SCMA33numfpCeSIhu4NhQz4xmJZrVsDsynJ7iKviFgkujnVfO5q9dVPVmpw
         4w2PXAMrPN58gZDCnc0zTS3uN8b6tgv3y5FdNDNYBvWEuuqutyuZCt9RMnO9zfK5Ehsd
         Vh0MrwlB0VeEZQIaMOrVM4CGllNtZj50trprWNiZic5f6MxagBhSfrAxNizvXSEa6s3t
         ov+j3Ljr8c5dy73gJxkQVxkwYsfoGAyvI8C97aHRplS5zZN3Vo6cxeihrDWIkLDsn9b6
         7+qFlUhdbw5iRx226REqnbk075zSjGoEN0/4DwuOpYi9nr8Xsrofy/TbAVHl/UbhEGqC
         ed7g==
X-Gm-Message-State: AOJu0YzPniA83r+tw/qM3N0VLl3CaI3/n3K+hAP+D8Z6buUWtSpxQGAw
        ymnj+VaVdCHIELujYMxGvwQ=
X-Google-Smtp-Source: AGHT+IF75/luerKU9iGAYk+Lzf6auxmzkZsTM7WG3xUcykaOHGrNjBPqMLwo4GPv3V7F6vDXmp3vog==
X-Received: by 2002:a2e:9d19:0:b0:2bc:f41a:d9bc with SMTP id t25-20020a2e9d19000000b002bcf41ad9bcmr3808287lji.25.1694264101016;
        Sat, 09 Sep 2023 05:55:01 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9dc1000000b002ba130e9a29sm649871ljj.76.2023.09.09.05.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 05:55:00 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 0/2] diff-merges: introduce '-d' option
Date:   Sat,  9 Sep 2023 15:54:44 +0300
Message-Id: <20230909125446.142715-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new convenience option requests full diff with respect to first
parent, so that

  git log -d

will output diff with respect to first parent for every commit,
universally, no matter how many parents the commit turns out to have.

It's implemented as pure synonym for

  --diff-merges=first-parent --patch

The first commit in the series tweaks diff-merges documentation a bit,
and is valuable by itself. It's put here as '-d' implementation commit
depends on it in its documentation part.

Note: the need for this new convenience option mostly emerged from
denial by the community of patches that modify '-m' behavior to imply
'-p' as the rest of similar options (such as --cc) do.

Sergey Organov (2):
  diff-merges: improve --diff-merges documentation
  diff-merges: introduce '-d' option

 Documentation/diff-options.txt | 101 +++++++++++++++++++--------------
 Documentation/git-log.txt      |   4 +-
 diff-merges.c                  |   3 +
 t/t4013-diff-various.sh        |   8 +++
 4 files changed, 71 insertions(+), 45 deletions(-)

-- 
2.25.1

