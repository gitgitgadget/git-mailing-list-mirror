From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 08/48] refs.c: add an err argument to repack_without_refs
Date: Thu, 12 Jun 2014 10:20:59 -0700
Message-ID: <1402593699-13983-9-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:24:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8jq-00013l-DR
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933736AbaFLRYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:24:23 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:40513 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756213AbaFLRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:44 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so142822vcb.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ui+8/YgjFhX422+EOWngk9anWiRUpiiDirGQPh92bzc=;
        b=QV3Dk2SUu4vND3yyhplcL9GMIe4CTfolXk8RU6J+DpPsan4ivKI0x+Ic47BVYgO5On
         T/EmASUjrPUCopoOg2K1noq0LBdgJoWbtRrpxLEuib65+lQwbE9wpWN4sA7mTEyyzJfG
         /P6fmL/uRQWMKIUcELofRRN9AWKppkS8REmGK1JlisuwiXzjWsGqLw4rx2GghDENwcx8
         ijPxM3L7tXx/5+ytaitNGu7KhsyGpAEes2DeKCEKdwZpD4M5x66wh9jfZ7jjGyxj38HR
         aRKi6BbuF9LNiBp33IBY69AOF4nGSuQ9A674y4IaegJbF5iqxqza9+7Bvl+TSpI1LKXx
         lQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ui+8/YgjFhX422+EOWngk9anWiRUpiiDirGQPh92bzc=;
        b=M5haHtL/tbd4bAhQiqUPaTcZZ6v6DHVICmW29DgHHijxD8QVm5RV3dGT+nrY6ptvuj
         ihKtwIpPao0rSc/Q0vd14UyobvCrUJCNPTRBzumrWtIrbuoKCmvbkpw5ouWvy8cz+JDq
         bx0/kEdiz6CN9Wr6nXdg6YE8w8NjqmjE8sZYA0ldcZqzNtBQO+igLTCU/g+pqhayDb3K
         r5z1mLq17sjWbCaQ38gUsMQTGQvTU3taDVGwiI7QWLeOxeMTVuinsA190Rm4b1Zdy5Lq
         qMcY1gXbBJSZ1yDxBbx/TPDuiEiAVQFZ5zjfeUx6i4chNeXzaOp7YV1YdQYhV3LVaHtF
         vQFw==
X-Gm-Message-State: ALoCoQlr2IJ4qqQ5SaJjo1BmPK36Y/2YmpGCoi8hpTySVX/jxmkHAxbB05t+U69XAY6hdaRHfuoI
X-Received: by 10.58.135.130 with SMTP id ps2mr845623veb.8.1402593703173;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si113140yhg.2.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 09AEF5A4743;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 95EADE0C3E; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251460>

Update repack_without_refs to take an err argument and update it if there
is a failure. Pass the err variable from ref_transaction_commit to this
function so that callers can print a meaningful error message if _commit
fails due to this function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 1e8f293..b4b05bd 100644
--- a/refs.c
+++ b/refs.c
@@ -2428,12 +2428,12 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-static int repack_without_refs(const char **refnames, int n)
+static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, removed = 0;
+	int i, ret, removed = 0;
 
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
@@ -2445,6 +2445,11 @@ static int repack_without_refs(const char **refnames, int n)
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(0)) {
+		if (err) {
+			unable_to_lock_message(git_path("packed-refs"), errno,
+					       err);
+			return -1;
+		}
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refnames[i]);
 	}
@@ -2471,12 +2476,16 @@ static int repack_without_refs(const char **refnames, int n)
 	}
 
 	/* Write what remains */
-	return commit_packed_refs();
+	ret = commit_packed_refs();
+	if (ret && err)
+		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
+			    strerror(errno));
+	return ret;
 }
 
 static int repack_without_ref(const char *refname)
 {
-	return repack_without_refs(&refname, 1);
+	return repack_without_refs(&refname, 1, NULL);
 }
 
 static int delete_ref_loose(struct ref_lock *lock, int flag)
@@ -3482,7 +3491,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum);
+	ret |= repack_without_refs(delnames, delnum, err);
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
-- 
2.0.0.599.g83ced0e
