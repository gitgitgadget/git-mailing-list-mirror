Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26316C4320E
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 08:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E6C61002
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 08:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244467AbhH0IEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 04:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244547AbhH0IDc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 04:03:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6379AC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 01:02:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d26so9158232wrc.0
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8pfuCCAQFFXiFIOeZnyKNFXFe57v83TKVFlSA+4p9R8=;
        b=i8ZjN7YmRt5U6ww/OIG93eXiIM2PWdZTcrT+BTr/iIsRWfOioemCaOFucRNZEQ+oRO
         k7qcxJP7rdMckMU3xHx058a0UY4TtLjUur25UATT2Wh27s8OYE8Ck67HLQ+S713g+fqE
         5gyFBYRsutW1Tkai/gw9Reh4WOpmeTa2iKoleT/YzB+lctSjVjQ2A5auDpKdCNubZ3kl
         qMwc1T0hrhJNytT73MeZX4hr1xTmXusU1OesGildCDbzKHh17ARi6o4MOyaDDY+JrU5E
         r+QuDE2PM0gm8GSgWtbfW55vQuhszDCGg0CPjcDExUULnFAr3swg22taAqXX2mXrN4F6
         chVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8pfuCCAQFFXiFIOeZnyKNFXFe57v83TKVFlSA+4p9R8=;
        b=hRgJYvXOdlyPnj3qFUdQjjO5Oe0ABhtWFLMmZ7gXpFuQPFzswxSzNc2CEAIR86gjZC
         IhBqx2a/Zo/tg7K1slLFaQbPyBISj+GWYA0UYeuJDC8Yj6+nMTJYsMeYH2fDh2mU2MDA
         G2pIZKQ3nbpvYukUWxd8d9RzwZk8oO0QpmQW4uxBQ99rn6OX/AY0XR2CXJzpizB4nLtF
         wREP+HGy2LXgiFRCuzxzlOtOLPiu7hwqNwLqcoiJaY+NTEJO9nhcg7GQJHaXhPj2/DbI
         ajdd2XmmwRoUd9sVcuLen78YN0ltJ4vfoZsRCvw/n0BfMtpi4qUCqxENNMa6bJQCiTe7
         rfAA==
X-Gm-Message-State: AOAM532et3LeVHdPYXj5bqEJoBUPBIDTKHlCLkJk5p+YiridqIxPz+W3
        PKyy3fLEUX/utQuuQ9Qf40+aqAcuCsxU/w==
X-Google-Smtp-Source: ABdhPJzeL7cHqtbBT67E8aBUHL5/QfGONyEkXQJCFD6NLQR4nYKFjX13iqG1U6uog+gmrQUsVbV/Cg==
X-Received: by 2002:adf:c390:: with SMTP id p16mr9054647wrf.105.1630051343732;
        Fri, 27 Aug 2021 01:02:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z137sm10922636wmc.14.2021.08.27.01.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 01:02:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/6] tr2: remove NEEDSWORK comment for "non-procfs" implementations
Date:   Fri, 27 Aug 2021 10:02:13 +0200
Message-Id: <patch-v3-1.6-306f14a0f7-20210827T080054Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.736.g68690aaec9a
In-Reply-To: <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com> <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm fairly sure that there is no way on Linux to inspect the process
tree without using procfs, any tool such as ps(1), top(1) etc. that
shows this sort of information ultimately looks the information up in
procfs.

So let's remove this comment added in 2f732bf15e6 (tr2: log parent
process name, 2021-07-21), it's setting us up for an impossible task.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/linux/procinfo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 578fed4cd3..15a89676c7 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -25,7 +25,6 @@ static void get_ancestry_names(struct strvec *names)
 	}
 
 	return;
-	/* NEEDSWORK: add non-procfs-linux implementations here */
 }
 
 void trace2_collect_process_info(enum trace2_process_info_reason reason)
-- 
2.33.0.736.g68690aaec9a

