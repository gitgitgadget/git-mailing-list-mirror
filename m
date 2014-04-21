From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 01/13] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Mon, 21 Apr 2014 15:53:19 -0700
Message-ID: <1398120811-20284-2-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6O-000864-Qd
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbaDUWyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:13 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:39697 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527AbaDUWxi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:38 -0400
Received: by mail-ve0-f201.google.com with SMTP id jy13so823065veb.0
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dxtqj0jrHveKvY4CHwCpmYBKH1eSop0Q4CdZeX0PzXQ=;
        b=R15T/SD8Q5wcuAhZSskHktkZmun/z6jTv7qPZpQ8fn+rG/kNi273TBvrz9YndRDotk
         hzPUFL14HDus/c55Hfzmtu0VSaWm11rtdfcUJsffZT3Y4c8prARYw6jMm9HqaYz11Gdy
         YCvrN0dcC4vX3TKdW2U+WNp/leTjFN+z5gMUkPdh2wgsRiRfGv5m5+CIeqy/yuxPnt4B
         aFp3b/vE/ULsBOXVm/eW7/TkDoWeIpd0emcaVTJBA1vYR24QOqSxcDqlchfNemjIZdvD
         PST6wDxqfHsmVC27hQVAsykAXNXkjRSnSlb5TPWkSgUZv751dhxRtitGUrOLrzMmDP46
         RoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dxtqj0jrHveKvY4CHwCpmYBKH1eSop0Q4CdZeX0PzXQ=;
        b=JzttUzOSvo0tvgsu5rDYD8EINYd395pTd5P9/ffNB+DDt+MsF8EbF5M8hbtSqk28Cr
         5lwJxIbDO0E2aTeo2vh0WrSTtHIzhFZSYqxXp3/1fImhwFyy9yHJMhwLGAkLZpXCmdzn
         quU2X/vGWJOapj+DPqzwNQqdorZuLfJgLSMhPXuWxAFKHYu5bfnBwyjpBVr4NqgQ5ZDj
         ojcwPtFZn78gfO9Yi9HCr5Wmg1v7t1ir5V21NrlqnwM+RyTjiaK/zKnHE5tfJHHQVBZG
         d9ysyZF94mkUKhQhbKX1tM881C9qrZuE4AQHxa1gXd6p2xZ4jr0RvbybDfZ7m9ZZj/sc
         aKLw==
X-Gm-Message-State: ALoCoQkpnS+XMHImAYF9YCis8YTjJFREklYPhP7BOQBWi8648XjwtS74TKIG7dVL6h7kAqbEpdcGqVixvx7pPc3Yag9YkPMepozF6uVuuWTwdsqrr2XqVK+v5MlxtNzUKsadYH7xXKMtwna5JWfCEZY4R4imG79c9dmArFrnKILdQx6nKtgRPKQMNJ69+EusMD+nDIqQZYLK
X-Received: by 10.224.29.129 with SMTP id q1mr14053082qac.3.1398120817627;
        Mon, 21 Apr 2014 15:53:37 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id f65si5366044yhg.7.2014.04.21.15.53.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 67EB65A4207;
	Mon, 21 Apr 2014 15:53:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2A80FE06AA; Mon, 21 Apr 2014 15:53:37 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246664>

ref_transaction_create|delete|update has no need to modify the sha1
arguments passed to it so it should use const unsigned char* instead
of unsigned char*.

Some functions, such as fast_forward_to(), already have its old/new
sha1 arguments as consts. This function will at some point need to
use ref_transaction_update() in which case this change is required.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 7 ++++---
 refs.h | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 728a761..138ab70 100644
--- a/refs.c
+++ b/refs.c
@@ -3329,7 +3329,8 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3343,7 +3344,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
 
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3357,7 +3358,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
 
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
diff --git a/refs.h b/refs.h
index 0f08def..892c5b6 100644
--- a/refs.h
+++ b/refs.h
@@ -239,7 +239,8 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  */
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
@@ -250,7 +251,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
  */
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags);
 
 /*
@@ -260,7 +261,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
  */
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
-- 
1.9.1.515.g3b87021
