From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 01/44] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Fri, 16 May 2014 10:36:49 -0700
Message-ID: <1400261852-31303-2-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:40:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6w-0003E3-KS
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155AbaEPRjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:51 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:50234 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756937AbaEPRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: by mail-yk0-f202.google.com with SMTP id 9so163427ykp.3
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fiYSqXy6J6dgGzck4mYrvwbbjd1eND1pQKTuTi1QVC4=;
        b=lFprBL0HblHbvOe2g9C1U+ReaZluCnFiN8PxjvLPuPJH43GcvhCfDgeqeMJThkAFG9
         VtIOAo2ZQnWqq1IFcbfajRDwXARVJkFyriSbvX2ktR4QsbLc5ksOG6gPt2jY2e8pLpe+
         jWrhZgCUzPte/0YK3jSFC6Pi65Fmk7L/0icX1BsQQEuLgKMYn+3d3WCF07ztX++iGejh
         XDvvOwVOihIE/hxG7fsuxej2CQX90q8hNAoLHIDjCkO17zobR+RRJ8buu1YOYMJkivTb
         d26+W5aHK911XT/uEF09CqRPziEASVBZ9p7zBmdy44Ogni8KqoWAyqgoTd01auy0Gcig
         iHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fiYSqXy6J6dgGzck4mYrvwbbjd1eND1pQKTuTi1QVC4=;
        b=MWWi5rM0QhSgEORq8ZdwY38WLTvx5rUrILoEwjJXiqJPHONY5uKHsMUpgkRF0SeH3L
         oAZVA4Rj5a+7hzcBvVjmnXROY4y9IsLu80fzmLQoI1a7HNX/2i6s/1QVWYe3enDZxCOM
         yT7ioAeuyCjTkCNEugf+SBR3n6YJuUlypx+neWUpgEDpDdB2ZDz5xYdCrnSuNVZNcpqS
         75MAJLzpfpUxS2Gml9kDzsF4Fsy4ujW7UCT0H3Ir5GuMcRLJktrZGVXs23o5MyMhqLoJ
         iftsmnC24ysKxlGA7oN0vXci2RgG4BSQWC25gLGmdlPkhO2SMKAi9waJ7nrWrqq/R+ww
         CI/w==
X-Gm-Message-State: ALoCoQnAvMCsGZw1DQIJXKQz1oxNQIZZjkjUGH+viTRHREAjHeC/aO2bgFPjgZyE2C0MP0xONlv9
X-Received: by 10.58.155.3 with SMTP id vs3mr8747405veb.16.1400261856801;
        Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si441214yhl.7.2014.05.16.10.37.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A2FE131C273;
	Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 49C2DE0C3A; Fri, 16 May 2014 10:37:35 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249391>

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
index 48573e3..3b7e604 100644
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
index a07a5d0..50ca06a 100644
--- a/refs.h
+++ b/refs.h
@@ -238,7 +238,8 @@ struct ref_transaction *ref_transaction_begin(void);
  */
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
@@ -249,7 +250,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
  */
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags);
 
 /*
@@ -259,7 +260,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
  */
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
-- 
2.0.0.rc3.510.g20c254b
