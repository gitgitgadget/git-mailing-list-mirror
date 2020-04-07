Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3527C2BA80
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867682078C
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jspAs+Q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgDGO2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32835 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgDGO2b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id v7so1821050qkc.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0IRPHF+2p0k1bT1/v3/FOq8V/yFy8XbQoyH3Ew1eGU=;
        b=jspAs+Q8H/vzhEXgyFIEZZ7jUBXwIjeUJbzax8QjkGP+ltAVV/7Nkr4snUoYF84M7X
         8eWcEElj6H2I3KMiJsjow2nJmeA+YhZT8EEL5MZQq6XUT+liSLJNJpHxe7hAt0pdMTve
         hKNmVFqo7XEwL9mfF9hjCzVK1DI4qAcV9BRw6TA4fdmu1nURUkGZtha8JAK1oUAGbJ1z
         Trxhcv6oFwFx9zb+ozbG1KC3DE/mwUystae93PqzPhKW5yQO/W+202u3o4AbDIyhkRho
         yPdJo0v7OvxuRmQpAKkZsH5RK1fZjqHdUwCK1Xq2VQxeBtf2kv/iUnrcyvAdRgaW4QDf
         eQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0IRPHF+2p0k1bT1/v3/FOq8V/yFy8XbQoyH3Ew1eGU=;
        b=reBK/wFEMhae8YKaVjHs12t4lZcung6XQvd8eGgtjKbhA1kUM3ewYTU4wiZL8RdWRA
         ifGySbcX8eoA78Tch6ggtjl0GoElOt9bpmoBv1+xNRkM5t7jceHxWryjN4b6aTR9CGIb
         sZFfy+0FKt8FRJzXNB2MlSPci2SM/mt/qPyC6EaHEMBTPtUD43u1pH/ZNYMUCHOEmaQF
         4rJiFZMELAwhZAYo4FPDNGp9Etd3PXv4yhUuaE7El5MeLRgcHdi6MI6tTqYkyLA49vIS
         0Cd5YF/2G0cTsXspfR80JwAsN7kZOiCp/gs8rckRcfxEHDuCzLDxYTwp7yahKMCftOo+
         Uwbg==
X-Gm-Message-State: AGi0PuZlkq/KcKEMzthDrHhsWOrBseOQMq+5X39tEPQWMHJ4fEHLFaTk
        9lFZCaFrIe9y6iZb9MLr1MFcloId
X-Google-Smtp-Source: APiQypL+vJMqt6+O3rX+fBjw2yvgDi4dXT+hbGYJIvNeAQ8HoAgXtcwDjL5lRAMAP4tD67Ikx0u2LQ==
X-Received: by 2002:a37:af86:: with SMTP id y128mr2561607qke.429.1586269710672;
        Tue, 07 Apr 2020 07:28:30 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:30 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 10/22] sequencer: rename stash_sha1 to stash_oid
Date:   Tue,  7 Apr 2020 10:27:57 -0400
Message-Id: <937b4964d14cd2f41521722d370cf0d89b3b9f24.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The preferred terminology is to refer to object identifiers as "OIDs".
Rename the `stash_sha1` variable to `stash_oid` in order to conform to
this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4917c70a86..4a6812e90e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3659,23 +3659,23 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 
 static int apply_autostash(const char *path)
 {
-	struct strbuf stash_sha1 = STRBUF_INIT;
+	struct strbuf stash_oid = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
 
-	if (!read_oneliner(&stash_sha1, path,
+	if (!read_oneliner(&stash_oid, path,
 			   READ_ONELINER_SKIP_IF_EMPTY)) {
-		strbuf_release(&stash_sha1);
+		strbuf_release(&stash_oid);
 		return 0;
 	}
-	strbuf_trim(&stash_sha1);
+	strbuf_trim(&stash_oid);
 
 	child.git_cmd = 1;
 	child.no_stdout = 1;
 	child.no_stderr = 1;
 	argv_array_push(&child.args, "stash");
 	argv_array_push(&child.args, "apply");
-	argv_array_push(&child.args, stash_sha1.buf);
+	argv_array_push(&child.args, stash_oid.buf);
 	if (!run_command(&child))
 		fprintf(stderr, _("Applied autostash.\n"));
 	else {
@@ -3687,9 +3687,9 @@ static int apply_autostash(const char *path)
 		argv_array_push(&store.args, "-m");
 		argv_array_push(&store.args, "autostash");
 		argv_array_push(&store.args, "-q");
-		argv_array_push(&store.args, stash_sha1.buf);
+		argv_array_push(&store.args, stash_oid.buf);
 		if (run_command(&store))
-			ret = error(_("cannot store %s"), stash_sha1.buf);
+			ret = error(_("cannot store %s"), stash_oid.buf);
 		else
 			fprintf(stderr,
 				_("Applying autostash resulted in conflicts.\n"
@@ -3698,7 +3698,7 @@ static int apply_autostash(const char *path)
 				  " \"git stash drop\" at any time.\n"));
 	}
 
-	strbuf_release(&stash_sha1);
+	strbuf_release(&stash_oid);
 	return ret;
 }
 
-- 
2.26.0.159.g23e2136ad0

