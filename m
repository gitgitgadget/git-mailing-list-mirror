Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172EBC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbiA1M4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiA1M4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:56:51 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3C4C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id p7so9629207edc.12
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wOy+4qZVsI2VQDjFq2FzKO/9en8oZYsolTRq1NJBBE=;
        b=MOHIJ1cNBolBW4+JYTXHB1AhdefT7oWLvGUNeYWoPBTLchtrCvBNiXgshZelQj0GCJ
         ODNHEj+nvJijJ79NN6rzdP4hybYJvQcrArfTnQ7W+vbElYb3ySsh6nE5nCo0GkxcHamp
         urrG02A3u2+aMqQInw5K+wZDyp2wkSArWoJ63NgUa6fppYkQsuZzNREnPfwj2o+to+ri
         E/IYeuumP+piDpMniLJu6gh3DJznqNz6RtCbUyMuxQJERjOvGQY/HFnhCOsxTY8s/Cjb
         fxI6X9NVOsvyaVynCgC/ltOoEoHKwCbzTPKS3KZHi90syl7lP0k20kgJgw17lmqPymnb
         1ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wOy+4qZVsI2VQDjFq2FzKO/9en8oZYsolTRq1NJBBE=;
        b=0P7+TYSyXGJssdAAMuHdTEK9Nx8fIDG7laZcK5tLs1Zvxv8iCwRsmRA4BzRiuLbw2F
         kg/BsJgej6eKek+nX+CQxDWNejk+i4uSIJwWxn+xelUhLyioc3EFYPxqr7+AaSn5QJnL
         cQwaifFWyyaIYi7IIVggqnfGuCOeuGg9KL9O30dACQwkGHleHU1w6lv2CCNfpO1wQ7DD
         YtV8gSB8fkn4aDa5Vojt0PZnGKufjmuadCgDKUcluHXNC12JjfZjHAx8ZlGrqmhG38AS
         6+xgMVIOIKMGADRFvIPFk7fv7S6eHc30QDQvJfaXijqN3d5wW9yUflGTl+2NIHHlT9J7
         +mbA==
X-Gm-Message-State: AOAM531D8K1dtxZE0ZFkH+67MUBbtRV4MnN6jyh8pmTbGwjWGXRfzxYy
        AoL18HJ4tWdC7z43sE4BkerU6tZpgSVhgw==
X-Google-Smtp-Source: ABdhPJzs6UrVEf6apaed6JTihI5u/4Mm2YYLS80thWRlIYvTuWoLN2ZPfCi6kyOoY+M2/+OFCdZ3Ew==
X-Received: by 2002:aa7:cb8c:: with SMTP id r12mr7965478edt.164.1643374609622;
        Fri, 28 Jan 2022 04:56:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g8sm10154691ejt.26.2022.01.28.04.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:56:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/9] submodule--helper: allow setting superprefix for init_submodule()
Date:   Fri, 28 Jan 2022 13:56:34 +0100
Message-Id: <patch-v5-3.9-e2cc7f0e23b-20220128T125206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.914.ge5c8aab0d5b
In-Reply-To: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We allow callers of the `init_submodule()` function to optionally
override the superprefix from the environment.

We need to enable this option because in our conversion of the update
command that will follow, the '--init' option will be handled through
this API. We will need to change the superprefix at that time to ensure
the display paths show correctly in the output messages.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5efceb9d46c..09cda67c1ea 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -606,18 +606,22 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 struct init_cb {
 	const char *prefix;
+	const char *superprefix;
 	unsigned int flags;
 };
 #define INIT_CB_INIT { 0 }
 
 static void init_submodule(const char *path, const char *prefix,
-			   unsigned int flags)
+			   const char *superprefix, unsigned int flags)
 {
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	/* try superprefix from the environment, if it is not passed explicitly */
+	if (!superprefix)
+		superprefix = get_super_prefix();
+	displaypath = do_get_submodule_displaypath(path, prefix, superprefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -691,7 +695,7 @@ static void init_submodule(const char *path, const char *prefix,
 static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
 {
 	struct init_cb *info = cb_data;
-	init_submodule(list_item->name, info->prefix, info->flags);
+	init_submodule(list_item->name, info->prefix, info->superprefix, info->flags);
 }
 
 static int module_init(int argc, const char **argv, const char *prefix)
-- 
2.35.0.914.ge5c8aab0d5b

