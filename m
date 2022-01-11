Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDDEC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 16:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbiAKQkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 11:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbiAKQkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 11:40:42 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0046C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 08:40:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e9so32575619wra.2
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 08:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=828VVD64n3LDBzUQ2oOkvJ5ZWAiX9577TwdS07vijfY=;
        b=LQDIBHJIQI7ruqWhJg6MbKRCs/0YTDLzYLRxcOD2ioNH8FZnRq969x5+RgK/Asi1aV
         OaJ/GCPFrlNYjNzT70YPIYb4vWzlVBxN3b4dVY9R/viVsfKgf0lZdHRcpMneImrUFKJ+
         B+yOuOmSm32WGWIGS8e1tls0tqGDto0x6JNda3+AhoJfyRlQTrzrRxLEnbc5z3r01SQD
         1Nr5ie0DYFhKRFDUt94gU+tU7dlueoV1nf7G6jrhJOlZlyEShpdvlbbYqOvoD0HYtIaC
         pZLpQnofTG6iNG2jg79XcEkYAP71AwBxklTwbb4i5i0jBCrOUiHnHUG2y8eWmG4cIK2G
         TGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=828VVD64n3LDBzUQ2oOkvJ5ZWAiX9577TwdS07vijfY=;
        b=dwXuNm3x6ZJFw2J6ZGbPDM1ZUwGZHK6mYps+pgrk61ufHi3zVZhOGCH+CrqNEUb8w8
         ZpdkrUi7kKFGMtNF8ZAEoHCV1ooiXgooG2rtyxK2N+6NrUwd347W4LGz7ItX2XR9dG26
         86vITcTnQydwc3JzUibb9DNPADRNpG/Rxw63mO/EaU1R7hUni+bLCt/4H/wKWUQsshAW
         uNYgZrVlU/nSOMFTvyiV55LaeqokT9Emdd/T23FkopthV9RHoIR+0w8iaL75qDN94aAo
         ZALgvIhONcLM3THK/XWtTHrbOPQk9DKxEGWVx2c+1HzGqVQGNtVEyvtAJacHjJ5vem7c
         q02A==
X-Gm-Message-State: AOAM5338xZK48uTiIeq0MdwEecslLyUE6L1E/W7c4CJwdhy6Wm41Cb7y
        6Yzv2Oi0+aJ8tQcwxKpgQWeBarPn96CJIQ==
X-Google-Smtp-Source: ABdhPJwzq5rHYgWmixaIvp9pkrQx7RUe49IOj3jgHy76NSET/G7NBiF2ALdsr/Jv9X4pmicFS7nqIA==
X-Received: by 2002:a05:6000:1006:: with SMTP id a6mr4637021wrx.484.1641919239981;
        Tue, 11 Jan 2022 08:40:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o38sm2536934wms.11.2022.01.11.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:40:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] Fix SunCC compiler complaints new in v2.35.0-rc0
Date:   Tue, 11 Jan 2022 17:40:20 +0100
Message-Id: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.844.gb5945183dcf
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This trivial set of patches fixes compiler complaints from SunCC on
Solaris that are new in v2.35.0-rc0.

The first two are only a minor annoyance, and not the first or only
warnings of those categories that we emit, but if we can avoid adding
new ones...

The third one is a generic integer overflow bug, and will probably
result in logic errors or failures in the reftable tests on some other
platform.

Ævar Arnfjörð Bjarmason (3):
  test-tool genzeros: initialize "zeros" to avoid SunCC warning
  reftable: remove unreachable "return" statements
  reftable tests: avoid "int" overflow, use "uint64_t"

 reftable/merged_test.c   | 4 ++--
 reftable/refname.c       | 1 -
 reftable/writer.c        | 1 -
 t/helper/test-genzeros.c | 3 +--
 4 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.35.0.rc0.844.gb5945183dcf

