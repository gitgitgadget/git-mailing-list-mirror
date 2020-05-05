Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320F2C47257
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E844206A5
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwN+jipn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgEEOlu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 10:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729488AbgEEOls (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 10:41:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68A2C061A10
        for <git@vger.kernel.org>; Tue,  5 May 2020 07:41:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a7so1182467pju.2
        for <git@vger.kernel.org>; Tue, 05 May 2020 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7sFUlkf8lsE3Agqm+OVmHurXfxuwCOW4QFSGNZ8kPQ=;
        b=OwN+jipneLc+bQGFGoreaZWWvsdsjsRVnp9vMOGKmOOaIlTXpyKnsYsHTJk6IyDTgX
         SMAudlIhhG01LW2joJ0ZQ1vxqoUmavPjgG1flniESvV3AFqp00izPZS1pKoGv4odj+Vc
         8FdCnkQ13VWtoju1AMsgEB3UE67/nfshE3rkvMFtSVS2I8/UrtvWTAIWMQ0oN9VkLZo/
         OVuFuDUSh955/ZdC0SQgpNhhI13v4tWRx++xq9avwFO6cYTFzh987iS18yJhYm6DcCBW
         AId134QZMvPWUsGNmFmcmPlhw2yhYitiNn2KqqvgOmRlNctgahUTjO4XG2i2ODkPG2fQ
         Ohdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7sFUlkf8lsE3Agqm+OVmHurXfxuwCOW4QFSGNZ8kPQ=;
        b=EKQIy3L3OQt03fT/keTL7w424LZtapuUXOIodKUy4+ZYK9UP4EVQRtosyIblDq/Jwv
         +Ro9DdIlzxsux/6LTa4KjJuXG33xebPettByq+47OonIUB2M3J8v89mw4wiL8JoO8u1q
         6TRBd0gMJyEayBePpq8Q+vAHKxJplxDtnF1k1yhf4X06G/LHDv4cyf2V3rn0aSAMM5Ke
         CglBGtkX3k1wO7jaunNzPyWYxKE81/FuBkQdh9H0x5lvN5bvl5cxg2v4sN1BfzDTQqsd
         Py5D4EZfspoxpuclsRC7YGznF31Ko73O7+JVrDylHZpF+eYPe47g+us+xwiuY4JUvPI3
         nbdw==
X-Gm-Message-State: AGi0PubzuUdsXz+86MtaKrPYM4bLA+6vw+K0adEiAeundUFXr14Zn8sc
        Dbkpacl/Uww+Qsu5ZOoztHw=
X-Google-Smtp-Source: APiQypKZHvT4F2Zdiq9KVZKfyfu/qczM9Y/0Yjonm0nu84pkrZ74VNGobMMSp/Fkgkp68TUsZJxC6g==
X-Received: by 2002:a17:90b:3014:: with SMTP id hg20mr3523026pjb.56.1588689707387;
        Tue, 05 May 2020 07:41:47 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id f99sm2431012pjg.22.2020.05.05.07.41.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 07:41:46 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v14 7/7] doc: add documentation for the proc-receive hook
Date:   Tue,  5 May 2020 10:41:31 -0400
Message-Id: <20200505144131.30048-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
References: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
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

