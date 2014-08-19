From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 2/5] send-pack.c: add an --atomic-push command line argument
Date: Tue, 19 Aug 2014 09:24:48 -0700
Message-ID: <1408465491-25488-3-git-send-email-sahlberg@google.com>
References: <1408465491-25488-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:25:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmDl-0007UR-Vk
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbaHSQZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:25:05 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:44424 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaHSQY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:24:56 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so1476603oah.2
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z0hajuZ3eq0K/9gD7nEkzd/fwTINqlglFE0n7L+Qivc=;
        b=X715vB0VuESwhbxiP8aLd/zEWRSJTdD8DrF42UzQL+aqTX9mXC+NpsoouVl/8ip2YJ
         o8PsqZRrVphhIs2bSbmLseCjizvkLqUYi76/ZZu+FD79zbsc5hdQ1LTHg2uypFcyzRf3
         9kRuGMLJtNYds7vxK0u/nAqz7O6fjaP8/rFi/vSQxQegETPYMxw4Qecl0KCgR4lZv9Pq
         tatyJw7INvPjrJ9l/TNaLvIZlbm7ZvlcjXNtekl8tDEu2/Lx3A0LMAqoUjPZQJ70kXcR
         lHzR12qzaayF0AjTgxd8ja/FxaYI5QfvbiaiGnD2npo8Kgo4JjzpY+6C57nBk+nS8/jU
         zjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z0hajuZ3eq0K/9gD7nEkzd/fwTINqlglFE0n7L+Qivc=;
        b=VNtp6X8M31QS355sXLV2bFK+3f9zgsKlaGgmb4m8OEFzF/OQNpkaE8AbL03V1xvAj+
         EKJZx7jRt94+HByZxafySSva3NC8mNvdTLTu9CPAegLwtsknLr3TRTi2k77s4aT+Exjo
         Ye4/CFi1LN3r1I8EHdT5vO99wQcms6DMnZsscXinl6BXAl1RiV8Brz69CgXk4C6Bh7pM
         KTQV9zoP5XLjzO2Oy8/1lXmaLGu941VzKrZW7znCBNzMRyJ8l2ahniT44m85YTncNW/c
         ThXxFUE1e0vnNKq/15TVQ/V8RgBPeZ5CNZe2Xb+9/NnosgpNjzqismfDKBUoz580dQN2
         hQJA==
X-Gm-Message-State: ALoCoQl/u5JDp+7YmNDIqTdvnQMUMtnlI5kmApP4Yrq7TCfLb7ePUTP1wIkGlYJClBcQWMfruHeO
X-Received: by 10.182.66.234 with SMTP id i10mr22438813obt.12.1408465495635;
        Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v20si327906yhe.2.2014.08.19.09.24.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4BC9C5A442F;
	Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B0391E0E84; Tue, 19 Aug 2014 09:24:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.ge8f7cba.dirty
In-Reply-To: <1408465491-25488-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255473>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Documentation/git-send-pack.txt | 7 ++++++-
 builtin/send-pack.c             | 6 +++++-
 send-pack.c                     | 8 +++++++-
 send-pack.h                     | 1 +
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index dc3a568..4ee2ca1 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -9,7 +9,7 @@ git-send-pack - Push objects over Git protocol to another repository
 SYNOPSIS
 --------
 [verse]
-'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
+'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic-push] [<host>:]<directory> [<ref>...]
 
 DESCRIPTION
 -----------
@@ -52,6 +52,11 @@ OPTIONS
 	Send a "thin" pack, which records objects in deltified form based
 	on objects not included in the pack to reduce network traffic.
 
+--atomic-push::
+	With atomic-push all refs are updated in one single atomic transaction.
+	This means that if any of the refs fails then the entire push will
+	fail without changing any refs.
+
 <host>::
 	A remote host to house the repository.  When this
 	part is specified, 'git-receive-pack' is invoked via
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f420b74..78e7d8f 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -13,7 +13,7 @@
 #include "sha1-array.h"
 
 static const char send_pack_usage[] =
-"git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
+"git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic-push] [<host>:]<directory> [<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive.";
 
 static struct send_pack_args args;
@@ -165,6 +165,10 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				args.use_thin_pack = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--atomic-push")) {
+				args.use_atomic_push = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--stateless-rpc")) {
 				args.stateless_rpc = 1;
 				continue;
diff --git a/send-pack.c b/send-pack.c
index f91b8d9..66f3724 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -228,6 +228,11 @@ int send_pack(struct send_pack_args *args,
 	if (server_supports("atomic-push"))
 		atomic_push_supported = 1;
 
+	if (args->use_atomic_push && !atomic_push_supported) {
+		fprintf(stderr, "Server does not support atomic-push.");
+		return -1;
+	}
+
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
 			"Perhaps you should specify a branch such as 'master'.\n");
@@ -272,7 +277,8 @@ int send_pack(struct send_pack_args *args,
 			char *old_hex = sha1_to_hex(ref->old_sha1);
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 			int quiet = quiet_supported && (args->quiet || !args->progress);
-			int atomic_push = atomic_push_supported;
+			int atomic_push = atomic_push_supported &&
+				args->use_atomic_push;
 
 			if (!cmds_sent && (status_report || use_sideband ||
 					   quiet || agent_supported ||
diff --git a/send-pack.h b/send-pack.h
index 8e84392..0374ed8 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -10,6 +10,7 @@ struct send_pack_args {
 		force_update:1,
 		use_thin_pack:1,
 		use_ofs_delta:1,
+		use_atomic_push:1,
 		dry_run:1,
 		stateless_rpc:1;
 };
-- 
2.0.1.556.ge8f7cba.dirty
