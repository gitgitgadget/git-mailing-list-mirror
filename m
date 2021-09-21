Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57118C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DCC61131
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhIUNbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhIUNbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:31:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656B3C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:30:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t18so39239865wrb.0
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6dobea5t/RUZQVrolQROyGGbBxzGVDLkbE62WViGi5Q=;
        b=Wd82NZS8AWWjQ6NiRuVX3BMsoaGPf+UZ68ZxjMPVs/mz4z/J+qNZHE6U24qGKVBzOt
         RoDZHEKgMt2PDLqEaRzEl6xvpWbhT5xHDbF7o0EcwTlT8fR9wMv0y7ti4AKk1eFHeMmA
         S7VfugCvE3WUhOQNyHleNWmfLWJHfSzMk+2NCvZqyARj2ikbtyOwkNjUY34iSlOGvD5c
         pU+1564pfElMG0hj2S5tFUAGHRuDAUTGP9p96Mv8FPUR7nCXiY5e/GbFkLduMAX7Gl/w
         rZVumyfnfBOIR0GFYSzHQfyieQwe4K1wUuwS1urJgJjf2+HqqBSZKzDwsllLiwl3OXxa
         QKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6dobea5t/RUZQVrolQROyGGbBxzGVDLkbE62WViGi5Q=;
        b=luB7E0ie6d7x1muA1a9SPC+583MFLgBx4ZCM9Yv7m8rS4HC/hIC3+K5aTJxTef8iig
         lcadCoO11irBanWbpT1CKecWWu+mG5awKgtYN0xpfEZue6+jxTI2qI4CIuds6ZJGbbcu
         laSM4XRwETsPXURHIvsPJah2rinLCu8om4A/airYCWm7zTm7r0btrh1DzfEcKhmje1bz
         sLLHV4PnqSmh7rSGn0OvvWhKCrV4NHJO33hpkqEcmsJ1UQ9h7cATJ6DM+51HqT99ibtz
         dZFttd5uOVs5pPXT8ftT3PzRxgoZJ4akC2la3yVffCbNvVodZUvg1qLPQX1VSEVDNogQ
         m9cA==
X-Gm-Message-State: AOAM530NE3tGtkW6taIcUwTGH0PKeLh6aoys6RH0evg+cx7HWkEpHwtq
        rpXD13uxQ2sRjSsNQJFfKGHpGSdd9/kDOQ==
X-Google-Smtp-Source: ABdhPJwvUA02ctKe6mBsA3yCjpRcJFxaesBhTShKIk8C5vWuoCDp5a4/xblF4xbWbGoy7AOLuflcxQ==
X-Received: by 2002:a05:600c:35c8:: with SMTP id r8mr4716376wmq.71.1632231016481;
        Tue, 21 Sep 2021 06:30:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 135sm2926891wma.32.2021.09.21.06.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:30:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/4] parse-options: properly align continued usage output
Date:   Tue, 21 Sep 2021 15:30:07 +0200
Message-Id: <cover-v5-0.4-00000000000-20210921T132350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com>
References: <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes usage_with_options_internal() in parse-options.c
to properly align continued "\n" usage output.

There's only a very small typo changes in this v5 in response to
https://lore.kernel.org/git/xmqq8s01geov.fsf@gitster.g/; I also
re-read the rest over & spellchecked the comments I added, for
whatever that's worth.

I didn't add a test in t/helper/ as Junio suggested, since it's the
usage message itself it doesn't slot nicely into the control flow of
t/helper/test-run-command.c, we could of course make it work, but I'd
prefer to punt on it.

I think having manually tested the output should do in this
case. I.e. I manually looked at all the "-h" emitted by t0012-help.sh
and it's all nicely formatted now (aside from some overly long lines,
addressing that is left for another day).

Ævar Arnfjörð Bjarmason (4):
  parse-options API users: align usage output in C-strings
  send-pack: properly use parse_options() API for usage string
  git rev-parse --parseopt tests: add more usagestr tests
  parse-options: properly align continued usage output

 Documentation/git-send-pack.txt |  4 +-
 builtin/ls-remote.c             |  4 +-
 builtin/send-pack.c             |  8 ++--
 builtin/show-branch.c           |  6 +--
 builtin/stash.c                 |  2 +-
 builtin/tag.c                   |  4 +-
 parse-options.c                 | 76 +++++++++++++++++++++++++++------
 t/t1502-rev-parse-parseopt.sh   | 54 +++++++++++++++++++++++
 8 files changed, 132 insertions(+), 26 deletions(-)

Range-diff against v4:
1:  64d8647340d = 1:  352662be92d parse-options API users: align usage output in C-strings
2:  f10ff775c69 = 2:  d3767214d22 send-pack: properly use parse_options() API for usage string
3:  05a0c7cac37 = 3:  8262999b456 git rev-parse --parseopt tests: add more usagestr tests
4:  55480dee680 ! 4:  9f7f3f8b4ed parse-options: properly align continued usage output
    @@ Commit message
     
         But to do that we'll need to find the length of "git stash". We can
         discover that from the "cmd" in the "struct cmd_struct", but there
    -    might cases with sub-commands or "git" itself taking arguments that
    +    might be cases with sub-commands or "git" itself taking arguments that
         would make that non-trivial.
     
    -    Even if it was I still think this approach is better, because this way
    +    Even if it were I still think this approach is better, because this way
         we'll get the same legible alignment in the C code. The fact that
         usage_with_options_internal() is adding its own prefix padding is an
         implementation detail that callers shouldn't need to worry about.
-- 
2.33.0.1098.gf02a64c1a2d

