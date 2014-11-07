From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 4/7] push.c: add an --atomic-push argument
Date: Fri,  7 Nov 2014 11:41:58 -0800
Message-ID: <1415389321-10386-5-git-send-email-sahlberg@google.com>
References: <1415389321-10386-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:49:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpWo-0005Nq-MT
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbaKGTs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:48:59 -0500
Received: from mail-qc0-f202.google.com ([209.85.216.202]:37619 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbaKGTs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:48:58 -0500
Received: by mail-qc0-f202.google.com with SMTP id m20so278661qcx.1
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O9ybpa6gLJCST4tFFcTsDqZZY05OqV8Czwe2U98fyjQ=;
        b=JGPz8XVtjlDMSoGXwMvM81fsVc6P3kqRYT6px3jGkEXb3S0NnjCRbyKv0sR7V3dEJ3
         xRrdC+XThRO6UvBuJ0DdDK7VNzwP0Fn6E8X0rlavrVAHYjczwLUcuJJbXyxXnVXnSTiR
         YoVJ+Xj6HbnCHCto1BX8wUWZt7cA51RH4OSftFPDHfHuPHqXnm6PCdS1BnFy5HoSjn9C
         tWgvCLi8aNoTDLJVLrOIlBNoYM65fQTh93nwD/MBMs1/dDAm0iKKxzUGa6/Zw1ftfR1n
         +7bZ8kC010BFq0p41u3k1pkxjfZdOdkOE1pa3p8V4zVRzns7BuHGOaIgHnpG9uTXhqrh
         60YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O9ybpa6gLJCST4tFFcTsDqZZY05OqV8Czwe2U98fyjQ=;
        b=I/uJoeiX+P2LiLJLMdrCBMz25OiOfGsydDPcysfOMUmTfePzGFVk9Xmk9sV43M/y/g
         45on3onWc+LOK1Px7AK8S94DWBhGxZl5zVQzuLHqTPougLEuXkHXszn3BCjyTHIA8rka
         TUOz7P9dZZHRpNdFfmKqHmrLInDPapIuEosg2Oyfca9yyc6B1lNNhZzj8UeNUvSsQia/
         XY7XCTDfPIBigQ2rvB+eBxLnAmj0CQlTkuSLBVgi7gYrErgVlPCv+uuhH0hudxkbZI8m
         7SbyzZKYvLkX3EHSgnDPgsRPi9ssK3upgONyWXZ8fri93ximExD9u5Ik8mA8Wb9Qqekc
         zi6A==
X-Gm-Message-State: ALoCoQnUwQuj7BMOdyJqqAiRia+WnBXHc3aZBz2yF5iY7AmfoD6Fb34jMxsuuXi0BL4TL9EF+e+9
X-Received: by 10.236.53.34 with SMTP id f22mr10929008yhc.51.1415389325207;
        Fri, 07 Nov 2014 11:42:05 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id s23si405691yhf.0.2014.11.07.11.42.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:42:05 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id wHUlofbV.1; Fri, 07 Nov 2014 11:42:05 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DE834E0A73; Fri,  7 Nov 2014 11:42:03 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389321-10386-1-git-send-email-sahlberg@google.com>
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
