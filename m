From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 10/22] refs-common.c: move read_ref, read_ref_full and ref_exists to common
Date: Fri,  8 Aug 2014 09:44:57 -0700
Message-ID: <1407516309-27989-11-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:47:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnJk-0000s3-Go
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757118AbaHHQqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:46:38 -0400
Received: from mail-yk0-f201.google.com ([209.85.160.201]:41972 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155AbaHHQpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:16 -0400
Received: by mail-yk0-f201.google.com with SMTP id 142so764805ykq.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/3k2m1nzmNH9+Vw3PFEeduulDeZg5Flo4cTcpPvUIws=;
        b=NHy++gT3yewRoPenaLYOq0rVSukX0XDcGjEf/ttnK+Mb6XvQNpKihSi0qwspGGMkwT
         zs2oTO2pcdadWtH84aI2bOCf7jn3mpLgnOT9NNIkOlqkOLeR99k7Tmkx2NEBfG55w7hM
         hQQE+vjJguExXth7BUh/upHXM4eMtElqYSfwk9yKgi7XSw7dHKuKZD8REBXSesMAQCm2
         HYp2aowO4ZId+laGSG4AnCeeFmgQT+9OAFAlOWm3OpFUZ1xMsdqA7GAp298/m037Eq4Y
         opoBdI9HUszYRiZ4rs/nJFGNI5/NRrMRXpl+by8moaiokatmpddFsZZUMdHVKZkAQpOo
         PhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/3k2m1nzmNH9+Vw3PFEeduulDeZg5Flo4cTcpPvUIws=;
        b=CDHCZoxkhCJozQFduwrWtxhnWD114YdgRdkoBvhfE7NP3a+RCU8loA/0i9fLpLHN9y
         ilIvKuU8JFXTuhuEai0MogGja5UK4Cm85jruaKgZizPq/9uct991M2uFVBXNT0YMy7Ot
         wtNYCnQfJMg1/dTJ2m+uAmhIEqdrFe0IDjtB9bJtz2M9Xlz1SznRU77dkX3qdD2ijpZT
         gx/en+4l70xTLnJv0vwfs8uMw/N4mapaVBiQ7+ylxg8Tifi4r/eoZ2d3cbIe6gJR+oHm
         PJOZObcs151ZupOSulxDpvEbUqOfkDurhUY/NFnHfEZgXdYjPPgAOKyYBa5Qno4lFj5g
         lovA==
X-Gm-Message-State: ALoCoQlaUdfCQGSJB/TVNqinLHSb5G+bzO1Zq6KTjBnzxBn3CK5tkSWkgUlPQ2nxW28OjNOrgp/g
X-Received: by 10.236.197.65 with SMTP id s41mr5385065yhn.36.1407516315707;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a66si502686yhg.7.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8EAD031C5BD;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 15F53E0E29; Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255044>

These functions do not depend on the backend implementation so we
can move them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 18 ++++++++++++++++++
 refs.c        | 18 ------------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index ab3a118..37d3d14 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -547,3 +547,21 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
 	data.msg_fmt = msg_fmt;
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
+
+int read_ref_full(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
+{
+	if (resolve_ref_unsafe(refname, sha1, flags, ref_flag))
+		return 0;
+	return -1;
+}
+
+int read_ref(const char *refname, unsigned char *sha1)
+{
+	return read_ref_full(refname, sha1, RESOLVE_REF_READING, NULL);
+}
+
+int ref_exists(const char *refname)
+{
+	unsigned char sha1[20];
+	return !!resolve_ref_unsafe(refname, sha1, RESOLVE_REF_READING, NULL);
+}
diff --git a/refs.c b/refs.c
index 40c329b..a94378e 100644
--- a/refs.c
+++ b/refs.c
@@ -1514,24 +1514,6 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
-{
-	if (resolve_ref_unsafe(refname, sha1, flags, ref_flag))
-		return 0;
-	return -1;
-}
-
-int read_ref(const char *refname, unsigned char *sha1)
-{
-	return read_ref_full(refname, sha1, RESOLVE_REF_READING, NULL);
-}
-
-int ref_exists(const char *refname)
-{
-	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, sha1, RESOLVE_REF_READING, NULL);
-}
-
 static int filter_refs(const char *refname, const unsigned char *sha1, int flags,
 		       void *data)
 {
-- 
2.0.1.553.geee1b3e
