From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 2/5] refs.c: make add_packed_ref return an error instead of calling die
Date: Thu, 31 Jul 2014 14:25:07 -0700
Message-ID: <1406841910-3278-3-git-send-email-sahlberg@google.com>
References: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:25:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCxr1-0000bc-81
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbaGaVZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:25:28 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:44435 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbaGaVZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:25:17 -0400
Received: by mail-oa0-f74.google.com with SMTP id eb12so961829oac.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ErQcWTWz0zintdd2ANsDOYoB8uLsAqxxz1vCKzfxL/Y=;
        b=LIOVpw9hdbg6QVhvgG9SkV6YXa2LTpOAItAbgPbrBHwwLrKHjBrzHeQvZx1SvXOcZh
         yHDQqkbxunvb/JqhFVfHY57f85C9+7RawGVIJ9Gdaqj0y+PbKAFy/A1TWg3WUX8xu9QL
         fTrZc79hevJ6vNCxFXmITpltPiJrkHcjdwImL3eL75BMzSKaEx82mugFp5U3ZmbIfREE
         1ust5dfVYcDcwUEfd1q6fSMbpWQspGp0qqmiE8pf4NPB0Lb1L8iAXpQXseSJFryc6cPa
         +C4F04OvRs56XSOyFocaa7MTHEA0jYSHv6x4gMK4FvZ/Df7zvfzc2QGaRCKmr2ABgRom
         lFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ErQcWTWz0zintdd2ANsDOYoB8uLsAqxxz1vCKzfxL/Y=;
        b=PoEkeMW8n3dvE+vaIhYb5wZQdbUZVR5k/4BYWFW503Ys2muC35wv478H6BV/F1ZZtT
         nR7zXnXhiCWswecV4ZQi/bwVj18bi7vFb25cn0KJG0DgW/htcYans0VPtqfVgKgGG0Ur
         v/m+YLLW5wl26whzgnqY58Blq9r3c+AEue+eu4P/OV5MnWwg34ypdnOIRITrTRtlC9Qe
         iwK2d1YEfI2EZaP0sotzoOPcttDqeF+WY9OL4cr0fvFmt7SVFJy7cjH1A8PGWlWUYkGP
         KG3FHCNVILyIOH1HEhe76DR0zFh9kQeuh0Su2BNSQiXXw6t6hHZHmK1UCPvxjo57EWGt
         cUeg==
X-Gm-Message-State: ALoCoQmPefkjQT9A0qs/7RAIzBhzRcIwbboaVm5scllEaRwyxHCINYf0RxzO0cRNjKbIvg7hB0xL
X-Received: by 10.42.16.69 with SMTP id o5mr970367ica.17.1406841916493;
        Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id gy6si51990igb.3.2014.07.31.14.25.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0E9AC5A4713;
	Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8B70AE075D; Thu, 31 Jul 2014 14:25:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g70700c9
In-Reply-To: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254606>

Change add_packed_ref to return an error instead of calling die().
Update all callers to check the return value of add_packed_ref.

We can also skip checking the refname format since this function is now
static and only called from the transaction code.
If we are updating a ref and the refname is bad then we fail the transaction
already in transaction_update_sha1().
For the ref deletion case the only caveat is that we would not want
to move the badly named ref into the packed refs file during transaction
commit. This again is not a problem since if the name is bad, then
resolve_ref_unsafe() will fail which protects us from calling add_packed_ref()
with the bad name.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 65eee72..0aad8c8 100644
--- a/refs.c
+++ b/refs.c
@@ -1135,17 +1135,16 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
-static void add_packed_ref(const char *refname, const unsigned char *sha1)
+static int add_packed_ref(const char *refname, const unsigned char *sha1)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
 
 	if (!packed_ref_cache->lock)
-		die("internal error: packed refs not locked");
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
-		die("Reference has invalid format: '%s'", refname);
+		return -1;
 	add_ref(get_packed_ref_dir(packed_ref_cache),
 		create_ref_entry(refname, sha1, REF_ISPACKED));
+	return 0;
 }
 
 /*
@@ -3666,7 +3665,13 @@ int transaction_commit(struct ref_transaction *transaction,
 					RESOLVE_REF_READING, NULL))
 			continue;
 
-		add_packed_ref(update->refname, sha1);
+		if (add_packed_ref(update->refname, sha1)) {
+			if (err)
+				strbuf_addf(err, "Failed to add %s to packed "
+					    "refs", update->refname);
+			ret = -1;
+			goto cleanup;
+		}
 		need_repack = 1;
 	}
 	if (need_repack) {
@@ -3778,7 +3783,13 @@ int transaction_commit(struct ref_transaction *transaction,
 
 		packed = get_packed_refs(&ref_cache);
 		remove_entry(packed, update->refname);
-		add_packed_ref(update->refname, update->new_sha1);
+		if (add_packed_ref(update->refname, update->new_sha1)) {
+			if (err)
+				strbuf_addf(err, "Failed to add %s to packed "
+					    "refs", update->refname);
+			ret = -1;
+			goto cleanup;
+		}
 		need_repack = 1;
 
 		try_remove_empty_parents((char *)update->refname);
-- 
2.0.1.523.g70700c9
