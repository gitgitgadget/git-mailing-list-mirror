Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B6C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DB464FA7
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBDVGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBDVGv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:06:51 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531D3C0613D6
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 13:06:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y187so4214659wmd.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 13:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=luYlB0G8WF3KG4jVQvday2Ph41kbEEdGZFFa2pF1kP4=;
        b=JiQBj5HRiatATSthEVmkTsEcM1ZzGTstPSW0N956exgMHinlmfNU6Bt/2cEsyAdJ6h
         Gh0+HsyjOZhrhYqw9JGNZDG8EE7GJkBES9TfhnwALU6SbT2Ld7swO6AWAw/DEBAphGXw
         pdje+ZWnyQYGJJcn2H+8UbP0sKV3JQQ5IiYn/yPEROvA5yMjQJm7FYmyyngdnQY5PV4u
         N3w1eUfuSTIRKxLFsDzU1NIlWZneS0dd+hLAUNrH3e9H+pvbR7bhEAydrNKIwyHcVlYu
         1wo+gHN9esNiW7orf/R4qwHkKV5B6tHjsr+C7yeT43cKJBOHmnrnzXUltVv8Sz9wB6tZ
         yj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=luYlB0G8WF3KG4jVQvday2Ph41kbEEdGZFFa2pF1kP4=;
        b=pl1GMrd/mByCZMORUWbQLJIyVAJoEVHmzGJ8ZpFbTkGaJ9ELAdZcFsmnopoF/IgJbD
         p97GudaA3VUbzfn3APIc7xTP89aD2Gj4JZZki3N29TIyrWIz542urW7+ps3SUQ0cUQ3I
         sTI/lvbD1rk/zPjaXNGBpUAccAsbgGocwgLPhyCC94YCxYdaXZcvbvWrfvOHwTkqS0ij
         WZyffm6GApcax/5pfQqs01uETxYoTbNbTpWroXEpgPSi22+8j8sm5pvhcRy1EptRaXJe
         Ejeuaeu/bZXUfgSDMnWF9PyN2u3XA9xpUa8ZSj9oDhjnWtIJD1QM8S67AivuLZsNjvgG
         5nFQ==
X-Gm-Message-State: AOAM531tdMy1RfiiADt4Bs/W/xAB+8w/W2z/4Cg2iF2t0TdvpmJc0NIq
        9z+5Pb9QsAarc9pczO0XOFayLnTwb5E=
X-Google-Smtp-Source: ABdhPJz1pOQ6PmXhTGOjYF3ZZgV2Zj76Ihx2imCCLQ2qdvbaE6Tc14K/9rKzSBBTpHC51ubgzYq0Aw==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr869185wmh.164.1612472769736;
        Thu, 04 Feb 2021 13:06:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5sm6779318wmq.7.2021.02.04.13.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:06:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] grep/pcre2: memory allocation fixes
Date:   Thu,  4 Feb 2021 22:05:46 +0100
Message-Id: <20210204210556.25242-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes up bugs in our PCRE v2 wrapper code and how it
handles malloc()/free().

Junio: I'm splitting this off my recently sent 25 patch series, which
I should probably have sent as an RFC:
https://lore.kernel.org/git/20210203032811.14979-1-avarab@gmail.com/

It's on top of "next", as it would otherwise conflict with my
in-flight ab/grep-pcre-invalid-utf8, ab/lose-grep-debug and ab/retire-pcre1.

06/10 is a follow-up improvement (not a fix, the in-flight works fine
too) for ab/grep-pcre-invalid-utf8. The latter two just touch adjacent
lines of code.

There's no notable new behavior here, just cleanup of existing
functionality. In mid-2019 there was a lot of discussion around the
code being fixed here:

    https://lore.kernel.org/git/pull.306.git.gitgitgadget@gmail.com/#t
    https://lore.kernel.org/git/pull.402.git.1571227613.gitgitgadget@gmail.com/

As discussed in 08/10 I believe that fix was so difficult to get right
because it was starting out with a fundamentally incorrect assumption
about how PCRE v2's memory handling works. With 08-10/10 we end up
with a much easier to reason about end-state, as the API itself is
actually quite simple.

Ævar Arnfjörð Bjarmason (10):
  grep/pcre2: drop needless assignment + assert() on opt->pcre2
  grep/pcre2: drop needless assignment to NULL
  grep/pcre2: correct reference to grep_init() in comment
  grep/pcre2: prepare to add debugging to pcre2_malloc()
  grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
  grep/pcre2: use compile-time PCREv2 version test
  grep/pcre2: use pcre2_maketables_free() function
  grep/pcre2: actually make pcre2 use custom allocator
  grep/pcre2: move back to thread-only PCREv2 structures
  grep/pcre2: move definitions of pcre2_{malloc,free}

 builtin/grep.c |  1 -
 grep.c         | 99 ++++++++++++++++++++++----------------------------
 grep.h         |  9 ++++-
 3 files changed, 51 insertions(+), 58 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7

