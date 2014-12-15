From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] push.c: add an --atomic-push argument
Date: Mon, 15 Dec 2014 11:56:07 -0800
Message-ID: <1418673368-20785-5-git-send-email-sbeller@google.com>
References: <1418673368-20785-1-git-send-email-sbeller@google.com>
Cc: mhagger@alum.mit.edu, jrnieder@gmail.com, gitster@pobox.com,
	ronniesahlberg@gmail.com, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 20:56:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0bl5-000276-Ih
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 20:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbaLOT42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 14:56:28 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:55845 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaLOT4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 14:56:24 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so11455564ieb.40
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 11:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N145YTRggFw+EMzl86BLfkW37qCOSXoe2Rhm61IoZq4=;
        b=HnrflsHU1/FiD1ezH/kqoInByW6i6R6lMfTxLXVPRWRCmyhk4Pqr0aSSGA12MqaY8L
         YI82EdlZu0XjNaF22JUGtIPVuc6uiFYLAJfiHhiWMFrBULeUsB8mIbh5xhdIPjrTgwoZ
         gZY+nhFA1G2eI0XIZRcHYNjaCGIVd/R6muK7coZx91obQGqCacRDzqmaNfdWLhrAnohH
         dBSgD7ArJd75SvwKvGwtS3sv/MR/3dCyu0faaFw3yUUDFHAJl90WNqkFQDwAPwe8vQVp
         ViHRob3dSusBdnzcIMUntkMKC7Jkq29gHeXvFYfBdlVm11xMJclDQlGW/dZC0AOY+LhJ
         O5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N145YTRggFw+EMzl86BLfkW37qCOSXoe2Rhm61IoZq4=;
        b=SAYHUtu8fWTFneCOsoy4ck5dW6tjb4I7aeba52Dq1/wxD9QiQrPB+8lhW2cTfT10zy
         V79nLt0gyK2wju2qne4efdcoIlzJ5YurYyjFBxcFvzTNxfy9I4caNT+xSUS3lDA3ZB1J
         BO1YwumYnXudZ0eNcYZUz74g0kGfOrTlUwVA2AR+FH6/7tTGMOjjFMuET7PM0fwnjnrv
         fQvXew6O7LGcZhsNZM1PAr92zUU7GaIdrLI8D4g67XT50wWXcqWlstt0VThXdl/Sk+Ru
         qtESougCo/CJJnzs6C2vo46UOxSlja/IUgWV+aDeiIAXszUg/Mh72lQ8ItrbqO2LO2HX
         idbw==
X-Gm-Message-State: ALoCoQnsP5NVzqw6URN3Lk5kNpiZD91jqUym8HBaoPgx33rVHsdmdVkElAqQNYeH8W1Q1HQakyH2
X-Received: by 10.42.155.71 with SMTP id t7mr7517788icw.96.1418673384214;
        Mon, 15 Dec 2014 11:56:24 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:ccd:69a0:9bbf:bab9])
        by mx.google.com with ESMTPSA id g5sm5138365iod.25.2014.12.15.11.56.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Dec 2014 11:56:23 -0800 (PST)
X-Mailer: git-send-email 2.2.0.33.gc2219e3.dirty
In-Reply-To: <1418673368-20785-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261418>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a command line argument to the git push command to request atomic
pushes.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-push.txt | 8 +++++++-
 builtin/push.c             | 2 ++
 transport.c                | 1 +
 transport.h                | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 21b3f29..3e0cb6e 100644
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
@@ -136,6 +136,12 @@ already exists on the remote side.
 	logged.  See linkgit:git-receive-pack[1] for the details
 	on the receiving end.
 
+--atomic-push::
+	Using atomic push. If atomic push is negotiated with the server
+	then any push covering multiple refs will be atomic. Either all
+	refs are updated, or on error, no refs are updated. If the server
+	does not support atomic pushes the push will fail.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/builtin/push.c b/builtin/push.c
index a076b19..ae393c5 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -518,6 +518,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
 		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
+		OPT_BIT(0, "atomic-push", &flags, N_("use atomic push, if available"),
+			TRANSPORT_ATOMIC_PUSH),
 		OPT_END()
 	};
 
diff --git a/transport.c b/transport.c
index e87481d..ba1499e 100644
--- a/transport.c
+++ b/transport.c
@@ -830,6 +830,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
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
2.2.0.33.gc2219e3.dirty
