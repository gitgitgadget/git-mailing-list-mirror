Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7517BC43217
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 19:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiKITes (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKITep (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 14:34:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C596205F0
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 11:34:44 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v27so28607571eda.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 11:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu7RvODAQz8ko9ZmaXDH6B8ZloleFYPTonG6/q7/oRY=;
        b=GJwyK3EgLXdY5diAwskRCvnRGmtr3hmyRFCMFzj8YQdalvO+esjJ2PV5Ik6FQS8Khj
         uOZ6YisYLexhdeo7RZILY4dQgjnVNas8MJP/tznkGDsYbMVBkMxY/8My+NZ7Ld+8FLLT
         DxNtKOy5uXGaYzNSE9sbRCFqojAPRHHkEO5GvvFdrQ0nznbDhUuQg7YQ142zWeMLrOXc
         DVMv+dCek84HM568S01e69bnrqWeLxFpWSsPWKHNO6zF8j2Jvms0WRkKCdZh+qoIb5UE
         MMGI0HiQnI2wTS8U1QotsZAAFyyUKChaRzQ4/AOax7HIZJKAdtlROT5bvrqD7UJrG7s5
         bPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zu7RvODAQz8ko9ZmaXDH6B8ZloleFYPTonG6/q7/oRY=;
        b=q38sjXSDPL4mYay8VTcfiVMeCF+zrk8ta/o0l/XPzatHsmi7GqN+531KWQXEegQpOc
         cgx+FZha+m6hmUpvfpyIrp2n5NYrN8F4dqT+b/hcUgKOBIHIGnYtHAhf0dukuN4Jf9HY
         B8MoLAC+fLORTCtNsKjbHKxgQ2C9svjcR91/SFRSNLJg56oXyAwlBcJVmbqHnwwXXbiK
         kv4TsVBPFR8IyWL/yBoQkrJ4nFDMDwq31wN861eZdgvAsSr1NUis5UuXTXdZUq2kkwEl
         Ukv/B4xqi5+shx/RnfO9+uN2xqwh3mWPmfJv6z/6CdiR9X9Mq1aZJC6F4/3C8zl7tOBv
         jU6Q==
X-Gm-Message-State: ACrzQf25k2uVtvs5BF5Gm9PitLI8ld5Rr4rMIDsJ7/AlLBNI4yNszROu
        wkF+45wU25CWbXOzISaDqdsqyZf5le8ncA==
X-Google-Smtp-Source: AMsMyM6hv8BrrPTB5oxZ9/tDBBzkmT0eXVjNP4qxJIF7a+QWdstmBbAE2Ca+8wGWI2xM/Fw6uwsxHA==
X-Received: by 2002:aa7:da84:0:b0:463:7873:119a with SMTP id q4-20020aa7da84000000b004637873119amr49040418eds.329.1668022482272;
        Wed, 09 Nov 2022 11:34:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q21-20020a056402041500b004589da5e5cesm7387566edv.41.2022.11.09.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:34:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/8] submodule--helper: "deinit" has never used "--super-prefix"
Date:   Wed,  9 Nov 2022 20:34:30 +0100
Message-Id: <RFC-patch-2.8-87a780eb9bf-20221109T192315Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
References: <20221109004708.97668-1-chooglen@google.com> <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "deinit_submodule()" function has never been able to use the "git
--super-prefix". It will call "absorb_git_dir_into_superproject()",
but it will only do so from the top-level project.

If "absorbgitdirs" recurses it will use the "path" passed to
"absorb_git_dir_into_superproject()" in "deinit_submodule()" as its
starting "--super-prefix".

So, let's introduce a "get_submodule_displaypath_sp()" helper, and
make our existing "get_submodule_displaypath()" a wrapper for it. In a
subsequent commit the wrapper will be going away, as the rest of the
commands here will stop using the global "get_super_prefix()".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 427e793e204..c4d5e029b37 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -113,10 +113,9 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 }
 
 /* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefix)
+static char *get_submodule_displaypath_sp(const char *path, const char *prefix,
+					  const char *super_prefix)
 {
-	const char *super_prefix = get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -132,6 +131,13 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+
+	return get_submodule_displaypath_sp(path, prefix, super_prefix);
+}
+
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -1365,7 +1371,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 	if (!sub || !sub->name)
 		goto cleanup;
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath_sp(path, prefix, NULL);
 
 	/* remove the submodule work tree (unless the user already did it) */
 	if (is_directory(path)) {
-- 
2.38.0.1467.g709fbdff1a9

