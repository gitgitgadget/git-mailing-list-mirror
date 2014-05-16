From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 32/44] refs.c: remove the update_ref_write function
Date: Fri, 16 May 2014 10:37:20 -0700
Message-ID: <1400261852-31303-33-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:39:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM66-0001Ks-Tp
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758129AbaEPRis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:48 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:57155 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757953AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so885228vcb.2
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z9JEZHoVfdfiD4Mk/zk+ZPWTRjdNFD8cGDTUdk7/CtA=;
        b=p1ZRZAwP56ZT4kKsqiqKN4P6gtA2qMA6bYwshVwbduhLu9OHuy01ydm70O/17hflSn
         GidgZjGbaJ9cxwXlQFnhNZ/YwKvyWB8cWNtqnAvsouU2ENBjvOIJEZWxEvKT25OQWtXs
         wC32hJlMyv+Lr74fWzXVaZqG2n5lWWqMei8M4He2M0IXioccGfyNWDxtWyIwamO4F0zP
         LJTAzhZjB3J1/lJqM0IFCgLCxkupg3Ih4RKUOUjRrgCDstou9MEutAuswoNOctLqdQ5S
         u8fwiXuaHTqH2SkG+jwCoNaZPzZlwjhUJdGwwhIjMW2q8Akij+FdsuOVniigjxY3Oj0s
         tPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z9JEZHoVfdfiD4Mk/zk+ZPWTRjdNFD8cGDTUdk7/CtA=;
        b=lRydamzFjV85OXdzTz4EfCQM95E1b/5e7DV4tknKaqspx7aEtaP51DDc+RVndmnbAZ
         8SixKO9n9D9mbSvaXjpZv3DyyllwIlRt85xuJeKJiUpEhjWLr1D0c1T5qY0H2NOW1vEG
         D5R68s8jHMzN12h/2q2nUHfgKQG6m9UnWNPTj5I4kgQhq6D+yDwMvR0zP2u8MyH5Q6wo
         85HyayM99gM9yAQhuF2fY/YJEdLrEVGtmBtwEHHgXTZ2mTZGHjxVfH1ryp7w7HoR8o5b
         96M9A1YoNOyqmJ6I2YDNWVO48qNFXhXmlnzsxHgzKCJ0isZMzmZWLVrNEXJ/WhpykXR3
         b+8Q==
X-Gm-Message-State: ALoCoQn0umVdFycFV+zaYwsN6nmbXlQ/aQvNAyOpscpi0/iUFGG3R3FvtQ8mKQstqh33N90hXqxN
X-Received: by 10.236.134.49 with SMTP id r37mr7540512yhi.14.1400261858295;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n43si191480yhe.1.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 2B19E5A40F6;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 07352E0A04; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249377>

Since we only call update_ref_write from a single place and we only call it
with onerr==QUIET_ON_ERR we can just as well get rid of it and just call
write_ref_sha1 directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 04de777..b1acf51 100644
--- a/refs.c
+++ b/refs.c
@@ -3283,25 +3283,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-static int update_ref_write(const char *action, const char *refname,
-			    const unsigned char *sha1, struct ref_lock *lock,
-			    struct strbuf *err, enum action_on_err onerr)
-{
-	if (write_ref_sha1(lock, sha1, action) < 0) {
-		const char *str = "Cannot update the ref '%s'.";
-		if (err)
-			strbuf_addf(err, str, refname);
-
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
-		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
-		case UPDATE_REFS_QUIET_ON_ERR: break;
-		}
-		return 1;
-	}
-	return 0;
-}
-
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3539,14 +3520,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			ret = update_ref_write(msg,
-					       update->refname,
-					       update->new_sha1,
-					       update->lock, err,
-					       UPDATE_REFS_QUIET_ON_ERR);
-			update->lock = NULL; /* freed by update_ref_write */
-			if (ret)
+			ret = write_ref_sha1(update->lock, update->new_sha1,
+					     msg);
+			update->lock = NULL; /* freed by write_ref_sha1 */
+			if (ret) {
+				const char *str = "Cannot update the ref '%s'.";
+
+				if (err)
+					strbuf_addf(err, str, update->refname);
 				goto cleanup;
+			}
 		}
 	}
 
-- 
2.0.0.rc3.510.g20c254b
