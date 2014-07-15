From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 17/20] refs.c: remove the update_ref_write function
Date: Tue, 15 Jul 2014 16:34:15 -0700
Message-ID: <1405467258-24102-18-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:35:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFQ-0003Pj-QY
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934363AbaGOXe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:34:58 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:35308 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934325AbaGOXe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:26 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so35006ieb.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6nNs5aWMN/7FxU7hgmoQaCpGyDT1xnFmEAoymEa2Kyw=;
        b=pwS0nSjzzu/DSwBFgmlZmaqWb/HqB7u8QVQYEOoUKuGvIvQ4zn5LvogMr6GZz5nhGV
         Jhmj+hIU7sA6nTTQF4zPhW9dCzZQaalclq7HrMntuPt0WmDxvFap29BOzLkYiF7HlK88
         Wpfvcqc7O4AUa8eTXK7gvE0TP4hHKau9iImg+PAsr+L92uWvwL3ftBIrHocaMRZQ5UbF
         r3+NI/0uOzwIzmzOZQznqGAZGO8gNF9ZX5eybgOHlz3DR/NwZ/vYpKdW756peXKOrHvv
         xl9dYEXcHF/pj/F+G9FYgG+kgI3YklDrZymeyLG8KqCk7huO9vyrtab9a/i1hbwQzpgo
         Ev/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6nNs5aWMN/7FxU7hgmoQaCpGyDT1xnFmEAoymEa2Kyw=;
        b=K3Oj2IcQHA6Uni8KUtQ14Gd0S2ejVdOJ47hN5Ivzaddw8l7i6yz7YEkkT2IKHjNDRn
         6a/6gHR0f5F6/fLNcOq9mTquFO04T7i6+D1i3EABcpI946DeNr8WAZfKZU9vgXP9hFC4
         ee250z3MtlcjOnnsvNEI3K7P3OCznlIeclJuJiFGhnE+BF5ZxXxHi69WEZ60wtilSJh7
         Wz/OqPZQxVxrnaQuO+u495vEQxr4GkZCRoMVHcnEJ5ueH2bBrzppqQ2t9tcgkE3U8pV2
         eVyu1YxiqISvF1V5UOBzWqob8p+aAEYL28amlvcV4kOMMGjPpbct/TM/KubwOh/QfqXr
         yliw==
X-Gm-Message-State: ALoCoQlHnCl49WX5SaJkXT7lfoF9reUPKtIaD8eNHx5yZ4io7zQR97gmMYoDcRC8Yezb7ERdYIpq
X-Received: by 10.182.241.169 with SMTP id wj9mr12869497obc.14.1405467265046;
        Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si1059804yhh.5.2014.07.15.16.34.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:25 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DFE4B5A428F;
	Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B5D21E0C21; Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253629>

Since we only call update_ref_write from a single place and we only call it
with onerr==QUIET_ON_ERR we can just as well get rid of it and just call
write_ref_sha1 directly. This changes the return status for _commit from
1 to -1 on failures when writing to the ref. Eventually we will want
_commit to start returning more detailed error conditions than the current
simple success/failure. For example if the commit failed due to name
conflicts etc.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 091c343..27c629f 100644
--- a/refs.c
+++ b/refs.c
@@ -3333,25 +3333,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3604,14 +3585,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.1.442.g7fe6834.dirty
