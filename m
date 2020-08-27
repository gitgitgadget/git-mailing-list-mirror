Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62C5C433E5
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E292177B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBIsiGLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgH0PqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgH0PqI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:46:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6C9C06121B
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:46:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y206so3806133pfb.10
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+w/ZUEz9uwa4488MthxDSq8bg/8oMimN8qJZs+WIIbU=;
        b=uBIsiGLcXFmAkW+m230FP9Ie74hHuhDVOTfrXnU9xYe3tnfPc8q2Y6lIHZ5apPutdb
         UHXTThWZv/mnUTvJkO8L4h/hkEil0ohfJiwONPM2zgaPS5subFZd8dTHkEgsdSj1zPMv
         9KjwhV0U3RwTbsztpg3cu92r/m+s5gR8TWvQqmHTUtvpEix87+07PI+Kh9pFUG3XNofm
         /ooonaYHLgNNzt+u+xot5mGPbYlvHhKBMgtUkS1P4hRYAe3G10jiOdNdr7eStA8WGiCi
         KGUMRvW7DGeV4jOd25mzG8w7kFR8rvfLbfTtTOmLkO9PCe8xu6OojHahL1eBdi2COlL8
         4kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+w/ZUEz9uwa4488MthxDSq8bg/8oMimN8qJZs+WIIbU=;
        b=oNA7daBl9BUTLCpavrRgXzvu1CeQJt/L+iLCYSavPRe9FMzJIttb5di3bUaaP/+uey
         Uy/dY3gRyH8zcFJDWb2Ew5jfO2EhSLq3FesOYaHVcBsJG2icB0NCdqT/5RjFtJeIcsnu
         OPGfjXs4/1tNynphtklnu9rKc9U9RyTEJgeHRMOgd8s7wTDnqFBWJOUsYhHSVsSBJyhy
         ILn/l78CjA4wy/1MbUc37n50DBOlSZgs5lLEWTtRCfU1P5cVL7nlJImH4qn1hbfvc4jr
         lWJno8vtBTmhyxtVuKLXoxJLEpVHZtQNnr53EQSMBO6qeHLgNz/epi9VCX7Qdm7hXrQc
         O6IA==
X-Gm-Message-State: AOAM533vbxCqiA3QuWJvzoFQe/47FmoBjGvXkpjc9h0K+Ul/ADCKA+CG
        IRUqqLFLV6XBsFkWa8GTYYI=
X-Google-Smtp-Source: ABdhPJwj0xt6H7Mtv38F2khC4irEc2kP49+VpdhdFzcsC6PaO+KBO+4rtX4g+iGRDH3iSBmqSGyfOg==
X-Received: by 2002:a17:902:7582:: with SMTP id j2mr2944072pll.322.1598543165765;
        Thu, 27 Aug 2020 08:46:05 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x5sm3129218pfj.1.2020.08.27.08.46.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 08:46:05 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v19 10/10] doc: add documentation for the proc-receive hook
Date:   Thu, 27 Aug 2020 11:45:51 -0400
Message-Id: <20200827154551.5966-11-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200824174202.11710-1-worldhello.net@gmail.com>
References: <20200824174202.11710-1-worldhello.net@gmail.com>
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
index 31b601e4bc..2899e80445 100644
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
+    # and other status can be given in option directives.
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
+by the leading "ok" directive.
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
2.26.2.543.g44b58e439b

