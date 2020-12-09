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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B663C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A03C22B47
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgLIPxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 10:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbgLIPxF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 10:53:05 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0BAC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 07:52:25 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a6so1928533wmc.2
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 07:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CK9BSn3aGlok1qfZCSwFIRRPxjiyAe0sHr6xIJwkox8=;
        b=FQAyFoNe5fsEvvsKTeT6+GrvppeGEGLiFWvimJ7FtIm07mtffmZbLlKo6tvHqkSpr+
         my96UGatiP/Lwe+AMp6/s7HhN4TZEhrXD7iRPlg4BrpNnNE4qhiGnNWC0vndCwF/bVbi
         0vb5JbOdX45iWpW8FpJCHMQbJPHlGarsdiIh0FBvwWYibavxqjPFAP9qld7tDereWLKX
         gvqOl4uu8tJ45B7FfLGONx1/bgm+F4fXs+3voGkw1lyI6uHBC8DnEnRi6pK9NHYf7ov3
         8V7m4Wi0H6l0Lk+H/lmPo/o0t2b8zKryf/SMzOxMfurufUReZQPrd0Qmdop/OKhm5pDo
         yBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CK9BSn3aGlok1qfZCSwFIRRPxjiyAe0sHr6xIJwkox8=;
        b=RMNgMyAzhp36sTw8awWf/ib/8oldMquNDgaXSXW0jbGirRNlbvNski0wXFIZAHyO7L
         DJZhHvLlfdl9zY/iNJJ9frXdzhlOpG86sMmJETrh0gB+4UrsUx7PNxqi00ZRYK68NPD6
         cJlxgyfW/on0N1Z0sddWeMcTaG+iA2mdlmTGanKSKbfwmViMMAykRwmM42T9OO5lrnwL
         QOmvK1JvVm+0kD2aBQCmR+g/nwz7HBCqyVZ2zaeAUVJcLCzYftxHhJphOr7/gGYeNdHw
         iRTT9qYfRXMxAdgZKoNwNYpNfBE5wImDSaRRXaCb2hNFpfT2ILQPJwitLsmhbgy/WH5C
         zLIQ==
X-Gm-Message-State: AOAM532xQ4nKguKnlx43wnaJaLjYJXX6ZeKBCPbpuaBcC3l3fVJYrTfR
        t87GkOzdkwidiBz6fBzmFMqcMk3Bot96Zg==
X-Google-Smtp-Source: ABdhPJyTtrnlOJ11lareDPTwzNixPysCzN+dH5YU9K00pgzKhBC5PzR/5oQ2THIWY+YevedjjnbqfQ==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr3412026wmc.156.1607529144131;
        Wed, 09 Dec 2020 07:52:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b7sm4424495wrv.47.2020.12.09.07.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:52:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/5] pretty format %(trailers): improve machine readability
Date:   Wed,  9 Dec 2020 16:52:03 +0100
Message-Id: <20201209155208.17782-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201206002449.31452-1-avarab@gmail.com>
References: <20201206002449.31452-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A minor iteration on v2 with a commit message wording change &
s/=BOOL/=<BOOL>/g in the docs, as suggested by Christian
Couder. Range-diff below:

Ævar Arnfjörð Bjarmason (5):
  pretty format %(trailers) test: split a long line
  pretty format %(trailers) doc: avoid repetition
  pretty-format %(trailers): fix broken standalone "valueonly"
  pretty format %(trailers): add a "keyonly"
  pretty format %(trailers): add a "key_value_separator"

 Documentation/pretty-formats.txt | 34 ++++++-----
 pretty.c                         | 10 ++++
 t/t4205-log-pretty-formats.sh    | 99 +++++++++++++++++++++++++++++++-
 trailer.c                        | 15 ++++-
 trailer.h                        |  2 +
 5 files changed, 141 insertions(+), 19 deletions(-)

