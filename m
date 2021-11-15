Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC7BC433FE
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 11:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9D461A3D
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 11:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhKOLz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 06:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhKOLzU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 06:55:20 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025A8C061746
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 03:52:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so12819345pju.3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 03:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4FOfgjijEYdrq3Jcj+ZM3LdOuqFpmG74kxtUzYxw9AY=;
        b=deix1zH8vCuyL9QVMcgopPw/w8pAbK9w/wLNg/KgLKycT7MSOIeF2G+Qt5ABII79mV
         kdGLtURNjb1SwkeHP1vnlI6oZw07gPDW2dL6wH0yDoNyj9eEK2pKA1JgpvlfEM5DOAv/
         HmrO35VwC2o5/RaAyTQj8B/8KYzrChu8tmpfGfeVVxXNhZAVxhNHngSrF4UYqDblRpaC
         ueAQVHyPPTzUZz7SGib0eZU1j20462pnJ9kPbboME3levNdz9WiJtjv8bqMzi+JIa+M1
         ggO9LRMHvnHWXQ4uycO9F0T5bkIASy7CEoca2oHJlWopYbJZpqcC+++PDUqG5TiACCHm
         PvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FOfgjijEYdrq3Jcj+ZM3LdOuqFpmG74kxtUzYxw9AY=;
        b=fDVQrulnLj/GSl1K/ZBHzTSntY1QDOigukbBaWYc5oL+AEOWwFfUAfNTkjmdyeNq4s
         BwnJS36ZVA/3tVBYyR2ud/AphFQKgAi5xvZGqLZTviK6AZiqPMOhW1M47cxpuhfVhJP8
         f7senavqH5oktJd9Ff6reGD2rVIILOSN7luDYZnNSMU9GOddUIZwwOw3vCykbUk6qt+K
         ALl4JZMDUhH1BdYg9LEDD6pOVJSXOikZC/VpFMmWbhzz/VDnCz4hyiOyHjECW54VV5j2
         rgsV0dScZWuMFSeISBgUt6ayziQIhTKv7B1n+BjHd0ic9Zprmz27wnYhHVRcjmp3GvVD
         WjFw==
X-Gm-Message-State: AOAM533IwjEdXTSGlCRv/PC9Ow+AXAZrSrxnCsqy1k5wW2I9YLubWPm+
        zIal1Ujw8SZI3pnS5viyXJ0N6tAB1dOqLA==
X-Google-Smtp-Source: ABdhPJwSF7tPB5NOGgMes2csOHJnr/FGjTKYYrCXoc+PGGIZzV+4zbOMaCl7uFSUqRJTaNS7a+efNg==
X-Received: by 2002:a17:90b:4f83:: with SMTP id qe3mr64463135pjb.56.1636977144314;
        Mon, 15 Nov 2021 03:52:24 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id s2sm17543280pfg.124.2021.11.15.03.52.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 03:52:24 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 1/3] ls-tree.c: support `--oid-only` option for "git-ls-tree"
Date:   Mon, 15 Nov 2021 19:51:51 +0800
Message-Id: <20211115115153.48307-2-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.9.g5fbd2fc599.dirty
In-Reply-To: <20211115115153.48307-1-dyroneteng@gmail.com>
References: <20211115115153.48307-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit supply an option names `--oid-only` to let `git ls-tree`
only print out the OID of the object. `--oid-only` and `--name-only`
are mutually exclusive in use.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3a442631c7..1f82229649 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -20,6 +20,7 @@ static int line_termination = '\n';
 #define LS_SHOW_TREES 4
 #define LS_NAME_ONLY 8
 #define LS_SHOW_SIZE 16
+#define LS_OID_ONLY 32
 static int abbrev;
 static int ls_options;
 static struct pathspec pathspec;
@@ -90,6 +91,14 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
 
+	if ((ls_options & LS_NAME_ONLY) && (ls_options & LS_OID_ONLY))
+		die(_("cannot specify --oid-only and --name-only at the same time"));
+
+	if (ls_options & LS_OID_ONLY) {
+		printf("%s\n", find_unique_abbrev(oid, abbrev));
+		return 0;
+	}
+
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
@@ -139,6 +148,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_NAME_ONLY),
 		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
 			LS_NAME_ONLY),
+		OPT_BIT(0, "oid-only", &ls_options, N_("list only oids"),
+			LS_OID_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
-- 
2.33.1.9.g5fbd2fc599.dirty

