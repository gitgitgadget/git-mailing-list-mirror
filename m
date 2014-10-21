From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 4/8] push.c: add an --atomic-push argument
Date: Tue, 21 Oct 2014 13:46:36 -0700
Message-ID: <1413924400-15418-5-git-send-email-sahlberg@google.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:47:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggKe-00058Q-Sw
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933518AbaJUUqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:46:53 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:62587 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933485AbaJUUqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:46:44 -0400
Received: by mail-pd0-f201.google.com with SMTP id y10so372080pdj.2
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YaTJt9X/dp0NYZku5QvRg5gywmCTgpG1iG3gY/NzHi8=;
        b=bShx0LoRabxDSQF2xwPv6c+aCzcu0rCrQkJvH/m21LuIFqlig3P5IiPfo2NDLjQ/0U
         kQ2Ebvzlmm6cBbyQ6KMxDBIllCV64KSc5nBFRmKQL2VZMRphdg+zPZ8nJ7vV2zIjtXLE
         NnFgGU7nU+EzoSnmzfFftUSPh0AGsh18xsU2Ndd9Bl7k4uPD5pEFVOKJKBqv+qCxb/+G
         mHVrKECwSGXKwKOC8nuV60OaN6wdRuseBTAIfkl4LXWgSkRCMcCC8lPJDPCS8r6N5iOJ
         uu7JlPXNl4i8ioj/Hm+QR/vUvey1I5svC4H2aT6bn2jb4Xh9ohZ5RWwUV9Q1piaefJ8x
         29eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YaTJt9X/dp0NYZku5QvRg5gywmCTgpG1iG3gY/NzHi8=;
        b=dGtpzf9ia5lCqrf1qhZwjAlCCwIUG+fPXSJDRyAGRFEMLnOa1619rzz4emMcn79Ds0
         pibnuVgX3WizIUq7ZKwaxI+3M9YEp263r+GevFlOUdFTQLzTH4pm3I+4o+quNBTF2XaH
         nKiK1IBByo4aXwVG6InXqcgCGTQZK36abQ6z5wIb1ClFIqgj/e2ZRdUdnJ/UAe+L1uqr
         xNse8O8RDn8Iq19ibWUbZ9WA2n3Fpyhaf4T1YDcagWTGyw+UWxV43JbUY6JuWnzVMl0N
         F7fprJRXrg4wfsM1smGIw6QG8goyy2BbetvUN/hTaTcuGcRAMG9EflHvkk7gCeJhUGhV
         7wEQ==
X-Gm-Message-State: ALoCoQmy2aa9Q9dmF8Pif6cnAbXCNSOVu1uBMQpgevSHhxXmZtBzCbE+DlUkgzG8vgaBCPSCYqr6
X-Received: by 10.66.177.135 with SMTP id cq7mr5603189pac.19.1413924404144;
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n63si595349yho.5.2014.10.21.13.46.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 35RftNT0.1; Tue, 21 Oct 2014 13:46:44 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 78893E0CC5; Tue, 21 Oct 2014 13:46:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a command line argument to the git push command to request atomic
pushes.

Change-Id: I9f8d06970b2fdd1cf7d933e0cce1288752034af1
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
index d3e9e27..e2a16b2 100644
--- a/transport.c
+++ b/transport.c
@@ -832,6 +832,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
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
