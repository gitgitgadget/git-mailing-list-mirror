Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A06DC2BA2B
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 13:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41112206E9
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 13:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A53bMO2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgDDNn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 09:43:59 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39594 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDNn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 09:43:58 -0400
Received: by mail-pj1-f68.google.com with SMTP id z3so4325769pjr.4
        for <git@vger.kernel.org>; Sat, 04 Apr 2020 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xao2PpbLEeHz8Q7brQeSrXDbuQXW7E1m7gDBH+k/EMk=;
        b=A53bMO2DBBKpd4yw/yXZTKvPerAptw2UqWmVT08F0D9z8vrha//D2IW97AA86m8Bi/
         J6zD0JLYutwR+I4E4lr1ARLNkF/2X6T8du8aEd+0qU8wSLecoSEzBIjnyqqXGEiFG1qi
         9YIiJ3NOKgm/DL0XNGiDjnmOIWNx5r9npppnv///bohMAp/pUMeVYXaZi5D1aY1cOhbc
         9LE1lRANysA4gtC+ZF+uV0DhqNmhzTFYUSAe7iupX9oneRAI/G9C1EAoxFIShl4P5gGD
         g2m10xFZX7+6ybj1HDftEr1xOf9ioVo2EbfJ0WITBJr992mz0G+VPKg7+E96a6lIvYvd
         f0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xao2PpbLEeHz8Q7brQeSrXDbuQXW7E1m7gDBH+k/EMk=;
        b=mqJYlB64fi6ylnAN1gaFgG75dKoYjubH0APYUWqT1/D426X54JLy+2CVigTM3hpxoF
         3tjPGyyZ9VoolaClZSGeq7gFPCk7IGDj2b4mEWnOcvqSUI3LE/4x88Ga64dbuusL29ic
         d0wsREoXTiUu3/Jr0/5W/9NHm6ArktXfnvauZ0nlPkGBmMuI4ZJNrjdWHJEWlFYTQEKP
         +ssMdmJ6IRAdFpRwJRp0ZnMtqQabMdUZHLcmh5OB1sksTL9iwbAIOBCn5AZ6GDybzlx0
         hOZzi295bBI56gu4Gp48cEHdvCc7aXyhml0v7U7u3+nQxVtBOQpZ5rnef7UUDZl5S4i7
         p6dw==
X-Gm-Message-State: AGi0PuaBUqgm3yfbtZKWtxg/kd9621k9K9ial9yMJYPjzjyFfOzbFFEN
        FJX9Fv/Q4hQ8FQs8T+PN4JIBp6zp
X-Google-Smtp-Source: APiQypLgMNLsGrdMBv7yBfbtG2guhaXXKcKQ/Yp+SFo4a2SjIik9nARpWriDcGCwYldDkg4Ezbxn5A==
X-Received: by 2002:a17:90a:fb41:: with SMTP id iq1mr15474672pjb.38.1586007837203;
        Sat, 04 Apr 2020 06:43:57 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15sm7755531pfc.206.2020.04.04.06.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2020 06:43:56 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v8 7/7] doc: add documentation for the proc-receive hook
Date:   Sat,  4 Apr 2020 09:43:45 -0400
Message-Id: <20200404134345.10655-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200403160838.6252-1-worldhello.net@gmail.com>
References: <20200403160838.6252-1-worldhello.net@gmail.com>
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

