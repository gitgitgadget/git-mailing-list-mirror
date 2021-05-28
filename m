Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B8AC4708E
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3858611BD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhE1MN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbhE1MNV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDBCC06174A
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x7so3047525wrt.12
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qh1W8CHM+5quh8R+f13/jE7JfhopytkR4b/WfPwdz7g=;
        b=odVmvP/64er/FdFtlZDDB91St65WFU8pPdorAWrVGLbq2IxuuD16MM6rsksVH+Va5i
         Ex9rW5FdBM3KPt5J++eFvNygBZS4QNW24TevuJErDq2ROFszTlCuJfIcMRC8oLDVou3x
         cGZt+MlLuoD5tHjWum1hznBmXG8rwy5nnERwXu6jzoD6H8SkTWIcQTjX1L4EUWl9GRoc
         vUlKmv/fL+bYJMl3nExu/PwlRxV2W9G1xk19UkTlgoz5EsZkHiyg5/i3X43+eQ13CGoq
         MtuitHnrx+TUgvC1VZoqW5FkuIjHdRbgOnvGmuX0gLW4gSY5PnLBK9bzcNPVeT908fyk
         355Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qh1W8CHM+5quh8R+f13/jE7JfhopytkR4b/WfPwdz7g=;
        b=SHXdVyXcSwVVPx+nwQRpTqOUFH0hY4eQ2+Mu+vdylGDfk6adn7KnxnXfdHmR9CDTw6
         PdKbvIbQ3AeV+rHwhMfBKkNY30MRlFYlEclBBekhP6LK1CpxWSba/8KIUmLabzJP8uS2
         eCEtGQnr4NbRHPl3LI4GQO08QmI/ON1jItZyX19h5GbvXACCHfaVbUXvNvtalExWG+tg
         n2qU+1hXfQOod426znkEirZAQ6EFBK5YkKVbuoxQHENIiliKiIGylPBD45l/Kx2/zSGs
         8ibxPa3eIU5CuSzDjXFz3GPwyLHzmxjQH7l558l7sjk0U4s9qnErwv5FOSiCejiBxkVp
         98eA==
X-Gm-Message-State: AOAM532cFdcNLR2RzSCzluX1+9pJ6AV19OPixvsRKYfiaD5HouN8Zr/J
        2sR7zaU17ORrbRGQT/zSoyf9frA7xGXLlQ==
X-Google-Smtp-Source: ABdhPJyEkWHn1F94NIRZFKpvMJ/FOwFqUCXmLX6E2kQZ7o+5zUutq2xT9lLjqButNCTCJ0ngfmU3KQ==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr8171587wrq.44.1622203905046;
        Fri, 28 May 2021 05:11:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/31] hook.c: add a hook_exists() wrapper and use it in bugreport.c
Date:   Fri, 28 May 2021 14:11:07 +0200
Message-Id: <patch-05.31-a6f0817ad81-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Add a boolean version of the find_hook() function for those callers
who are only interested in checking whether the hook exists, not what
the path to it is.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 2 +-
 hook.c              | 5 ++++-
 hook.h              | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 596f079a7f9..941c8d5e270 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -82,7 +82,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(hook); i++)
-		if (find_hook(hook[i]))
+		if (hook_exists(hook[i]))
 			strbuf_addf(hook_info, "%s\n", hook[i]);
 }
 
diff --git a/hook.c b/hook.c
index 06842f50e5c..c7da273822d 100644
--- a/hook.c
+++ b/hook.c
@@ -36,7 +36,10 @@ const char *find_hook(const char *name)
 	return path.buf;
 }
 
-
+int hook_exists(const char *name)
+{
+	return !!find_hook(name);
+}
 
 void run_hooks_opt_clear(struct run_hooks_opt *o)
 {
diff --git a/hook.h b/hook.h
index 291ee19469a..cbda7746a5d 100644
--- a/hook.h
+++ b/hook.h
@@ -44,6 +44,11 @@ struct hook_cb_data {
  */
 const char *find_hook(const char *name);
 
+/*
+ * A boolean version of find_hook()
+ */
+int hook_exists(const char *hookname);
+
 void run_hooks_opt_clear(struct run_hooks_opt *o);
 
 /*
-- 
2.32.0.rc1.458.gd885d4f985c

