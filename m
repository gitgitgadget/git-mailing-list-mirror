Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9311C433FE
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbiEIR70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbiEIR7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:59:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C652D7EFD
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:55:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j6so28290558ejc.13
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o35V+F38FntRNj4XcjEx50Tx5IbG9FfyWoMOOk9/v6w=;
        b=bOpRn0dmE/d0Ktrd0zTFDI4XQVv8OS+VCWIM/HPBeZ0EnJnUCFRMC2i/GKiE5dEuat
         SnK8L3ENz8xqxcwXDIovE8mO+JY0qurac5maFKnKmcSAxTjrczTH4q9psgzFe9TIieVT
         SbFBtcuuHBFgudI/1KQ1nBo0J+WP0iHHkvDMEu4TWCCBzSAGj02G8PS+wq+wb5H5W2hL
         CqN9XTSjJnGgME7nZTo/6cdbTDy7hOjMlLUWULg+MaMSB4x35bw9lcVSyorlVZnR/1rs
         IXibhdvgjdyzNQPhwLOaWn7MdVKMwcktWD2gNdrERsGDUdAX7Ofj33gs83XmHrn0EqgF
         mTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o35V+F38FntRNj4XcjEx50Tx5IbG9FfyWoMOOk9/v6w=;
        b=ylGdqh7UB9x2cITM5IgzzeFnNDksprF75qgke6BHR8ZHfUG/ZmqwpTJ5ilZGXw4ehZ
         5/I+nmsp8CYm7NMEazO45AjarucM20O9qwqwqAaPn05TnbmgrrIdp8otqk6+ftWCLJLF
         J+HUzjSjMTNryeGm4pd/0YN0o5iLiPDP+YKy5bIN9kxt7n6HaNh8JspQWvuWX8R5rXES
         X/0qMT7XRxHSEs2WdBcGKRG4Ua6vLu+KcnkeCqcekYhxf7UsxXuCOC6oF5oNKaeAnoaW
         EkXV8ywVZBbzh/F09oVmBnkSjR2534xq1M8QNrdyONkzW7YJoPkUkUD6onPspO/yU/HO
         ZdzA==
X-Gm-Message-State: AOAM533cMYxzvVD68winUSNQsLLc/393gSrXT8rmXxdtVl3fGeO4Jsiu
        3nNNyqgFJxfZ2acUDiUjtl5gSdRjJ78=
X-Google-Smtp-Source: ABdhPJzI9cDuME+Xu4/5UEdadu43IqZRrnNPikJmZXaBEqNsWD3T8cOXI4lN1WchZB1z2z1CJFnH8w==
X-Received: by 2002:a17:907:97c4:b0:6f8:5ec5:61e2 with SMTP id js4-20020a17090797c400b006f85ec561e2mr10930622ejc.559.1652118910999;
        Mon, 09 May 2022 10:55:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:55:10 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 11/15] dir-iterator: open root dir in dir_iterator_begin()
Date:   Mon,  9 May 2022 20:51:55 +0300
Message-Id: <20220509175159.2948802-12-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we call dir_iterator_begin() and the provided path is invalid, the
call won't fail and return NULL. Instead, the call succeeds, and the
first call dir_iterator_advance() fails. That's unexpected behavior from
the perspective of a user of this API. The expected behavior would be to
fail and return NULL from dir_iterator_begin() if the provided path is
invalid. Successful call to dir_iterator_begin() suggests that the root
path is valid.

To deal with this, call activate_level() in dir_iterator_begin() which
opens the provided root path and confirms it's a valid directory path.
By doing this we can return NULL from dir_iterator_begin() in case the
provided root path isn't valid, implementing the expected behavior.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 dir-iterator.c          | 13 ++++++++++---
 t/t0066-dir-iterator.sh |  4 ++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 3adcfbc966..c36f549a78 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -181,10 +181,12 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 	if (activate_err == FAIL_NOT_ENOENT && PEDANTIC) {
 		goto error_out;
 	} else if (activate_err != OK) {
-		--iter->levels_nr;
+		/*
+		 * We activate the root level at `dir_iterator_begin()`.
+		 * Therefore, there isn't any case to run out of levels.
+		 */
 
-		if (iter->levels_nr == 0)  /* Failed to open root directory */
-			goto error_out;
+		--iter->levels_nr;
 
 		return dir_iterator_advance(dir_iterator);
 	}
@@ -295,6 +297,11 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
 		goto error_out;
 	}
 
+	if (activate_level(iter) != OK) {
+		saved_errno = errno;
+		goto error_out;
+	}
+
 	return dir_iterator;
 
 error_out:
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 04e51928bc..52b0217bde 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -289,7 +289,7 @@ test_expect_success POSIXPERM,SANITY 'setup -- dir w/o perms' '
 '
 test_expect_success POSIXPERM,SANITY 'iteration of root dir w/o perms' '
 	cat >expected-out <<-EOF &&
-	dir_iterator_advance failure: EACCES
+	dir_iterator_begin failure: EACCES
 	EOF
 
 	chmod 0 dir12 &&
@@ -301,7 +301,7 @@ test_expect_success POSIXPERM,SANITY 'iteration of root dir w/o perms' '
 '
 test_expect_success POSIXPERM,SANITY 'pedantic iteration of root dir w/o perms' '
 	cat >expected-out <<-EOF &&
-	dir_iterator_advance failure: EACCES
+	dir_iterator_begin failure: EACCES
 	EOF
 
 	chmod 0 dir12 &&
-- 
2.36.1

