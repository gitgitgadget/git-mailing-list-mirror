From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 5/5] push.c: add an --atomic-push argument
Date: Thu, 31 Jul 2014 14:39:11 -0700
Message-ID: <1406842751-6657-6-git-send-email-sahlberg@google.com>
References: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:39:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCy4U-0005Ge-V0
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbaGaVjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:39:23 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:61272 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbaGaVjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:39:15 -0400
Received: by mail-qg0-f73.google.com with SMTP id q107so147840qgd.4
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cIUizCWmOtNI52PmlYGuOxu+dcTYc6TqQ5dJmQcz/dI=;
        b=dt4dus13R/sxzwHPFdgS0f+oeip187T9T5aIsG+f1vY9fsyvARkhDOy3AdeDAADN3N
         vCIn8ojCFQ+/aMX8bcb5UA6HTxaBeVsVHWoNkmoQJcgizLWFbnhypaOi+/HGB9J9ShUY
         8t4I2q/esK3ns0ScwKHwSLMrQfBQ2kXzW4TrCnvYyAwpJzy0a8/XS03iov6j9oAcgP4p
         ZIbN9x8uZgDJfMl6w1Q76rS60cHV1d1UW5FecDHOkcRrTfPnKBUV62rV9sKG94W478ZV
         Dp6TeNBF6+RaXooxNTPoF5Rf4hkJnnjLGzG7GlsWcSpTbpLrsxCjh3rskOSEbyAGSDiy
         A27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cIUizCWmOtNI52PmlYGuOxu+dcTYc6TqQ5dJmQcz/dI=;
        b=bgGYJNzbe47LfOLZCCkHlVYL1s5UlRRRB8o6pT1Qr7zT/c97VET0AxpdctjvvGVMpn
         X2Tz4rXqOR4XNIlVbmUn+3alz662TEHhPXUWw85cnzm784tuWlb7boJXxdZJnPM2ZFva
         z+UCsMoPJp7frw1aEIbfPdnbehpch3tZmYQbtWnQfq6BmtMuMhFcHykePtpwXv6gv8nh
         4RrIShDmrXGi6wECLFL1fwyxkbsyzhe5Z+YvVmO9Lwlu+UfTni4XCijKtXuGv192lapW
         2r0wCwX8Nr3ZEY/lDFF9h6roxuG360qAqvliNxz1qG/JjgirmL5uI3iqYiLA5s5jETqQ
         qJ8g==
X-Gm-Message-State: ALoCoQld5QGJUjn225rvSxLBpNaec2GZD0zZv5pBhPrnI16A3VROfz9UJYJbP7H5m0ukkfsmVg9f
X-Received: by 10.236.175.42 with SMTP id y30mr391832yhl.42.1406842754689;
        Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v20si424251yhe.2.2014.07.31.14.39.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 89C9031C611;
	Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 037BBE075D; Thu, 31 Jul 2014 14:39:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.528.gd0e7a84
In-Reply-To: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254613>

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
2.0.1.528.gd0e7a84
