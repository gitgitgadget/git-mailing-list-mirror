From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 18/48] update-ref: use err argument to get error from ref_transaction_commit
Date: Mon, 16 Jun 2014 11:03:49 -0700
Message-ID: <1402941859-29354-19-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbK8-0007AQ-Cs
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788AbaFPSHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:07:18 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:57174 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so829928qcz.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=icnhyIOig9m3poC/Utiw+EgxtFCfa1yxXczYXnJpSSc=;
        b=npCe0MZeY98c8LRdMACoZ6UcjrX7Om/l3JRzlg2zB4JvzcmxQLvSOK41ofIr0hCrlt
         yexeeIHQ3lL1mnYhWR9jC+uL8r5+hkE2ZxtqogIyjOEI/OF8k3j69AHB++g9GOoVdC38
         LxHIpfaLWKyGjKtPoFnBUnRKN6qOQSxQ2ROS6WIc5uu43tGaarmkprXIZKVZW/X/F6UI
         6dgiG2JAN6TWeJANTZWJi99PPqCWj9FnkEuKj1ZAcpYM9P814lONXojoyRlJolI7Doms
         6lqnbnOvBL5KBJiNLEvX7mt81lOO1P04K8HNJO2/40BaXrI6iTZWrkRD32ZooRpnYTG0
         SI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=icnhyIOig9m3poC/Utiw+EgxtFCfa1yxXczYXnJpSSc=;
        b=kNqtBU16iMwEQ2zQvPYYbj6roKvJywsPIl+ml40ZS0Vbch7QugP4oC0540cyhMCNd3
         UA4tUW0IFbwp0HjCaZ6xUdr1Dcrh9WHAN9zN7XgPDuXktd7pRaC3b/MEByNjNI5nxWn0
         XMtRftVd8jFBxV97t7Ads8/XvKCrclBM6T0RFx9vZVWLGX9vRsEFFGXKpdYxb9UJFy3B
         SWWa+qX/U+FoHjHgUX6SY17cSsQt87lrlqfn6wBD6Ez4d3RciArUTpTfSlnyr2FwIt03
         aySlZfYKm87hgOYDGIgAmSS2kyf/HhAdz4vbcIZN0yFg858rUL5G5GM3G/X+vpYLZOIm
         KSzA==
X-Gm-Message-State: ALoCoQlDYVX+YP3/LvankZkOA2+oWoVgQKdxIlCFJ4PgAPeyL4FnBGVo/GMqIoUMd4bAkG3T/2X+
X-Received: by 10.52.113.226 with SMTP id jb2mr1489066vdb.6.1402941862967;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si996724yhp.6.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CA2335A4914;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A87F3E0AF7; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251771>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 22617af..aec9004 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -359,18 +360,17 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		int ret;
 		transaction = ref_transaction_begin();
-
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg, NULL,
-					     UPDATE_REFS_DIE_ON_ERR);
+		if (ref_transaction_commit(transaction, msg, &err,
+					   UPDATE_REFS_QUIET_ON_ERR))
+			die("%s", err.buf);
 		ref_transaction_free(transaction);
-		return ret;
+		return 0;
 	}
 
 	if (end_null)
-- 
2.0.0.282.g3799eda.dirty