Range-diff:
1:  4b134a62aec = 1:  584c7580b5b pretty format %(trailers) test: split a long line
2:  0d3fe6daf6c ! 2:  0255a64949b pretty format %(trailers) doc: avoid repetition
    @@ Commit message
     
         It took me a couple of readings to realize that these options were
         referring back to the "only" option's treatment of boolean
    -    values. Let's try to make this more explicit, and upper-case "BOOL"
    -    for consistency with the existing "<SEP>" and "<K>".
    +    values.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Documentation/pretty-formats.txt: endif::git-rev-list[]
     -   `false`, `off`, `no` to show the non-trailer lines. If option is
     -   given without value it is enabled. If given multiple times the last
     -   value is used.
    -+** 'only[=BOOL]': select whether non-trailer lines from the trailer
    ++** 'only[=<BOOL>]': select whether non-trailer lines from the trailer
     +   block should be included.
      ** 'separator=<SEP>': specify a separator inserted between trailer
         lines. When this option is not given each trailer line is
    @@ Documentation/pretty-formats.txt: endif::git-rev-list[]
     -** 'unfold[=val]': make it behave as if interpret-trailer's `--unfold`
     -   option was given. In same way as to for `only` it can be followed
     -   by an equal sign and explicit value. E.g.,
    -+** 'unfold[=BOOL]': make it behave as if interpret-trailer's `--unfold`
    ++** 'unfold[=<BOOL>]': make it behave as if interpret-trailer's `--unfold`
     +   option was given. E.g.,
         `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
     -** 'valueonly[=val]': skip over the key part of the trailer line and only
     -   show the value part. Also this optionally allows explicit value.
    -+** 'valueonly[=BOOL]': skip over the key part of the trailer line and only
    ++** 'valueonly[=<BOOL>]': skip over the key part of the trailer line and only
     +   show the value part.
      
      NOTE: Some placeholders may depend on other options given to the
3:  ea44eeff510 = 3:  c2c5513942f pretty-format %(trailers): fix broken standalone "valueonly"
4:  4fd193fd90c ! 4:  574ef0be25f pretty format %(trailers): add a "keyonly"
    @@ Commit message
     
      ## Documentation/pretty-formats.txt ##
     @@ Documentation/pretty-formats.txt: option is given with no value, it's enabled.
    - ** 'unfold[=BOOL]': make it behave as if interpret-trailer's `--unfold`
    + ** 'unfold[=<BOOL>]': make it behave as if interpret-trailer's `--unfold`
         option was given. E.g.,
         `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
    --** 'valueonly[=BOOL]': skip over the key part of the trailer line and only
    +-** 'valueonly[=<BOOL>]': skip over the key part of the trailer line and only
     -   show the value part.
    -+** 'keyonly[=BOOL]': only show the key part of the trailer.
    -+** 'valueonly[=BOOL]': only show the value part of the trailer.
    ++** 'keyonly[=<BOOL>]': only show the key part of the trailer.
    ++** 'valueonly[=<BOOL>]': only show the value part of the trailer.
      
      NOTE: Some placeholders may depend on other options given to the
      revision traversal engine. For example, the `%g*` reflog options will
5:  6cc6fc79388 ! 5:  dbc73b951f6 pretty format %(trailers): add a "key_value_separator"
    @@ Commit message
      ## Documentation/pretty-formats.txt ##
     @@ Documentation/pretty-formats.txt: option is given with no value, it's enabled.
         `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
    - ** 'keyonly[=BOOL]': only show the key part of the trailer.
    - ** 'valueonly[=BOOL]': only show the value part of the trailer.
    + ** 'keyonly[=<BOOL>]': only show the key part of the trailer.
    + ** 'valueonly[=<BOOL>]': only show the value part of the trailer.
     +** 'key_value_separator=<SEP>': specify a separator inserted between
     +   trailer lines. When this option is not given each trailer key-value
     +   pair is separated by ": ". Otherwise it shares the same semantics
-- 
2.29.2.222.g5d2a92d10f8

