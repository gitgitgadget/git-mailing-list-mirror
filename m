From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 01/19] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Fri, 25 Apr 2014 09:14:36 -0700
Message-ID: <1398442494-23438-2-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:20:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdirk-0006tl-Ll
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbaDYQUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:20:38 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:57943 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbaDYQUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:20:35 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so494459qcv.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x1OOeKTGaNZPYVImDzZhfErcMJq0ZiAOkq8yr3cgCwY=;
        b=hIJI32wgM/GSXZEcSgjUlHF6fpFtSHscWMuLO6w2O4LRl4GAtovfw2CYv9fbnkTM6G
         wvPiAlKznRmzDx8C9iqZYx49idgJ5WoZMJNC1nNf/EvKsPaOAmFqXfL/s2ZPPt9YHseL
         rFWpkvK5puzuEnbD94gh1+Bq/xfLKejEz8TZlF6tfu3WLMqB0+vBkskLNfudyppJMMYL
         wdI7tEiXkAjTItiLbwfs5NXCZVTVrwTSW7LmBK23gj8njXbVC7L96gC6IcHGziK9Lu/7
         rhPUrFEn13eY3uA+NFp5vphgXFZw+l1DIKgugKXJSBvGBP1/gMmLLz5+wr5eKytyqHiE
         vwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x1OOeKTGaNZPYVImDzZhfErcMJq0ZiAOkq8yr3cgCwY=;
        b=BZOFFhBCK0rhJCoTYZeTnUqTe2cTKorxeMZNOrc+Dc7o7Ze5U6aCPHlbTTLCmnVqHg
         nnYRF0Su/MZrd5Itz3OwDfL8uw0iQXmUehBRWenD5sYlHoXYwNeqADJB7O5u2+ooSstp
         Yqhiy/zK0zXT90TdmYVgXqwipxXh8gfkETfUrAuXGsBxDwB0DJG+fdnKX0K2UX3XsqZZ
         YckX+WWtU5svHZdmMp68/0481tr5e6cknxyzLrTa4gE60LeZ86j2T5FBUsuMDg/HjgWU
         EV+Fm3cRcpBjb3mB8xyu9n2Kj4i0Sj+dCYGmcGBtHlo1AykFGd07D2T66A+qi36//DI8
         rEuQ==
X-Gm-Message-State: ALoCoQnHInSs79IifDqGlJjn/Ic6xYrz0VqbEK0eKnKdxAQHfJIbK0lMojl9bpL+MyLXdj0wMTj3AqwqJrbi6KfkmckO1LjelDp8TL29j3f8M1CM66Z4CKMJJjmV/r13vnvX9qr913PZMzwulNeFOJLLH1k8VBmfaCFkrXPreg4XBR9KKoJleoHDjjSLvaaV2wQbFytXAHOZ
X-Received: by 10.236.25.175 with SMTP id z35mr4294177yhz.32.1398442498290;
        Fri, 25 Apr 2014 09:14:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si1051054yhe.3.2014.04.25.09.14.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:14:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2598131C028;
	Fri, 25 Apr 2014 09:14:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BDC7FE0855; Fri, 25 Apr 2014 09:14:57 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247069>

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
1.9.1.521.g5dc89fa
