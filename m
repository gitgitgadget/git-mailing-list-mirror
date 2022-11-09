Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B9DC4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 17:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiKIRBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 12:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiKIRAx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 12:00:53 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6298D23E8A
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 08:58:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso1728951wmo.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 08:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n80JSSiOxbuntGL9+w7PkWY1RAA8zNtOf97igvcodjo=;
        b=Ocqji70MlxOukMC2OXj/QvwCiM5JomcoB6xwLV4nlx443BSi1YW+5g/AiEPF9bSwOW
         GFjvoEqd3qzxmN10Wa/flC8eYdEKsl89kdARW8qhqjJ3RI3sRwN5OUqOpQqAcofz+ZSs
         pIX36XKqtZAI9rG0lmo9PRv+O24uQDB7btaoE/MJy52Troa9veHdKG2GkuUWUdffLGay
         McZSp5nAVOg1MHP/rYWPLRvqhFynBPDEcVwukO16YvQZ5DELLf8fOyRTOul/fm9WDbOB
         rHeJG4NaVpNrILWJr+oR7iFj7Fo5YP5g+v4nXlvZgMQT6fWcFje/ni6H0EnlI1P+gbd5
         JdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n80JSSiOxbuntGL9+w7PkWY1RAA8zNtOf97igvcodjo=;
        b=OcFEhCC08EdxRYDpsopBlbwBsPUSV38WnxeQeZBntWKNHJhe5wotHYG217Sva/PB6h
         I9zuw1wm9NOX42TkLj0sr88+TEfvFAjd/6YRA65VBrEgmWhlWhtHU4guxTm85UmElk1L
         vQfZIPYpBd/nIaJDYJdH+mnC4Xbt+ac9c7xLtKaPazi6J9gCW2nS3s3Xp0AGIcqknbl+
         NNr7PcAB2gLmeuKy2pDgZb1nfV2RVQ8uQqit7IRrthBHMBJnqujVvSAIrCAMhC2Ym7J3
         t83Lski1X3q304VhWkHzt9utW2oQQ+PvF/9SVfeaYKZo95LYQTI94HBoOga1qqLHYXo/
         Q3yg==
X-Gm-Message-State: ACrzQf1wZl9eyclx4X+ajLM1MGKVZZdfFxFmU/5bKaqAyFubF0wJaG8t
        YjpIFC13WeSTiraEzeRB3dcnQ9R+HoI=
X-Google-Smtp-Source: AMsMyM7qfgvsVXYO+TSKH07ntEqVgMQL4hiMZWCglZwLavBGj36ufOq/B6fhiMnXPTTR2/ej7mdtKQ==
X-Received: by 2002:a05:600c:a04:b0:3b4:f20e:63f4 with SMTP id z4-20020a05600c0a0400b003b4f20e63f4mr41103713wmp.201.1668013116710;
        Wed, 09 Nov 2022 08:58:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bw14-20020a0560001f8e00b00240dcd4d1cesm9672266wrb.105.2022.11.09.08.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:58:35 -0800 (PST)
Message-Id: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 16:58:31 +0000
Subject: [PATCH 0/3] chainlint: emit line numbers alongside test definitions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When chainlint detects problems in a test, it prints out the name of the
test script, the name of the problematic test, and a copy of the test
definition with "?!FOO?!" annotations inserted at the locations where
problems were detected. Taken together this information is sufficient for
the test author to identify the problematic code in the original test
definition. However, in a lengthy script or a lengthy test definition, the
author may still end up using the editor's search feature to home in on the
exact problem location.

This patch series further assists the test author by displaying line numbers
alongside the annotated test definition, thus allowing the author to jump
directly to each problematic line.

This feature was suggested by Ævar[1]. I suspect that Ævar's next nerd-snipe
attempt may be to have problems emitted in "path:line#:col#: message" format
to allow editors to jump directly to the problem without the user having to
type in the line number manually.

This is atop "es/chainlint-output"[2].

(Note to self: Fortify against Ævar's nerd-snipe blacklist evasion.)

FOOTNOTES

[1] https://lore.kernel.org/git/221108.86iljpqdvj.gmgdl@evledraar.gmail.com/
[2]
https://lore.kernel.org/git/pull.1375.git.git.1667934510.gitgitgadget@gmail.com/

Eric Sunshine (3):
  chainlint: sidestep impoverished macOS "terminfo"
  chainlint: latch line numbers at which each token starts and ends
  chainlint: prefix annotated test definition with line numbers

 t/Makefile     |  2 +-
 t/chainlint.pl | 69 ++++++++++++++++++++++++++++++++++----------------
 2 files changed, 48 insertions(+), 23 deletions(-)


base-commit: 73c768dae9ea4838736693965b25ba34e941ac88
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1413%2Fsunshineco%2Fchainlintline-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1413/sunshineco/chainlintline-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1413
-- 
gitgitgadget
