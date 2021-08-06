Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BAFC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675DD60F70
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhHFQpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 12:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhHFQpB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 12:45:01 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF12CC0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 09:44:45 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id v24-20020a0568300918b02904f3d10c9742so6228698ott.4
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQngdPDRr9Fysv2jIsmhkRTWhlUStwGZeigmPcyn0gU=;
        b=MApW9BYPOZ+2e4kTOtovfuTHIzVsO3cPgu7lrWioiUfudSvBHp5433t0LhaikPswLC
         Ng7rvIdvKVcv1GR5xBlvPJeaKVWYp48PVu7EeT7X5wiKX9Z7bk7C8nzRd6xFOR4nIEDI
         Hl8byfP6NQD3I3VcrMfjnCkZpXeHnFFmickz3S19oHUvFR7/9SldClKppQ5rVtj01z+U
         pVHyB4rZaaaORIR67MY/jLgzW2mCs4dFGUWcOplzglo/JkzAyh4cmLyU7H0pu6AgdvnO
         TrEctIgNYdeb6ZEJ6ZGBHMZkiNvwhUG2j51vzcUXi2H31/xu+bh8nPkKZL/LcDKbTcAb
         Rtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQngdPDRr9Fysv2jIsmhkRTWhlUStwGZeigmPcyn0gU=;
        b=nPTyCf8h/5QPeltt6DtfQ0dRotK8K9cQRp3EYiZn+/Tm3yf5vI2OdV1Vhac4vzxKpI
         SrmHaHbr3x0jm/8jt3wdGpOsU+XV9JA1W1GZ95mMVVqNNgrXsBYCmpSPkrthwiBFTAO/
         nfZIbhKYv6htGKgotzxxR2wQrPYXR5iic546NgexXLnbALGLq49TcpvjbITs9QdbFW/s
         HFkqQQVJkH+dPCO4a8WqYr+jnkp/KJdVIejEU351heq+urhLiozJtk94c+vdkwUb7y09
         PcJgplrpXOvZKhaAAhP9zmvIKuGc00wDiqc2uYi4+dmQWygEd69lx5WTCXkXJzjj+i+L
         D4nA==
X-Gm-Message-State: AOAM53124frE6Wm53+hZEDvAnBGFq85pwx6aNH78g42uS9oG8hZpLI02
        rDjMg71jSm+bXHO1HarFFDH52iXZ3YvicA==
X-Google-Smtp-Source: ABdhPJxL62rN6+c3Ej4vFAuaiQ1tT8p9aUjLabxRQHhE8ELakJbwsf4yg+PCzxTqRxLQven14npLog==
X-Received: by 2002:a05:6830:2144:: with SMTP id r4mr8031374otd.19.1628268285083;
        Fri, 06 Aug 2021 09:44:45 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id s13sm941389otq.16.2021.08.06.09.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 09:44:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>
Subject: [PATCH v2] test: fix for COLUMNS and bash 5
Date:   Fri,  6 Aug 2021 11:44:33 -0500
Message-Id: <20210806164433.8665-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
In-Reply-To: <20210805194825.1796765-1-felipe.contreras@gmail.com>
References: <20210805194825.1796765-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since c49a177bec (test-lib.sh: set COLUMNS=80 for --verbose
repeatability, 2021-06-29) multiple tests have been failing when using
bash 5 because checkwinsize is enabled by default, therefore COLUMNS is
reset using TIOCGWINSZ even for non-interactive shells.

It's debatable whether or not bash should even be doing that, but for
now we can avoid this undesirable behavior by disabling this option.

Reported-by: Fabian Stelzer <fabian.stelzer@campoint.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Since v1 moved the code before setting COLUMNS as SZEDER Gábor suggested
and mention checkwinsize could be set before bash 5 as Ævar Arnfjörð
Bjarmason mentioned.

Range-diff against v1:
1:  40273074de < -:  ---------- test: fix for COLUMNS and bash 5
-:  ---------- > 1:  9f8c3ffa6a test: fix for COLUMNS and bash 5

 t/test-lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index db61081d6b..6b1015a5af 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -409,6 +409,12 @@ then
 	verbose=t
 fi
 
+# In bash if checkwinsize is enabled the COLUMNS variable is updated every time
+# an external command completes, even for non-interactive shells. Since bash 5.0
+# this is enabled by default.
+# Disable that since we are aiming for reproducibility.
+test -n "$BASH_VERSION" && shopt -u checkwinsize 2>/dev/null
+
 # For repeatability, reset the environment to known value.
 # TERM is sanitized below, after saving color control sequences.
 LANG=C
-- 
2.32.0.40.gb9b36f9b52

