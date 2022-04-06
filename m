Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236D3C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 14:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiDFO2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbiDFO2W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 10:28:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BD34FBF6B
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 03:42:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m30so2593715wrb.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YpBz3l17HeE8blQ/xwt+hR5hV/7cwnETPxWohWTe4p8=;
        b=b4nLG8+K6yBJW2D/NxhF4nBK1nsOtUgVAB88ELgwwxGREoammtxabE4P/OT7YXWcOm
         UqLFp0UeN0b3lJepzm0Csesms4WPZ8inCVddR3+qnfP5WKgMPYjKb7/tELOwWqHCINhD
         7NYs+E8KEzHKm3w4wuF/YmFpmahDy2lTakvawsX7TREluXKb0PStPr+3mEeoRisqhnrP
         pXR8rxe22Pw5NGoEbHZ/Um5vnpm8HhYaNMGGuethEltLODocwMDU0Rnb6UmxqJ+q4F8h
         TaDKEL/tSw6pMBKAFc4GMRh3W5smXbhb7cw/1jdnUdeNBo8V/VYF88P3sSRqif8cYWgN
         BJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YpBz3l17HeE8blQ/xwt+hR5hV/7cwnETPxWohWTe4p8=;
        b=PQBt+PJZLg0BrWMXwXQfh1XzUKdI6qgCrlMfa84LiLu9ZCDqvjwosVL7sqvxkjj7wG
         m17Qrb+YTm8hb8LhmXfzu3ufRTQkJ1aDggBPKXLK3vRXxJrUIi/x2bxcQSoVe6oTWLxR
         aVmVSWS5Mb41ZSrxe+Ni9MwQ/dn47XSHtFsEc+ZQ9H7Z5pi9OWak5ohVUb5shN+lCBlH
         mMhypTLYEP0lUUuRgnDLZ9itzLmbibtIj0wfrDAAbW2RATRwBGLZGDnnk8Z2dDiheGUS
         ia1kQ4plNdinLm8I9Vbvrjd/535C7C++eaoq6wJ7/fDOGmiSQhqNaw0QnKxsm8BvqhFX
         95+w==
X-Gm-Message-State: AOAM532GxlrGHllr2NB0m2zsS++905oy4DFpo80txbuYfKuF29UN7EOC
        9B2C24FmeKkui+9/sfPkNHIg4duT9UOStQ==
X-Google-Smtp-Source: ABdhPJyU6wMZ1SB4wHMguAtcfWm5+8AqZLZJq/PFqo9HX08geDfcefnEedwdYG4n8NyJjoR3HXJ21Q==
X-Received: by 2002:a05:6000:188b:b0:204:109a:fbed with SMTP id a11-20020a056000188b00b00204109afbedmr6264235wri.569.1649241770175;
        Wed, 06 Apr 2022 03:42:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c354200b0038cb422e3fesm4831288wmq.32.2022.04.06.03.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 03:42:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] run-command.h: rename "env_array" to "env"
Date:   Wed,  6 Apr 2022 12:42:42 +0200
Message-Id: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc0.849.g2d5b5d9ab01
In-Reply-To: <Ybtb6Shdj56ACdub@coredump.intra.peff.net>
References: <Ybtb6Shdj56ACdub@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 16 2021, Jeff King wrote:

> On Thu, Dec 16, 2021 at 12:51:55PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> Or maybe you're not interested in either case, which is also fine. It's
>> really not needed for anything other than to resolve the minor oddity
>> that we have two "struct strvec"'s, "args" and "env_array". It's just a
>> bit odd to have one with "_array" in the name, which is only because the
>> now-removed "env" was taken at the time.
>
> Yeah, FWIW I absolutely hated "env_array" when I added it, but didn't
> want to do the transition all at once, so needed another name. So I
> would be happy to see it become "env" now. ;)

Perhaps this follow-up to 832ec72c3e1 (Merge branch 'ab/run-command',
2021-12-15) will warm Jeff's heart if/when he returns from his git
sabbatical :)

Junio: We're in the RC period, but perhaps this change if we're ever
going to make it would be good to make around that time of patch
slowdown. I.e. for the first batch after release.

I've been holding onto this since around December, but when I checked
there was always 1-2 series that was adding new use of "env_array",
resolving that conflict didn't seem worth the hassle.

Right now this doesn't conflict with anything in "seen". The
scary-at-first diffstat is almost entirely in 2/3, and everything
except a two-line change in that commit is made by the coccinelle rule
added in 1/3.

So this series for reviewing is really:

 * A trivial coccinelle rule in 1/3
 * The trivial 2 line change in run-command.h in 2/3 that isn't made
   by that rule
 * Subsequent trivial cleanup in 3/3 changing s/env_array/env/g in
   comments & variable names

Ævar Arnfjörð Bjarmason (3):
  cocci: add a rename of "struct child_process"'s "env_array" to "env"
  run-command API: rename "env_array" to "env"
  run-command API users: use "env" not "env_array" in comments & names

 add-patch.c                          |  2 +-
 branch.c                             |  2 +-
 builtin/difftool.c                   |  6 ++--
 builtin/receive-pack.c               | 32 ++++++++++----------
 builtin/stash.c                      | 16 +++++-----
 builtin/submodule--helper.c          | 44 ++++++++++++++--------------
 builtin/worktree.c                   |  8 ++---
 connect.c                            |  9 +++---
 connected.c                          |  2 +-
 contrib/coccinelle/run_command.cocci | 11 +++++++
 daemon.c                             | 14 ++++-----
 editor.c                             |  2 +-
 hook.c                               |  2 +-
 http-backend.c                       |  4 +--
 object-file.c                        |  2 +-
 pager.c                              |  4 +--
 promisor-remote.c                    |  2 +-
 run-command.c                        | 19 ++++++------
 run-command.h                        | 14 ++++-----
 sequencer.c                          | 18 ++++++------
 submodule.c                          | 38 ++++++++++++------------
 submodule.h                          |  4 +--
 t/helper/test-run-command.c          |  2 +-
 trailer.c                            |  2 +-
 transport-helper.c                   |  2 +-
 wt-status.c                          |  2 +-
 26 files changed, 138 insertions(+), 125 deletions(-)
 create mode 100644 contrib/coccinelle/run_command.cocci

-- 
2.36.0.rc0.849.g2d5b5d9ab01

