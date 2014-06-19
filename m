From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 15/48] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Thu, 19 Jun 2014 08:52:57 -0700
Message-ID: <1403193210-6028-16-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:54:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxeeu-0006GL-MG
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096AbaFSPxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:42 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:61618 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757906AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-pd0-f202.google.com with SMTP id r10so289868pdi.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYcX3wVulKfcc5uXTtzRhrsQwdytvygud3VlfUEWYPw=;
        b=F/aTp2JbEBDaJMt+T1YczlWs10MFzmlZPHTVMBETgooKchCddrzW7mp8kXJKi6rrbP
         N6vh0k7qssHNAWlEr+0dtkfMWHx/Gj404NhKVVp5GueTImhhTL5jz79MydgvGly60AN6
         t6NtnPtq+/fH3F4nlMcMHm0PRZbGb6WehxoHjYbO1DjUxLpXKjo0BqBpSnXbfmZ94deJ
         xpVasvjEyB929OAVBRGtXqiG7Aq4+luGUT/wdsoGiozcOsqljCqOvIuohOJ5skoGk9vI
         k1Jvd+U72yR61BXLgkNL53CC2N6fxR4c0dMfHkvmNFv+8SxI4mArrKUrF/z+n0n54P2P
         QI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iYcX3wVulKfcc5uXTtzRhrsQwdytvygud3VlfUEWYPw=;
        b=j8vqWDl3FZwVrR79m+htbYeRhZ8ANP+YC1LRi0Lq6gmfxbfd6thwlAe79zWsaAgqae
         59TRupb1SuUjB7xXnx1c0uQ7MhG9Wc2kgSQEHPMNOkPrPrpAsEhO3iXcrl4kPQ0UYYYM
         KKb58fFjn6qEy/XuCVBdPpQrzt1DZRVoOZDwMNyqcn9rpwu/EyU2OoHbuuRnsyXEVwhE
         LbPCvYswhELYgW7I4OC1sR0z9sCT3Xs8oARTjML7z+Al3G8Z3kKKKE1oRkaP2pNudZCa
         jfywJALwA6dgJLTrHEztrR1O/EnUzHnftWXpxYVzFbpVh+DuMItf/ANFHu/8Qfc6SsuY
         TikQ==
X-Gm-Message-State: ALoCoQkcvc//s6uVhifMYrLX8G0h6JFc3+Y/vz6V7IB6gNYHZSch8iZenl47Z7mD1V1QhBipX69q
X-Received: by 10.66.156.2 with SMTP id wa2mr2754771pab.0.1403193213542;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si418317yhl.7.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5D8FB5A4618;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 00118E11C5; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252120>

Make ref_update_reject_duplicates return any error that occurs through a
new strbuf argument. This means that when a transaction commit fails in
this function we will now be able to pass a helpful error message back to the
caller.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 61570c9..115f143 100644
--- a/refs.c
+++ b/refs.c
@@ -3488,6 +3488,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3495,6 +3496,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3525,7 +3529,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.0.438.g337c581
