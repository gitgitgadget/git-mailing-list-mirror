Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299FAC433E3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF3FB619BA
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhCWQkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbhCWQk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 12:40:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0E8C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 09:40:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo11209202wmq.4
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DMlwz4gT1Xev95zrHmHzwXa47Lezpv7dhcxUQQ3ngc=;
        b=sq15C5D7zRjcpPUTyO2pXOJxjRTNevpiKpehkV3W1swkw6VS7er6vREDQa30mQhVUk
         yM4AcS2YN+QGRuOmCx30WF1a22fV4lC9aBeANNmbakEClxyxQJrcPnIDsB/Ea1dDqQAy
         KisSWon5fw0uDsnm+u0HXuppkXgAbVsI0WawZcFQpUb/5I3eH6TULLPwTVfMBgP9CiR/
         i4ch93cbxmLkdN2pCWKS8GV8EwcADAE1OmbWKKXRcB7SXPOS3KZGBqJsWuuh2ffHs3Vj
         6rk3QpUv5xSbnEljwYiD8vFF8GLzcGrll/O6CsOc5xWNU0AOc2vfD2ewUim526lZKxvh
         vnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DMlwz4gT1Xev95zrHmHzwXa47Lezpv7dhcxUQQ3ngc=;
        b=hKGRPjmyBjUFiJO9l1kKiC08JRwZUDF8I7vnrjO1Oj52TOoBC1BHxAEXbXez7sAuVw
         QbeDyle1zY4ZnyjUdbKd4KvUyYkrdf4xi/C4r4eZoz3kRiQvn41lcOlfOAWlyKFcQBs4
         il+29JQbKbPndJz1r8KWE/CAgtuMZND0yvv63cEK/D1g9Lf9Tiblxty1ie/vsWcJE6VV
         6sEVG0OkW+oWVhD64l6lqVvZs0+VhnV2p+QLjx+C4VkbuOmhxMlyT5B0fm4hGzIJ5ELu
         QPa+tLGatb5mUScuFjrURoSK87XITiFFPevn28eVFzpotuG8hMmF/9EZeyRcaS6z2v8N
         dQTA==
X-Gm-Message-State: AOAM531aneguXLOd8W+80QlrXaJMmlYr7zQOjNsF40SNA8Ikz6oXLWXi
        ia0L71bReS/CG8w5dS113wBJpgKKGuk7bw==
X-Google-Smtp-Source: ABdhPJy2jJPn80YL08O0ZKNC/IYIbs4vBAmH05N6VXZbq4ferMOQUlgpRwIeII4OGagdnYt7bFxSew==
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr4247286wmj.185.1616517626009;
        Tue, 23 Mar 2021 09:40:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i3sm25037488wra.66.2021.03.23.09.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:40:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] diff --no-index: fix test blind spots
Date:   Tue, 23 Mar 2021 17:40:12 +0100
Message-Id: <cover-0.3-00000000000-20210323T163917Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.g871543fb182
In-Reply-To: <cover.1616366036.git.avarab@gmail.com>
References: <cover.1616366036.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v2[1]: s/echo -n/printf/ (and I re-adjusted my test setup to run
the linting..)

1. https://lore.kernel.org/git/cover.1616366036.git.avarab@gmail.com/

Ævar Arnfjörð Bjarmason (2):
  diff --no-index tests: add test for --exit-code
  diff --no-index tests: test mode normalization

 t/t4053-diff-no-index.sh | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

Range-diff:
1:  2dbc6c253e2 = 1:  7dd5c309a70 diff --no-index tests: add test for --exit-code
2:  a1ab6a323f2 ! 2:  e5bb094b783 diff --no-index tests: test mode normalization
    @@ t/t4053-diff-no-index.sh: test_expect_success 'diff --no-index allows external d
     +test_expect_success POSIXPERM,SYMLINKS 'diff --no-index normalizes: mode not like git mode (symlink)' '
     +	ln -s y z &&
     +	X_OID=$(git hash-object --stdin <x) &&
    -+	Z_OID=$(echo -n y | git hash-object --stdin) &&
    ++	Z_OID=$(printf "y" | git hash-object --stdin) &&
     +	cat >expected <<-EOF &&
     +	diff --git a/x b/x
     +	deleted file mode 100644
-- 
2.31.0.366.g871543fb182

