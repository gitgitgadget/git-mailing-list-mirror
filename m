Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D57CC4742C
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5050E22268
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a79WY+Yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgKCA1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 19:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCA1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 19:27:15 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A944CC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 16:27:15 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y9so9550288pll.18
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 16:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=I8LOc03FQsEbG+peTCv8TKVa0w7CTfBWvRVZBeYaACY=;
        b=a79WY+Yu7sRwHIfDCLkpxomiqkiUvWFcpCta0OPk06TapH2D1EnI2XXSoi8OxE3PPg
         +LlaXBSowZxra6rS9v8XVSXizdl5tg4DrdunrlqZCOkfgLWsxGyU69Uh3SyMEqXMECqK
         rKko9k0vC+IxQA9CvXRxo8bOmuzGq78X16BhLzhH8Oer1TU4uiNdqJz3shq9Gg7EBP48
         CQekzjVxIbQtS2/lCVDEJmnOiID+UIXFYQW5YuwemnakddqDhHnhBPXilMFgXEW0YsiZ
         tffZBWvzOObUaXX4dHaDxEdlKwvXCLsYuhi+cjr29kaLUzfl9oZBrgKe28vw6soofSlk
         WbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I8LOc03FQsEbG+peTCv8TKVa0w7CTfBWvRVZBeYaACY=;
        b=XrBGDVHWzvS2aTQcdxwhX44v/mbTXFOlAtn2YKvZkkAX5I/FnnFyEMRq8d9PZF4BAJ
         8v5DJ5rR+GMGOAIoHELrzK377T2OBVdwRhsi1Az09Jyl0jpSVU7wnnbKK0ag8353Hj3O
         DjIYxA38tgu8w59HF+FpaxCHx9KPj5PX2WHvs4MOeRSsf6Hro46dY4Mu/hJYLhYoaZRc
         Zk+7PTOZR0pTXWQglRVg+q0GxDzxB8iEUnZG4BXnDeVPQinTRT2eZlkneWmfX5Y/MxxJ
         NFeGsWzJpvBffnnS8LmwieyHd0hZkxemuIF/flOqbKWCkHI0i8/BRNBWZrUeDpETtpIs
         Wtpw==
X-Gm-Message-State: AOAM533rywOiOb7CNbLeyPJj3NV6l2kZpzII+42Iw0PDFklQTdjHESgt
        k1j4deAfeZrB/fXeTBnoxTolle47q0xo9pJuoAi0ZchIi1kCtm7EJG4cQvdMb9Njw/Gh2aQwbID
        vPQV0KZCC7QH/JBUJHOkdOTZf2bIqeAu6aFb+pb+7q0m+eO3QLVa0IVFZrH9gIFfV+UXu9l/+Sy
        8P
X-Google-Smtp-Source: ABdhPJyMhVmmnR3nOIR1uI9y5eKu1rs3ogypp9aqmnFLS+vZYhHGvUZg8pvGAvsB+8gT+1frLPQWLEeA+fxZ5gC0XstI
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:d710:b029:d3:7e54:96d8 with
 SMTP id w16-20020a170902d710b02900d37e5496d8mr23385377ply.65.1604363234958;
 Mon, 02 Nov 2020 16:27:14 -0800 (PST)
Date:   Mon,  2 Nov 2020 16:26:13 -0800
In-Reply-To: <cover.1604362701.git.jonathantanmy@google.com>
Message-Id: <6250c13897e3cc01f247d80c148cf8dc5e7f3ad0.1604362701.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1604362701.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 4/4] Doc: push with --base
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Includes protocol documentation and a design document.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/pack-protocol.txt  | 10 ++--
 Documentation/technical/push-with-base.txt | 61 ++++++++++++++++++++++
 2 files changed, 68 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/technical/push-with-base.txt

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index e13a2c064d..0485616701 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -59,9 +59,9 @@ Parameters", and are supported by the Git, SSH, and HTTP protocols.
 Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
 
 Servers that receive any such Extra Parameters MUST ignore all
-unrecognized keys. Currently, the only Extra Parameter recognized is
-"version" with a value of '1' or '2'.  See protocol-v2.txt for more
-information on protocol version 2.
+unrecognized keys. Currently, the only Extra Parameters recognized are
+"version" with a value of '1' or '2' and, for push, "base" with an OID.  See
+protocol-v2.txt for more information on protocol version 2.
 
 Git Transport
 -------------
@@ -506,6 +506,10 @@ real difference is that the capability listing is different - the only
 possible values are 'report-status', 'report-status-v2', 'delete-refs',
 'ofs-delta', 'atomic' and 'push-options'.
 
+If a "base=<oid>" Extra Parameter was sent by the client, and the
+server recognizes that object, the server MAY send "<oid> .have" in
+lieu of all the reference obj-ids and names.
+
 Reference Update Request and Packfile Transfer
 ----------------------------------------------
 
diff --git a/Documentation/technical/push-with-base.txt b/Documentation/technical/push-with-base.txt
new file mode 100644
index 0000000000..d56aa7f900
--- /dev/null
+++ b/Documentation/technical/push-with-base.txt
@@ -0,0 +1,61 @@
+Push with base design notes
+===========================
+
+This feature allows clients, when pushing, to indicate that a
+certain object is an ancestor of all pushed commits and that they
+believe that the server knows of this object. This in turn allows
+servers to send an abbreviated ref advertisement containing only that
+object.
+
+Besides bandwidth savings, this also ensures that the ref
+advertisement contains information relevant to the client. For
+example, at least one project (Gerrit [1]) have included workarounds
+to send ancestors of refs that move often, even though the ref
+advertisement is only meant to contain refs.
+
+[1] https://gerrit.googlesource.com/gerrit/+/refs/heads/master/java/com/google/gerrit/server/git/receive/HackPushNegotiateHook.java
+
+
+Design overview
+---------------
+
+The "base" being sent is sent as an Extra Parameter, supported in the
+git://, ssh://, and http(s):// protocols. By sending it as an Extra
+Parameter, the server is aware of this parameter before it generates
+the ref advertisement, thus making it able to tailor the ref
+advertisement accordingly. Sending it as an Extra Parameter also makes
+this protocol backwards-compatible, as servers will ignore any Extra
+Parameters they do not understand. (The push will then proceed as if
+neither party had this feature.)
+
+The remote helper protocol has been extended to support the
+"push-base" capability and an option of the same name. When a remote
+helper advertises this capability, it thus indicates that it supports
+this option. Git then will send "option push-base" if the user
+specifies it when invoking "git push".
+
+The remote-curl remote helper bundled with Git has been updated to
+support this capability and option.
+
+
+Future work
+-----------
+
+In the future, we might want a way to automatically determine the base
+instead of always having the user specify it. However, this does not
+make obsolete any of the current work - once the base is automatically
+determined, we still need this protocol to communicate it to the
+server, and allowing the user to specify the base manually is still
+useful.
+
+
+Alternatives
+------------
+
+- Making a more substantial protocol change like "fetch" protocol v2.
+  This would eliminate the need for some of the remote helper updates;
+  as part of the protocol change, the protocol could be made to
+  support "stateless-connect" and thus no remote helper updates (like
+  "push-base") would be needed. For "fetch", the protocol change has
+  enabled features like wanted-refs and packfile-uris, but I do not
+  have any similar ideas in mind for "push".
-- 
2.29.1.341.ge80a0c044ae-goog

