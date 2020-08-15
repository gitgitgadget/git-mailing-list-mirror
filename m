Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB89C433E8
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A8F204FD
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMY+9fcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgHOVzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbgHOVwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:25 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1340C0005DD
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v15so6003558pgh.6
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fh+DwmfOmldcvLEzNo5wwv/5ahz9TmRejH+rPE4PnzY=;
        b=PMY+9fcWIxTSCPUI1nHBxDRFIj3/soVZCb5/gAEV/XETaT1kEEaFmZdQdtEGqZQF2T
         wVNIAzWBR/d+LidyTqSWo3PeW9DSrjZqJ+V7aYRYAw3UMSlrinvBA4+56k+t/u5IB5cB
         qlTxNsPevZZ5JloTnswVB6xTpIIi/OLVKC7JeWdV2pifIktGObFN7rMRsrfd/85I8T2k
         UnbmLeViQj8jHY4Oa6ErEjvhxWeSQg6JXd3ki/yBxkuR4mQyz7C6H+rFIwJpOQ5B9Pyh
         ea/bi9QLO1Gy+RDFwqsDv0J/aAxtFr4vstj8BLlA2qf4AyDUsdCBFzkN/iyZj1Y4fbfh
         riiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fh+DwmfOmldcvLEzNo5wwv/5ahz9TmRejH+rPE4PnzY=;
        b=FM+kY/PLGsqPj1NT0OeEVIklwqV6UtsgWLVl7YCIUlGTNSL1MtsSntti8tmS5/KLTE
         LxANfdPNj3B24H6JREtwMP+IPzLHFpaytGOYng68cFc6hZCJ39KAKjqSRefAfKH4MkMr
         W643fKJHOQ0u1Tu+6GkbsAjOHv3oN2vcfTNN7LcHlA9610FqckQ148cLI9DG/tr03KCU
         6M6B61siwbWjK6kejSZhq6MRwHtDDJu9+kJeMd85MdL6RtwKhzaEby0VC+QUqxW6EVIB
         mDyIO9AzUWa3mn0OEWpxqf359oclJpX0KqlyesNqPsgcwLTGmxFYtKgcON8epfFqk4IC
         kVLA==
X-Gm-Message-State: AOAM53055B7i26JbeNpMlGFFzIzWshnPib4J2eY0qR1Q7y+gdqndJDcA
        ht54+atV4UKlqZ96z6ZywUphFF05i8E=
X-Google-Smtp-Source: ABdhPJxH8W7dHGGFNINQ7Nr56J6NDM1VQQM3PRd1bNsgDA02sPFNpuwQKHi22RHInrKVZ640XI9Mrw==
X-Received: by 2002:a62:18c9:: with SMTP id 192mr5619711pfy.23.1597511877991;
        Sat, 15 Aug 2020 10:17:57 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x13sm11040596pga.30.2020.08.15.10.17.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2020 10:17:57 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v17 10/10] doc: add documentation for the proc-receive hook
Date:   Sat, 15 Aug 2020 13:17:40 -0400
Message-Id: <20200815171740.6257-11-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200518094039.757-1-worldhello.net@gmail.com>
References: <20200518094039.757-1-worldhello.net@gmail.com>
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
index 31b601e4bc..ff2f2f1fb3 100644
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
2.28.0

