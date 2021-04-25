Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AF5C43461
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E9960232
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhDYORG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhDYORE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0EAC061574
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p10-20020a1c544a0000b02901387e17700fso3664623wmi.2
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/S2cCAihu244sZ8mK3Psrc+xkBPmsXsW5gez3ZTu/JU=;
        b=nSLfBqYuy5oNkqFHHBOt3wPAjMXgbzzjPEyc7ovjcOMSaPgQJMSo/6qLt5QfQiZJAG
         2XsLJDrjJ1ZnfwmS4kbB4pLTIxHxXJe1/hu9aMakldRAgcKs7OWNb6XQr/jPo+tQDjma
         7diPse5QsOvWrvyZ65baepp7xAHzc8U/SZD8cYvDd/8zfNi1EPshi/7Envr2CZFfWQkv
         4WRIJOKgKSms7LaiHCu90c9wV0P80nL5K/OvDe40SF/T0K8d9biFo5XVFdzJoAK6GQFc
         lsJ6f76dTKnjT1+OZGQOK8m7h4rciw0hVuwm1aNV2DFFgqa/tRt6QWXSCprGEAiCkmZ9
         xqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/S2cCAihu244sZ8mK3Psrc+xkBPmsXsW5gez3ZTu/JU=;
        b=iulbCgywljIIEGnYoKr+TnZ7BioeLmBwEXElQvL8lV9F9Xv8vjB8lbB+Do68mbcFzI
         N4ChlcOufAXNbUsIloeBTA0JZME4EydBHostFknbYVG3zQTGC52VXMAvrrLSb4Nhbqn5
         2BEVHuNjL0OSUSZbVjt9YWCRp9dtDm1vsY0zGZJfJvMEO04J7eSNWs2hmSXeOQFnLOWq
         5TDvcSxZ/3q9bhZitNWTDWhGzXSETA0qp5/KgIcBWKlO3IpCi9DiUmFgQUcfph6YZMTF
         9drjBwZIiCSB/P+QDz9vRvMHDTg90Rpl1PSKK+yBR6OTE+6O7z3JnXs6KtwQlwjza3Tu
         CfIg==
X-Gm-Message-State: AOAM5319eqhOaC0RKKKjDWjG0LUoMwiD2bMZjXEZ79InkDX4+BuqrDS9
        s+fVLUi/guSBdR4PcvbMI4JwNXJTRc4=
X-Google-Smtp-Source: ABdhPJwS2/9pd2DewL9ZxGRtvkfB52gp6IZ87tsOpj15R5UxzPDmb6pyyiG9ZdNZfGbR6krDMJHOFg==
X-Received: by 2002:a1c:a7d1:: with SMTP id q200mr15255615wme.13.1619360183523;
        Sun, 25 Apr 2021 07:16:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm1744797wrl.11.2021.04.25.07.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:16:23 -0700 (PDT)
Message-Id: <76519acdfee7b7f45dc1a8b52b2083fb4fa03b3f.1619360180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 14:16:10 +0000
Subject: [PATCH v2 03/12] ls-files: free max_prefix when done
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

common_prefix() returns a new string, which we store in max_prefix -
this string needs to be freed to avoid a leak. This leak is happening
in cmd_ls_files, hence is of no real consequence - an UNLEAK would be
just as good, but we might as well free the string properly.

Leak found while running t0002, see output below:

Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x49a85d in malloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9ab1b4 in do_xmalloc wrapper.c:41:8
    #2 0x9ab248 in do_xmallocz wrapper.c:75:8
    #3 0x9ab22a in xmallocz wrapper.c:83:9
    #4 0x9ab2d7 in xmemdupz wrapper.c:99:16
    #5 0x78d6a4 in common_prefix dir.c:191:15
    #6 0x5aca48 in cmd_ls_files builtin/ls-files.c:669:16
    #7 0x4cd92d in run_builtin git.c:453:11
    #8 0x4cb5fa in handle_builtin git.c:704:3
    #9 0x4ccf57 in run_argv git.c:771:4
    #10 0x4caf49 in cmd_main git.c:902:19
    #11 0x69ce2e in main common-main.c:52:11
    #12 0x7f64d4d94349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/ls-files.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 60a2913a01e9..84448b360120 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -603,7 +603,7 @@ static int option_parse_exclude_standard(const struct option *opt,
 int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
 	int require_work_tree = 0, show_tag = 0, i;
-	const char *max_prefix;
+	char *max_prefix;
 	struct dir_struct dir;
 	struct pattern_list *pl;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
@@ -781,5 +781,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	}
 
 	dir_clear(&dir);
+	free(max_prefix);
 	return 0;
 }
-- 
gitgitgadget

