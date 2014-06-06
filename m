From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 03/40] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Fri,  6 Jun 2014 15:28:41 -0700
Message-ID: <1402093758-3162-4-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:29:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2di-0002El-1j
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbaFFW3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:25 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:63301 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbaFFW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:22 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so742694oah.0
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gNgtZQhiprOo2TrLvf6uy2Qrml2+JBYx+MbPwu9vydE=;
        b=nit91+UY8GPAUJqw+6JdTJ/31X6d8JETrmyGr+4UzDTu19QnGAOYwZ1lFRp9oObTTT
         uVQkBnYjPsg7/oYFuiOCzxIIbN4zisGQcRB2f47Lx16dhK6zgF2OlSarp7oiS+3n6JU3
         xghZd9+B+PW2gdXS1W5b2+GtyiF+SeuqaZGepI0Ky9D5luHcgGCZRIpMRXRLCUCiT1am
         sfzMqhH8x3QXuV61gYBAKKN3x88KEu4D2FHm/XAbPF+oWP8ut0X+XazQiRri5OD20yPg
         e65YWnxOB7vK26wbxhZMPQdF/ZElm0S4aI/ZtdlkIZILz0PoUqSqyt5LZ+LuR0P+fDX7
         qZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gNgtZQhiprOo2TrLvf6uy2Qrml2+JBYx+MbPwu9vydE=;
        b=YzWsnzPjX+7c8n9n0Vo8lTpySmQr0ObT5nz5V9FvrKjjlHUIbquVj9Z/AUousABZHW
         ul2/lNDJdenRKc0OPPQZcpw87xTmJLpP6Wo4iT48gWM5Uv44GmbS8Xq9emuJwXBc0RMP
         WSZXNNtmaqCbD36BGVWC66ScKdCYrmKiVfCHFtro+HV7tT8d3p36ioBxdu6uNXyvTXna
         5ff8lgY4vmgmi26YMcCcSd8FA2EHW6mRyEVCsACWnBWNBdIcQ8EU4d+zUhJ8F8REzS1e
         egk2k7jjuykZ5IkReejZXwZ4cHl5qMgNEQbSLfuH7eeO/VzW/gppPDEEp1jcZtdKNw3a
         UBsA==
X-Gm-Message-State: ALoCoQl5BYcC7cppVjUzXBYczzeiaVr2eUGHRqNQjP/hKGX/usucLEor2EvKJJmTq0svk9jhwPZ7
X-Received: by 10.50.32.4 with SMTP id e4mr4071955igi.7.1402093761746;
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l7si751209vda.3.2014.06.06.15.29.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 7D3875A44F9;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 29491E0D74; Fri,  6 Jun 2014 15:29:20 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250974>

ref_transaction_create|delete|update has no need to modify the sha1
arguments passed to it so it should use const unsigned char* instead
of unsigned char*.

Some functions, such as fast_forward_to(), already have its old/new
sha1 arguments as consts. This function will at some point need to
use ref_transaction_update() in which case this change is required.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 7 ++++---
 refs.h | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 33541f4..a767ef6 100644
--- a/refs.c
+++ b/refs.c
@@ -3333,7 +3333,8 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3347,7 +3348,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
 
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3361,7 +3362,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
 
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
diff --git a/refs.h b/refs.h
index 306d833..b893838 100644
--- a/refs.h
+++ b/refs.h
@@ -237,7 +237,8 @@ struct ref_transaction *ref_transaction_begin(void);
  */
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
@@ -248,7 +249,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
  */
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags);
 
 /*
@@ -258,7 +259,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
  */
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
-- 
2.0.0.582.ge25c160
