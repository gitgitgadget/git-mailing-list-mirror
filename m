Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6E7C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjARMrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjARMqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:24 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47608EFFA
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:48 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v6so49267971edd.6
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XYzzDZOSUDBBe1ZGCFYhwfsb6htnueNwPuJIfYkT3Q=;
        b=RC1gXhAtnzvL5FA0asP7Zq4fX2CfLFF6hZrhxsA9CAGJ49y6Y7gj0JCPr4tpqm1bVJ
         lkm0lH1izoiogFvKkwhYVFHhv+tCHrnWX6IFVOnwncul5hiBf4NCIAzi3g+549Ioa9nU
         oz597l0yYfQmRyTR9as/CubBGFBVc6Ele1uGwNwp+PKaI8UnseSEeevHVOssYml48TmB
         lHuOtA915GbbSABaGW9yg2MXVMjWIlWC0DH6tCWy+im86GV5HjuYLMH25bj6W5H1/PD+
         M8sgB9CxykYuOm67lld8rU9NBskChb/EQLgopkhbdI6BJlP9R6k5JPg8iSjLyoZEYgel
         Z5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XYzzDZOSUDBBe1ZGCFYhwfsb6htnueNwPuJIfYkT3Q=;
        b=pTd+jjmMt8BlO4ej0BBOXBCIH2BgBt+/wJCKIEbVDIJxUUTACnIt8wWOoX7pgqQaFX
         ogZHkRJqYb2nwaXo5x/QbHbvQHnIHTWGqUooqBZOW7A8GSyFPkfqq9cn3XzfAWTbCoCG
         Z/8KdF3saLinlaq2gvjK20mccrFte0mLMc5j9OYyQn3RoJuW8v07WDcjGVcZFtVw2Mvx
         Wgwzr4wY4Na+XJ4XfqG3/KiZWHeaAkZnEngYTvZuFXjrb4K5WnU9Yjzxq4Sw3jA6zFDj
         S3A/YsVUMPvYLwb5rJ2HBh14lJrRRp+RX06a4/B5BlDhb2NBiV9WUJZXWMTHZFt2dnCH
         Z8hA==
X-Gm-Message-State: AFqh2krcBoUMdvRQSQHvr0Lc+KpS7N/XeqUL9xC88f6h09jQYlVhDaag
        TJepiSTbfwYGMn8if4f3Ku7ha/w+hsJ5Hg==
X-Google-Smtp-Source: AMrXdXt/hl0HHU52RoVPZrFUoBzlOcVZ8ucmq/P90MJr7R42PDSEDCQERyUagCSWci7kKYzrX57mKg==
X-Received: by 2002:a05:6402:380b:b0:492:bf3d:1a15 with SMTP id es11-20020a056402380b00b00492bf3d1a15mr7504279edb.1.1674043727071;
        Wed, 18 Jan 2023 04:08:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 14/19] builtin/merge.c: free "&buf" on "Your local changes..." error
Date:   Wed, 18 Jan 2023 13:08:27 +0100
Message-Id: <patch-v5-14.19-15e4b8db805-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug a memory leak introduced in [1], since that change didn't follow
the "goto done" pattern introduced in [2] we'd leak the "&buf" memory.

1. e4cdfe84a0d (merge: abort if index does not match HEAD for trivial
   merges, 2022-07-23)
2. d5a35c114ab (Copy resolve_ref() return value for longer use,
   2011-11-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 91dd5435c59..2b13124c497 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1618,7 +1618,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				error(_("Your local changes to the following files would be overwritten by merge:\n  %s"),
 				      sb.buf);
 				strbuf_release(&sb);
-				return 2;
+				ret = 2;
+				goto done;
 			}
 
 			/* See if it is really trivial. */
-- 
2.39.0.1225.g30a3d88132d

