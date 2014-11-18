From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 4/7] push.c: add an --atomic-push argument
Date: Mon, 17 Nov 2014 18:00:37 -0800
Message-ID: <1416276040-5303-5-git-send-email-sbeller@google.com>
References: <1416276040-5303-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 03:01:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqY6N-0000v6-Ns
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 03:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbaKRCBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 21:01:03 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:52692 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbaKRCAt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 21:00:49 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so231553igd.8
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 18:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AXS/j/hXSR6GxdB7ae1hKg9T8Hn7l1MYNE1/4UaaDYw=;
        b=PYXquMad5ezAwbV5Bq5rc8AWwlrgTmo4XZOeEXO7XOeYyvt97/l4o9RqKs1h75vKU7
         wsYskCDxhHWaBSGCS+E+1LQOKRm+Ud+SR/T6x5r/VC5HKw40V0cA5MbErShRedgY0ZrY
         DlUZoe7/kIGD/YEbQYjdE/vxCfyEo7gyQX4LxhTwgUoj18LKJuB4lP8brZ2rF4dsAgMv
         EWUuFSlj3V6oT/PbWh6syID7cGcOt14030AnfNPaKX+E/XOn/L/230VWEoKyMwoegt4F
         824flRfv+CESlLGDCR9ZIP+dXqcwB/krXf+WIrsq8MFJLIVS8jJ7W+UU2qRV2s+t2+AX
         oSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AXS/j/hXSR6GxdB7ae1hKg9T8Hn7l1MYNE1/4UaaDYw=;
        b=bQzt+M/Qf5smFWQ6xF7XxrTpoMPda2oP/d5Z6dH0O1y9rFARzHoFh28+wCe6xy2La+
         9PUamfNfRNgI54Be9JPoxMpEmHGPBnFtFYSCtJE2l+Ay9BjFxGhOJikz7QUrcaE10r2I
         T+7NJpRMRKp8/BibAXH6Vj3fbfLOguX3aK0wlcWKWkByOlK8Uanf+ThnXQL7r8sTXkXz
         RRx8pSeVjdIzabyZCj+UfsImFEY9f0PEuw0MrR2/UqdUCuIC8ur4pGwP4ZKF2mk4pMQc
         GRCMj3mfymWPlwloFOfXhcMzTh0DBiJfQVSLSLBMMQWVq3XvOxDvrxfvH0OtrJncXw63
         Is4g==
X-Gm-Message-State: ALoCoQkUe/rs9ODZhIcUmv2KjlFCkE+he7sE/llfQNEAj9RLp9aOub76HU586LP9jVIgcnn+DUeG
X-Received: by 10.50.111.226 with SMTP id il2mr670222igb.10.1416276048488;
        Mon, 17 Nov 2014 18:00:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id f4sm12715634ioe.11.2014.11.17.18.00.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 18:00:48 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416276040-5303-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Add a command line argument to the git push command to request atomic
pushes.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.2.0.rc2.5.gf7b9fb2
