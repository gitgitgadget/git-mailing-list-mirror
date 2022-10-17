Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C5FC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 12:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJQMJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJQMJd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 08:09:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54B510B73
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a10so18081172wrm.12
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr3rsmznHuIRnlyV5tKdPVFHEvV2rpaU/ldQlVxWV9Y=;
        b=L307Uj7Fz7JZ3hbTHLgY8wf0n5UNs1L0ct4TrXmMcRSnltHk3GTSt8zjKprT9i3dK+
         rs4HqCgt1w1erkumDQX53DDQKlh9aJkB7kgDNOz4AGKmk5GNRQTibSYBG3yEopwEnb+m
         WoSr5Xe16QmcNVRVUsEM+nPINLKEflPJYhy+2Uw/7j0NqOUO6qEHdWAzc7e/SJzE5C8v
         paJf5RhrS8hrtkSqjXGCL603NaJeg8zB1ZRqhvQ9vS5I2K/IocVALDfoYC55eI+w9stb
         Ho+zBhRm/MydzPlKHpWVjN/PHfM+0U0VoVW1gqrEnmvpiOMbhK2K+ZFZeDB6AV46YFJE
         hCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr3rsmznHuIRnlyV5tKdPVFHEvV2rpaU/ldQlVxWV9Y=;
        b=Ft+e71/r4XCZQ8VbnXzAQhowbdyF80Tli2WJjd533UvFBvsaS2AmzlwQpMiUVrfV0+
         VohBYcHttLFIQxfOby6unOVaM29HycGuBIjRNs8LZ7QXmA5N0VqXp1DaneNXnuVrWujV
         xAlRC53qs9DDyreUY+sHCYwLUBf5jd2z2pmEdwnkPvShyY3XmGx2YGX8xBDkLERDlV1P
         RSSRztF5HsrIjSSY71KSZs7HK9rFR3n33x6kNVsNnrf8JtQmxdFypFACkfw8sV0dkW/C
         8ErFczoF5Ft18C/YpIVNx9nbPVKjN60TwvYiAuqK62/5riqe3Oc+LZ061MTtD1KVshjx
         dqYg==
X-Gm-Message-State: ACrzQf3WfPJ2zLvxrbVFC30lt+1cV+967+/8Q8cpp3wf4qXestM7M1+f
        u2sp2oUSCIr9zHcBQAHfqxHn+b3++5Dv/A==
X-Google-Smtp-Source: AMsMyM5utm8nOpLamO/fTHpXcekbo9R/4PEXQ9QpsN/voOwhiLN9QMoMW0TvD+T0qtdfrzb6QLtZqA==
X-Received: by 2002:a5d:4dd0:0:b0:22e:33dc:3bf3 with SMTP id f16-20020a5d4dd0000000b0022e33dc3bf3mr6199378wru.214.1666008569854;
        Mon, 17 Oct 2022 05:09:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm10028770wma.45.2022.10.17.05.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:09:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] git-submodule.sh: create a "case" dispatch statement
Date:   Mon, 17 Oct 2022 14:09:16 +0200
Message-Id: <patch-01.10-2379d5dc0e0-20221017T115544Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1091.gf9d18265e59
In-Reply-To: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a "case/esac" dispatch statement at the end of git-submodule.sh
and move the contents of the trivial cmd_absorbgitdirs() function to
it.

This template will be expanded on in subsequent commits, but for now
we're moving the trivial "git submodule absorb-git-dirs" to it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5e5d21c010f..b851d64aa62 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -555,11 +555,6 @@ cmd_sync()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
-cmd_absorbgitdirs()
-{
-	git submodule--helper absorbgitdirs --prefix "$wt_prefix" "$@"
-}
-
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
 # options are primarily done by the subcommand implementations.
@@ -608,4 +603,11 @@ then
 	usage
 fi
 
-"cmd_$(echo $command | sed -e s/-/_/g)" "$@"
+case "$command" in
+absorbgitdirs)
+	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
+	;;
+*)
+	"cmd_$(echo $command | sed -e s/-/_/g)" "$@"
+	;;
+esac
-- 
2.38.0.1091.gf9d18265e59

