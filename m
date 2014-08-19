From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 18/23] refs.c: move head_ref_namespaced to the common code
Date: Tue, 19 Aug 2014 09:30:42 -0700
Message-ID: <1408465847-30384-19-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKW-0002zZ-MR
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbaHSQbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:00 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:51020 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbaHSQay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:54 -0400
Received: by mail-pd0-f201.google.com with SMTP id g10so1804615pdj.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4wXwGWtTykQZFEiQCno4ro/c9XHqPl9lCcy96sEvnJs=;
        b=R9VzFO0HG37d/hg7D8zIteeTwF8ep5BmTDzPyRRw8YmvH8RBfASzsqona54AJtBYvh
         r39EDjckloruGtEQza6XaYxFYjwpXRJF39uqB+lop2uWEzYmbjExbIVZrTAgqrc+cgP0
         OsIwiyVuqepg2FXN7bYqSk/5cZj2AqPQon10OM6fj5FtcOAQbdIfcS14Iyw5YZaZFusS
         2mFjz62jrA1lVKW0kLmyzPmw776iJ31lFtaJHmb407urhTSqCeMSppwT8lgU/QKaGMXT
         1eyw4nZc3h5HHX0QGS1OwoZLUlbkSYOyfQFURLwE2zxsXScAql/iU1xUGlDPfunUQ4qc
         59+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4wXwGWtTykQZFEiQCno4ro/c9XHqPl9lCcy96sEvnJs=;
        b=JJD+D5+jFrabepOY+fMJVbkqhm+CjSr+YmN/WNIVqDqJW6pf8XmR+EkWZ07fxrXgTT
         64yCRSCtFGR8NI8465VZewXzt7WBMvpu8EOljhOZ6IL0GBB8ru5TI8GOUpiuARrzAhJp
         CaSoa69ePnLhHbXscO60CM/CzqEG77bBBNcI8dOkG6Fc0qvimu+9sdRVdN6vZsFwQ6ka
         w1ziyRVrncA+/FsTrfemJg6eDwhzenlygjPJv2jgQ5dcCjG2Yl4KHKOCovb68vF79Ubr
         GRGD0ObQkxFAQEDx+JziO7FXkpLZV+RZip+Gz5qEJKsr7q4Z5nwupzeNN3kxkuZNeT8E
         EINQ==
X-Gm-Message-State: ALoCoQmRzrDxWjxXUk4SvrweF+nZeRUiF5zLjr6iATUcE/Ok6D5Tnc/0woHMyN8z5olqY6jl7gmb
X-Received: by 10.70.37.41 with SMTP id v9mr3828088pdj.0.1408465853656;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t75si329275yhe.5.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6286131C539;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2CEF8E106D; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255484>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 15 ---------------
 refs.c          | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 9aa88ef..e58a7e1 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1635,21 +1635,6 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
 }
 
-int head_ref_namespaced(each_ref_fn fn, void *cb_data)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int ret = 0;
-	unsigned char sha1[20];
-	int flag;
-
-	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, sha1, RESOLVE_REF_READING, &flag))
-		ret = fn(buf.buf, sha1, flag, cb_data);
-	strbuf_release(&buf);
-
-	return ret;
-}
-
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/refs.c b/refs.c
index 964a513..6b434ad 100644
--- a/refs.c
+++ b/refs.c
@@ -786,3 +786,18 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 {
 	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
 }
+
+int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0;
+	unsigned char sha1[20];
+	int flag;
+
+	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
+	if (!read_ref_full(buf.buf, sha1, RESOLVE_REF_READING, &flag))
+		ret = fn(buf.buf, sha1, flag, cb_data);
+	strbuf_release(&buf);
+
+	return ret;
+}
-- 
2.0.1.552.g1af257a
