Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C787C636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 14:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjBTOZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 09:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjBTOY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 09:24:59 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703ABCDDA
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 06:24:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso1994156pjb.3
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 06:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OW4zrVZ+9QT1eRYfiuVKXt4R4oLH7kjlPyJixsZleS0=;
        b=jgEaBjdLwWnUowkQbpiMOneRrmoNjPW+pYM7+rZZg9BZkcNeHkQJQlCeE/YK2CCUd/
         Jmyv7+wJCFh8FEBq6ma9EJr4DwHds4/qUlNyW4BdcbDmRnaVE2nb7kt40xGSYWXBrpaD
         ioxWcmD8aGlGvD1gSiDsQmhZXTLOH4S/EztUY0ek0MbXUTh9At8Ba0jl2QjAOfr0OJjS
         Rej+jLrUfP0IUzSZWzBsWJQdN//MwqjoLqhLxXsS5AkL/ct/XfLxAZNzIhOEhohxbNq2
         NhAaA91dFlcYpuK2SvfzC/KGY7M2t+i7whFshIriISr9MG007VzSGjRd8c/K4CxEQHc0
         C7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OW4zrVZ+9QT1eRYfiuVKXt4R4oLH7kjlPyJixsZleS0=;
        b=c1IeCmJe9uqrvf3kNufDtumdYkIDDvEbQRiowXft87uxcwlI+btqzzWBpt4T08ZSYd
         N2zMIFMJJtOLSzUGvCNqkQA4kdHJ2gezGGFEbnMFLZdHfOArDOSOw/iu12q/JTvtAC+2
         oa1UCMXun5TLA4P17gHKah5OHqBnVDQy5+7Qae27xRB//OnBdbijvZ1tOETnNs8rbGAV
         Gb4iZ6o4EcuQbR9pGBrGqsjxYHZHgx0fjnLctgYt90foJez+RvCaUDNlnhl2MwSVGcWv
         NHlSq9M+J6r8FsZwOMw9GllKad7polpEsYpVUGx/e4c1CXWZINA4ELG6JSxupkYubQ00
         yPpQ==
X-Gm-Message-State: AO0yUKUnig7PRSlDDjgykUrG+F0P9fEVV21z3o28ZnvSYCcTXUKm5vi5
        GHD0AU8RYlTDsunnE571ShMYj3lgLyMp/WXG
X-Google-Smtp-Source: AK7set9LVyGh6qM5/jjGJ2UCQlJChUB5s/8DRdkXYP1jissSpS3kbZyLgDKAiWedAK8jq/bF5Nhocg==
X-Received: by 2002:a17:902:d2ca:b0:19a:e762:a1af with SMTP id n10-20020a170902d2ca00b0019ae762a1afmr3019041plc.33.1676903097574;
        Mon, 20 Feb 2023 06:24:57 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902ec0100b0019ac7319ed1sm8031595pld.126.2023.02.20.06.24.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2023 06:24:55 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, --cc=tenglong.tl@alibaba-inc.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 0/1] range-diff: let '--abbrev' option takes effect
Date:   Mon, 20 Feb 2023 22:24:43 +0800
Message-Id: <20230220142444.18739-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.2.459.g1d9d282d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Let's support --abbrev in range-diff output.

In some other sub-commands, there may be similar ineffective
situations. If found, it will be continuously updated
in subsequent patches.

Teng Long (1):
  range-diff: let '--abbrev' option takes effect

 range-diff.c          | 11 +++++++----
 t/t3206-range-diff.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.39.2.459.g1d9d282d

