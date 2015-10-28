From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 17/26] refs.c: move head_ref_namespaced to the common code
Date: Tue, 27 Oct 2015 22:14:18 -0400
Message-ID: <1445998467-11511-18-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:16:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGII-0002dl-Ea
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbbJ1CQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:16:49 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34722 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbbJ1CPK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:10 -0400
Received: by igpw7 with SMTP id w7so19301115igp.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D9U71riAqH7w2hj2O3rUWQvjtQEBXIdLM/WuWxBqaAI=;
        b=aDd/c899P5Sz8cBVrEvuWhX4BH4tTOhtrRd9/cgUlWwVeve1tTYmgC9NbX3m8omBVc
         dZ8DGrwrq+AxUakSJYFZyT72kqQx8htVNk1oPBzQi5bP7462qSW81KwWNiNmmwO2kdlA
         XWw8hg04zKAg+k5Pnh1mEgaIyXMOKcd2PtB7MBPEHyTLvCeP3DvYMI7JXlJjyhw1pi1M
         0dzMUvDz8hvTb6Q4bHOtYRRyJnsutiufXvKILgEUE3wMqtTRtkYLUI4gGiDBM+FeVXeW
         PdxYYtHzV1K5pfMHhRU6Cx1BgYGQdo8a4OXjZINEPGerRXIxwHMw/fiP+X6EKaRp02Fm
         gBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D9U71riAqH7w2hj2O3rUWQvjtQEBXIdLM/WuWxBqaAI=;
        b=PUZipUcBUL+Y8q1MzvRwGeqpcj8Iqvj7fC/oXjQyAeqP2teSIFxuHcUz931MzKAsPs
         wFILbPeOmfNalepp1c7rEiu/0qvL1lhxQiacy2aWrEV2GT7ImB6zDNeYwivBDzpbalEb
         qGyOPwE3jUtC2CiBc9Bs+G1+rf5MBeBl7iPgicV2rn1o7vocuTa0XvjLI8qRRfKRVVpd
         8zWTyLS1dM0Mn6YP4Q6cHDhq7Olijx9UehAKpBBZEql844ozJv0RmMKWWSCmpkXhQ7gT
         0PT0VYD6INMIzp0PrnVOUoR37Ov2xrhdrNCV2zGk/f84XXlL/8rQ//Z2VyLX7ou8szTx
         kCVw==
X-Gm-Message-State: ALoCoQmWMcYH8tUxl5n4SpJDkgiVc8UY7fEiuzzNNh5iF4dXYDi202BVPYgGhbEaMAi0EFOPxVxd
X-Received: by 10.50.119.9 with SMTP id kq9mr381333igb.32.1445998509810;
        Tue, 27 Oct 2015 19:15:09 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.15.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:08 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280347>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 15 ---------------
 refs.c          | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index d04a9d2..18c849c 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1939,21 +1939,6 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 			       strlen(git_replace_ref_base), 0, cb_data);
 }
 
-int head_ref_namespaced(each_ref_fn fn, void *cb_data)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int ret = 0;
-	struct object_id oid;
-	int flag;
-
-	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, oid.hash, &flag))
-		ret = fn(buf.buf, &oid, flag, cb_data);
-	strbuf_release(&buf);
-
-	return ret;
-}
-
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/refs.c b/refs.c
index c7778d1..61d71d5 100644
--- a/refs.c
+++ b/refs.c
@@ -826,3 +826,18 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 {
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
+
+int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0;
+	struct object_id oid;
+	int flag;
+
+	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
+	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, oid.hash, &flag))
+		ret = fn(buf.buf, &oid, flag, cb_data);
+	strbuf_release(&buf);
+
+	return ret;
+}
-- 
2.4.2.658.g6d8523e-twtrsrc
