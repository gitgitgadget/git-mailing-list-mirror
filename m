Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1EFC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 16:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379837AbiBUQF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 11:05:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379866AbiBUQFz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 11:05:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0112612B
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 08:05:31 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so13875543wme.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 08:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ryaiSl5yPTqTmQWTx6flTKVjknJbIwquk9VI27OVhRM=;
        b=XqOk38c/4QqDzuiHu2bZdCH1BBLlwV7hudreJGMUPXC+pXacAHQdQkIa2/m6T51pXi
         NqLTYKGL45U314MZ6IHDq6plvswotuwsmVtrbBAbs1LmHCcyL4jI99nrSnCswz7+nQq7
         HJdve87OffStdfkdXXf7+ybjAhXJOp3V7PlYswaUNHpEp3n5gXPJPOokuLLgEXg3mia4
         qr+zwjOc6Zw7o1YY4sFpUAGgRtBBc4wowCyMdYGLrkPs+zDEkzTftC32iYxl9CV6I4S0
         O/E34v7km4buH8h5GZddoSxHrUGNRUqNZe0rBPGuKqNqtTRXaECs3SZiH0YM9KqPQMEI
         gmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ryaiSl5yPTqTmQWTx6flTKVjknJbIwquk9VI27OVhRM=;
        b=emQU4BOxORTuRr6OvsSJc5tIbiq0bpuwi+mEkPAZqeWe67OOuL932hcRscLEWAZYOl
         430UWJxqpHYzcAlkWe0EBwgUw6BgGjJ8GJOQsvrUD6B8g+TS7JOFT2sH7rhQ04+CAAzi
         As3igXsiPqEArP4NBHXxAdvh86/uK/gTyQXLCxB7iRiFBtp2oQ5ZBy6wJZ9YRwJXyZ0r
         /gF+k8UxCwY7LtdcQUtTv/deUNvRmDPPQ2VZnamRiTnix5Wbz0RkN2DDuK+FzFcew5Ay
         JNQXaxPuE2la3PBXa8z3f4Np4JhViy80IJ2IxFMYJThn1MrwV4U/4TagGtq2pc08eTOB
         /2QQ==
X-Gm-Message-State: AOAM533AwXApUr3vn4szyvVDxBsKH2/BXxC1jQQDpxis/F0knbTEMT1K
        bz9tR9Xy4zhJm/M5gDEJckdeLnTmkPTomA==
X-Google-Smtp-Source: ABdhPJyHSzFRRQSPOS4/80RnUZDn+WRhuvmZGVtK2X0eaUIcfVkA4k5Mr9GEHSuqIE4ZLY/ULdC1bA==
X-Received: by 2002:a05:600c:2d41:b0:354:24d2:8e13 with SMTP id a1-20020a05600c2d4100b0035424d28e13mr22195310wmg.138.1645459530300;
        Mon, 21 Feb 2022 08:05:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25284207wrz.84.2022.02.21.08.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 08:05:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/2] C99: remove dead !HAVE_VARIADIC_MACROS code
Date:   Mon, 21 Feb 2022 17:05:25 +0100
Message-Id: <cover-v4-0.2-00000000000-20220221T160440Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com>
References: <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I trivial re-roll of v2:
https://lore.kernel.org/git/cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com/

The only change is removing the 3rd patch, per Junio's feedback.

Ævar Arnfjörð Bjarmason (2):
  git-compat-util.h: clarify GCC v.s. C99-specific in comment
  C99: remove hardcoded-out !HAVE_VARIADIC_MACROS code

 Documentation/CodingGuidelines |   3 +
 banned.h                       |   5 --
 git-compat-util.h              |  16 +----
 trace.c                        |  80 +--------------------
 trace.h                        | 128 +++++++++++++++------------------
 trace2.c                       |  39 ----------
 trace2.h                       |  25 -------
 usage.c                        |  15 +---
 8 files changed, 65 insertions(+), 246 deletions(-)

Range-diff against v3:
1:  1a15fe4fd74 = 1:  1a15fe4fd74 git-compat-util.h: clarify GCC v.s. C99-specific in comment
2:  bd0f969be55 = 2:  bd0f969be55 C99: remove hardcoded-out !HAVE_VARIADIC_MACROS code
3:  27ea260bbea < -:  ----------- trace.h: remove never-used TRACE_CONTEXT
-- 
2.35.1.1132.ga1fe46f8690

