Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63826C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjDKHnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjDKHnF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:43:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B438D40ED
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:39 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id kh6so5470308plb.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198958; x=1683790958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33hECf5iH/mOAE0FI+YNo4Z9xeJW/fjN0sb+HvcmToo=;
        b=MsB63gw20B0iurZMpfgQAX4Kkj6UEkpZV8HdOQ7wE1zRpZinIjFWlY0yYEPtQ71pLc
         ZVPLKmIdA2FK123JtZmPYJUPQQwGq0TZ4jPkjOSM+KSYZlP3sRuuOg5CuWvRJk8mX4/R
         /ppeO7XihDzRauqbfpa9kUv19clLx+9W4Yd7J53LWs8EPU/I2GxMT5/784myrHVk2w6a
         2GAHep/HHuEmyM3eBLYGsisiK/3W2UIMstNf33YTUGJuSx24FggUKM12i4dWdyGu6Zae
         5CsuA/yonDBsZkFIp9zNE+sgwFS5J+GmIy9WQPXgU0l0tLczRlGUf1kCzgGjVRiv38IC
         iWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198958; x=1683790958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33hECf5iH/mOAE0FI+YNo4Z9xeJW/fjN0sb+HvcmToo=;
        b=zowDRelDSvZaAJY2ycgW2WOcxMUAV4qJHh+NbheVxDnhux8vcZt7v2Zr07FCIXo+Uk
         h3nU4KUA1VZV6VC7pR4Pr+bo5lPlXfRkpofhOa/4/UuVK8uArliT7nIwUCcm2OIsmUqQ
         LKG7LTQtZxDX000yXfMPqr1vP7UArIsCFVdtafOfpm5C6a9X2V5rrD7XOaC5oPU/AQZv
         bIgykeFRY0/s0aRddG3n0sOUoPMu1YTzSaVfZvPyW+yTDz1CP/x+2nR3L6qNUKM4rief
         1h9Zz/fQXBUDWK7FwOYp6Hs1aey3pQrwZfx0oyOgs1TOVGj87I94wU3umD8XZpVI3Msr
         HZuw==
X-Gm-Message-State: AAQBX9etnWG3oip5jQCc9Rbxs8RYblY0nROOlT2Ikqi0O6gf2X9cQmWm
        RpPLbIVdr+8rtzSpYWxMtaVPC9UuFqE=
X-Google-Smtp-Source: AKy350bh2Qg5nCixNAvf0NSdVoEpDFiWPUSNLHQYuPne6wISZgiATKlnxC4ty+wNbL2QNOUtjynwiA==
X-Received: by 2002:a17:902:e887:b0:1a5:253f:ace7 with SMTP id w7-20020a170902e88700b001a5253face7mr1668733plg.29.1681198958613;
        Tue, 11 Apr 2023 00:42:38 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:37 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 23/23] mailmap, quote: move declarations of global vars to correct unit
Date:   Tue, 11 Apr 2023 00:42:04 -0700
Message-Id: <20230411074204.3024420-18-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since earlier commits removed the inclusion of cache.h from mailmap.c
and quote.c, it feels odd to have the extern declarations of
global variables in cache.h rather than the actual header included
by the source file.  Move these global variable extern declarations
from cache.h to mailmap.c and quote.c.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 cache.h   | 5 -----
 config.c  | 1 +
 mailmap.h | 3 +++
 quote.h   | 2 ++
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 16b5fc9fa31..2f21704da9e 100644
--- a/cache.h
+++ b/cache.h
@@ -599,8 +599,6 @@ void set_alternate_index_output(const char *);
 extern int verify_index_checksum;
 extern int verify_ce_order;
 
-extern int quote_path_fully;
-
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
 #define OWNER_CHANGED	0x0004
@@ -655,9 +653,6 @@ struct pack_entry {
 /* Dumb servers support */
 int update_server_info(int);
 
-extern const char *git_mailmap_file;
-extern const char *git_mailmap_blob;
-
 #define COPY_READ_ERROR (-2)
 #define COPY_WRITE_ERROR (-3)
 int copy_fd(int ifd, int ofd);
diff --git a/config.c b/config.c
index 11e3295419b..9beba19b41c 100644
--- a/config.c
+++ b/config.c
@@ -18,6 +18,7 @@
 #include "ident.h"
 #include "repository.h"
 #include "lockfile.h"
+#include "mailmap.h"
 #include "exec-cmd.h"
 #include "strbuf.h"
 #include "quote.h"
diff --git a/mailmap.h b/mailmap.h
index 7e99fccb46c..0f8fd2c586f 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -3,6 +3,9 @@
 
 struct string_list;
 
+extern const char *git_mailmap_file;
+extern const char *git_mailmap_blob;
+
 int read_mailmap(struct string_list *map);
 void clear_mailmap(struct string_list *map);
 
diff --git a/quote.h b/quote.h
index 87ff458b06d..0300c291041 100644
--- a/quote.h
+++ b/quote.h
@@ -3,6 +3,8 @@
 
 struct strbuf;
 
+extern int quote_path_fully;
+
 /* Help to copy the thing properly quoted for the shell safety.
  * any single quote is replaced with '\'', any exclamation point
  * is replaced with '\!', and the whole thing is enclosed in a
-- 
2.40.0.172.g72fe1174621

