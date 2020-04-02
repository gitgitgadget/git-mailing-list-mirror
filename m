Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6008DC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D572074D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnUCuUzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389834AbgDBQfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:35:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46725 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389735AbgDBQfj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 12:35:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id s23so1514996plq.13
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xao2PpbLEeHz8Q7brQeSrXDbuQXW7E1m7gDBH+k/EMk=;
        b=NnUCuUzWtTdj1jPXXhsNKe9wU4IcHkPj5Vr+OVGIgw5LHbvMwXzZadQJMe5zwJvIQL
         Zl+Di/DbUJCamPkK7EnF+g1Cz9uTFJdbP8ivIR372rBiovNeeBpexz0Uc6o2agWO7fo+
         2UZ/Q6166zepp5ESdXtajoM3qDmDaYkNpT2F+pkY64Lr5S3hl69YSWDtCKBp0z/B+xU4
         4/XGUPI+XVQeDX0TJc7fblxElxQWFuPdn6asz7OFKRE24Bd45TznQr47tiR8Bue4vq89
         cJwmae3o4kVtCLV7bTUVrQAat0zG9ErvpBXnfFx0lSkGS5AiEYBhUSTNyEJjZbMBpVvG
         TpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xao2PpbLEeHz8Q7brQeSrXDbuQXW7E1m7gDBH+k/EMk=;
        b=s+8ItbqgMLgc4/6GWNo7nPY8AJ5meGzcNZH7HdECV33BvDz6XHhAm2Gl77qS/rDHYu
         0TMyKCK8awiXgt28QkNoDNBavOphhOSO6x+1eG+LoqMGzIv9bT+auruP+us20fVy+zM9
         joJ0JH+MDLyg6G2cJ1iTzc8JeTz4LnlRpI1O8VtPT17NYQwfcleEnNpPqYjpUw+hbz2V
         T7XziGmy8NNeSG4bZZombtIlfpn+f0lDl4rxgbKaaBLnib+kaaqeh/6GwNx9A5YmGbhe
         91phuJA/oYzlIXA9tAQmxOWkNGNWzXUhbrGVjT7CIi4DkZPahmBL3ql19cHnMTbL6Vu+
         3xTw==
X-Gm-Message-State: AGi0Pua4JOTBRqAO8nmrnlwbDLBIoIlbpULIzq3tbTziTar0fGrqgJYc
        oWykjf19Ug7IANOOxBzwOICdXKPJ314=
X-Google-Smtp-Source: APiQypLiVYWUqCXiWB1OSBo/uEVQ2pDEMuz6NFLCN54T0qkYqcYVAZSEbJ8fwe0Qk7YkP/orCTeO3Q==
X-Received: by 2002:a17:90a:feb:: with SMTP id 98mr4817925pjz.72.1585845337011;
        Thu, 02 Apr 2020 09:35:37 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 1sm4178140pjc.32.2020.04.02.09.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 09:35:36 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 7/7] doc: add documentation for the proc-receive hook
Date:   Thu,  2 Apr 2020 12:35:20 -0400
Message-Id: <20200402163520.1338-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
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

