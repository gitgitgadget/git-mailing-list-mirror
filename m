Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF43B1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeCORcr (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:47 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:35591 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbeCORcp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:45 -0400
Received: by mail-ua0-f202.google.com with SMTP id a31so1902087uaa.2
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/k6vmGViCp/b0NnmDxA3wEX3V5LmlaO5gD7ANlI9GMg=;
        b=h2ImVBA7RWhXffLUcTiSMdKpfAUvlcMHoimsf1hJ7PpxzB7uR7aKI/zxJ6hXm6Niiz
         /d7P84E9s99/KkX/b8KFVzfrVXDSKi79K7EhxTwlTVuUiii23lAkQFXtY7edL/ZQl0Uu
         fRkirRVeq8Sb9aEDvEqdpZT/nfEbogoaSpkMYtdLD5VQWuRvnMf1CA03FjufGUTKdKe7
         I3x6TBdHoRMCglibbLKBLRlbuNXlbvo8Ujpwi+5Sx5tNYA7hWIny8EUn4InBg7XhnUT/
         N1dtfQwMwj/5bLH8V47TrP0rUu/j/8/WuaEZ0Y1F036+xXfSxRakTwni6okhn7HMe+dE
         FhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/k6vmGViCp/b0NnmDxA3wEX3V5LmlaO5gD7ANlI9GMg=;
        b=sBv4JCgQnvZeDCD5uLRug6g1cKdJUYW00fjTWhQRl65wWjQv8rmMavisVnMArpOAms
         tKPcVSBvGEorj+vXVLnNh45Y3BRVkB8471K4tSu3f/FptxFmJbD4beRiNussjKlK1/QH
         ra9bhhDxO61fMi/6UzuDW3n7nGBiDqKUBAg1SELYNW5aJSNvlv2BtfpVjFXbNg5ahR6d
         pwjKBi7ohCXumVBavS3Ucp+vr5WwuMaMvR7Pem9qDxRT82wF2Gjs8cl5MSmXEeMofo7h
         bIAvb9hdM/h8a/iovLte1e11l1pjz3877YEqKwbZBrCWkCth30B0fumcLHFIdJTHmBia
         +CSQ==
X-Gm-Message-State: AElRT7HT88O+hzj5ptKs1EKB4X/LkE8BCclVtZgjarVuoKEMC+3pGD7a
        kn4efEZIh+rIUR1uRWirlF4yB4xyVPPbnCr/DTMb6jpauiuoBeVBTCT1pNiSoSwkNBtr6JrwmIL
        PvP4AlItzfVc9QXBpU8nOPdbQC+nG+dZ1ZwRzYPmWxhrqQLW2AHQMlfObHw==
X-Google-Smtp-Source: AG47ELv0caHTTpLAUqg0sYmPogMT31azyCiPjtDj5qUi3+1hs5GWptpzE2G31sNtW2+rOPEt0tbnaCsBLe4=
MIME-Version: 1.0
X-Received: by 10.176.83.142 with SMTP id k14mr3179075uaa.0.1521135164557;
 Thu, 15 Mar 2018 10:32:44 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:31 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-25-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 24/35] connect: don't request v2 when pushing
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to be able to ship protocol v2 with only supporting fetch, we
need clients to not issue a request to use protocol v2 when pushing
(since the client currently doesn't know how to push using protocol v2).
This allows a client to have protocol v2 configured in
`protocol.version` and take advantage of using v2 for fetch and falling
back to using v0 when pushing while v2 for push is being designed.

We could run into issues if we didn't fall back to protocol v2 when
pushing right now.  This is because currently a server will ignore a request to
use v2 when contacting the 'receive-pack' endpoint and fall back to
using v0, but when push v2 is rolled out to servers, the 'receive-pack'
endpoint will start responding using v2.  So we don't want to get into a
state where a client is requesting to push with v2 before they actually
know how to push using v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c              |  8 ++++++++
 t/t5702-protocol-v2.sh | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/connect.c b/connect.c
index a57a060dc4..54971166ac 100644
--- a/connect.c
+++ b/connect.c
@@ -1218,6 +1218,14 @@ struct child_process *git_connect(int fd[2], const char *url,
 	enum protocol protocol;
 	enum protocol_version version = get_protocol_version_config();
 
+	/*
+	 * NEEDSWORK: If we are trying to use protocol v2 and we are planning
+	 * to perform a push, then fallback to v0 since the client doesn't know
+	 * how to push yet using v2.
+	 */
+	if (version == protocol_v2 && !strcmp("git-receive-pack", prog))
+		version = protocol_v0;
+
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
 	 */
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 4365ac2736..e3a7c09d4a 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -95,6 +95,30 @@ test_expect_success 'pull with git:// using protocol v2' '
 	grep "fetch< version 2" log
 '
 
+test_expect_success 'push with git:// and a config of v2 does not request v2' '
+	test_when_finished "rm -f log" &&
+
+	# Till v2 for push is designed, make sure that if a client has
+	# protocol.version configured to use v2, that the client instead falls
+	# back and uses v0.
+
+	test_commit -C daemon_child three &&
+
+	# Push to another branch, as the target repository has the
+	# master branch checked out and we cannot push into it.
+	GIT_TRACE_PACKET="$(pwd)/log" git -C daemon_child -c protocol.version=2 \
+		push origin HEAD:client_branch &&
+
+	git -C daemon_child log -1 --format=%s >actual &&
+	git -C "$daemon_parent" log -1 --format=%s client_branch >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v2
+	! grep "push> .*\\\0\\\0version=2\\\0$" log &&
+	# Server responded using protocol v2
+	! grep "push< version 2" log
+'
+
 stop_git_daemon
 
 # Test protocol v2 with 'file://' transport
-- 
2.16.2.804.g6dcf76e118-goog

