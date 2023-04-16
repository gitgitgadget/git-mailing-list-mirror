Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041ADC77B72
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 05:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjDPFrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 01:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPFrq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 01:47:46 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8083B1BCF
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 22:47:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b35789313so806710b3a.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 22:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681624064; x=1684216064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5knHIQabAqQomB6oJCGmro5fwrljYXzHmQIpXEWkPQE=;
        b=Rf9PTO3hDZo4dFyDGhXKT/QXzFPgMi1xzvWlameCDnh0lYPov3BcatYiRs5CkRk2mZ
         6SOWgiEo3E6Bin3r8ZHT2qP+bFeMUA37ReRD3ugSXEBt/VYG/7DZZKzeozG4NC17rYhn
         mnw3Le2Y1ythCLEun5EZMbmh/TBofKHtp8SlcBBwhRJnu5j4Q2Zp67jEEa50v2nq7+BE
         xqGeC469CLpRFg+7Uk+yRayxf2kGmozr9PJBAJnQM8GIVc6wZEWMbRUnTFwmieNmzji3
         NRhLChHPaTFxwN/iHwKnGifeQw24P9m9onNetavr4e08Cd1fwPnOonDwxeWsExWc+GKF
         ArRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681624064; x=1684216064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5knHIQabAqQomB6oJCGmro5fwrljYXzHmQIpXEWkPQE=;
        b=JXj+QPUoMsylTsPNW7euwtDNI8+nVptPSmwqJmZsbbvidM3dMHQcBWEXwy4ELMkYF6
         SarWuYFGYANBh7d3Ujg9ITnK4UJ51KHVYRqNP/rTcK3vvsGscYdlHKcauqafIN4Yjont
         G+v/Yyg8DTTr4x68gv/fQtKlCmXE53Ynzno5WYKBeZwMWRqmbnebJNIijAK4rg24Q4y8
         1qRFDr+aP7R69ej1y5KBYgQoXmAxooa5iLd7kVCb7FuZzGvsmHaxKlFA2UwasYDVuLeA
         PtBKGPWujR/EfGN+eZTy6vh6DB4VAW1K5RD+N1Vjt0StaUKuRgTCm4INZjtXSDeeSHij
         TSdg==
X-Gm-Message-State: AAQBX9fjqlnhMYw85d+c4Z2LAuLeTOCUZbpZeCJcyiSOOAYE/lufV1GR
        5hLTPoE35EqVH8fP+x7ujVk=
X-Google-Smtp-Source: AKy350a/vVhRhdzbUqlk7lNgpxohm2OuJvYVFujqqvtd6Ne2uen5b9ElLI63k+Bdgus7XVVi4X0caw==
X-Received: by 2002:a05:6a00:88e:b0:626:2ae6:31f6 with SMTP id q14-20020a056a00088e00b006262ae631f6mr17514235pfj.7.1681624063829;
        Sat, 15 Apr 2023 22:47:43 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e01:7190::7e16])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0063b675f01a5sm3668118pfn.11.2023.04.15.22.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 22:47:43 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
Date:   Sat, 15 Apr 2023 22:47:35 -0700
Message-Id: <20230416054735.3386065-1-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.195.gf32d4fa3dbf
In-Reply-To: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2023 at 4:06 AM Michael J Gruber <git@grubix.eu> wrote:
>
> 5579f44d2f ("treewide: remove unnecessary cache.h inclusion", 2023-04-11)
> broke connections via git protocol because it removed the inclusion of
> the default port macro. While some may consider this transport to be
> deprecated, it still serves some purpose.

In particular the problem is that

	const char *port = STR(DEFAULT_GIT_PORT);

translates now to

	const char *port = "DEFAULT_GIT_PORT";

instead of

	const char *port = "9418";

Since both compile and nothing in the testsuite tests this, I just
missed this problem when making the other changes.

Sorry about this.

> connect.c (no more chache.h) and daemon.c (which still includes cache.h)
> are the only users of the macro. Hot fix the issue by copying the
> definition to connect.c.
>
> A real fix will identify a proper common header file (I couldn't) or
> create a new one.

I've got a patch that does precisely this that I just submitted as
part of my follow-on to the en/header-split-cache-h series.  I've included
that patch below in case Junio wants to advance it faster than the rest of
that series.

-- >8 --
Subject: [PATCH] protocol.h: move definition of DEFAULT_GIT_PORT from cache.h

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h    | 21 ---------------------
 daemon.c   |  1 +
 protocol.h | 21 +++++++++++++++++++++
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index 2f21704da9e..71e2fe74c4f 100644
--- a/cache.h
+++ b/cache.h
@@ -39,27 +39,6 @@
 #define S_DIFFTREE_IFXMIN_NEQ	0x80000000
 
 
-/*
- * Intensive research over the course of many years has shown that
- * port 9418 is totally unused by anything else. Or
- *
- *	Your search - "port 9418" - did not match any documents.
- *
- * as www.google.com puts it.
- *
- * This port has been properly assigned for git use by IANA:
- * git (Assigned-9418) [I06-050728-0001].
- *
- *	git  9418/tcp   git pack transfer service
- *	git  9418/udp   git pack transfer service
- *
- * with Linus Torvalds <torvalds@osdl.org> as the point of
- * contact. September 2005.
- *
- * See http://www.iana.org/assignments/port-numbers
- */
-#define DEFAULT_GIT_PORT 9418
-
 /*
  * Basic data structures for the directory cache
  */
diff --git a/daemon.c b/daemon.c
index db8a31a6ea2..75c3c064574 100644
--- a/daemon.c
+++ b/daemon.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "environment.h"
 #include "pkt-line.h"
+#include "protocol.h"
 #include "run-command.h"
 #include "setup.h"
 #include "strbuf.h"
diff --git a/protocol.h b/protocol.h
index cef1a4a01c7..de66bf80f84 100644
--- a/protocol.h
+++ b/protocol.h
@@ -1,6 +1,27 @@
 #ifndef PROTOCOL_H
 #define PROTOCOL_H
 
+/*
+ * Intensive research over the course of many years has shown that
+ * port 9418 is totally unused by anything else. Or
+ *
+ *	Your search - "port 9418" - did not match any documents.
+ *
+ * as www.google.com puts it.
+ *
+ * This port has been properly assigned for git use by IANA:
+ * git (Assigned-9418) [I06-050728-0001].
+ *
+ *	git  9418/tcp   git pack transfer service
+ *	git  9418/udp   git pack transfer service
+ *
+ * with Linus Torvalds <torvalds@osdl.org> as the point of
+ * contact. September 2005.
+ *
+ * See http://www.iana.org/assignments/port-numbers
+ */
+#define DEFAULT_GIT_PORT 9418
+
 enum protocol_version {
 	protocol_unknown_version = -1,
 	protocol_v0 = 0,
-- 
2.40.0.195.gf32d4fa3dbf

