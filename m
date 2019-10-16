Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1591F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 17:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbfJPR01 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 13:26:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46775 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfJPR00 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 13:26:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id q24so11564377plr.13
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C3YuEIen6oY5te54nvxV9MMtvxW235lOUN23NKfdvM4=;
        b=P9bkjaVsQLd043BulCITmhLTeA/s4DxoR645BqUFryLE3PMFjpARR7n1SQNGldGrbn
         fZuibZwj33wglkJZDSTPlV3t3s4MHfTjJEmZtYNX9Om/947mNb3cxuq/ded32siUWRz8
         fJvNfhNZNt+fESGOuVAR8MLm/VimKnuGSLDWXNWdFJACgQLnozkrctCdPzh8KhXIpg0c
         i3hSzGeTw7joLc1Ye3t9gF4te1BL4xXitEZvQq8ddedbS5OQgZ7pIZFZnsvPJ+Qcftl/
         yqhN3IyNHZxBS22MF6UJDZoAWz4Ak7t+mFK0DXjYnQhnfKk8JDWiMGA3d7aeUORWSGOm
         OL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C3YuEIen6oY5te54nvxV9MMtvxW235lOUN23NKfdvM4=;
        b=HVaC6NrSdIh45gpvYKG/22A4OGIGmPqyL/gNKrjaiTu8Z0WXQX/S+sYNd+t/z/TSiX
         ME4jTWYm2ICwlVA6cxMNywkMa7SNwdxGscne4MWNkBpuUAsDh9ywxXc5uT6YKI4vjkP0
         KPiQBZ2k3IYMtbgAyXdsE10svonpIPE8NxKXA9knM2g4pXVaG6ZquvW/OADtKoFJPMfh
         j4p5hW/rjyTeAuoC49yMQRsob2TSb6t+o8X/WMPPrhU/BnewvfKxUhFoeMnvpJ1AAzYo
         O4wB7dWtgkbImT1ZjIkfXeku5mD1QOQNQb+hzo65N3XojPSB7shR1l4ENetKiKrgfTlI
         hg0w==
X-Gm-Message-State: APjAAAXf4d3piR4yqboCP4lj5YJxsLtFvRRGUVcz/wX5uTeJBNrjFAY4
        9Rp4+3s8zmEazE9pQiygqU+AVYKP
X-Google-Smtp-Source: APXvYqwa1Y6GURMYrj5rZAAN51zTV1RdDPvUk7eiOy5yi7WnbViGKwE+bCGHDeffSYX0VMyFp3NQSA==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14mr42384496plo.287.1571246785526;
        Wed, 16 Oct 2019 10:26:25 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id z25sm25957840pfn.7.2019.10.16.10.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:26:25 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:26:23 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 2/7] autostash: extract read_one() from rebase
Message-ID: <bbd46ad8d27ab547c8efa6b55c1777becbab7302.1571246693.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571246693.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Begin the process of lib-ifying the autostash code. In a future commit,
this will be used to implement `--autostash` in other builtins.

This patch is best viewed with `--color-moved` and
`--color-moved-ws=allow-indentation-change`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 autostash.c      | 12 ++++++++++++
 autostash.h      |  9 +++++++++
 builtin/rebase.c | 10 +---------
 3 files changed, 22 insertions(+), 9 deletions(-)
 create mode 100644 autostash.c
 create mode 100644 autostash.h

diff --git a/autostash.c b/autostash.c
new file mode 100644
index 0000000000..a6898e0fda
--- /dev/null
+++ b/autostash.c
@@ -0,0 +1,12 @@
+#include "git-compat-util.h"
+#include "autostash.h"
+#include "gettext.h"
+#include "strbuf.h"
+
+int read_one(const char *path, struct strbuf *buf)
+{
+	if (strbuf_read_file(buf, path, 0) < 0)
+		return error_errno(_("could not read '%s'"), path);
+	strbuf_trim_trailing_newline(buf);
+	return 0;
+}
diff --git a/autostash.h b/autostash.h
new file mode 100644
index 0000000000..4a8f504f12
--- /dev/null
+++ b/autostash.h
@@ -0,0 +1,9 @@
+#ifndef AUTOSTASH_H
+#define AUTOSTASH_H
+
+#include "strbuf.h"
+
+/* Read one file, then strip line endings */
+int read_one(const char *path, struct strbuf *buf);
+
+#endif
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4a20582e72..9fd7de6b2f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -27,6 +27,7 @@
 #include "branch.h"
 #include "sequencer.h"
 #include "rebase-interactive.h"
+#include "autostash.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] "
@@ -561,15 +562,6 @@ static const char *state_dir_path(const char *filename, struct rebase_options *o
 	return path.buf;
 }
 
-/* Read one file, then strip line endings */
-static int read_one(const char *path, struct strbuf *buf)
-{
-	if (strbuf_read_file(buf, path, 0) < 0)
-		return error_errno(_("could not read '%s'"), path);
-	strbuf_trim_trailing_newline(buf);
-	return 0;
-}
-
 /* Initialize the rebase options from the state directory. */
 static int read_basic_state(struct rebase_options *opts)
 {
-- 
2.23.0.897.g0a19638b1e

