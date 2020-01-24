Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F33C3F68F
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0881924125
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psBGsHBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgAXDfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:25 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:51459 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAXDfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:25 -0500
Received: by mail-vk1-f201.google.com with SMTP id c127so249057vkh.18
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4ePX9MdGkN/ZfSUGxE9QIoCX83dvdMKlkminVB6jc8s=;
        b=psBGsHBRkmYcIaTwC1RaMDjqaUhiBN+7ueOGoLLpsSw/FsyulMlBNYLLfxrSMSvxaT
         dKCOBmiA2qoaHs+3cqLF/OrvbgGKrGRAmENH2IPCNPq8bvOuELsNS4cfokqiv/RuIP3e
         b7pix/lHiRkx1h98K8Kv+peTsctUcAxcRAAAueKPCb/G01FKyqXG7meFRL+MxcvkPCHi
         8s1xvBO/mndIWg1YJExw0FOVCSt0a+rPigP0ZVjJdHuvRcnhZs/O+5aZhuR0XrV7ix/m
         JrqgAHTzmPh0Y8UJmYIplu1yfcMag7vSV60JhR23Ul9ALic38G/Mc7aLPqdf9qmaUnbn
         wI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4ePX9MdGkN/ZfSUGxE9QIoCX83dvdMKlkminVB6jc8s=;
        b=YiUy2+QjbCp0zWhJvsXIyBGxuZlWgNy8khLC2mxgmAmy6qM6Y6xVMzWFg4WL7Klqkb
         iBsdUkE+2dzJuo3jAguJnuSm2Efl/2NkgefSwZ3eey5lNENcQELs9A86/k59XOOerJbo
         IqGphQUHHnOgBR6o9wZCvsfN9APDev7pN9rEKqqlaX4h0OGLp2vYLDxiczKK3E7P/fdr
         G6QyEle039tOvRHhMkor2eOQ10ba+gTcRkxAmA/n31rdgl/biHPrTBhdco7SUtQmRS6z
         bEofkqLWpU/Offr5c21Xotf8QVNLCDyw4wud3d38eZrgPlx17zaF6M379lKRKnHfQgi5
         c/ew==
X-Gm-Message-State: APjAAAX5u1RPpG8h+9xptpcmkFvJ86WhsiHHThEAzLrzuXtan8iZW1Hf
        3+1IoeMCnjcAa2clbDwnZBgghb8rm6klweoePeU6p2IiEnv1ks25NtBduAbym9BFW3lGfozp2bO
        TV8fijvKtFc0dB853SYnZ71RazbcWDNFZUEOh5vgEAl8lzFSBCAOAABopLDiG3s5u5fm8MM1uzQ
        ==
X-Google-Smtp-Source: APXvYqwqZiP+wzDCYE8sW7K4P2iyupGlweQ2vw/G1wrsuuUFPAZzLmdom5DIiziz5fmhQ67YgUcjYeWohdcQi2m8J+E=
X-Received: by 2002:a67:f81a:: with SMTP id l26mr985744vso.194.1579836924089;
 Thu, 23 Jan 2020 19:35:24 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:27 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 06/15] bugreport: add compiler info
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

To help pinpoint the source of a regression, it is useful to know some
info about the compiler which the user's Git client was built with. By
adding a generic get_compiler_info() in 'compat/' we can choose which
relevant information to share per compiler; to get started, let's
demonstrate the version of glibc if the user built with 'gcc'.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c       |  5 +++++
 compat/compiler.h | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 compat/compiler.h

diff --git a/bugreport.c b/bugreport.c
index 720c91e1bd..818ccb385c 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 #include "time.h"
 #include "help.h"
+#include "compat/compiler.h"
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -26,6 +27,10 @@ static void get_system_info(struct strbuf *sys_info)
 			    uname_info.release,
 			    uname_info.version,
 			    uname_info.machine);
+
+	strbuf_addstr(sys_info, "compiler info: ");
+	get_compiler_info(sys_info);
+	strbuf_complete_line(sys_info);
 }
 
 static const char * const bugreport_usage[] = {
diff --git a/compat/compiler.h b/compat/compiler.h
new file mode 100644
index 0000000000..bda5098e1b
--- /dev/null
+++ b/compat/compiler.h
@@ -0,0 +1,24 @@
+#ifndef COMPILER_H
+#define COMPILER_H
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+
+#ifdef __GLIBC__
+#include <gnu/libc-version.h>
+
+static inline void get_compiler_info(struct strbuf *info)
+{
+	strbuf_addf(info, "glibc: %s", gnu_get_libc_version());
+}
+
+#else
+
+static inline void get_compiler_info(struct strbuf *info)
+{
+	strbuf_addstr(info, "get_compiler_info() not implemented");
+}
+
+#endif
+
+#endif /* COMPILER_H */
-- 
2.25.0.341.g760bfbb309-goog

