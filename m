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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26163C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BDC611AB
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhDIIdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhDIIdU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:33:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4FEC061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:33:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w18so5625539edc.0
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r3ZtPMupGOlvs+7DOUC+BEJ5EbgDE4kJIv/weNrQ6m0=;
        b=tHJRMRZEecfJWyuNFxvghQ8VoX5a/cL+FudvsufnYa6Pww8eiA2XRaL3Ha/8wzD4Fu
         7th9I9kKJwqKDEyL2arAlYu9j1LvQNE+XjLKW+0aAvq4BM4mXfWIxWQL4at4Mb8oA/x0
         36JpfG3nHFP2tJh25HJ9BY6/eHjuKVJaCHuRkdMDEuNmL/pQwoUZIkisura8XdghZOdA
         hiyk6de0A+d9mCxYPLSCfmp9L7jmgmGl4acqQKhZ02XFwV28qgbOzUsQEroUA0blKtlV
         EqX1JS4jEd9caJJUIQvtG2eQinwsJacPCOXMR18TkWhi4rOp6pBt1Fjw2PRiM2XvcUdi
         0MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3ZtPMupGOlvs+7DOUC+BEJ5EbgDE4kJIv/weNrQ6m0=;
        b=oS/AoJ8wriXFOIy65pBoLYsoF6V4vj+8zjz2H9ebsSxij8CFixBrBrZzlkQvJXCSjT
         Od6I/fhZVuc4jhYlFO6pdx8kIaIAtsz4Iq7sr4Rqn0POQGobuXhvzMWhZvGl9vgX+FH1
         N7kiESZJoAl0mDc77pTINfUesa3JIRf7oq3PFsogM5hfCh8d1ESmQKL9kjB6EHVHh/FZ
         khDSWUtP8G1Fh1eJalidhQ3yjoom422o3yBZJ64PdCUHAt6asyOqxu/WGl/yaCyrhxUZ
         XCmAw/Xvno5OZHg7ifpF3qMdLQqGSKb365JOqhISeiODLepURw4be7lydtBAKGV39AdH
         rU2Q==
X-Gm-Message-State: AOAM530cCADUPjZS+pI8od52ANPpnFGTMsv8e9ROL5V3OvjNBkJt3gX1
        FOpK7vcgbPe+NgaV6dEeAXyIt9iFCuy5Og==
X-Google-Smtp-Source: ABdhPJzZft0SvNc+lQD7pOCNo+hUBJWY21kw8eqOs2DDAxAPDzjh0rbYfePl54LV+rJsGjMaQrqIqw==
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr16091930edb.135.1617957185733;
        Fri, 09 Apr 2021 01:33:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n17sm1016707edq.32.2021.04.09.01.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:33:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] object.c: make type_from_string() return "enum object_type"
Date:   Fri,  9 Apr 2021 10:32:51 +0200
Message-Id: <patch-3.6-7fd86f6699-20210409T082935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the type_from_string*() functions to return an "enum
object_type", but don't refactor their callers to check for "==
OBJ_BAD" instead of "< 0".

Refactoring the check of the return value to check == OBJ_BAD would
now be equivalent to "ret < 0", but the consensus on an earlier
version of this patch was to not do that, and to instead use -1
consistently as a return value. It just so happens that OBJ_BAD == -1,
but let's not put a hard reliance on that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object.c | 8 ++++----
 object.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/object.c b/object.c
index 5477abc97c..2216cdcda2 100644
--- a/object.c
+++ b/object.c
@@ -35,9 +35,9 @@ const char *type_name(unsigned int type)
 	return object_type_strings[type];
 }
 
-int type_from_string_gently(const char *str, ssize_t len)
+enum object_type type_from_string_gently(const char *str, ssize_t len)
 {
-	int i;
+	enum object_type i;
 
 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
 		if (!strncmp(str, object_type_strings[i], len) &&
@@ -46,10 +46,10 @@ int type_from_string_gently(const char *str, ssize_t len)
 	return -1;
 }
 
-int type_from_string(const char *str)
+enum object_type type_from_string(const char *str)
 {
 	size_t len = strlen(str);
-	int ret = type_from_string_gently(str, len);
+	enum object_type ret = type_from_string_gently(str, len);
 	if (ret < 0)
 		die(_("invalid object type \"%s\""), str);
 	return ret;
diff --git a/object.h b/object.h
index ffdc129830..5e7a523e85 100644
--- a/object.h
+++ b/object.h
@@ -93,8 +93,8 @@ struct object {
 };
 
 const char *type_name(unsigned int type);
-int type_from_string_gently(const char *str, ssize_t len);
-int type_from_string(const char *str);
+enum object_type type_from_string_gently(const char *str, ssize_t len);
+enum object_type type_from_string(const char *str);
 
 /*
  * Return the current number of buckets in the object hashmap.
-- 
2.31.1.592.gdf54ba9003

