Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BF4C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiCDKF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiCDKFz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:05:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB46219F457
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:05:07 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so4783959wmb.3
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/Df1TMxSHds7LPmAJeFxvbShuw+7I7j0IB6OsO0YFM=;
        b=PF2t9FgBpPoRb4Q0H46CHi4RcZ61pSnJjfeSB/SHAooffFCeErE2Rl1eMBoHIg1zgh
         nS5Ik/hiQVI6r7mpzltsK3N+MlSNUadmKNjSvRsnuAmT6v3biqPMWbsKaoTNb2MGKusY
         Oc2AUg5MuRUStkATT9IVnGuMJlI+3SfdluIddGRpGc6dw2bwcdT2joePSS66BOsJYovd
         Ycn9h983zgGbU+Q77NQ24yutZGNwbK/0YwBlfICneOokpHihjqkNveVpyieLKqMsecdw
         FjJT4HpTAR6mDu2Pxy86DOl3EC2TjpREArs0uqu1kgVyXyRqHjARYWqQGGGSLvQgO9Hj
         lpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/Df1TMxSHds7LPmAJeFxvbShuw+7I7j0IB6OsO0YFM=;
        b=TryuMzsE9TFJwUak5vtYW02jyUSMyfQ/rr3Q7FbQxgFYU8BoTtferv5NGZCRxDQajE
         Lc6xXWlp/4lHhAiV+9AlzZOUEOpWL+eXtd3U8j3lBtT7v2wILgJ/ZW8OFE9i++Vdwwss
         3SQgjD9BCcHrHU/r3DhlNsm+4Nmpa4fZ0UiEFNHHVnZXfvkhGj5xC+Ttwgnap1dzz5Tx
         HA5buKZ7Lkr3Jt8dQ0nNXaDVYAiGQ8CBEj4L1Ce0wnQ/+JAlEOpvcRBQ/JQlWT86Wo3P
         PPgV88Tb+KPcR9FHjMysT1cKeCq0ELYXLVlwgzr4OEN8FOcLAgAc1BoNjWnmshwKhM4Z
         zSwg==
X-Gm-Message-State: AOAM532t94g0mZl8Xt9t/LOAcq+a+A1mcGR+KuEB1sVu+U0/KU8mL17S
        y7eHx5IEy9KR3nrVFSbWx8WAO7sa3jHoMw==
X-Google-Smtp-Source: ABdhPJwOSSzgszHZ94jXQbSL8PbrLNu1HtSQpIchvbOFZsa/2/xozbreuMDSTEJl7TL9f/IYajX8Zw==
X-Received: by 2002:a1c:f018:0:b0:37b:c13c:3128 with SMTP id a24-20020a1cf018000000b0037bc13c3128mr7066466wmb.157.1646388305441;
        Fri, 04 Mar 2022 02:05:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id az37-20020a05600c602500b0038144e509dfsm11141690wmb.20.2022.03.04.02.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 02:05:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] log tests: fix "abort tests early" regression in ff37a60c369
Date:   Fri,  4 Mar 2022 11:05:01 +0100
Message-Id: <patch-1.1-3b41c1a26d4-20220304T093323Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1230.ga6e6579e98c
In-Reply-To: <20220304085719.yht6hiuybhgfd6vo@fs>
References: <20220304085719.yht6hiuybhgfd6vo@fs>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in ff37a60c369 (log tests: check if grep_config() is
called by "log"-like cmds, 2022-02-16), a "test_done" command used
during development made it into a submitted patch causing tests 41-136
in t/t4202-log.sh to be skipped.

Reported-by: Fabian Stelzer <fs@gigacodes.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Fri, Mar 04 2022, Fabian Stelzer wrote:

> After rebasing my work from <20220302090250.590450-1-fs@gigacodes.de>
> on master I was a bit confused as to why my tests in t4202 were no
> longer executing and none of my changes did anything about it. I
> suppose this `test_done` is left over from testing and slipped into
> master?

Ouch! Yes, that's a rather obvious stupid mistake of mine that
shouldn't have escaped the lab. Sorry!

FWIW since we haven't run these tests in a while (not too long
though!) it's conceivable that CI would fail on them, but in addition
to passing locally here's passing CI for this change:
https://github.com/avar/git/runs/5420131756

So we should be OK with this change.

 t/t4202-log.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 55fac644464..46e413bcc93 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -484,7 +484,6 @@ do
 		)
 	'
 done
-test_done
 
 test_expect_success 'log --author' '
 	cat >expect <<-\EOF &&
-- 
2.35.1.1230.ga6e6579e98c

