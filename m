Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C773FC77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 04:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjEBELS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 00:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEBELQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 00:11:16 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BB52114
        for <git@vger.kernel.org>; Mon,  1 May 2023 21:11:15 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-187edc01fa3so1213302fac.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 21:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683000674; x=1685592674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYO+8ufiJMUl+tFlyq77nEenub5XfA757dBhBF51968=;
        b=J6dd5112GYdCLuReKTyvrcMon/l+SBrEeLRZy7Cb75DCC2XM7YCg1C3TB5+nVoVGCJ
         6JPzYcq3QKRbZgb1dnDC5p90sNB0hf+vZMSt6lyHCprKthtS/olH1Daido4gHAkx2A9a
         8+fRNhVmW51bJGV9rkm3HxiqhKAoHFX7/7Cm9H1gQSvbLCZa5tKSrpI0q1wDDv2qPvci
         1tthpNGJaLznmXoeudeeA/8jbd/Ww52N4Upn7CCVe/lpsdsYOsWn2uLMg699EozPNzPQ
         aU1KUmi+paisVEmkLCvYA3NiLhFvoKzdjO04ybfZBd366tj/502ixlGPsfaZpkYfKAqK
         RO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683000674; x=1685592674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYO+8ufiJMUl+tFlyq77nEenub5XfA757dBhBF51968=;
        b=KbygH0WZq4O3035v3dDn7NGyrMEmforL40s03wVjYvMb5Iwha+dOVAn/rEroW+rlUa
         lxtrGt43MkKpU55KyJu6jsMKraWwxKeYOY80sZ+UL4gHMC8CGBAQcaNdiznYAL2amL3Y
         PfYIQAygvfdVVvC/vKi3x/gdC7zsnjUfTL7JIzg9jxLKEHe/YLGW2Vu3Qyz++XdqmsOf
         Kx1+pjHISUQoB7TBxmDtEXxR36FRlaj8VXzCANWJAoi4LdqaXaZY5ONgrFomdy8ESWRb
         37OWdDMCUf9wUah0tWZW3oIg0z1c+ou+tV9SrJuNijih0LjrVeEao6l44R07p209guho
         pqeQ==
X-Gm-Message-State: AC+VfDzi1sfHo3PgZDKlQS5Vi0o7tW1Buh8fBPENC9JbIxmGzJKzhiOi
        brruGwMm53jmAJoqQ2fh9GMHwsiP3Tc=
X-Google-Smtp-Source: ACHHUZ7ZvzoHZb1oJJX/Qr0hk0G8QzKI7GLyJ6uOYDTzGYwbpaTGzNj2VH9mcnLNatSSte82sq1L6Q==
X-Received: by 2002:a05:6870:8447:b0:17a:e416:b0df with SMTP id n7-20020a056870844700b0017ae416b0dfmr6665470oak.3.1683000674629;
        Mon, 01 May 2023 21:11:14 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f35-20020a4a8926000000b00541b5963069sm646428ooi.20.2023.05.01.21.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 21:11:14 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 0/3] test: new testing framework for libification
Date:   Mon,  1 May 2023 22:11:10 -0600
Message-Id: <20230502041113.103385-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan proposed a new testing framework for unit tests written in C,
and while I agree unit tests can be useful, there's no need to write
everything in C.

I'm of the belief that one should pick the language that best fit the
task, not write everything in the language that you happen to be already
using.

A modern testing framework written in Ruby is much simpler, and more
powerful than whatever can be written in C. This patch series shows an
example of what can be achieved with just 68 lines of Ruby code, plus a
git library with Ruby bindings.

[1] https://lore.kernel.org/git/20230427175007.902278-1-calvinwan@google.com/

Felipe Contreras (3):
  test: add simple shared library
  test: add basic unit testing framework
  test: add basic unit test

 .gitignore       |  1 +
 t/Makefile       | 22 ++++++++++++++++
 t/lib/git.c      |  6 +++++
 t/lib/git.h      |  6 +++++
 t/ruby/git.c     | 13 +++++++++
 t/ruby/testox.rb | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/unit-test.t    | 14 ++++++++++
 7 files changed, 130 insertions(+)
 create mode 100644 t/lib/git.c
 create mode 100644 t/lib/git.h
 create mode 100644 t/ruby/git.c
 create mode 100644 t/ruby/testox.rb
 create mode 100644 t/unit-test.t

-- 
2.40.0+fc1

