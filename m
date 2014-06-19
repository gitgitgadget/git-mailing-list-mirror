From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 22/48] refs.c: make ref_transaction_begin take an err argument
Date: Thu, 19 Jun 2014 08:53:04 -0700
Message-ID: <1403193210-6028-23-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:55:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxegK-00081s-2I
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933441AbaFSPzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:55:00 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:57964 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757961AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so694259iec.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H+iy+LXtiM0EO0qBueo5jGcenfqTuSpb3zKxzkMYhT0=;
        b=N+cpOynO+rb9LPEOXPM6rKUE0tZh+hJPRbXl0ixwNkOAcT0rBmib2IMeJyrWJCCozG
         5wbhZIXtmH9uGmKp98vM4U6z68KkwnyIV/F6k16A2uDr5aJxN3UAIzaL3CNIuf2H8lJH
         MEmaFfbC8vxazknNS+yMNQqz7tnzz+WsCTALq1y+/kOujTrikiN8ZUEdM8BXKYTn/tNC
         oW9T+M3chG/g9OOYSBp6xVyZh9gtHlV6i24Z1z8HfYqjAJVoJKHDolS2LUhN1PS8yidE
         XlkdYXQh34msc3BRAhGR3GaVjK0Cz9AjTlUy+8p6+NdC0MiMaDRUnMmwNtp7V/eLoZtw
         pKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H+iy+LXtiM0EO0qBueo5jGcenfqTuSpb3zKxzkMYhT0=;
        b=Enoemtlicyq2I4NHOTNkHu/oDyfYo8GGmFwZt4VoqFkkGmMoYtYq6MBocKVY8+b7sM
         cHeCdE0I+jv5oeQqdPqr9WHZts0Ob5bTEGJWAoOKO6UkiUyOGEDDaOvo/Yqk4Iyft/M2
         1M1ZB0tsumS/xPw1w3eDhFbgXCsWIXxghdLQ41/AdCVI95kFYtdc/f7Yyi+caiMmReE8
         KuEM6rbXCKMQ7RpaIRx1nx5rt0j9uvMCaJ0pmVw6H1cI9SdFyxa3f3rc3YbjBQjMuJOu
         YKeT+aKM/fQEy3EDN/2QvCC2kn6dkXgfk4eTKsqyHuCa7CFDYMZXqVq0I0V+of5hpdMY
         whqA==
X-Gm-Message-State: ALoCoQn0XwNK8wrSQCTgT8ccrehRNW2BEdWeRfN5ilP62ezlQOmcUSMZJwsX6v1T9EUbNnutPpLV
X-Received: by 10.182.213.37 with SMTP id np5mr2703726obc.36.1403193213575;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v12si347089yhe.2.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6CCBB31C3F5;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4B12AE1B1A; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252139>

Add an err argument to _begin so that on non-fatal failures in future ref
backends we can report a nice error back to the caller.
While _begin can currently never fail for other reasons than OOM, in which
case we die() anyway, we may add other types of backends in the future.
For example, a hypothetical MySQL backend could fail in _being with
"Can not connect to MySQL server. No route to host".

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 2 +-
 refs.h               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 7c9c248..c6ad0be 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -365,7 +365,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		transaction = ref_transaction_begin();
+		transaction = ref_transaction_begin(&err);
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
diff --git a/refs.c b/refs.c
index 40f04f4..9cb7908 100644
--- a/refs.c
+++ b/refs.c
@@ -3397,7 +3397,7 @@ struct ref_transaction {
 	size_t nr;
 };
 
-struct ref_transaction *ref_transaction_begin(void)
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
diff --git a/refs.h b/refs.h
index eeababd..e729ea9 100644
--- a/refs.h
+++ b/refs.h
@@ -269,7 +269,7 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(void);
+struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
-- 
2.0.0.438.g337c581
