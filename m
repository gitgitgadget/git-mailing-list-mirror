Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1BDC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbiI3SJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiI3SI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:59 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CAE1E92D2
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c192-20020a1c35c9000000b003b51339d350so5492834wma.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GMI4Tzs1eOf8I3AzqyCeCNihJIdohR8xEaGJ686i+OY=;
        b=Wo7PS2/mjLtAXQVGLP5YLxJk6XPfi5NqkpYBYd7ns+1irF5HPwCe7VwTTXy/2kvIpa
         9MsshzExUaPteJCTDeqmzRxCwbVcAxq0kRzIxQG3bDSEfPXQMYEX/NctoA5ijIaCLu3Q
         TZBVg3jXsf8EYxH0qf5S2ZfZEJJfbmUxgFeu/pgsVjA5kwlAMrYmWHrE3jCVKZy/khdD
         wu5o7HTo9ORouRp2nqX4AvY+Kzm6IrgGmTMexb9//hJmsj1QyFlysl8+R4PkOJsEFRu8
         CeMcF0vx1j4qDyOaqhdQT5vlb09WSbSpFQdpMZGvt8eqwLa30chlH5OPK9e0MXnw+DH9
         5uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GMI4Tzs1eOf8I3AzqyCeCNihJIdohR8xEaGJ686i+OY=;
        b=LGICwpRgqgrPnNvJ3o/Q51S/3PqSGUOiCMCebjksABhgRFzLU4z+4RMhItX5coHpS9
         6Bq0uFh5RPGEcebTv4hU6kRWHBqCk0gRET2c558OroE1UKahPUoiuay3zFMbpQx5LrNW
         9WvNCjyP+Vzw0RaxkkFvYf00pif1uf4aE5O1BhKsxL+jILGKt945wsMcuTIZ6IFcppeE
         geUGmcdHsB73dxL6vxlzJmO/lKea8lM/ebuwWALLAp/T4dqQK59FU5vMfts4HoRmyIo/
         2pJipkOGvRf6SSHECHp48tE7EAmVBDl3Xo54ySPrLUy+K37o8/5Fp2Imokd82tXWKL9/
         nXxw==
X-Gm-Message-State: ACrzQf2FMvE4kuN38RoT3vQ66f8nMzeg/JJWUI5YagJsiIsxadbtKDF5
        2Oj9XPXGMw1A8x/84zRvPt7GTsIngHTURg==
X-Google-Smtp-Source: AMsMyM5spvlffWyP78WZHF9gcxUF8nQLL21ozPd4hb+6TLT5RqiDXB5Y+T0lklJedF0qReYH3eL3pw==
X-Received: by 2002:a05:600c:1d26:b0:3b4:a677:ccc9 with SMTP id l38-20020a05600c1d2600b003b4a677ccc9mr14811777wms.121.1664561331857;
        Fri, 30 Sep 2022 11:08:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 13/36] doc txt & -h consistency: balance unbalanced "[" and "]"
Date:   Fri, 30 Sep 2022 20:07:36 +0200
Message-Id: <patch-v3-13.36-57cbaee9826-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a "-h" output syntax issue introduced when "--diagnose" was added
in aac0e8ffeee (builtin/bugreport.c: create '--diagnose' option,
2022-08-12): We need to close the "[" we opened. The
corresponding *.txt change did not have the same issue.

The "help -h" output then had one "]" too many, which is an issue
introduced in b40845293b5 (help: correct the usage string in -h and
documentation, 2021-09-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 2 +-
 builtin/help.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 23170113cc8..bb138161943 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -61,7 +61,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <format>]\n"
-	   "              [--diagnose[=<mode>]"),
+	   "              [--diagnose[=<mode>]]"),
 	NULL
 };
 
diff --git a/builtin/help.c b/builtin/help.c
index 6f2796f211e..53f2812dfb1 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -88,7 +88,7 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	"git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]",
+	"git help [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]",
 	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
 	"git help [-g|--guides]",
 	"git help [-c|--config]",
-- 
2.38.0.rc2.935.g6b421ae1592

