Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F10C2BB55
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 12:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17489206F7
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 12:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZaZPQYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgDGMI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:08:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42166 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgDGMIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 08:08:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id g6so1636151pgs.9
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xao2PpbLEeHz8Q7brQeSrXDbuQXW7E1m7gDBH+k/EMk=;
        b=iZaZPQYIqABgnu344wbr2Gkrn6Okhqb+Y3dmhteB8wGUREAG+Hnm71bgjQhbwgPWpX
         5GgljgxYnHCBUeWcdfQHtBelgheMkunaR8LuW+38k5JFfbzn2V/bpymJ+47yDRBWAx+p
         Rl8phzBe+QeOJ38nfgTigLAT6mrDajDuMshRB3WyglaH3y/2Lb3wdPjqVQUm2D4vzfOJ
         FeizZPnko/GTmwZEfr3YYZr3VqThlYzjqp69gptEJjy6ve6QO79V30pk+LixsAXumfN9
         j5FkoGHrN/bXcv0Oo2vwiYcvGL/9g7LaKmdIrnjTdWRwXQuFleIf+ZuoOnrwXAllbK8p
         JhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xao2PpbLEeHz8Q7brQeSrXDbuQXW7E1m7gDBH+k/EMk=;
        b=UKSr6Q5tfnminIyAHaID7Vl4EIk7T+FtItfXLM4ibq5lGoBKPnr6tMzLVGJCWyDMb9
         tboEDN3ABHQ6ggCDDJL0dCJnbasUI7DcEQNxBXkC7mz73qDVD75QvlbOVepePC0Lhfjx
         FjSINfpbbW2MdZ87esC18C5hDCO74d+9kWi8PD47L3wHaqE+TwkjhdJbDG3iNCU/Qsw4
         3hm8ItSayj9++oMSTYxt6jjTrzP1ay7R6eZvidm6gJXjmDVvdmGA4S66RB8V3EVi74ZH
         ehjb/silYVAu6ldZeO/TMyR8YZ0YKFzb0yd7y9HG/ZWB3ixLnG2Tm1Y3cBQaxFqHKuug
         Ld5A==
X-Gm-Message-State: AGi0Pua9O4Q4nPv2PLrQIClr0gkJxmHzin7q/JS75ZoFRH9uGmqpl7iZ
        aFZjs8I/7WdlrKpgcLvX6VE=
X-Google-Smtp-Source: APiQypKdCFuUa0YO1XolTcNbiDK2oEZt4gJ1W3irPdMOXq3SvvyR2ScV3P0NnmcKfU/vVLwn7/ubgA==
X-Received: by 2002:a63:4d2:: with SMTP id 201mr1728524pge.276.1586261304219;
        Tue, 07 Apr 2020 05:08:24 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e26sm14061833pfj.61.2020.04.07.05.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 05:08:23 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v9 6/6] doc: add documentation for the proc-receive hook
Date:   Tue,  7 Apr 2020 08:08:13 -0400
Message-Id: <20200407120813.25025-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200404134345.10655-1-worldhello.net@gmail.com>
References: <20200404134345.10655-1-worldhello.net@gmail.com>
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

