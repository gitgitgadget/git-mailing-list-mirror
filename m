Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E166C3A5A9
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B27121D6C
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 16:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVQxsYUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgDRQD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727790AbgDRQD5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 12:03:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3046C061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 09:03:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x3so2668023pfp.7
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFVbeO4bXagJhDbblegxUu51pn+AAl+6nu9bWOWjzwo=;
        b=bVQxsYULp3NEtergVq/5qXTKOiOD5OnqSTaTSwJ0GSTTkI1jOJutYn4zm6RNtU4Mtl
         p7rl6IU5BRmMG4UYAHTLc7/Q7YrFBK/jKDz9yA475TbYagB0McVd15FFbnHvg4cip3lv
         tiEvkR5DIBmNAOKpl7Mfbey9muYXiGqBkk28hz1taXQWBcrP4B4qeYHk/yJrXAKGCqxZ
         yphastErvvjVEjfW+ZFJihjnN+xkffoH2aCdoU2k4IYAy5qI0jiHdjyPGj5vCRnmSsCv
         yKBmdbDNeSvSiebUYLePKPtthKASWcgGJNF0CbOUAedzAQfS2f668ulSHAdBUoWgOtK2
         SVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFVbeO4bXagJhDbblegxUu51pn+AAl+6nu9bWOWjzwo=;
        b=S9KYJF9wA5czLTMV7kFP/WqJFdR3zNeGaqSlRptfcofdp3YG3mdSUV4HZl81hkNzU6
         aqt8jisjgKO8A5To9Qy+XQVaPWG20n5PEej5cDcHF3zHZT6HuS+MYiADgxEZ/gFJKt7Q
         t7Gfuw3Z4J6SPZZzw23C33gLbq9lCbgG3OtJEperGUnp2DQOqwDOQnzbff/S5ca7i3zM
         XPN0ZdJuZa39FxZCSErgXkaEIHRhLu6zkNNaKM1ZP7tWNvkl/E1Qnv9B/Jnq7rL6q4Ii
         u8BIZTQvCsyw2n895CJ/DOXrQDV2/Kn9ton+zz8dBWXl39S3ndJo1XPZ2mczl9t26hhn
         3TVA==
X-Gm-Message-State: AGi0PuY9WOsQ3oO3k77YdcnmjSZuDjpoqEjcjkgwUpQ9y8JcG7mT97jD
        5UmspUgp8jrgE/dtxlAuxZM=
X-Google-Smtp-Source: APiQypJEi+oioEl9p+S6bXZi+X/77Qx6YV3FxPIWuNkOSFR6x6xHXqxjSt5Ug6FoYjL0otHjknDlaA==
X-Received: by 2002:a62:2a8d:: with SMTP id q135mr1684764pfq.10.1587225836404;
        Sat, 18 Apr 2020 09:03:56 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i187sm22461649pfg.33.2020.04.18.09.03.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2020 09:03:56 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v13 8/8] doc: add documentation for the proc-receive hook
Date:   Sat, 18 Apr 2020 12:03:34 -0400
Message-Id: <20200418160334.15631-9-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200414123257.27449-1-worldhello.net@gmail.com>
References: <20200414123257.27449-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add documentation for the new "proc-receive" hook.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Documentation/githooks.txt | 58 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 3dccab5375..a0ea829435 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -333,6 +333,64 @@ The default 'update' hook, when enabled--and with
 `hooks.allowunannotated` config option unset or set to false--prevents
 unannotated tags to be pushed.
 
+proc-receive
+~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-receive-pack[1].  If the server has
+set the multi-valued config variable `receive.procReceiveRefs`, and the
+commands sent to 'receive-pack' have matching reference names, these
+commands will be executed by this hook, instead of by the internal
+`execute_commands()` function.  This hook is responsible for updating
+the relevant references and reporting the results back to 'receive-pack'.
+
+This hook executes once for the receive operation.  It takes no
+arguments, but uses a pkt-line format protocol to communicate with
+'receive-pack' to read commands, push-options and send results.  In the
+following example for the protocol, the letter 'S' stands for
+'receive-pack' and the letter 'H' stands for this hook.
+
+    # Version and features negotiation.
+    S: PKT-LINE(version=1\0push-options atomic...)
+    S: flush-pkt
+    H: PKT-LINE(version=1\0push-options...)
+    H: flush-pkt
+
+    # Send commands from server to the hook.
+    S: PKT-LINE(<old-oid> <new-oid> <ref>)
+    S: ... ...
+    S: flush-pkt
+    # Send push-options only if the 'push-options' feature is enabled.
+    S: PKT-LINE(push-option)
+    S: ... ...
+    S: flush-pkt
+
+    # Receive result from the hook.
+    # OK, run this command successfully.
+    H: PKT-LINE(ok <ref>)
+    # NO, I reject it.
+    H: PKT-LINE(ng <ref> <reason>)
+    # Fall through, let 'receive-pack' to execute it.
+    H: PKT-LINE(ft <ref>)
+    # OK, but has an alternate reference.  The alternate reference name
+    # is given in the third parameter, and other status can be given in
+    # key-value pairs.
+    H: PKT-LINE(alt <ref> <alt-ref> old-oid=<old-oid> new-oid=<new-oid>
+                forced-update)
+    H: ... ...
+    H: flush-pkt
+
+Each command for the 'proc-receive' hook may point to a pseudo-reference
+and always has a zero-old as its old-oid, while the 'proc-receive' hook
+may update an alternate reference and the alternate reference may exist
+already with a non-zero old-oid.  For this case, this hook may return
+different OID and different reference name as extended status of the
+report line.
+
+The report of the commands of this hook should have the same order as
+the input.  The exit status of the 'proc-receive' hook only determines
+the success or failure of the group of commands sent to it, unless
+atomic push is in use.
+
 [[post-receive]]
 post-receive
 ~~~~~~~~~~~~
-- 
2.24.1.15.g448c31058d.agit.4.5

