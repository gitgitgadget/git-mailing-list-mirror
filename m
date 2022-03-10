Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5641BC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbiCJN6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbiCJN6K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:58:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A435D141FF4
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so5516559wmj.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7zaQqmaj5/AwTmLW6tJluMyP18P34Buv7taBh1UcbI=;
        b=D3Rj+0CTAZDMBO2CZPHrZW07bV7Y2yAizQv7iJJL+sVVRHLhL1it6CSsQrbE0iqrR7
         L0UcC12LhXvlYZ5qzErvYge7CqWA1EiVjOtKhF69PBoYOhSBcSYskPPCXALofAYI3Agb
         jaxx87TBIIXCZ9ymewOtN/VgAW4cV147l2FeUKwm+4LDvlLQdoCQABf9JKw3ephtITwP
         KpSXmWAftM9AGuepHChPkslRyXZZA+/bxC/hLGdX1WskEjkp/ZTze57zjUNjVzL9RX2i
         GG7C8dEw8PshlxGxzgKUPsGpRS22ZwoOZ4VQwotGY9VB/a4l1PAKCeWSNO39blgk3IKw
         ykTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7zaQqmaj5/AwTmLW6tJluMyP18P34Buv7taBh1UcbI=;
        b=z25ZxDLdUAS6xWoiba3xD+2Og/rzgAWY+/0SZbEwhXwDfTTMKlNVsvX+gNjmm0VbkX
         xhZHBLHsh4ph2y08KViI0W2zxnfTMaUEGFghfCAldQbwlaWg7xKOYd7Wtto52VtLb1Ti
         BS1ZMfnUeyWK6/0IrX9/YtyfiV0FuJ49RNK8Wkkd8RZwul5YbmQqvs/WVlEkbl8GfLcj
         7JZfViOSc/4XKZwlrDXy8IiutT/fxrbRrKis1Dbv0JySGp8JP99U2i0zuQdoI+n63SiT
         xmfm0JuFQl0+AMoAZ8zUb8Z5/R3Lkt8Juk7qUdqYrGz0HXTjxf1WKmmyTc6Rvv0tCI6n
         7LXg==
X-Gm-Message-State: AOAM532S8kJFqJFARwJz4ZlMNXXvpV+fY4y5Od4bSz1oqW8oyetLer7O
        cmd2TEGtfPUSJd8j2hj5lL7GjKYccKjxLQ==
X-Google-Smtp-Source: ABdhPJyueTepfbcuhOMkKcFG9TddKwu9j43KmdKWuAjn5fmggjR/FoyKNsAaEEyg1FQ+wytOmB21vg==
X-Received: by 2002:a05:600c:1c02:b0:389:cf43:eafa with SMTP id j2-20020a05600c1c0200b00389cf43eafamr3702764wms.203.1646920627776;
        Thu, 10 Mar 2022 05:57:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm7737162wmc.22.2022.03.10.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:57:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>, Johannes.Schindelin@gmx.de,
        congdanhqx@gmail.com, tenglong.tl@alibaba-inc.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/REVIEW 0/7] fixups/suggestions/musings for tl/ls-tree-oid-only
Date:   Thu, 10 Mar 2022 14:56:56 +0100
Message-Id: <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re
https://lore.kernel.org/git/20220308080551.18538-1-dyroneteng@gmail.com/
sorry about the delay in reviewing this. I did look it over & come up
with the below almost a week ago, but forgot/didn't have time to turn
it into inline comments.

I don't think all of these need to be squashed or fixed up into the
proposed series, but are just various small issues/questions I came up
with while reviewing it. Brief notes below:

Ævar Arnfjörð Bjarmason (7):
  ls-tree tests: add tests for --name-status

Optional, but maybe a good idea to add to the series. I noticed the
zero --name-status test coverage when testing it.

  ls-tree tests: exhaustively test fast & slow path for --format

Probably a good idea to add to it. I.e. the tests for the --format
drifted from the RFC version I had so that we weren't testing the
optimized v.s. non-optimized path.

  ls-tree: remove dead labels

Removes dead code in the proposed series (from an earlier iteration?)

  ls-tree: remove unused "MODE_UNSPECIFIED"

The MODE_UNSPECIFIED is also dead code in this series, but...

  ls-tree: detect and error on --name-only --name-status

We should die on --name-status --name-only (two option synonyms), but
don't on "master", so. This does make some subsequent code here
slightly simpler though...

  ls-tree: remove FIELD_*, just use MODE_*

The main outstanding thing for me when trying to understand the code
in this series is why we ended up with FIELD_* defines *and* the
MODE_*. This moves to just using MODE_*. I think it makes things
easier to understand. I.e. it's one less thing to pass around, and
what was in parse_shown_fields() is just embedded in show_tree() now
without the indirection.

There's also a change there to add an array of format <-> fast path fn
mappings, instead of the current if/else if chain with harcdoded
strcmp().

  ls-tree: split up "fast path" callbacks

Maybe a good idea, maybe not. Splits up all the "fast path" callbacks
into individual functions, instead of a monolithic show_default().

I think the resulting code is easier to read, since it's clear what
data we need to set up for what, but maybe we're off into the weeds
here...

 builtin/ls-tree.c          | 279 ++++++++++++++++++++++---------------
 t/t3101-ls-tree-dirname.sh |  55 ++++----
 t/t3103-ls-tree-misc.sh    |  15 +-
 t/t3104-ls-tree-format.sh  |  89 +++++-------
 4 files changed, 235 insertions(+), 203 deletions(-)

-- 
2.35.1.1295.g6b025d3e231

