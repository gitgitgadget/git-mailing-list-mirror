Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97095C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 536E960FE6
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhELNth (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhELNth (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:49:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C778C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s8so23705478wrw.10
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LwYeCJMG9tnJGLEM2mYpdKJkBsyDF9Jx9HZRfT4eMxw=;
        b=qIRO5p32saSHu6l64nar1Sw4Iu0UCWYCft69T+fY0r180IbC633pKIcsgUHp4Jntuz
         CqgMgRBUJy7GfiX1Sq3xZqTrNMwSSZy2aUOFQfCUXynFpHupo8ZTAAohP9xzPMSITvZu
         l7qKZ6YLLMkRSVucv5JzgWSMRIZJPsXuFSq2QmQkZzK5KtwoIJzjlWT/oUIjOjSaFB0C
         vvQenZu694LiCNs9NErZzqzyDknEhLupdRfLg9TiTvkRAAwIDZ60HnoJbu3TCFj0GcUL
         2oIhn1B8EMYM1F2tKFFBav8CPuEU8FTX4iK9sF08TTUmCchGZJ1VEF5YuE0kqi5R4WBR
         3eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LwYeCJMG9tnJGLEM2mYpdKJkBsyDF9Jx9HZRfT4eMxw=;
        b=JyxoTWwEIbUjHLShuTG2rGg517xohnuxKYhb+x8mpXU95cG7N78+Q4oe3yokBG1V9V
         X6LLSjMAZi5p6yNDJ7qD2cgcnA+jDv+AUnhK5rij/RoPXee3MjK+wJIhiinqIIkZq7Vq
         qS8MUmh8pF8ooRw0J1fXyI243HXxJsGlm2xzywgHSEMFF2rjrg86TIYogvy9o+1P14Mz
         C4zonuLQWXbUYxzMTE3oonXXsLeDxOVo4me9KHVn8KAL+7BtikF2khxDWwwd0X0QF1Ja
         2w7Pbwya7M3XhV8t2MdfUD+xIYmfOrc0iooOTjVHbBp3exvx7jn4VApnd0gqJ0CjP0Yj
         r5Vw==
X-Gm-Message-State: AOAM531+f6W4TDFSv8oeXl0u9/qTg1s3+1zniGkChM/1aflPLjze4WbA
        wLDLuwMkTIuRfEJP5vr5MGny4OHf/vGILw==
X-Google-Smtp-Source: ABdhPJytvgPcA89/W2PS3KhrZe/dacnVD86vsWo08rRVk006+w0iavTzdQXZQZtEUOyhuT2WK3AYqw==
X-Received: by 2002:adf:ef47:: with SMTP id c7mr45116744wrp.297.1620827307628;
        Wed, 12 May 2021 06:48:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm31416612wmb.32.2021.05.12.06.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:48:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/9] send-email: various optimizations to speed up by >2x
Date:   Wed, 12 May 2021 15:48:16 +0200
Message-Id: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is on top of my just-submitted [1] which in turn is on top of
send-email work of mine sitting in "next".

I was meaning to hold off on these patches for a bit, but given the
concurrent on-list discussion about doing config discovery in
send-email I wanted to send this now.

This combines by not-picked-up[1] recent patches to remove the support
for the "sendemail.smtpssl" variable with the later patches showing
where that effort was really going.

As noted in the subject this speeds up git-send-email invocations by
~2x or more, and brings the very slow t9001 test from running in ~26s
on my box to ~12s. It's no longer consistently the slowest test I run.

This is basically done in two ways: We lazily invoke "git config" to
get config, before it's very eager, and deferring Perl compilation
with s/use/require/g.

1. https://lore.kernel.org/git/patch-1.1-92571a8cf7-20210512T094803Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-0.2-00000000000-20210411T144128Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (9):
  send-email: remove non-working support for "sendemail.smtpssl"
  send-email: refactor sendemail.smtpencryption config parsing
  send-email: lazily load config for a big speedup
  send-email: lazily shell out to "git var"
  send-email: use function syntax instead of barewords
  send-email: get rid of indirect object syntax
  send-email: lazily load modules for a big speedup
  perl: lazily load some common Git.pm setup code
  send-email: move trivial config handling to Perl

 Documentation/config/sendemail.txt |   3 -
 git-send-email.perl                | 145 +++++++++++++++++------------
 perl/Git.pm                        |  49 +++++-----
 3 files changed, 111 insertions(+), 86 deletions(-)

-- 
2.31.1.909.g789bb6d90e

