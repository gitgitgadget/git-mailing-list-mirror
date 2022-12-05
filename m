Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98980C4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 13:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiLENfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 08:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLENfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 08:35:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45831B78C
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 05:35:36 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so11450211pjo.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 05:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCFO1x6Bc7BIDIDQT1yaBQ9Qa7HW8XGblttR0iNvXko=;
        b=ebqriEvrNNyqsANgsEzez4CpFAZZhZCAK3Q99atn0d+ubGQl+GiH4ZAR/ezERjVfnX
         pFW0xAt3SzY/rzxu2XFh8c4nuACTwF41BLdZQaVY6vhbemtmE5h/wxODSi9E99rZud2a
         xAZb8qlCwygGQHuVyRR4PDRWCkfYSa8tcZZf4udVhQ1is+Obnk4o7y1i8CBfvstGXQjI
         i6d0DMGhMmjXe0MDBJ0lWs6qNIZzQc/0gUkeYQKdINK7EOPpT2ywnbJi5bPEZNq0DuUp
         wcJjObQISlk+4Al0t1v7IXW+HFC5qZDXLZYtoOrNutA0FNzvOZnIM36IYhwD3vuPMAcO
         J93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCFO1x6Bc7BIDIDQT1yaBQ9Qa7HW8XGblttR0iNvXko=;
        b=vH5CKYFZ7QcZGskioxGxUycVagmJyw1la8VsDaMl9R3GNb61hH8fGfFlDwzIaO+waC
         QxW5gr5qDAj8DLxdy+X483V3TBQP613iE93F5yiWCqAUi3bf6AkM1riYdCeXzDhvAr3n
         3Tz3MhLwq1vldKmj9MNZL50KiI8svPMCJ+vCbiykVU0hA6afdmP7m0lNRcW998NVB9Gz
         +LO52b0aMjUWL212+VsS2XAAAvHG0M3Op/BkOmouCNFn+ZfRUfC3Qjygp43Ljc1AxT3Y
         fO3MKXkI1FhXkNZjScTUZrZvDVt6ahJqho4flPhQk23FNR1DHOtr/uVS72yY8kR6x5pe
         S+pg==
X-Gm-Message-State: ANoB5pmKqkeS3XhDv6XOhOwjfpe88wNSgiYy/Vzejp5qFmC4RVILHh+T
        iRDWnZvKBu6Ndo265CwuyoA5emhD/98U2A==
X-Google-Smtp-Source: AA0mqf5F3TV0r2Sm4MgKSuWaMBICmMUWZ2a/JErOSdpRbnll0RFmf5ppmQzA4VUXb91eHlJQviFIug==
X-Received: by 2002:a17:903:22cc:b0:17e:539:c405 with SMTP id y12-20020a17090322cc00b0017e0539c405mr64546839plg.53.1670247335730;
        Mon, 05 Dec 2022 05:35:35 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b00186c3afb49esm2386636plh.209.2022.12.05.05.35.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 05:35:34 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     --cc=avarab@gmail.com, tenglong.tl@alibaba-inc.com,
        me@ttaylorr.com, Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH 0/1] push: introduce '--heads' option 
Date:   Mon,  5 Dec 2022 21:35:24 +0800
Message-Id: <20221205133525.60464-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.rc1.5.ge01d593fc21.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

This RFC patch try to introduce a new option '--heads' in 'git-push' subcmd. The
value of this patch may come from my personal point of view, and the patch might
not have enough tests so far. It's pleasure to hear any suggestion, test
scenario which need to be covered or any test method which need to be noticed if
it's worthy.

Thanks.

Teng Long (1):
  push: introduce '--heads' option

 Documentation/git-push.txt |  1 +
 builtin/push.c             | 13 +++++++------
 t/t5523-push-upstream.sh   | 19 ++++++++++++-------
 3 files changed, 20 insertions(+), 13 deletions(-)

-- 
2.39.0.rc1.5.ge01d593fc21.dirty

