From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 13/23] refs-common.c: move is_branch to the common code
Date: Wed, 13 Aug 2014 13:14:57 -0700
Message-ID: <1407960907-18189-14-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:16:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHeyD-0000NJ-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbaHMUP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:59 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:33053 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so268790igi.5
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6bYUij721bCk2mZYTXrwx4bjGS9VpWZGdChQHr+j8ns=;
        b=QVP4YSSZlDZP3cxBjpcF1MqDR7QRWOBhH+p5OSW6vj/XfTXWpgQ6TqJLX1ubxH2FVz
         j8mJQVFgBxJakJN9eLtZIJ3cR50FMtKiQf0WPyBIQ0lncH6JpXga7YPs+bbw+9cOvBU4
         fQj9q6mCc1CTqqmNmgmDH98q++cHPDvp3/7kYCONzclkDs/4bADFnQP6hD1vQXdaR99d
         RRidgu/fll9Dlhn+a1GU2EKPhlrzP+r4Q1FU+Fl746KxHroZIKoYqfm8E3eq4wuGMOJL
         848kDL9TZQQ8pYiEjOZdcB9zVeQvL5Np7JTVWnwBnjWE8CvMTNu1tam9gMZn/ewy7LBb
         qU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6bYUij721bCk2mZYTXrwx4bjGS9VpWZGdChQHr+j8ns=;
        b=QMbCpDN6/hhVbWb3G0mkgvd5p14K1vUguOG1XQSKG0mPU23r9drWpt4850+Gt0cQfY
         uRCiN1pHPz0L1TPUQNkK5Oxqft21pGJqUBmWt3S5cz00rtzeSJZyS4FqBzlsHSmfZ0lH
         0R9GqQRiPkCcTZ8b/ZjIa7PnVXodIV+uL4Fx4IkFGujYAb7lCmi4fKpenkZTWEG0AOiT
         +puSzT39ZCpCzbMfXii4HXluQ9Bkt4bfBJsdiVTxQrJo9QoZzfSlTa0rL+NGdcT50L3B
         t3zx/NjvNqqm1BbuEXIR7fnajFzP/aie/SlqWMMdn+bcrrxo42OXOO0sIydsYFpG5Ei8
         WPbg==
X-Gm-Message-State: ALoCoQksEVwWWU+8ORRwgCOdcQC88JoveoeHN2TtEDshQACzDJprst90m5QR7g6GzVGSgS63af/x
X-Received: by 10.182.18.8 with SMTP id s8mr3235604obd.21.1407960910730;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si209196yhk.4.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9193131C2A9;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6D3F3E104B; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255251>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 5 +++++
 refs.c        | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index f8b79e0..5f83d7e 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -3,6 +3,11 @@
 #include "refs.h"
 #include "string-list.h"
 
+int is_branch(const char *refname)
+{
+	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
+}
+
 int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, struct strbuf *e)
diff --git a/refs.c b/refs.c
index 55bced9..70c034c 100644
--- a/refs.c
+++ b/refs.c
@@ -2483,11 +2483,6 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	return 0;
 }
 
-int is_branch(const char *refname)
-{
-	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
-}
-
 static int write_sha1_update_reflog(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
-- 
2.0.1.556.g3edca4c
