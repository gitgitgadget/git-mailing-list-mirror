Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796CEC76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjDKHmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjDKHmT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:42:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CAC1733
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e13so6738216plc.12
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198932; x=1683790932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrpzWCOqU7yxySmkHVUU8qo7ljvGFwm6pAKfrtpPjzo=;
        b=jifTxu5GZVqE1k9xtoYwF5y4DV5sUn4DQOtI4eLbEtfCPlqn+QQJdxliVtUjW4d6Fe
         xj4OLafiEs1F/8MNVDjownPMU2UyfDsQtHfqLvui58G8rq9166TaU7pLq2d6lSrITpus
         1qfAULRKfGLjJhVUfjz6vAJ9Jv9vFvPgSAaa1HeLoy/Vt7ILxAunSvzt3eQwzyHbrY3P
         6ZWA3G/DiqF5YcneNwUTFW0MHutmznDYSzE0CAmTOtBFC0Vk00AP/FPwH9hp7TuD/kQF
         eQO8Rc2td33/leOSUoQsqYFotqJ1XyZVo6TenJKj7Mt6oW4+DQNC8v86D42vpadtglKp
         WAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198932; x=1683790932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrpzWCOqU7yxySmkHVUU8qo7ljvGFwm6pAKfrtpPjzo=;
        b=3jw/IDuHwPaSWW6N4AOQsh3+iEamvr9PHT4bo/hQPqk+V8k9k7BhwBET+Dt2ync6bH
         GP1NpkzKGjfD/KsSyM6mY+IHun6C23d228ba4Y/blWsd5j3WIOCKdsijUq6+f/FH37u5
         jm/U+M7l9uZ2xP4FQ3VqV6Y7vCbHBKLN/+Oy9BssI7yCSGoRnVrhx6FVPk7Ih+zuwc1d
         URkKbkp76mp9xrdSdV31Iw2QTDtOU/Rzf190FZcf8Y+BsWG6eT1sH7HpmZDGmJhTheY3
         2o+pKZryaMYS3gJ+5Kwwko0zZoGf9O4xp6z6Fgpw3a9vOToe/udjmcez5RLpsownixJm
         JfSA==
X-Gm-Message-State: AAQBX9ehhzVxUmqV11b3Unm7d2DopxLga4MqupGYJ5CZtkx5XZRnAJKG
        ced70iNld6vuGscxJF4RidVbmOxVt9o=
X-Google-Smtp-Source: AKy350ZR6sfA1jbs95s7iGM3GiytJdqJrkhbjRS6q0T8P/EnrMhEixNQgn32P2085Ts0aL79bgPQpQ==
X-Received: by 2002:a17:90b:1e09:b0:246:da2a:49be with SMTP id pg9-20020a17090b1e0900b00246da2a49bemr2447149pjb.20.1681198932041;
        Tue, 11 Apr 2023 00:42:12 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 07/23] treewide: remove unnecessary cache.h inclusion
Date:   Tue, 11 Apr 2023 00:41:48 -0700
Message-Id: <20230411074204.3024420-2-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several files were including cache.h solely to get other headers, such
as trace.h and trace2.h.  Since the last few commits have modified
files to make these dependencies more explicit, the inclusion of cache.h
is no longer needed in several cases.  Remove it.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 compat/simple-ipc/ipc-unix-socket.c | 2 +-
 connect.c                           | 1 -
 fetch-pack.c                        | 2 +-
 pack-write.c                        | 2 +-
 promisor-remote.c                   | 2 +-
 protocol.c                          | 2 +-
 scalar.c                            | 2 +-
 t/helper/test-date.c                | 1 -
 trace.c                             | 2 +-
 upload-pack.c                       | 2 +-
 10 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 7064475b39f..b2f4f22ce44 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "simple-ipc.h"
 #include "strbuf.h"
diff --git a/connect.c b/connect.c
index 929f72ec5d7..5d8036197d5 100644
--- a/connect.c
+++ b/connect.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "cache.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index 7d4f190fb1d..677102465a1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "repository.h"
 #include "config.h"
diff --git a/pack-write.c b/pack-write.c
index 152c14aa7aa..d9b460fab4c 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/promisor-remote.c b/promisor-remote.c
index 9d83d2f4b9c..1adcd6fb0a5 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/protocol.c b/protocol.c
index 4d8eb887e82..079ba75acf4 100644
--- a/protocol.c
+++ b/protocol.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
 #include "protocol.h"
diff --git a/scalar.c b/scalar.c
index f7680463e1b..af64f75ca66 100644
--- a/scalar.c
+++ b/scalar.c
@@ -2,7 +2,7 @@
  * The Scalar command-line interface.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "gettext.h"
 #include "parse-options.h"
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index a01eec99f35..7adadd41e0b 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "date.h"
 #include "trace.h"
 
diff --git a/trace.c b/trace.c
index d8eaa0a786a..592c141d785 100644
--- a/trace.c
+++ b/trace.c
@@ -21,7 +21,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
 #include "quote.h"
diff --git a/upload-pack.c b/upload-pack.c
index e17545a834a..0305fb2fbdc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-- 
2.40.0.172.g72fe1174621

