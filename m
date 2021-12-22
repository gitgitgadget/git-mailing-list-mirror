Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC7DC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbhLVD7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 22:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbhLVD7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18CEC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a9so2028514wrr.8
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OGgLsGRpc1c3jVcgobwtH1OCfHphbUiZ+J37GIu1g9Y=;
        b=TuGwoD/0ZPMKx/CA/Nh/ukghP4TUr5AYw/xrf28/TjeKA89bV8dW6/9bF847Dkd04T
         Y4wpqPhdEyz+FNjMacBX713nSmljSm7JfcK24gJgd/Vg6bkS2hB4gwV8D/SbkUV3l4YH
         tgBY01M4CM5UdcJOEnjIe/tyHq4uayGV7JSlaKMrN5K/Vyp3o34hwvZYWSDlc1oHUfly
         aHS9lCQmMpxrtGhnScS7S7aJOrENouaqM/0R+3FPx9Oh9JslHMlxBJjbgXjUoOhip+61
         FEuZmznreuEFCHQ8k83UVLZm42hg+Uw5OTXCaWl2k3u7qAYY/kn7dp4IK4EuTdGX4RV9
         TZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OGgLsGRpc1c3jVcgobwtH1OCfHphbUiZ+J37GIu1g9Y=;
        b=o68Ck5OEzDaQ5S6vPV+E73Vk5hBgOdhtAdGe75xSn2c5A6/M5DzYZ6asOEWDDnxXQT
         NEVqgLQ3dAvso4hAC/ULLSuh3QMX5wFZGd3RJGBzyybZD6y0Gmxy0jXmeXBSmPMpYmto
         d+MC0vIo1+a4bjUQidouLqkIlLEKQpmKewHWUWWVqwQC9fJoGjqyWtdbQLgx9pX1U1km
         fvaIKlMVUO6hX+8VBsAYYzFSMR0yBXC5TR75jZG2Ut6xGFNthwbimusV2Yshg8fDQGFy
         isv138Qe3CyI2PU/tlSvj3xBs6DhfHXRncr0KKmsKzJxpb0lII50/BwLbvEDJl5O44oM
         zjrg==
X-Gm-Message-State: AOAM531JZ2RwxGTud6tYiGJ21tC886YqvJo+SYS/IbocJ3ODkD8wEZJd
        Pn6dEXs9HQwBtxzxd+SgimdK0Bt6GCA8WQ==
X-Google-Smtp-Source: ABdhPJwQPG+dNs6Ml6Bd4fn7a4UnJOAC6NO8NjGMNbeIlDrxBJEoQiNT0mux4D205edx1IHqDRjfkA==
X-Received: by 2002:a5d:4810:: with SMTP id l16mr702720wrq.672.1640145588106;
        Tue, 21 Dec 2021 19:59:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 02/17] hook API: add a run_hooks() wrapper
Date:   Wed, 22 Dec 2021 04:59:28 +0100
Message-Id: <patch-v6-02.17-cfba5c139e7-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a run_hooks() wrapper, we'll use it in subsequent commits for the
simple cases of wanting to run a single hook under a given name,
without providing options such as "env" or "args".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 7 +++++++
 hook.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/hook.c b/hook.c
index a0917cf877c..d67a114e62d 100644
--- a/hook.c
+++ b/hook.c
@@ -142,3 +142,10 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 	run_hooks_opt_clear(options);
 	return ret;
 }
+
+int run_hooks(const char *hook_name)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
+	return run_hooks_opt(hook_name, &opt);
+}
diff --git a/hook.h b/hook.h
index 782385cc235..9c358789958 100644
--- a/hook.h
+++ b/hook.h
@@ -48,4 +48,10 @@ int hook_exists(const char *hookname);
  * error().
  */
 int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options);
+
+/**
+ * A wrapper for run_hooks_opt() which provides a dummy "struct
+ * run_hooks_opt" initialized with "RUN_HOOKS_OPT_INIT".
+ */
+int run_hooks(const char *hook_name);
 #endif
-- 
2.34.1.1146.gb52885e7c44

