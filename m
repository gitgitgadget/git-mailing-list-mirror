Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B85C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbhLUSFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbhLUSFw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:05:52 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E13DC06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i22so28530253wrb.13
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8lpUPq8Ich/Jxa9IhxYsmk1CI1jyDC2AW0SOvBStIhM=;
        b=LOUWR16HWYGl293QRYuTJnJZdTXVZjrLTUd0AQX6rB8fblDFro4cVsK7fHyoWq9MJz
         JOsn6UkT3RR7fqfcElOC+nVtaZHMbzDg3IrhmFvEJmSB750G2fvl1/N9bMGW08D9q9SX
         aFhx4hw3HvX+7sHwdoPQFsuwbf5QSgtg+Eu+sjUzv38Mms+G2D9P6JgVbE5qP279XGrm
         WeRG8mDgDBHAAjh0waXl92SZpwVG/xdrcN59GoNV1czXFSKZjw2aFEsg+JPFeQ+HBpVH
         3P6xBs1czvunqXLmKhHdd1aUznHgK7Nxt6OueJ+jXFnjrAwvAoIysqxwDLbAOCVxXfrU
         joYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8lpUPq8Ich/Jxa9IhxYsmk1CI1jyDC2AW0SOvBStIhM=;
        b=YJvIp+u/d2bd206qT+Tase0cDCkr4zQQdMhd74A5nSEf2026EwZVMkXDKImCO9RYoA
         zzP4cgjsxO9jqR0ko0eRo2BcI74lli6IQ7Lev5ocBSQPfwVTSjbgxvI5xpAO33qOcv/i
         fB7sMGSyzZcj+mzp6AvtG0EYMxn9n+fzWr5VZA8KUTr396u/AsDcu7UAHptJknzYAQPb
         1e8n7oUD3Y4+7i+Wbos0K0h/2I8nYEyOevL0kHPHa6k4iAqQPuakFdg6+L/evdMm7uES
         yr/XdPVmnhGMzVkumAv6R9piKhKP3fZJqg9IISdf4gvIshIosjJO6ZMSScHFOuUaV5QL
         PrEg==
X-Gm-Message-State: AOAM530udWjbhpXa6s1/l5sXw3iuJbxUJYs3vG9CZdacfaO0aDxEOOW3
        h8DJRz+Cbxazb/OgbI598WPH30hkWpY=
X-Google-Smtp-Source: ABdhPJzDqcGyX9E/O/FkzK4m5y+bJLNBAZOmLtBHYjddB2gIXdblB1BS7RDT6T8hrevZLVlRGIH7nQ==
X-Received: by 2002:a05:6000:156c:: with SMTP id 12mr3657062wrz.502.1640109950882;
        Tue, 21 Dec 2021 10:05:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm1673062wrs.43.2021.12.21.10.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:05:50 -0800 (PST)
Message-Id: <fab1b2c69eafbd3f211745886786c1d0ebdc05c2.1640109948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 18:05:40 +0000
Subject: [PATCH 1/9] tmp_objdir: add a helper function for discarding all
 contained objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 tmp-objdir.c | 5 +++++
 tmp-objdir.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index 3d38eeab66b..adf6033549e 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -79,6 +79,11 @@ static void remove_tmp_objdir_on_signal(int signo)
 	raise(signo);
 }
 
+void tmp_objdir_discard_objects(struct tmp_objdir *t)
+{
+	remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
+}
+
 /*
  * These env_* functions are for setting up the child environment; the
  * "replace" variant overrides the value of any existing variable with that
diff --git a/tmp-objdir.h b/tmp-objdir.h
index cda5ec76778..76efc7edee5 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -46,6 +46,12 @@ int tmp_objdir_migrate(struct tmp_objdir *);
  */
 int tmp_objdir_destroy(struct tmp_objdir *);
 
+/*
+ * Remove all objects from the temporary object directory, while leaving it
+ * around so more objects can be added.
+ */
+void tmp_objdir_discard_objects(struct tmp_objdir *);
+
 /*
  * Add the temporary object directory as an alternate object store in the
  * current process.
-- 
gitgitgadget

