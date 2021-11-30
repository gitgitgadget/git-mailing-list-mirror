Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E3AC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 04:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbhK3Ens (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 23:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhK3Enr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 23:43:47 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04955C061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 20:40:29 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z18so24428385iof.5
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 20:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VhuGAvcxG2oBXTPCdcf5zBFueLoqeQRfIqDi0qQ96GU=;
        b=p37Xx7gUovHkgkyj5IMSlTz6D+0ocf5z6H7EOahYJce+2++6LHnH9wip243sL4t58N
         r26E+4iWC7UBfqucEYY7FmOM8AeZivS47EqnKvPrg9A/9FVqe0pfXiPUz2Vc7Ql4eIeE
         mfkTIpugBm24yxQ2ZU20eZVrBtXUTesl/k1eU7VdLw1WAwshgC6VKV7edYnM2qUF7mYJ
         SowwuNIGl4LaTrMYo9sP838zzpTOJM1Rjxz8A7sgqp1Ztq/jZ+mYfTK2GNoHDY5mMHWg
         yKG2IJXlwtXvGmtHMruZ33MqOzqyLEiQqsCYlSfemBVya5JV1HC63/AX7kUSDQ42ENiP
         KaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VhuGAvcxG2oBXTPCdcf5zBFueLoqeQRfIqDi0qQ96GU=;
        b=e/2cOrPV/BmBPIZ8UTR/PO2gDVzPTr5xrxaM/rKArqHAL0XHVzr0o7WBBuvGreTCyu
         N/9dLLyx1A+EV2Nv015qXbP9Prd5Cd7ji8cL/6qK10k5GHakBz31z2I/7bNzzmbCsG/F
         /VOWuJQ21mPvWPrM9sPqcipTH9o7L8Pk9uIuROmx82kH/m/LQ4SsJUXSzO/EAhfW2SZU
         jTQFsetgEdwIAfFpK2CXtNlFTgY9WFvEWQfZbrroMmQtGdIV2ZpRp9tBsTaj0hI/1y6F
         T4GWniROAY+aiswPP8+xmKzd/O2EBP8icT6nIyB35yTVNl1imESTtCIHMqMZ2Y2RDNo4
         ZhTg==
X-Gm-Message-State: AOAM532QoKcR2IjFTtrUo1hX3sZJASGOuWygAXMqa7lSzemVxKmVfc+z
        4k0UcNv4Y/t1ig6tZy30RCC4r9MgRWJyoQ==
X-Google-Smtp-Source: ABdhPJwj6cHx8nWHhEQjL19DsSL6sc8sQQ/rrAJk2vagJy55Z0m4PEcP7A67LmDnOevOFA1wU1wJZg==
X-Received: by 2002:a02:a91a:: with SMTP id n26mr69550985jam.46.1638247227977;
        Mon, 29 Nov 2021 20:40:27 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id c2sm9443985ilr.70.2021.11.29.20.40.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Nov 2021 20:40:27 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC PATCH] vreportf: ensure sensible ordering of normal and error output
Date:   Mon, 29 Nov 2021 23:39:46 -0500
Message-Id: <20211130043946.19987-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.75.gabe6bb3905
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The order in which the stdout and stderr streams are flushed is not
guaranteed to be the same across platforms or `libc` implementations.
This lack of determinism can lead to anomalous and potentially confusing
output if normal (stdout) output is flushed after error (stderr) output.
For instance, the following output which clearly indicates a failure due
to a fatal error:

    % git worktree add ../foo bar
    Preparing worktree (checking out 'bar')
    fatal: 'bar' is already checked out at '.../wherever'

has been reported[1] on Microsoft Windows to appear as:

    % git worktree add ../foo bar
    fatal: 'bar' is already checked out at '.../wherever'
    Preparing worktree (checking out 'bar')

which may confuse the reader into thinking that the command somehow
recovered and ran to completion despite the error.

Rather than attempting to address this issue on a case by case basis,
address it by making vreportf() -- which is the heart of error-reporting
functions die(), error(), warn(), etc. -- flush stdout before emitting
the error message to stderr.

[1]: https://lore.kernel.org/git/CA+34VNLj6VB1kCkA=MfM7TZR+6HgqNi5-UaziAoCXacSVkch4A@mail.gmail.com/T/

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is RFC because I naturally worry about potential fallout from
making a change to such a core function. I can't think of any case that
it wouldn't be advantageous to flush stdout before stderr, so this
change _seems_ safe, however, it may be that I'm just not imaginative
enough, hence my hesitancy.

 usage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/usage.c b/usage.c
index c7d233b0de..0fc7640b25 100644
--- a/usage.c
+++ b/usage.c
@@ -27,6 +27,7 @@ void vreportf(const char *prefix, const char *err, va_list params)
 	}
 
 	*(p++) = '\n'; /* we no longer need a NUL */
+	fflush(stdout);
 	fflush(stderr);
 	write_in_full(2, msg, p - msg);
 }
-- 
2.34.1.75.gabe6bb3905

