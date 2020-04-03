Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67B7C2BA1A
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 16:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4E0206E9
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 16:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOOIxJ5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404096AbgDCQIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:08:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37084 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403930AbgDCQIw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 12:08:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id u65so3691311pfb.4
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xao2PpbLEeHz8Q7brQeSrXDbuQXW7E1m7gDBH+k/EMk=;
        b=YOOIxJ5ONVejVbNFUghUAdq7/Vg73dMUjgRtTAoWxaYq8UxXI+CUr8gklcH3pQZeEM
         UOewXX5gv+qMN1YS4QD1nbWoSbx/Lch8+Ok5D8mkOWQVWjJbwSHjGea70wknoPTX6HUg
         8cQP/QSgNtinyqtmDWuzgmSwHs/Pj6YN+UWpZW0+/fPZCBtcWXXg/fk8aYUjQfOVK+Yo
         6OvxlCvtR3TFFkRWDxO8cmxKA5zdYy3qNobrzYJoPLU2LT5+W04Fhe66mc3WuyKCPzKK
         1fyC8AOXfD1Qby3T9jsgWEnoembj6gt18NB+JB8yCMuscGIgHxL4TlOWBu0bKVe64YSa
         q/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xao2PpbLEeHz8Q7brQeSrXDbuQXW7E1m7gDBH+k/EMk=;
        b=KNi4XiIhgvubpLg2ArsRBzeEaTRKn6sx8zj7nt3w0lugZOhdLw2bqHpXDJZ6lkwe5X
         VyeHEKA5HOAShcm3PWy084MKhzZm+3uKTBLAOSMB5yYbHv53IDomAcw6A7dIRHvJAcTN
         l0g+XpsQWPhpJuzoMNpzy3DUueOGiPoNSb4ljju/TNDIPpwZGfNm+YTnCS8KP02IE/MX
         Q1W2rwceM1huYAjGaix6GFtF5w1AmAm/VMDmaEQwWrMP0S3VZ4/ZId/pwIdSLbVdTrFq
         BAs6itRQquSkAuzz7Dr+5redPb50gno+Yjn3DdG+CcsUW6zGh0Old99xHqGBugNGYTGp
         +YDQ==
X-Gm-Message-State: AGi0PubJew5908v2ghOXF8FhOf3r6f7m1qXHiG6auAJwIxdEx/4RyEzi
        tzf6ufHy7v2knR8jBstQd6w=
X-Google-Smtp-Source: APiQypKSLG7JUC8Kp1yUBjDy3xMx4KwdRyq1lu4818s/iv2lNkBxT9crH3LWGQ1ghA5Y9NwGgXgJtA==
X-Received: by 2002:a63:8848:: with SMTP id l69mr8329409pgd.288.1585930131005;
        Fri, 03 Apr 2020 09:08:51 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 21sm5670420pgf.41.2020.04.03.09.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 09:08:50 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v7 7/7] doc: add documentation for the proc-receive hook
Date:   Fri,  3 Apr 2020 12:08:38 -0400
Message-Id: <20200403160838.6252-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqqftdl3fss.fsf@gitster.c.googlers.com>
References: <xmqqftdl3fss.fsf@gitster.c.googlers.com>
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
 Documentation/githooks.txt | 70 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 3dccab5375..10ea5c1f18 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -333,6 +333,76 @@ The default 'update' hook, when enabled--and with
 `hooks.allowunannotated` config option unset or set to false--prevents
 unannotated tags to be pushed.
 
+[[proc-receive]]
+proc-receive
+~~~~~~~~~~~~
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+special `git push` command.  According to refnames of the commands which
+`git push` sends to 'git-receive-pack', the commands will be devided
+into two groups by matching what the `receive.procReceiveRefs`
+configuration variable defines.  One group of the commands will execute
+the internal `execute_commands` function to update the corresponding
+refnames, and the other group of commands which have matching refnames
+will execute this 'proc-receive' hook to create pull requests, etc.
+If there is no `receive.procReceiveRefs` settings, this hook won't
+execute at all, and all commands are sent to the internal
+`execute_commands` function.
+
+Its exit status only determines the success or failure of the group of
+commands with special refnames, unless atomic push is in use.
+
+This hook executes once for the receive operation.  It takes no
+arguments, but will talk a protocol in pkt-line format with the
+'receive-pack' for reading commands, push-options (optional), and
+sending result.  In the following example, The letter "S" stands for
+"receive-pack" and letter "H" stands for the hook.
+
+    # Version and capabilities negotiation.
+    S: PKT-LINE(version=1\0push-options atomic...)
+    S: flush-pkt
+    H: PKT-LINE(version=1\0push-options...)
+    H: flush-pkt
+
+    # Send commands from server to the hook.
+    S: PKT-LINE(old-oid new-oid ref)
+    S: ... ...
+    S: flush-pkt
+    # Only if push-options have been negotiated.
+    S: PKT-LINE(push-option)
+    S: ... ...
+    S: flush-pkt
+
+    # Receive result from the hook.
+    # OK, run this command successfully.
+    H: PKT-LINE(old-oid new-oid ref ok)
+    # NO, I reject it.
+    H: PKT-LINE(old-oid new-oid ref ng reason)
+    # OK, but use an alternate reference.
+    H: PKT-LINE(old-oid new-oid ref ok ref:alt-ref)
+    # It will fallthrough to receive-pack to execute.
+    H: PKT-LINE(old-oid new-oid ref ft)
+    H: ... ...
+    H: flush-pkt
+
+The "proc-receive" hook may update one or more references, and will send
+its result one by one in pkt-line format.  Each line of the result has
+four fields and one optional message field, like "<old-oid> <new-oid>
+<ref> <status> [<message>]".
+
+The first three fields are the same as those of the commands for
+"receive-pack".
+
+The forth field has a two-letter status code.  Available status codes:
+
+* ok: The command runs successfully.  If the optional message has a
+  prefix "ref:", the hook has created/updated an alternate reference
+  instead.
+
+* ng: Fail to run the command.  Error message is given in the optional
+  message field.
+
+* ft: Will fallthrough to receive-pack to execute.
+
 [[post-receive]]
 post-receive
 ~~~~~~~~~~~~
-- 
2.24.1.15.g448c31058d.agit.4.5

