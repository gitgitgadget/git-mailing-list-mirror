Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE8CC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C323A613C8
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhKSU3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhKSU3b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 15:29:31 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB1FC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:26:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso11387625wml.1
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bewm+Z2PZnN0S1oItsLi+oCRzo1+DqWF9hFZtmZGM3c=;
        b=R8Ki8Lg9mzQpj1kSNKcDmH+VTA1o7mmlZNwBU6YuTBfAVWtzVqO7xjMkkOzxPsWa+7
         kbUDfgBV9FAJ4C3HjAEoRuoc1eAzui0i8e+DZRBPV9K0gIq7NZS81biiGV+onjVOtzpa
         YJXtxWwBOEK1qIStDJDrMTx6CegEjmgGFe22W1BPC9WpvpcwkJgIikoGm4HLcMXhm4Cu
         ysiCUsI7N1KLJ9eT/gCez+7SXmkZDwYiAt/1lP96UcFN3v7l3iQLTOY0L0k/KoIZOTL4
         XmVBediLEbWZPEwNGG7YEA+dxabKAz5QrYqJZKQxToB5fiuscE2D+zI/PsahbuPCvwc1
         9Kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bewm+Z2PZnN0S1oItsLi+oCRzo1+DqWF9hFZtmZGM3c=;
        b=l2vAZolfcHfrz5BQGbBRAb3OzYi4dWhiRzWqvPxXFUCaMytwt9NrI/6kUVNxm/nVNE
         I8LM5zj/HDpN5X0v/7mLg9PdWdlWWLclpGnqcqQyAiWJ8b0+qfM1WTLcXkNAb3fBm7kY
         evxkFHqi5U+vJOGMNcynOPzpjwH44cEOWUpbkCDYnY9mQ2RKzORJl+TfaByOIqshcofM
         PfMpvYqz8IAmowqun+Ji5+RG/XsuCrTt7CVCcYHJxzeSaEtFZogrpQPrJ3yY9pu6zcww
         2Gmqd1POZ/jNK/56IWOGQ+XRQPyw7Y/OU0nrT5IACSTEHq9YIJKBd1O/37fmvxMJFMDQ
         ynAg==
X-Gm-Message-State: AOAM530UEaUgQR4cka1QZM4tME1nxt8KEd4c8kBvolioq/VyCToF4WuG
        fagn6ybkBoi/4BQfPK646rFnmR7BubrtKg==
X-Google-Smtp-Source: ABdhPJxDKEsVINwiOvNzQR+DtQGgq0IBC4KWwqCuUplGZCV8xIa1rvsNqjD3W9XydFEJKwXW398sTA==
X-Received: by 2002:a05:600c:253:: with SMTP id 19mr3000231wmj.179.1637353587525;
        Fri, 19 Nov 2021 12:26:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg14sm856202wmb.5.2021.11.19.12.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:26:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] various: remove dead code
Date:   Fri, 19 Nov 2021 21:26:20 +0100
Message-Id: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove various bits of dead code. Addresses feedback on the v1:
https://lore.kernel.org/git/cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com/

There's the minor commit message changes seen below, and the strbuf
change has been ejected per Junio's request.

Ævar Arnfjörð Bjarmason (5):
  xdiff/xmacros.h: remove unused XDL_PTRFREE
  pack-bitmap-write: remove unused bitmap_reset() function
  object-store.h: remove unused has_sha1_file*()
  alloc.[ch]: remove alloc_report() function
  json-writer.[ch]: remove unused formatting functions

 alloc.c                                       | 19 ---------------
 alloc.h                                       |  1 -
 .../coccinelle/the_repository.pending.cocci   | 15 ------------
 ewah/bitmap.c                                 |  5 ----
 ewah/ewok.h                                   |  1 -
 json-writer.c                                 | 24 -------------------
 json-writer.h                                 |  3 ---
 object-store.h                                |  4 ----
 xdiff/xmacros.h                               |  1 -
 9 files changed, 73 deletions(-)

Range-diff against v1:
1:  32bb8ad4de0 ! 1:  1e7e6d8d482 xdiff/xmacros.h: remove unused XDL_PTRFREE
    @@ Commit message
         generator, 2006-03-24), but none of the xdiff code uses it, it uses
         xdl_free() directly.
     
    +    If we need its functionality again we'll use the FREE_AND_NULL() macro
    +    added in 481df65f4f7 (git-compat-util: add a FREE_AND_NULL() wrapper
    +    around free(ptr); ptr = NULL, 2017-06-15).
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## xdiff/xmacros.h ##
2:  826027d2cd5 ! 2:  c9026af8953 pack-bitmap-write: remove unused bitmap_reset() function
    @@ Commit message
     
         This function hasn't been used since 449fa5ee069 (pack-bitmap-write:
         ignore BITMAP_FLAG_REUSE, 2020-12-08), which was a cleanup commit
    -    intending to get rid of the code around the resetting of bitmaps.
    +    intending to get rid of the code around the reusing of bitmaps.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
3:  62ed0ec6077 = 3:  6d0ca249001 object-store.h: remove unused has_sha1_file*()
4:  bd8aa9b1554 = 4:  672bdffde83 alloc.[ch]: remove alloc_report() function
5:  642eec3d77c < -:  ----------- strbuf: remove unused istarts_with() function
6:  e14ee1f8c47 = 5:  818f1a46d66 json-writer.[ch]: remove unused formatting functions
-- 
2.34.0.823.gcc3243ae16c

