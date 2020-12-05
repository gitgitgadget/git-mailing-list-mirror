Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DCFC2BB40
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C753522DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbgLEBv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731089AbgLEBv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:51:28 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDD8C08E861
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:11 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id p3so6380712qvn.15
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Donh/FHvh4F0njzTIN5avuchvXoVkUEY0MU53TswrPI=;
        b=TgSiQ/3aOT6pn84Eu7n9WPUe7AAiltIB7TezhTWHI31xupEgPOMetZPiDEFi6Qg4IA
         kGTnEosiW5wfQf7XPgHrll+qo2SbUhSok8jmhGk6Y0KTqs+3psR3Zd/kM6i9UU/0vRGC
         B7rnimuLteE9W0LCnTGgbBUzn8WO3M3ohHXI6wFESWTWz1XUJq20qBfHAL5k7fkZp+Uc
         g8ZFeQLbkVx29soe2PhuUMHoYoBR7+gINqhw3ShuOsHDPnh+ZkGtai22163DV/mfP2TK
         KrvnNKsaYFHZD4yzsatLsAz/o2qkk69sHe5CPtBJz/fQ7zVri1ZWuuBR6a+50thlf8Fw
         b6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Donh/FHvh4F0njzTIN5avuchvXoVkUEY0MU53TswrPI=;
        b=KlhXMzSq6Vdyr11bJiugIZnQbe2WxpxVVPS2G2d+fbvHFNHidzUPGh5aYRSyFaJixa
         +MY6Zcm2b27btw6t7hFbs4s0w3wue6H3PzWDimibVivW1qqxl2qZSBznmYHHTJnNL2zq
         +8JzkRQ4rxWULhHqllr7NysfYm6hTcIyEKaHUBU24LA8GLsGxymB6v/psluQQx/vxOGY
         nUhtzvGbOC4kdX+RrrV7H3GWHTAfKDdAjM/f74dLG7/iky7uynf2UgY5NK3TC8JNoAiq
         l40Js3/SNNgDFzIJJlSvss0zVNCyPPqs44v59FEgF85LD3SPH788jPl+ZseLactsSDE8
         qKpw==
X-Gm-Message-State: AOAM531xsaWdkeMCjOStIhFoGJi1kTHw/ZsOOWraoTM2k0Z3gcbj+XUI
        4ltCJMOhbefeunGYu9s3Gy3xWSuZJK6e1kp+/+MmI/bQjG/hoYvijNs+yWVaSfIPZ9yaG0lTXbE
        mfJrqnOf4MPJHuWmRD/OLRZz7k3q1+dccGOzujSm4f7s7FB64FkxtsX2X+RCTzIRtZtFSBKlXdg
        ==
X-Google-Smtp-Source: ABdhPJzTOtVgxmdvrpvr9bW6v3/jQAt9+aZS3kOoNtg8ikMyvrhjtfYyD+hYcAwYer7t1u0Vsbd+frrwNwyr+WmQqoY=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:190f:: with SMTP id
 er15mr8938620qvb.33.1607133011010; Fri, 04 Dec 2020 17:50:11 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:39 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 11/17] transport: convert pre-push hook to use config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using the hook.h:run_hooks API, pre-push hooks can be specified in
the config as well as in the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  2 ++
 transport.c                | 55 +++++++++-----------------------------
 2 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index db290984f6..8f5524055b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -271,6 +271,8 @@ If this hook exits with a non-zero status, `git push` will abort without
 pushing anything.  Information about why the push is rejected may be sent
 to the user by writing to standard error.
 
+Hooks executed during 'pre-push' will run in parallel by default.
+
 [[pre-receive]]
 pre-receive
 ~~~~~~~~~~~
diff --git a/transport.c b/transport.c
index 47da955e4f..6c67bc0fea 100644
--- a/transport.c
+++ b/transport.c
@@ -22,6 +22,7 @@
 #include "protocol.h"
 #include "object-store.h"
 #include "color.h"
+#include "hook.h"
 
 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
@@ -1162,31 +1163,13 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
-	int ret = 0, x;
+	int ret = 0;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
+	struct strbuf tmp = STRBUF_INIT;
 	struct ref *r;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct strbuf buf;
-	const char *argv[4];
-
-	if (!(argv[0] = find_hook("pre-push")))
-		return 0;
-
-	argv[1] = transport->remote->name;
-	argv[2] = transport->url;
-	argv[3] = NULL;
-
-	proc.argv = argv;
-	proc.in = -1;
-	proc.trace2_hook_name = "pre-push";
-
-	if (start_command(&proc)) {
-		finish_command(&proc);
-		return -1;
-	}
 
-	sigchain_push(SIGPIPE, SIG_IGN);
-
-	strbuf_init(&buf, 256);
+	strvec_push(&opt.args, transport->remote->name);
+	strvec_push(&opt.args, transport->url);
 
 	for (r = remote_refs; r; r = r->next) {
 		if (!r->peer_ref) continue;
@@ -1195,30 +1178,16 @@ static int run_pre_push_hook(struct transport *transport,
 		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
 		if (r->status == REF_STATUS_UPTODATE) continue;
 
-		strbuf_reset(&buf);
-		strbuf_addf( &buf, "%s %s %s %s\n",
+		strbuf_reset(&tmp);
+		strbuf_addf(&tmp, "%s %s %s %s",
 			 r->peer_ref->name, oid_to_hex(&r->new_oid),
 			 r->name, oid_to_hex(&r->old_oid));
-
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			/* We do not mind if a hook does not read all refs. */
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
+		string_list_append(&opt.str_stdin, tmp.buf);
 	}
 
-	strbuf_release(&buf);
-
-	x = close(proc.in);
-	if (!ret)
-		ret = x;
-
-	sigchain_pop(SIGPIPE);
-
-	x = finish_command(&proc);
-	if (!ret)
-		ret = x;
+	ret = run_hooks("pre-push", &opt);
+	run_hooks_opt_clear(&opt);
+	strbuf_release(&tmp);
 
 	return ret;
 }
-- 
2.28.0.rc0.142.g3c755180ce-goog

