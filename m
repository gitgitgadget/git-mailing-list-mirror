Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F9FC3815B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 861E2206E9
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF7/+5M8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbgDMQss (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731789AbgDMQsm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 12:48:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB42BC008748
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:48:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mn19so4019846pjb.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/VtPuf/KRndKzB/ORhQqCBSQs7ZC3obq6O/x7cTYhg=;
        b=pF7/+5M8/4RbfPHA0Ed+5wFApWLe7ty4dK08cv7jkMu6cGeV5JhJ2kdiZOyxf/Yhzp
         j+vJE3K8+1Px+CjbsvvFnceduh+K0DFPH1GdpROg5EfJcSgTEsABai85YaBnoL1tlcU3
         EdVyZO7EAY8OFRCLIKNUtiooVnBL4viDFt+B83jnPIhioqxhWpIr6f1VriVnGBfif1V4
         m3AGiB2gb9oRTPfVulbj1irkjIW3F3YohZUGfOfF3KGp6GVP9653o6LYqPJWtxWEXSPX
         /YGK4qgFFCbi6MwNfOuGdYMwh+DFTATyQzNzBbTeNTLcpASAmETDgAvOpMbf4O69o5oF
         9sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/VtPuf/KRndKzB/ORhQqCBSQs7ZC3obq6O/x7cTYhg=;
        b=K9y6m16FIi/xKP6sirz4AM1duOJMXZp0oWiSAznck2DRe+Dh5GFJxuLvZu6J0p1I5g
         LE/3lO7GV3cw0UdFL6MGMnetF3aKn9fQfoCd2gELhgc6QDs6DidEaDKXjCst3RL1rv7g
         cT1alcR1r7wYQNRUCLxAkWpBPngHbIEDJtIubPSa/RhVVhDGGd94EHQP1T+TD+q1nBYT
         saCvjoN3qIJSd1XVl6kNlsqrFlTos8jWn97HOHKY532/IbHSnBz77Nee46UF70CcTTXi
         EHQnINizpfq7rYESoE2zfXFqIJGxbFlwuDQB4S6pQWRCN59v8Ss0TTH+Azq4zMnHw0f6
         09VA==
X-Gm-Message-State: AGi0PubMHPNBd/8sUt48Oq42YUWEsY5mny6BjGd7uDZRN/zPQ5u5tgsE
        Jk7YdCxtq2+My1I0qLEVucgR3fTnftw=
X-Google-Smtp-Source: APiQypJyvJVS2K1YyS6uZc3kH1wpWAE+hQBFhe+i5A1sjkFL02oOKKQ2vg8wIDzZTJXIqBeUIwnjrQ==
X-Received: by 2002:a17:902:7687:: with SMTP id m7mr11906936pll.253.1586796521295;
        Mon, 13 Apr 2020 09:48:41 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e11sm9254885pfh.117.2020.04.13.09.48.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 09:48:40 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v11 7/7] doc: add documentation for the proc-receive hook
Date:   Mon, 13 Apr 2020 12:48:27 -0400
Message-Id: <20200413164828.23260-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200412133022.17590-1-worldhello.net@gmail.com>
References: <20200412133022.17590-1-worldhello.net@gmail.com>
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

