Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81366C2BA2B
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F11206E5
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT0MfPYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgDLNah (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:30:37 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:38114 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgDLNaf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 09:30:35 -0400
Received: by mail-pj1-f44.google.com with SMTP id t40so2798956pjb.3
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 06:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/VtPuf/KRndKzB/ORhQqCBSQs7ZC3obq6O/x7cTYhg=;
        b=LT0MfPYfKxc1/11sf9Nmwso/bt2VHFPPKUTkiCJjj/45nG3cvo64CiabdobzOxXL3f
         FFHOHURh+pwAVw+FQ0yQpY5Oz/n924jqtWA342BcA6Q8JqvktxA9gym2HZFyiGosTY9m
         nh+XKo7SlrruKDsiUaH/ku90c31HkRWGKh9V76WkBVlfY1Fbk6Zi4NsHHqGWM9kjmFuX
         +bAuR9iNoZ8iUX7Oujt2GgiCvuoq3E9V6z1YhCciSlo2WK6gzcZdbm4i5MNm4RvOoHEI
         qM5pqSEP+LZEtCrtvVYliKi8xA5E+v+9Y8Xy4pRk/zGsIWYAo64/rMwVmDhP4E7sTqpD
         wVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/VtPuf/KRndKzB/ORhQqCBSQs7ZC3obq6O/x7cTYhg=;
        b=YlYxBVcLv+EEzD25BGf9P405FiKMgkm2LKTneDxZXAalETMHMaODqIeLGIhsMs0ZX2
         VD7QjjXqXdz8X5ABHqHzxqP8VXu0hHfhruDQqwwj6Cq/fQRpsjjyyVPo02i9TznnVDZW
         9zipEpc/7BjicdnWZRWseo9AA63yEWLSEXX9BK13sHRPzd1Dce1WXOoiJDJLs/k6RCRs
         0S2bCfCr2ifQjwSudVdzLsf1DnKgEK8oSGZzcK1Mtfrelix9iuDdBE7nAWYnQV8zKhCK
         dW0Kzl6r+3XvGE8S7Y2KYSQsDbgTAH2qOb+TIEAoHZ4MfAPcw8w5gHHIdZ/0FGyJ3vD2
         tKzQ==
X-Gm-Message-State: AGi0PuaP49mjv3RUFlsV1NoK9m3NB+yI2C4iAxVkFGZt/y74IqdLqKnd
        otJ5zSGwfUVi9RvR+8KYVlLx04ee
X-Google-Smtp-Source: APiQypIdMbfgsBmYVKa9ITyVoOk97+G5s/aia4sLi5gQd7FMriRtLd+dws/tUizpYEEpKcw3rk7nZA==
X-Received: by 2002:a17:90b:2318:: with SMTP id mt24mr17146266pjb.66.1586698234890;
        Sun, 12 Apr 2020 06:30:34 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 139sm6093363pfv.0.2020.04.12.06.30.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 06:30:34 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v10 8/8] doc: add documentation for the proc-receive hook
Date:   Sun, 12 Apr 2020 09:30:22 -0400
Message-Id: <20200412133022.17590-9-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200407120813.25025-1-worldhello.net@gmail.com>
References: <20200407120813.25025-1-worldhello.net@gmail.com>
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
index 3dccab5375..1c528e2fc4 100644
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
+    H: PKT-LINE(<old-oid> <new-oid> <ref> ok)
+    # NO, I reject it.
+    H: PKT-LINE(<old-oid> <new-oid> <ref> ng <reason>)
+    # Fall through, let 'receive-pack' to execute it.
+    H: PKT-LINE(<old-oid> <new-oid> <ref> ft)
+    # OK, but has an alternate reference.  The alternate reference name
+    # and other status are given in key=value pairs after the null
+    # character.
+    H: PKT-LINE(<old-oid> <new-oid> <ref> ok\0ref=refs/pull/123/head
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

