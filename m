Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FE2C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiI3SJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiI3SIt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3CD1E2FF9
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b7so383290wrq.9
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=56sFvif3yWLTQpcEnyr9s6aVhZ/Sp0bZLz3XBFUJCEY=;
        b=HdaTlMoLbw/7jeM2mGQ0oN5a+DS6bMiAAvMXl2aRnzlE4qtykrUbdAfEr+92Mk1dYu
         QrScT2QMjeRgonkL/KR1YK5VVqVYwjYDd9HstnM1CRSnkvYybkyvWa5J2zgdxOP32rRN
         7gscPPXADamwLdgMpbS6tHqj6YNQBPK6iPGuDk8HUZVKPYFAeWnj8Ga8zulhaOZKvHPu
         EAx7k//563SbvfZv/brAKDZsIHautaCZtqyGf2/GZK8h5gotDGO76rD6so9clEYU8S/u
         OMUhFVdiMLGglPUhduhul6vShPI4a/Q+yKbniVb15wB43fFbXxw46FmdouTBo7WindlP
         fjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=56sFvif3yWLTQpcEnyr9s6aVhZ/Sp0bZLz3XBFUJCEY=;
        b=m2Q21eAZFSSmowzjkmlozZd0c+8+UYq8+YBjz92yQHiHYDEavAG/saCYpGproMU06C
         0p652/KX4gB33FXs1JNLB+AroNScvXlH4rVzhEOH9y+ZnlAKWiV9J6Ru3f8Zc/nb7sBa
         bKWRNO79eWt3+2DrmRuHlxczby7gvHfdcepSHKN3kDfgLbYZpm0LvNhxUOqMt41Nrpxc
         3gaIXV10jF4bxOTLXc3XVLOgrfkKWeBTzQxgqv7sxn3XDEMd6tZ7NpG3pqNtpy1TbwIu
         JN5bnP9duqtFcIX7OkZKMkaMaBzdTVriHR1VMx5tZHfHXXheJLWppVg5u4Z10FSM4bnb
         QGww==
X-Gm-Message-State: ACrzQf2IEL4rglF8LCNNZ0vfrR2oY4eUAUg+OM/StwJbfPH4z24p9FP0
        GEuJlAug30IEG2znuOcWVzLpqSithMyPmQ==
X-Google-Smtp-Source: AMsMyM6LFEoPTXvXavjCtXv0NXzWi+kWfz5fvUwnLHGGrpc1k17aZJKkbQz2l+Ix+aGh0xonphlqbg==
X-Received: by 2002:adf:f347:0:b0:22c:be39:4e38 with SMTP id e7-20020adff347000000b0022cbe394e38mr6394909wrp.151.1664561325657;
        Fri, 30 Sep 2022 11:08:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:43 -0700 (PDT)
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
Subject: [PATCH v3 11/36] doc txt & -h consistency: fix incorrect alternates syntax
Date:   Fri, 30 Sep 2022 20:07:34 +0200
Message-Id: <patch-v3-11.36-7794c3d6ef5-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the incorrect "[-o | --option <argument>]" syntax, which should be
"[(-o | --option) <argument>]", we were previously claiming that only
the long option accepted the "<argument>", which isn't what we meant.

This syntax issue for "bugreport" originated in
238b439d698 (bugreport: add tool to generate debugging info,
2020-04-16), and for "diagnose" in 6783fd3cef0 (builtin/diagnose.c:
create 'git diagnose' builtin, 2022-08-12), which copied and adjusted
"bugreport" documentation and code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 2 +-
 builtin/diagnose.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index faa268f3cfb..23170113cc8 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]\n"
+	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <format>]\n"
 	   "              [--diagnose[=<mode>]"),
 	NULL
 };
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 28c394a62a5..474de9ec647 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -3,7 +3,7 @@
 #include "diagnose.h"
 
 static const char * const diagnose_usage[] = {
-	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]\n"
+	N_("git diagnose [(-o|--output-directory) <path>] [(-s|--suffix) <format>]\n"
 	   "             [--mode=<mode>]"),
 	NULL
 };
-- 
2.38.0.rc2.935.g6b421ae1592

