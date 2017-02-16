Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCBE41FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 12:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbdBPMDz (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 07:03:55 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33882 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754144AbdBPMDx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 07:03:53 -0500
Received: by mail-pg0-f67.google.com with SMTP id v184so1864236pgv.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 04:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wT92m0QjwEe8GNp/FpDA65sj8lHLkmiLp5i0WzNZGME=;
        b=PBTzOBg0oBMnDqzF3hQ7fiGjNW4SMgkVpgPHbdVcn3M3WEkMMEX31J2CGsAWB8hKHe
         N01mFRd0wBlCwxm016fdD+pos5dUURQayJ3+6Lf8F+MXRzPJY6l5b2kUZJwCv6T0YdJo
         4omd4Aq0NhnOTTbcBqoelGjkOKhYpvR4R8r323H34JPoR2EmSrTJW7Qzdo+HfPKlNycN
         JpoFz3OATm+FLtqQwV+R5/hjDvj0WyfuJrY3VtE2dbGJFWz/Ja4A6OW+RS6JDKpkRgzd
         9gTF7hVRbU7Bjcv9JlzvdAsyl7qtLVN0/DYry3KdV2v7EDFxgLMiLZ002iSpZxQWq3j7
         1nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wT92m0QjwEe8GNp/FpDA65sj8lHLkmiLp5i0WzNZGME=;
        b=q19w/RqauQMx+s6L40r4SEgJ9kefDjN5n/LTwa1FmxNXMgLuAocOowWPWOcJpyTtEp
         wfEQXnGeBDOecYOe0/kFWxgkFqJv11pV38FOvzTmuKmrgySYWqluOSwPJuc5QzU/+yVh
         GPQbC9Vvfn7KnKlFbctWmFTEh/3EUpEu7EAqVaJqp9vIAr+OJpp/xgoGgyIZZD2OZJCz
         zb1Z808hKRyhEJ5SMVKrGz2wUIQsi2shVUKkhO+GDnc+sxS9OHFI61l0mb4TSrE7v4kq
         khFgT3b+Fl0yITFWaUOwmdIgcS7foQ+2WW2XIBUtTe+lWOFwIo0m8E2fmqREFH3dulTD
         T/Lg==
X-Gm-Message-State: AMke39nQJbCPIF+vmVb8g2/JFZ0p0dXSy02uz1/ODNBqbotyjI0VzvmWWxVPeTD2WIvgAQ==
X-Received: by 10.99.128.65 with SMTP id j62mr2391991pgd.4.1487246633290;
        Thu, 16 Feb 2017 04:03:53 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id y23sm13416931pfi.66.2017.02.16.04.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 04:03:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 19:03:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/5] refs: introduce get_worktree_ref_store()
Date:   Thu, 16 Feb 2017 19:02:58 +0700
Message-Id: <20170216120302.5302-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216120302.5302-1-pclouds@gmail.com>
References: <20170208113144.8201-1-pclouds@gmail.com>
 <20170216120302.5302-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

files-backend at this point is still aware of the per-repo/worktree
separation in refs, so it can handle a linked worktree.

Note: accessing a worktree of a submodule remains unaddressed. Perhaps
after get_worktrees() can access submodule (or rather a new function
get_submodule_worktrees(), that lists worktrees of a submodule), we can
update this function to work with submodules as well.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 27 +++++++++++++++++++++++++++
 refs.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/refs.c b/refs.c
index e7206a420..ba4d9420c 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,7 @@
 #include "object.h"
 #include "tag.h"
 #include "submodule.h"
+#include "worktree.h"
 
 /*
  * List of all available backends
@@ -1486,6 +1487,32 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	return refs;
 }
 
+struct ref_store *get_worktree_ref_store(const struct worktree *wt)
+{
+	struct ref_store *refs;
+
+	if (wt->is_current)
+		return get_main_ref_store();
+
+	/*
+	 * We share the same hash map with submodules for
+	 * now. submodule paths are always relative (to topdir) while
+	 * worktree paths are always absolute. No chance of conflict.
+	 */
+	refs = lookup_submodule_ref_store(wt->path);
+	if (refs)
+		return refs;
+
+	if (wt->id)
+		refs = ref_store_init(git_common_path("worktrees/%s", wt->id));
+	else
+		refs = ref_store_init(get_git_common_dir());
+
+	if (refs)
+		register_submodule_ref_store(refs, wt->path);
+	return refs;
+}
+
 void base_ref_store_init(struct ref_store *refs,
 			 const struct ref_storage_be *be)
 {
diff --git a/refs.h b/refs.h
index 1287ba59c..464cc384a 100644
--- a/refs.h
+++ b/refs.h
@@ -565,5 +565,7 @@ struct ref_store *get_main_ref_store(void);
  * submodule==NULL.
  */
 struct ref_store *get_submodule_ref_store(const char *submodule);
+struct worktree;
+struct ref_store *get_worktree_ref_store(const struct worktree *wt);
 
 #endif /* REFS_H */
-- 
2.11.0.157.gd943d85

