From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 2/5] send-pack.c: add an --atomic-push command line argument
Date: Thu, 31 Jul 2014 14:39:08 -0700
Message-ID: <1406842751-6657-3-git-send-email-sahlberg@google.com>
References: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:39:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCy4T-0005Ge-UP
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbaGaVjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:39:21 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:35545 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbaGaVjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:39:15 -0400
Received: by mail-qa0-f73.google.com with SMTP id s7so344194qap.2
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q86awS0JZt0xeQgOr53iM3NacJL/uDiEfSaFlinBipE=;
        b=A8v9oWkwqsfCgQUqfUYFsPXwtJaQMai+VlYxBo+tCilcFgCxpNg17yzyifOR34eO/7
         jH5gHbn17Tv6kC5MYrpgxz8ZpQdOo+4V051FSkB1RwJwTrBEvRk0WHrPvQFuyAQiTUdD
         woB3bllQH337ZJsOQd65pHb7dFGkQuPY7XqZ9O7VWmjReUXvbrgnExJbyg8rjYOQpuPp
         GAgjlWlOQkrRdKi19OqM/D1fEtTfR1Id4ChrTPMJ+bAQOXzsj3DeruItgTAjC819017b
         TcezOL7QN5pGD8V28D2MtGdYd2eO9RW4K7n8RVHZX4fNkj3pRp9AXfk0Fogh8LtdX5+R
         DuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q86awS0JZt0xeQgOr53iM3NacJL/uDiEfSaFlinBipE=;
        b=itpXweLiNJkQkP9FcpM1DpOIzOc+uRnBKSmHt9MWKRAWOpeKAZTiVHqEoVmw7H/IBp
         2i6N/1d4Q0ytxkwMvNzRs4zkcYU2X+nXluNZRg+pB+Ga1m4TvkOtmGn0DGgQXitk/d2g
         476X3ID5EIkJZw7VodaAan86g3ZCof/ETSDXpBMrI7nXumUWy9zdKfr+fStP3guRN92s
         frmQo1TVoFBQoSqhQUzVgftKswdWV/vEr1GoEsUNxrU6oUiItb/jqmxxP3of2PbhqN50
         B/mA70mvHRTDNddlMUkrlDZifbnGL5f++MzKp9QYE8Fu3Blnf1zH1lB6aGe1ulM52mx7
         YI9A==
X-Gm-Message-State: ALoCoQnEPbeiF9mSVk3aMc6Z8mODbe8pba80OWUjzuPl8TJcBSSO3A0Ejov7lGuabK6CpRXwYJfi
X-Received: by 10.236.66.105 with SMTP id g69mr394465yhd.11.1406842754688;
        Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si422522yhk.4.2014.07.31.14.39.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5E7795A42FD;
	Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EB34FE055C; Thu, 31 Jul 2014 14:39:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.528.gd0e7a84
In-Reply-To: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254610>

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
2.0.1.528.gd0e7a84
