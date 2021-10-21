Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BC5C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC6B61359
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhJUW14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhJUW1z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 18:27:55 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ABAC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 15:25:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id o26so1218499ljj.2
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 15:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWWd20W8U2vka0WkSPATTJPy7EScBF/VoyhRAy11TKQ=;
        b=keOSSgW3FutbNZGiChAbz51ka8aKDDZeFNVgCU/ZKpEHBIpipiPiqEc3rsBSf2ixln
         nuGRkKC3r5zCe3MYrOrIYlAoY8EiQVDYqMrqbtEzS+g5dcVKCZpL9APwBaWPAHiwPjcn
         K4zmpP4WRZzVeFr0pzxBXqNOSr64yfk0dDzW4e3/TdGH3QlviUD+1rNCcLqGyucCsRnC
         eX28Cpqijaq7eiZp88aJ2D22Kbc+SW13D2sSBm05Wqm2vh92f+Rvq4K+QZF7cD9l8qZf
         HHxeK6E8ZoH9xTN7OV0EdO6AFwsr7zdVhK+cwLpRcrb3kfJmcAV9qNVAo7y4mMADO8W4
         YXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWWd20W8U2vka0WkSPATTJPy7EScBF/VoyhRAy11TKQ=;
        b=QvGa2GLIhoSHnJmD4Ols8UJlessx4drKuYkGPGyzW38k3JPBa1nCdx1l4iTUP+xLPf
         /HyTB8mKXplo1l9e7BbjLRqcgaC0nnOGauSHAcEPvoKsRFs7XmL8nLoOKF6e2AGQsJkd
         Hz0a8tLB9tqRpEkSUWZj5PW8rwWzo5tL/Csu8WYXygH7v4M3zYZgAwkUvfPXYaOi6r2o
         ynSEzlZQ0TvGq3v+E4r19Er9gBc1p/GqF/fROyjfcgikQ33Iko7DEN9kpmtm0gpU+Ncp
         tBGYYP9m9nhMq0Q+ZJj8mNyqqRygVzvc7vLxiNAX2ZmjiAEPozFgmbGoyRUK9qGo6lzV
         3B7w==
X-Gm-Message-State: AOAM533TbREYfBMW3N4V0T++6HULG7cUEvRNV14DMwZypIjqWVttyge/
        2uxv8PZVzT9DGrk6p3KZa1Ds5RzJtzn8vA==
X-Google-Smtp-Source: ABdhPJyssnD3ZK8ZGmXCiMc7xAs36JY9eBMXfHJFy3G3i5PqZoxFRwz5tTZU+O0mPom4kzGV9+dCdg==
X-Received: by 2002:a05:651c:4c9:: with SMTP id e9mr8834427lji.272.1634855137240;
        Thu, 21 Oct 2021 15:25:37 -0700 (PDT)
Received: from paasan.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id o22sm608875lfr.250.2021.10.21.15.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 15:25:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH 0/2] Print stash info in the v2 porcelain format
Date:   Fri, 22 Oct 2021 00:25:30 +0200
Message-Id: <20211021222532.463375-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When --porcelain=v2 is given --show-stash is silently ignored. But the
format is useful for quick gathering of repo status, for e.g. prompts.
And indeed git's own git-prompt.sh supports printing a sigil when stash
entries exist.

The first patch is just a very small refactoring. It's far from
necessary (although as it stands the second patch depends on it) but it
makes sense to me. The second patch is the one that counts.

Øystein Walle (2):
  status: count stash entries in separate function
  status: print stash info with --porcelain=v2 --show-stash

 Documentation/git-status.txt |  8 ++++++++
 t/t7064-wtstatus-pv2.sh      | 15 +++++++++++++++
 wt-status.c                  | 25 +++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.27.0

