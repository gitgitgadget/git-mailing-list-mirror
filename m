Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF52C433E2
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732B82067D
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeDRKA7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgERJlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 05:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgERJlB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 05:41:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FB0C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:41:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a5so4905539pjh.2
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRuk1Se/vLAyVWxhzg2evxF63NLF6zG2/1wnu1HXRe4=;
        b=UeDRKA7Ut9ChC0MBayxavDBocWSMp8xhi3Kh2AhIJpM7tYGCNlBwzLJwZuqCUIEfjX
         jg88C66qGNwlxdYC4WHkgFsvekCnN7q2PP0MSfdFWlSoEcDafalVivQXBG3LuKqaTc4v
         FEMwkWgHNv4BphlyCZyx9w3eX68MZBhsDk7kE9jKLyIZOmvPnlpsrePnnw9JFA+edTgV
         s69aIH5DnMzyhC91qWZJu9a9QsS7CxvCQAb+lEvN2Df5ricZYGWt6pUpEF5NWpKuwUSh
         YTVgNocqmZg3ia7wj/b6ZI7YSyeQfTiPVv435Cxlg9DGAzxl7tYX7D4x2H7YjgLptHyS
         rBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRuk1Se/vLAyVWxhzg2evxF63NLF6zG2/1wnu1HXRe4=;
        b=qD5QkT9HgvoF4+vK6mk0U3lar+6nqTia7K9GSSmL7dipKsK3M/i9KR1JQNJezBFH8i
         bcAKYfVm3DWTZ9I31xBWueVtnYGod7cfdMS9JL8prVieCyoXUuI4Vbo/FuPtqdJl4Odd
         0XtABhPNi5O4WXfdpWpKU+CG3hyYFNQ+nhV+2yqwuzJJbdqDo2Y0tPI79L5vCZc5Te7p
         ZYKtYdoUZLPb1UYsgCZTUAORsyV7tBbBbYZPHgW6ozyEAcY4oky2qQK0DRi2fVypRXXi
         oS02jiYKZfVBrVP+wVU/oRIFFlZ3MYdpwxeiNJRq1c9G/H7CvEsRYYjMY5f1iXVWE7V9
         rM7A==
X-Gm-Message-State: AOAM5320mtvd8K+9ZTMkstMO2NQZHDPXgAKwnu/Um591qBdV/7C5xcMx
        qw6K/5c1/bug/ltJoXI6gBA=
X-Google-Smtp-Source: ABdhPJxVAbWn1xV2H+HRJM7oUN6BR40WTrpMMHR+H1xbU4OTtuOsXRKcgC+McjvPkphKkx1iVSYADA==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr14226618pld.188.1589794861288;
        Mon, 18 May 2020 02:41:01 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e1sm8119867pjv.54.2020.05.18.02.40.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 02:41:00 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v16 11/11] doc: add documentation for the proc-receive hook
Date:   Mon, 18 May 2020 05:40:39 -0400
Message-Id: <20200518094039.757-12-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200507161057.12690-1-worldhello.net@gmail.com>
References: <20200507161057.12690-1-worldhello.net@gmail.com>
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
2.26.1.120.g98702cf3e9

