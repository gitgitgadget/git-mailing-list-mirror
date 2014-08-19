From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 11/23] refs.c: move read_ref, read_ref_full and ref_exists to the common code
Date: Tue, 19 Aug 2014 09:30:35 -0700
Message-ID: <1408465847-30384-12-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKY-0002zZ-MT
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbaHSQbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:23 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:61223 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbaHSQa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:59 -0400
Received: by mail-qg0-f74.google.com with SMTP id a108so412865qge.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0dQHb4bQFKFvSoZ/djS+baXKUW/JQGN6szuwemzKZPY=;
        b=lSJGQ2xLaKam99Vs9NVO9fHzeU0+o5In9sBsVHs3bRBZD5azXYwfnzRtc6yQ9nHHs+
         ORyrODmnSW7N6M3khGG81PB+koLLpWaCzXlGanc2M9OC0v3/MvGLPvwCzSUvHjyFw58y
         ZC3aIJ99ScFRShe8WteAPUbd8AqYOxFpNjycn2/gntcmJlaReb75TvuDrS3CK7FL6oLk
         kI0w20wtqLOxoNLh90RbM8hAVIdBCX8QtRWzzNrlAWSiC4uGb4M+z9JbCISFw/ue1YR7
         wqOG5yS1y1Llt+H44VXMB27MKNBO7FwIukZmZfx82cXWmRLAKtqgemv/yaCPTG1buTS8
         eWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0dQHb4bQFKFvSoZ/djS+baXKUW/JQGN6szuwemzKZPY=;
        b=BaicgADCS8uSdpyEt9+wTSNi9b268MOee61XRC30kXa8uyyC0ZhZ2WXC39PzxKK/HS
         H8paKYpZgiRO4cdFOdsLNRSGO3+C0lzrhHW/IEAqLTGk12BPobzxhwO4Prx/EJCtfLmv
         bCbBd2Jh565OScJzTFBzw5kgf5z11laze06sS3LkdEue4ZGApTCjl5ges1wCI9r3kGvr
         dVlrRCbagFNBogh3cmkfCVhmYgDLqudHfHJn82o7Qh7BLZOk2UYuNqM8ooaC5fqofTCG
         utRJaCrrjD0CL5efV13AcLxqAwQd5LxnYpK1IuoxPYEbUlLeVerBWJY49BRC/kVsFqdt
         Myug==
X-Gm-Message-State: ALoCoQkT6mPYKfjhCkaI/nh22ht2jooQdSC7/m1Y1IQnbATCc1PBhC9uW1Cr8NMJsvf5QI9uMWie
X-Received: by 10.52.182.66 with SMTP id ec2mr4725570vdc.0.1408465853425;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x19si332774yhg.0.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4260A31C538;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C4042E178E; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255491>

These functions do not depend on the backend implementation so we
can move them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 18 ------------------
 refs.c          | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 40c329b..a94378e 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
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
diff --git a/refs.c b/refs.c
index 3011452..a0e6d81 100644
--- a/refs.c
+++ b/refs.c
@@ -549,3 +549,21 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
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
-- 
2.0.1.552.g1af257a
