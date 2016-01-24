From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 07/11] dir: add remove_untracked_cache()
Date: Sun, 24 Jan 2016 16:28:20 +0100
Message-ID: <1453649304-18121-8-git-send-email-chriscool@tuxfamily.org>
References: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 16:29:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMbl-00013c-48
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbcAXP3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:29:35 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33013 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbcAXP2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:28:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id u188so6828640wmu.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 07:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0x3MSmaaOmI4iB8b8sZUgY5ynS+EOjDHTVYAGEcDCP8=;
        b=cyOnxblb8mQQolWzQFn0kU/nKtPcfnxp/ke9FQpQX9rrkbsPLc+GIRYftyXP122AHa
         PVof7W4XDKiKxe7G4qPesLZsyIwjreRp0EQJJgoaRcSf0yz2zKZdWLTc1tkzVRIe2xbF
         1raJ515bH92VzpC2NPDtZ7iQOfrQKgkdaZf0FL/cSpXtYtvhwMKMtghfdonGY1LhNHJk
         wRQJl19H5TF51xzepqIKreFgx5hFoPfqYj+oa/xjmtcToVNlSV8GMVL0p+86jpA9AD4R
         k5pX5Bg3ZL6R2VO4hIKz1/ZW5hHWOrcDt/I/Ld1Vm171qF5T2C+5y6eXITz4VSW8R1rI
         GUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0x3MSmaaOmI4iB8b8sZUgY5ynS+EOjDHTVYAGEcDCP8=;
        b=eLCk6emvfeCubU8MTYxpjS5Z74EA5PgNG0oyfkGLpmBhOZ8umgWgsIo/I0InsMvaCj
         EA+McDQDgq+zfLj9y7+AmwKdpNuQ3wex1B06UV3HmhoMP+RbDS8FifFRvcoo4Yx4IJZr
         20gbdPIgZBzT863zL7mrHoHap5uO6dfwZ6JL2SiWEX/qL/yID3uth2z1KGbq/XLZ2K6C
         Ng3YX2EL8Hr6KrJOQPg+YzPAZJHustISEau/QlmRPBz1qsRCoZ1/asPCSMzBE75Kar0c
         alrCA/YLF/TYbcCCw+yHYV3ueaaISZLRvaA6G0hMYfiNmXvcFTKXJ++knqv8u49u30bs
         FU0Q==
X-Gm-Message-State: AG10YOTmRFgQl14KYChBWQ6SmHGw76cg7hKQGC9QiFxIUDUZHpJ5YF6wSoYt2xoQYf1Aag==
X-Received: by 10.28.87.135 with SMTP id l129mr14296184wmb.9.1453649331883;
        Sun, 24 Jan 2016 07:28:51 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id y8sm11900231wmg.9.2016.01.24.07.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jan 2016 07:28:50 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.gd7ef666.dirty
In-Reply-To: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284658>

Factor out code into remove_untracked_cache(), which will be used
in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 6 +-----
 dir.c                  | 9 +++++++++
 dir.h                  | 1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5f8630c..d90154c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1126,11 +1126,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		add_untracked_cache(&the_index);
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 	} else if (untracked_cache == UC_DISABLE) {
-		if (the_index.untracked) {
-			free_untracked_cache(the_index.untracked);
-			the_index.untracked = NULL;
-			the_index.cache_changed |= UNTRACKED_CHANGED;
-		}
+		remove_untracked_cache(&the_index);
 		report(_("Untracked cache disabled"));
 	}
 
diff --git a/dir.c b/dir.c
index 8646b18..f27b8b9 100644
--- a/dir.c
+++ b/dir.c
@@ -1882,6 +1882,15 @@ void add_untracked_cache(struct index_state *istate)
 	istate->cache_changed |= UNTRACKED_CHANGED;
 }
 
+void remove_untracked_cache(struct index_state *istate)
+{
+	if (istate->untracked) {
+		free_untracked_cache(istate->untracked);
+		istate->untracked = NULL;
+		istate->cache_changed |= UNTRACKED_CHANGED;
+	}
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec)
diff --git a/dir.h b/dir.h
index cfd3636..a3dacdb 100644
--- a/dir.h
+++ b/dir.h
@@ -309,4 +309,5 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_ident(struct untracked_cache *);
 void add_untracked_cache(struct index_state *istate);
+void remove_untracked_cache(struct index_state *istate);
 #endif
-- 
2.7.0.181.gd7ef666.dirty
