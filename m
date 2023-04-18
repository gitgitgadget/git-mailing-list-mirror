Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FE6C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 17:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjDRRur (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjDRRum (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 13:50:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A1BD31D
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 10:50:40 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2a8bbea12d7so20726551fa.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681840238; x=1684432238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ja4D60HFJCiRkToeSpaf2E0VqFZHTBhny0umA/UBEI=;
        b=PsUUuWs4mxvx9H6tCwkkwxb+7TIyH7/QfHqIET777gxYrxUsMdplmgfkvpt/TdSFXW
         LNPVkkAXVFCRytr6fPHvRXypNDCKznNPBLdfHkC4KeHY0WtfRl7C3E3lHJWBB6XmMkux
         NbaWAVS9/Cn+LHHq6vfCXIiCt4P3llOV69eirsQedpaCGCfYM/CJVALzciYV1ttB0zGi
         VdAzJciiyz7aUkVFP4lbeVniUcGHsL0q7g/AiDVrkC9fiTA9/BZ3gzhuhL7ocsjfQUla
         1vMnlH3uhHrNBGRPt+w3+EJjISto+5maxcYAaP4fIsxgVMzq4abHqjrWfJ+sf02kkzLy
         w0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840238; x=1684432238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ja4D60HFJCiRkToeSpaf2E0VqFZHTBhny0umA/UBEI=;
        b=MYNs0ENP1Tl/S0Xspu9IpT+TCvUX6uIY+uFogWzD/qoAYxh01BqNHBdklDn69c36bc
         99ANVImo2VexfsbpHzu6SPCTmmbI3oU1241sJuEMryHB/FdtCCg74368ZjYBQA1raZBb
         Wze2tvFV1X5DtFaPHUmE952LYc+XeH9inXjztyec2a+dBBlKAYAgSUMMaJm/m8uRqcfH
         P7csYMRNeNoQQnwWqHtlz2FaIxx0D61Zn8MFfhRfv++JYoNzofOIjlgVJubTYLEhFR+m
         yAsSzsEkAELGj79M+AQ09cS/M0t2cUKHLXZKmGSb7RMgsE0sH7wa7T9iAaCqyBapA4iX
         uZ5A==
X-Gm-Message-State: AAQBX9dQB9FV8HTiL60MSPls2fdLdf99jQpEh6u/cj9nHIJ6pidQ4f2E
        vUl1z/BLBqCXhvMmf0+KnINsIf9dwbwZs3V2
X-Google-Smtp-Source: AKy350bQHq2v2mwkDnHptsygyRbLNg0IJ+A1H/yQMBVvESL73eeP+fzqE2VKZcPBGXGStnG98QZ3Fg==
X-Received: by 2002:ac2:55aa:0:b0:4eb:f6d:64f with SMTP id y10-20020ac255aa000000b004eb0f6d064fmr2920550lfg.42.1681840237973;
        Tue, 18 Apr 2023 10:50:37 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id l20-20020a19c214000000b004ed149acc08sm2294998lfc.93.2023.04.18.10.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:50:37 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] git config tests for "'git config ignores pairs ..."
Date:   Tue, 18 Apr 2023 19:50:31 +0200
Message-Id: <20230418175034.982433-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414081352.810296-1-rybak.a.v@gmail.com>
References: <20230414081352.810296-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v1 cover letter:
  https://lore.kernel.org/git/20230414081352.810296-1-rybak.a.v@gmail.com/

While preparing v2, I've realized that I've failed to click "Reply All" when
writing my previous email in this subthread.  I apologize.
  https://lore.kernel.org/git/CACayv=jL4t3cUVS=xXQ3fLxF26vDXRJ3khs2y4UjzBw947JVkw@mail.gmail.com/

Changes since v2:
  - Rewritten commit message for patch 2.
  - New RFC patch 3.

Andrei Rybak (3):
  t1300: drop duplicate test
  t1300: check stderr for "ignores pairs" tests
  t1300: add tests for missing keys

 t/t1300-config.sh | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

-- 
2.40.0

