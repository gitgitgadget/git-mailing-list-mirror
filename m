Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D692A211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbeL0Q0D (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:26:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35766 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbeL0QZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:25:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so13006938lfc.2
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lolq631b14C8CWNv8wlwbVVhRpj2cxsgThi/9nYpKtI=;
        b=fcGDlYxKxDaCMNXVUY8aOqdw1Am1K0265LzPsO2ugJQh1ElmIK/j6I6sCFIy3kXHJd
         Ua7rLieHdDby9mseL+5KB8oIx1+TP8Xmqa2oLDGfX1DH+s7aRRFjnuUBabSmTPbXUPYQ
         Mvexb6dFNW8WMWED8pLGlYRmJp1Pf/4AcKs4VoUdIUr/vsf9xGHWQ6A2vtk5VNt+3Zmp
         PhFKcixLSh860UIJ917dyh0EqV/3+rrWR+Q19GT5n88XTzTEbRyAFdSMGYcb12gO5mpS
         6xbfXqTZTphn2L9V8cZAcUeWchdP8jj9sKruBltZCxEASR/XHOTQOyfSSiRu+G55J2eu
         hOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lolq631b14C8CWNv8wlwbVVhRpj2cxsgThi/9nYpKtI=;
        b=PETEhUswI781aqVK4gtRFmekspYjNYPQ60Y+0d4DIUtFNqs287m2zZNrUM/KATQqUc
         +7eFOnzNA8LP+WYZiu6yASjtrsl8QzWzaOyisBKaJkbH1+uw9ztlOyrhz54ddSRzNI0M
         OzBgluaf/InieLb6kJEa4df9RqeJ3Untwibxh7cO24ZzZRYmW2vHXSBnmYm4J07HDTe+
         OFhzOwCjf6SAHsM4kSCwJro4FJgBD57VO1gGPLZ3W7TZr7un6L0TrkzWlZATKeMGtzw7
         UROdomyqPJfjpV8VeC093Hnlj6QgeXH7m6BkT+tcpv11WFnV2D3xalYgCGAzoj1V9vdX
         QQSA==
X-Gm-Message-State: AA+aEWbWLLrQ/vErdcktJ9ECyjI7c70lFGeTcvjRT3+V2NU+DLQOgt/d
        ru/Nhbq7p+XNQvk3OcPDG0CzhOE7
X-Google-Smtp-Source: AFSGD/XPw2Lp4Ah/tj7/VFM0TUZr0ZrC/paMYq+G02J5Mpy0smTsJ4Y/bz7XIxI4I5JM3thScOSnew==
X-Received: by 2002:a19:2b54:: with SMTP id r81mr12997082lfr.34.1545927956854;
        Thu, 27 Dec 2018 08:25:56 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:25:56 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/75] diff.h: avoid bit fields in struct diff_flags
Date:   Thu, 27 Dec 2018 17:25:31 +0100
Message-Id: <20181227162536.15895-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bitfield addresses cannot be passed around in a pointer. This makes it
hard to use parse-options to set/unset them. Turn this struct to
normal integers. This of course increases the size of this struct
multiple times, but since we only have a handful of diff_options
variables around, memory consumption is not at all a concern.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.h | 66 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/diff.h b/diff.h
index 4b65ff739f..b71062c2d2 100644
--- a/diff.h
+++ b/diff.h
@@ -64,39 +64,39 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 
 #define DIFF_FLAGS_INIT { 0 }
 struct diff_flags {
-	unsigned recursive:1;
-	unsigned tree_in_recursive:1;
-	unsigned binary:1;
-	unsigned text:1;
-	unsigned full_index:1;
-	unsigned silent_on_remove:1;
-	unsigned find_copies_harder:1;
-	unsigned follow_renames:1;
-	unsigned rename_empty:1;
-	unsigned has_changes:1;
-	unsigned quick:1;
-	unsigned no_index:1;
-	unsigned allow_external:1;
-	unsigned exit_with_status:1;
-	unsigned reverse_diff:1;
-	unsigned check_failed:1;
-	unsigned relative_name:1;
-	unsigned ignore_submodules:1;
-	unsigned dirstat_cumulative:1;
-	unsigned dirstat_by_file:1;
-	unsigned allow_textconv:1;
-	unsigned textconv_set_via_cmdline:1;
-	unsigned diff_from_contents:1;
-	unsigned dirty_submodules:1;
-	unsigned ignore_untracked_in_submodules:1;
-	unsigned ignore_dirty_submodules:1;
-	unsigned override_submodule_config:1;
-	unsigned dirstat_by_line:1;
-	unsigned funccontext:1;
-	unsigned default_follow_renames:1;
-	unsigned stat_with_summary:1;
-	unsigned suppress_diff_headers:1;
-	unsigned dual_color_diffed_diffs:1;
+	unsigned recursive;
+	unsigned tree_in_recursive;
+	unsigned binary;
+	unsigned text;
+	unsigned full_index;
+	unsigned silent_on_remove;
+	unsigned find_copies_harder;
+	unsigned follow_renames;
+	unsigned rename_empty;
+	unsigned has_changes;
+	unsigned quick;
+	unsigned no_index;
+	unsigned allow_external;
+	unsigned exit_with_status;
+	unsigned reverse_diff;
+	unsigned check_failed;
+	unsigned relative_name;
+	unsigned ignore_submodules;
+	unsigned dirstat_cumulative;
+	unsigned dirstat_by_file;
+	unsigned allow_textconv;
+	unsigned textconv_set_via_cmdline;
+	unsigned diff_from_contents;
+	unsigned dirty_submodules;
+	unsigned ignore_untracked_in_submodules;
+	unsigned ignore_dirty_submodules;
+	unsigned override_submodule_config;
+	unsigned dirstat_by_line;
+	unsigned funccontext;
+	unsigned default_follow_renames;
+	unsigned stat_with_summary;
+	unsigned suppress_diff_headers;
+	unsigned dual_color_diffed_diffs;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
-- 
2.20.0.482.g66447595a7

