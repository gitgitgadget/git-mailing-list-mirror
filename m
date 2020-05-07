Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DB9C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 16:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223132083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 16:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AImSUbpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEGQLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEGQLM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 12:11:12 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B8AC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 09:11:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id js4so788992pjb.5
        for <git@vger.kernel.org>; Thu, 07 May 2020 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7sFUlkf8lsE3Agqm+OVmHurXfxuwCOW4QFSGNZ8kPQ=;
        b=AImSUbplvIAK3auXu7tf304rRX/VMTej/i6qF2TMWSrZZW8rUEKmYOLM2s4MPB1pSW
         ieLaXRvhxMW1MAJZPdkqnffh4aNi+ursvYeQysPI5Mdn0EvinogCyMc+n1at+aGoiqBk
         2R1x1hH/4cM9Sahwol0X8m9hNRU2GDlRoEOLLaeeUERgRCiAlM2NCSlt2mKuYwCKst1o
         XZ/ixUw2Zsm4KX6Ai4E5X5FD2K8h/Fi5GMpxcqPlnHb6vZyVlpmLHTwgSyKOT+V8NLea
         lEQUEw1ER4Wgbdj0mSI1DBabMy3eBjrEd5OlD9ZKaCPKxf70yIMgF6VeiCE2Yr203fC1
         0ugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7sFUlkf8lsE3Agqm+OVmHurXfxuwCOW4QFSGNZ8kPQ=;
        b=LeTB7eYGLnKHYBdIV75RlIo8RAG7XEZgL8Q/f6nwTCGoB+6GRG8zpXiqDXkTKHhr9I
         JxMxxb3gqUzIL/Duev3oNqU9KoMFhyjg6d8v8Edikd+3gtlv/fAqTMWAEAnJtDmtzI6B
         wKqu+yp/NzjaQfDbxt+KxL2aQkBaChaJrllPSQ2fdSXEzuEItnPTyfzI2ED5i9R8zIiZ
         M8Za+R68PvEYO1MxhfZJSW4Iu6q70tnb18/RKtypSzSUimRwxX4177DIaPYtrpndAn6o
         f+V95IsJPKBA//Nsur2ZsGDLI1bd6PtMJo6KP1QjKTZNa6SUOymGMoyFsJD6+Gbaokpz
         ZFLQ==
X-Gm-Message-State: AGi0PuaU/KVgCYY8ZSvywSI4VIGqLfVqX5LtLMpJTten8MWr9BR17X63
        bdjhT+Af3F6tG4gaV9Ex11vsTGAq6Hg=
X-Google-Smtp-Source: APiQypL/LqaaxiWzP/8JWLZmWwTJRfCA1LqCYZ1CXhpm7c3t1ta1cfNNl38TN7pkNuP/C9D+beanRA==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr13875101plf.115.1588867871930;
        Thu, 07 May 2020 09:11:11 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id gq6sm238800pjb.54.2020.05.07.09.11.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 09:11:11 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v15 7/7] doc: add documentation for the proc-receive hook
Date:   Thu,  7 May 2020 12:10:57 -0400
Message-Id: <20200507161057.12690-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq4kss64h7.fsf@gitster.c.googlers.com>
References: <xmqq4kss64h7.fsf@gitster.c.googlers.com>
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
 Documentation/githooks.txt | 62 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 81f2a87e88..d66154f606 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -333,6 +333,68 @@ The default 'update' hook, when enabled--and with
 `hooks.allowunannotated` config option unset or set to false--prevents
 unannotated tags to be pushed.
 
+[[proc-receive]]
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
+    H: PKT-LINE(ok <ref>)
+    H: PKT-LINE(option fall-through)
+    # OK, but has an alternate reference.  The alternate reference name
+    # and other status can be given in options
+    H: PKT-LINE(ok <ref>)
+    H: PKT-LINE(option refname <refname>)
+    H: PKT-LINE(option old-oid <old-oid>)
+    H: PKT-LINE(option new-oid <new-oid>)
+    H: PKT-LINE(option forced-update)
+    H: ... ...
+    H: flush-pkt
+
+Each command for the 'proc-receive' hook may point to a pseudo-reference
+and always has a zero-old as its old-oid, while the 'proc-receive' hook
+may update an alternate reference and the alternate reference may exist
+already with a non-zero old-oid.  For this case, this hook will use
+"option" directives to report extended attributes for the reference given
+by the above "ok/ng" directive.
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
2.26.1.120.g98702cf3e9

