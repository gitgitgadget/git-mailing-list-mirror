From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 5/5] push.c: add an --atomic-push argument
Date: Tue, 19 Aug 2014 09:24:51 -0700
Message-ID: <1408465491-25488-6-git-send-email-sahlberg@google.com>
References: <1408465491-25488-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:25:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmDW-0007Lf-D3
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbaHSQY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:24:58 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:48469 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbaHSQYz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:24:55 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so797829qcz.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n2Rc8wE4JpOelLVOrMS6FRwrN6XSUUqgkvdMwvzzhvg=;
        b=W5+Q1n56hyBdqG8naVcvkb60FZpVE+i7Cd1/5OwehE+76M7GWJpRJa+4nxx1YX62WH
         G3S9NS+yvh7uz8Pa/fgUQUeW+Q4KOmVl8uFndpLygkzyi3kZiqNF4hp7RR9P482JoDkM
         +9HqhJEfzhJ8scbIszoT0ClgxcZ3v73cU2fxY8/GYDVWf+miEc/JQw9XlKG4t+oCdvHc
         vuFSyDTjm6dJJK5gL+wqM6Z8+kibDBqGOwsgAzyA24vcsfu1fyjiqNZOjyQF4Xn9bdHk
         oAHaQ2TI4dRMUe3FNLk8dIsIQfP9AyHu+6iZTeItT5ev1KcMFJ/IiwPh/rhNt5JW0HrC
         HN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n2Rc8wE4JpOelLVOrMS6FRwrN6XSUUqgkvdMwvzzhvg=;
        b=aPbVTPX/vhQmHlM24KPF8D2PBXp7YPfUSscxSUY0oBb5Tn6cxFROiBEyjc6YeuSeu1
         8PRvk+Las0XqrqxpOUZmK78MiDQpKFmG7YWrMK6pD5QyVzz7tHVExSjAqUVia6nsN2lQ
         T+W1B0W1dv7VtTnkThYp9RXp+1IX1p91Hgos/F1tBhQeLBnhAPp1hiyupgUxvAVaH9VT
         k4qKO490KIHe99y86YyFzvCn3u37XDqxlkMteEW+/Vo+3bawf3K9OfI9ua+KqwFm7YAv
         yLYf7JBVcJ7EY19qWwEAerR/Po+u0gLTqmPTGfYOzH046fgrZc+uHAEkzDQswvpzHJ2n
         EGUA==
X-Gm-Message-State: ALoCoQkXagcpI7HbKsaE5qgsv50PvMnChuuFFOzlcW5sNqCoa8SFR0kdunqKLLLI9hCk9DAAf3Cq
X-Received: by 10.236.121.133 with SMTP id r5mr18744805yhh.28.1408465495149;
        Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si327976yhk.4.2014.08.19.09.24.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 04B2331C519;
	Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9D98FE119C; Tue, 19 Aug 2014 09:24:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.ge8f7cba.dirty
In-Reply-To: <1408465491-25488-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255471>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Documentation/git-push.txt | 7 ++++++-
 builtin/push.c             | 2 ++
 transport.c                | 1 +
 transport.h                | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 21cd455..b80b0ac 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
+'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic-push] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
 	   [--force-with-lease[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
@@ -129,6 +129,11 @@ already exists on the remote side.
 	from the remote but are pointing at commit-ish that are
 	reachable from the refs being pushed.
 
+--atomic-push::
+	Try using atomic push. If atomic push is negotiated with the server
+	then any push covering multiple refs will be atomic. Either all
+	refs are updated, or on error, no refs are updated.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/builtin/push.c b/builtin/push.c
index f8dfea4..f37390c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -507,6 +507,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "no-verify", &flags, N_("bypass pre-push hook"), TRANSPORT_PUSH_NO_HOOK),
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
+		OPT_BIT(0, "atomic-push", &flags, N_("use atomic push, if available"),
+			TRANSPORT_ATOMIC_PUSH),
 		OPT_END()
 	};
 
diff --git a/transport.c b/transport.c
index a3b7f48..ab5f553 100644
--- a/transport.c
+++ b/transport.c
@@ -837,6 +837,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.progress = transport->progress;
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
+	args.use_atomic_push = !!(flags & TRANSPORT_ATOMIC_PUSH);
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
 			&data->extra_have);
diff --git a/transport.h b/transport.h
index 02ea248..407d641 100644
--- a/transport.h
+++ b/transport.h
@@ -123,6 +123,7 @@ struct transport {
 #define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 256
 #define TRANSPORT_PUSH_NO_HOOK 512
 #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
+#define TRANSPORT_ATOMIC_PUSH 2048
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
2.0.1.556.ge8f7cba.dirty
