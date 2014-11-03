From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 4/7] push.c: add an --atomic-push argument
Date: Mon,  3 Nov 2014 11:12:29 -0800
Message-ID: <1415041952-19637-5-git-send-email-sahlberg@google.com>
References: <1415041952-19637-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:12:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlN3Z-0006P7-QG
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbaKCTMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:12:41 -0500
Received: from mail-pd0-f202.google.com ([209.85.192.202]:55398 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbaKCTMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:12:35 -0500
Received: by mail-pd0-f202.google.com with SMTP id ft15so1999730pdb.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O9ybpa6gLJCST4tFFcTsDqZZY05OqV8Czwe2U98fyjQ=;
        b=Atc1/FJvfNxON0S7pNTiARNij5VtoaDAfcGOOTKmPm9PIoY0FZnwVHo4w2Y+ZEjAXz
         mjlwpOJqjeUyqhYik4DvXHJyQUntHbpHbd7/YAMeLDGqcetbhk7/rA4baHlAKyjDXLoq
         iDJ1ofLb3XEvJYkdeHXOTXiGCKa7xH/WuK1cJDXjRqdujCQMektNRxLE3UPY8rmnk/Jb
         deYBGhjeS+bHt44es2NvZ1WXBgOo67iurwCxg5iRk3zuGNEwkINyK0GZmqjMPWIIOJ/j
         OCCIDrnvE4d92PlBgL0WEvYTbf6l0+gf4lRwP5iuiMfti2xaGOhUKgyVt5bbYM0n4Iw7
         jFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O9ybpa6gLJCST4tFFcTsDqZZY05OqV8Czwe2U98fyjQ=;
        b=DT3SemhxBLzgOU0edpxgjZucmqVemKo20GlZjiRwChadK5LGfWVYPTlno6o612BkJQ
         yuNGw718XaHysMDAimhzZ5HLjcLE0XY0m6/2QOkPDqv6GEmYdquT61IuZLu+CjLI6DhB
         IgQj73uR84cY5eo8C1XYXEz2tVcJTMLvWZ5rH5ZBqs4+h1fN7OEbwN7ij+TYncqtuocS
         lnGoZTpUXyV9vMUdTNlMq0pgnoJQTcIRgZOjr20IOGPYUVj+Lu7F3XmucLlXxuZ3Rsir
         Z//6LmkMWJDdQPc3H3cqiG3391LZlH7FUy35hvJKEBqDmThN7iVq3QTqoETR0tppLjfx
         71bg==
X-Gm-Message-State: ALoCoQm9hVVcYsLAyFo7ovN2jwS5HJkISUCRRBGusTRgwCQjdhwz9WXZLB3Ju8jkYdZ1EIMHAs40
X-Received: by 10.68.201.195 with SMTP id kc3mr8439094pbc.3.1415041955151;
        Mon, 03 Nov 2014 11:12:35 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id l45si977139yha.2.2014.11.03.11.12.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:12:35 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 2AoMNhzb.1; Mon, 03 Nov 2014 11:12:35 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 41DC3E0B17; Mon,  3 Nov 2014 11:12:34 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041952-19637-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a command line argument to the git push command to request atomic
pushes.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Documentation/git-push.txt | 7 ++++++-
 builtin/push.c             | 2 ++
 transport.c                | 1 +
 transport.h                | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 21b3f29..04de8d8 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic-push] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
 	   [-u | --set-upstream] [--signed]
 	   [--force-with-lease[=<refname>[:<expect>]]]
@@ -136,6 +136,11 @@ already exists on the remote side.
 	logged.  See linkgit:git-receive-pack[1] for the details
 	on the receiving end.
 
+--atomic-push::
+	Try using atomic push. If atomic push is negotiated with the server
+	then any push covering multiple refs will be atomic. Either all
+	refs are updated, or on error, no refs are updated.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/builtin/push.c b/builtin/push.c
index ae56f73..0b9f21a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -507,6 +507,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
 		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
+		OPT_BIT(0, "atomic-push", &flags, N_("use atomic push, if available"),
+			TRANSPORT_ATOMIC_PUSH),
 		OPT_END()
 	};
 
diff --git a/transport.c b/transport.c
index 2111986..cd2b63a 100644
--- a/transport.c
+++ b/transport.c
@@ -833,6 +833,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 	args.push_cert = !!(flags & TRANSPORT_PUSH_CERT);
+	args.use_atomic_push = !!(flags & TRANSPORT_ATOMIC_PUSH);
 	args.url = transport->url;
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
diff --git a/transport.h b/transport.h
index 3e0091e..25fa1da 100644
--- a/transport.h
+++ b/transport.h
@@ -125,6 +125,7 @@ struct transport {
 #define TRANSPORT_PUSH_NO_HOOK 512
 #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
 #define TRANSPORT_PUSH_CERT 2048
+#define TRANSPORT_ATOMIC_PUSH 4096
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
2.1.0.rc2.206.gedb03e5
