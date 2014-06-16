From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 08/48] refs.c: add an err argument to repack_without_refs
Date: Mon, 16 Jun 2014 11:03:39 -0700
Message-ID: <1402941859-29354-9-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbK9-0007AQ-DX
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbaFPSHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:07:21 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:39256 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932638AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so765321vcb.3
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eGRnIzjywS0zq4A80+J7oKZ+Bkw5D9/30XD6IlBy0Hw=;
        b=ivZSuWqMIlb34c2kj8E3Ah7M/POzmXsoA9zrb1HnS/9f4JHRtRw0diDlomOgdY0/rx
         DiKSJ3O5KtGNKsoZoqMxIBCVcdX/jdqlhhqBpb3Iv3ZM7CG5wHN8g4++HZPfJ2coYlql
         j6zXjDTgBP7rcl9Ulze3vnRu766e83UsTjDd/NNDKOUyMCs58bvmNQcA4Updfu3gygnD
         GH43CSbHx1yM8NajTcp5xnIETex8jFmMaphoIKqOt0ZgYcqJKdAWFcaC1toEU4A8N5i7
         rZn0mqM1YuiaWJmd8NWfFi0HejfTg5C3rJ4BEhpD2ULd/y58M4nN5jsgi3pcWjBE0JF4
         rouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eGRnIzjywS0zq4A80+J7oKZ+Bkw5D9/30XD6IlBy0Hw=;
        b=BQkkTxbG3rZ0uj/BKJqHw+mgBqZlNw/qDNqlZlihbOzSixQCEb5j04GfD+mbDKgfI2
         dhlB6FlgoWC8lxsVEJfSKlahGVpx8ejcV8txzK8QYUa2qq+SLTpO6Clv+2O0RkYP+sQu
         TdBpXCG4IEx4B6yM9Cj5d2fTDMQ0kJOznjWgxGuN/B1qZqsXfoRZeEfeyb4yzy2/Md/6
         X0izoNhTKq8aYJznaTKxQUtN+6wRtWoZJgViR84gdGg6/mpSiY8oD9h5VlYhB7VCP5yI
         Sqr3VAy/n1hiRAyF3urt92TRF3WSucHHWvXDu+GzGiF2WNuVMkykQTKv7aK42SWcjLyF
         S6Tw==
X-Gm-Message-State: ALoCoQnMSoUCOHCG2XLdUDmqBk0CQRs7IHG77d4sAvUMy0D6YWu0MBKxyXFF4H5cAaoGNagOn5u+
X-Received: by 10.58.187.68 with SMTP id fq4mr4416009vec.0.1402941862667;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si997790yhb.3.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 7B0655A4913;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 27D33E0F37; Mon, 16 Jun 2014 11:04:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251773>

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
2.0.0.282.g3799eda.dirty
