From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 4/5] receive-pack.c: add receive.atomicpush configuration option
Date: Tue, 19 Aug 2014 09:24:50 -0700
Message-ID: <1408465491-25488-5-git-send-email-sahlberg@google.com>
References: <1408465491-25488-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:25:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmDl-0007UR-FJ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbaHSQY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:24:56 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:39787 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbaHSQYz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:24:55 -0400
Received: by mail-oa0-f74.google.com with SMTP id eb12so1477694oac.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gV8HcbkZvQSC98Zr6e7gCxnxRoPCW1d4gPghii4V8PE=;
        b=XxN7X0kaTFNiz3dWYVrdNeL23aAF5lXU/q92+ERvS3SaB882nmFSrp3HYG/II2Uex2
         pBLxFmihpDeHHMq/e+KgzyB7Zn7BUjOJYqA7N3r/mNtJ/4N4AOx1RZwAHUlPP2RuJFv+
         Ay1fGDw7okWRzOTgeWLmqk1MiWcNogZQyvofvqpAfZqc3jaCkKixEQS53psRpNqW/pbd
         2QYTSZtBZXYwGX9kEwlw0Fdv2sbKbuZFv3mdW70md6NU8zTATEWwDS2RK10fZbySZQe5
         kdSFALL/dyqja98Zk9MmwA6j6BHOfRcOdqmeT+DQ8+nBsNs06AY5KPcsSr7XqP+YzuWU
         5Vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gV8HcbkZvQSC98Zr6e7gCxnxRoPCW1d4gPghii4V8PE=;
        b=VAGmntrg+/Bvh3Xrw/iKlP6p9/jRC6xVRxSrOgCVuRUn2Ue1E9ckzGb/v3mKxTvv5c
         Lg8RyOLb3ejNavIL4f7764Sx3QtkEL0rE8edogoyd7e6WnZ+V6HChfrj/bt3fVf8Za9m
         Z1U4gSaOWmngQrhVVpBXIAsXQRxEg3MfsHFH7QZ5vgb6ZrSjLmMuijVHCHkXwEQdtliq
         tqlAT+i7PFgXM48IFvXjR85dGxM+Dw5CQAUGFfT4AkX5gu2oggIM3zfWdyotCmEWsrE6
         Zpyt2OmOBauMxWdd1UI5LEHEdObk+97L3iy+Afj1a+43sRsNjIvxUnORWx5PYW3nZhn6
         p0RQ==
X-Gm-Message-State: ALoCoQnsLbSoZ3ag/PYuOonVtE3TR0IxpLCjGuD25P+N1yc8qbNyOPgKtB00KhNPUiwSQUj+8+FF
X-Received: by 10.182.24.8 with SMTP id q8mr22325566obf.25.1408465495108;
        Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si327975yhk.4.2014.08.19.09.24.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id EED505A4438;
	Tue, 19 Aug 2014 09:24:54 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9356DE0AD7; Tue, 19 Aug 2014 09:24:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.ge8f7cba.dirty
In-Reply-To: <1408465491-25488-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255474>

Add a configuration argument to the receive side to force atomic pushes
for all pushes to the repo.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Documentation/config.txt | 5 +++++
 builtin/receive-pack.c   | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1d718bd..75ce157 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2038,6 +2038,11 @@ rebase.autostash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
 
+receive.atomicpush::
+	By default, git-receive-pack will only use atomic ref transactions
+	if the client negotiates it. When set to true, git-receive-pack
+	will force atomic ref updates for all client pushes.
+
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
 	receiving data from git-push and updating refs.  You can stop
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 47f778d..9fa637a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -132,6 +132,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.atomicpush") == 0) {
+		use_atomic_push = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
-- 
2.0.1.556.ge8f7cba.dirty
