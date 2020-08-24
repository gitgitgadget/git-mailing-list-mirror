Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDC9C433E3
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3A92067C
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhp2H5gJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHXRmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgHXRmX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:42:23 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0504C061797
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g1so1102767pgm.9
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/T2p8krcQte0QRUp0q/Umun859q0E7dBe5wj5OgB8Y=;
        b=hhp2H5gJ588TulzgWPGiADT/4zWVI8ufuYWKO8GZ4dlzbaMdZHjG3sL0Ra5kuqncrq
         /W9L8oefy0hghkiPJo76+377Yh4mtaFizCyPm3tF2E8I8QMMRcNUjwSPjgk39Mv1W8JE
         3tO2bo4olpFSb3RUF3YkGuHeWxrK8i9vPSixFmAmKitCJe1EW6NHnaAMi21bNjsXm/PT
         f0DUYAcrBkvIQKF5FdG5HholsJiPJ6N0CcQ8fybsXQp/v7WJeJKVwcUvlAfCxKmnpWOH
         dPi2lcMdZEUKXWNLVUXssPQ7Ugv+GgbDpeQr5jJRHsVnZe4aDiKjHiNeQsnSyn8RliDz
         Z2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/T2p8krcQte0QRUp0q/Umun859q0E7dBe5wj5OgB8Y=;
        b=tpg00XB9/LjbGjYfo4IeGNo1XErfLeitUvmKc+A4FW+9IMtm/uK9hObt0GOSLLiSzK
         evx2/AYsTRQFtsyGT1HXq6ELvbrH7I9h6VPHSEr4by7LWGQmAOp3fX0aRB8ujvKinVwK
         J8Vt2PZlsWvB/n8yi1+NYXCY5mhDzW3FT0Ars2LPfmHwzHllQATBLKRGn3FVqn1f+WZ6
         wQDkvmCWqprzoZ1CrgGrLsspFcA93lKobz3dZBlZ5GiPU6KWWcbHTFDmQfYl7FEQCAkn
         6zHEfrVp/lge2InBBu3osXWJDdkzFZy60zqfZ1dh4KEDHAmpQDIlIpxjta8FNbLda4f0
         WdOQ==
X-Gm-Message-State: AOAM5328OqaEBXbO4CeCFumYcx8zVC27zSRnTNUzHnYmiPj9Vgk2x8RP
        jJNpLoWYc03JFG9aG7+SdpQ=
X-Google-Smtp-Source: ABdhPJxPm+dWTfctHkHLN0aDpwBMit4eP4/ceg5a1Hdju/HbLTiMGhC6Et5IKGJrEboAY8yGewVFXw==
X-Received: by 2002:a62:206:: with SMTP id 6mr4821492pfc.228.1598290942316;
        Mon, 24 Aug 2020 10:42:22 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b15sm9773162pgk.14.2020.08.24.10.42.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:42:21 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v18 10/10] doc: add documentation for the proc-receive hook
Date:   Mon, 24 Aug 2020 13:42:02 -0400
Message-Id: <20200824174202.11710-11-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200815171740.6257-1-worldhello.net@gmail.com>
References: <20200815171740.6257-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

"git receive-pack" that accepts requests by "git push" learned to
outsource some of the ref updates to the new "proc-receive" hook.

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
2.26.2.543.ge7de2a6e37

