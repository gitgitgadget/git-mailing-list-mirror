Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D6BC2D0E5
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A8F20780
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxsJh28S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgC3Q6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:58:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42191 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbgC3Q6M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 12:58:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id 22so8868439pfa.9
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RmH9tNFuD8U9FdYMRWjfacTTahV77xFCGdBbz+yqOdI=;
        b=IxsJh28SA3uwe+kch2Z/4KjcDfs2OztfL90JBA/ywVIBSDU5088vsSZg9yUnLFuYEu
         Xv/arAGPrYAErb01YqJXLJmWWU/F/PFDdj8cv4kFdGYg7KyPBSImDWrA8Sbig4HKhBrr
         kyQ/Ha0FdLJdp4JEzhK44QmXXAnN2jd1XhGODk7YRT7ha6rWzyBW+cybVg9ZDQPK/fvO
         Zh9074wLcypztqnr2A55F8j7LtEIWpyDLJWusNHhh4wDHn8MQS+Cjm0ZPyCkWq6Ud00w
         KiVVGFpzrZXsKAkEHRyPx25sk5dMi8C330Y/6z/wMegR+kmenHjQvny1tADET+4PZzwi
         H5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RmH9tNFuD8U9FdYMRWjfacTTahV77xFCGdBbz+yqOdI=;
        b=XXA4VVhdr49I0C2VirJ+DtBA+PfKAePad4MZdd4pVJeURWl6OiR8p0AOSSiVoDRJjZ
         5T9nvF8E2454fPH2picIdCilmIymUDDMoBTWJW/OhYFhmduJ5iR+7K2/Z6CHpauHDbO2
         fFc7lesOE9zJTKzK+Nm3KLB1PpRgqWai2/6VXzLq06uIgfv8BYvjx8Gy0dmIjOeSwvPY
         ipx1gKml48KUKExLlk6C74+LVPMTyvJ0L+++Q/agKFhMWjr3vPMgTUegJL/Mhv2aCaTI
         kMkscn4W6+VzrVKu1hqLW6F5J9Zeikv9nu+kIhUziaOZNvLArMIQfmwrl5noD0le2b4n
         pffQ==
X-Gm-Message-State: ANhLgQ3j84RYDzSW2/f4tFDtbYLBpdRD0IP2qp6L6wuz2oq9KGXUAtDz
        Z7OAem+s2gUVxWgjLbv7FBXnymPsrrA=
X-Google-Smtp-Source: ADFU+vsM9xKfiLI/W0waYD0iycwXr9mTTq/klXS8eMH10E1WN/H3F9/ZIporwKsY/ZBVCpVopRKVjg==
X-Received: by 2002:a65:6250:: with SMTP id q16mr14072716pgv.9.1585587488985;
        Mon, 30 Mar 2020 09:58:08 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a24sm10589604pfl.115.2020.03.30.09.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 09:58:08 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 6/6] doc: add documentation for the proc-receive hook
Date:   Mon, 30 Mar 2020 12:57:54 -0400
Message-Id: <20200330165754.19195-7-worldhello.net@gmail.com>
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
2.26.0.4.g39bcdcb101.dirty

