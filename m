From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 01/27] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Mon, 28 Apr 2014 15:54:16 -0700
Message-ID: <1398725682-30782-2-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:54:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuRq-0005VH-Ex
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbaD1Wyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:54:49 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:45084 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbaD1Wyq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:46 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so570065vcb.4
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TKO3kRo72QPUxa4IVHtUAQIhJweEYPLPlZcfi+CCgrw=;
        b=cp8i3vvK6ZCCfib6Oo2UKDasmLRqGU4EEOoA7yWfuu3nmgtmigSKi5uEXSm0hMQUUK
         CIjAaDfvl89MY40AnCHgeDqKUAWv83CmVmKoCOi8BpdFv7GwEhHprw4aG9MGmrgG/kTK
         gV1DO//rNL3esBzDxqNUcO04vgLWLVbkP2blvOFghXGaDHSQZmS8Cecs1+kdpf+9nSma
         Ygox9h8+SCrpTPp0VGLj2XlgA3mGT3o7Yh8JYKOeMBqBUmOThmB0qqcwVe9ZD6N3Y5Yu
         PBVM2Xg0V6H5tvsRg+aGo6KEQXRrZywvgBu/tdq9TcOVJjNFaHPeppG00AY9XKjDhOil
         5JBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TKO3kRo72QPUxa4IVHtUAQIhJweEYPLPlZcfi+CCgrw=;
        b=FRMA0kyBBoN0hB2Su7P3JIjGXbf7C9kFhfEpuZQOovYniNW/efBfP4aIYV7o2F2R+F
         gGF/bfCO8hMqRHP9SQmYTVUd2iqYdhmK0w7eO1ZkWhavgOPEpieNXQb583w02H4Q0u+B
         wqPjlQEwTEup3JyhmBzsv/MaVNXxUaDxL2eGdjNjT+VQvxHwSqjUgXVokHN+dcVVSBf9
         Zw5PjrRXoKH4K3+LxE300KKwxyCqHliM6uPdVZpQeHkdZoC94sK/a95KzE15dqQL25kg
         cEIb0Qs+y9gwz9PsMRk1VGc9w+xmCg5O+U5hzZR3S7AdOrhq9Sj7NVjUUrJ8YHWgCVvx
         HQqg==
X-Gm-Message-State: ALoCoQmGd5qme73LCDuNBs2b3BpyKewrOpoF7u2eBX5FPa5PzC7S7VjCVC8LUAraHftm+5KLhCqQWXK1bctCCqXoZZuzb4ALDKp4bzLyRRLPSPyRpRqM4F/Y7mIxOilY1/e/BSdq9RGHssEoWwAZULQenkOLXLD06imLyZVjY2tu9+qPctgQ+g6Wy38poYfBEVwkEMgewqo9
X-Received: by 10.58.22.166 with SMTP id e6mr14830228vef.6.1398725685674;
        Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1424518yhl.7.2014.04.28.15.54.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 749F431C224;
	Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E5784E08C1; Mon, 28 Apr 2014 15:54:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247462>

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
1.9.1.528.g98b8868.dirty
