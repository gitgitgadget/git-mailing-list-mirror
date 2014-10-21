From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 13/15] refs.c: make add_packed_ref return an error instead of calling die
Date: Tue, 21 Oct 2014 13:36:58 -0700
Message-ID: <1413923820-14457-14-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:37:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggBo-000100-8u
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933293AbaJUUhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:37:32 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:35703 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933166AbaJUUhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:37:05 -0400
Received: by mail-oi0-f74.google.com with SMTP id v63so304912oia.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OLNm/cFW3AHnoVhWlj1KF6CCU9UmImiAd3CqLh5jInY=;
        b=exU4bU1Y+F4vgH8eZXXZTMy+//LZWN80MwEz2NAmWekES7VrXC8CuKck3PEuEmpmYu
         PDS9P3Qf+bwJmK1SaE/2x4kxn5qMDkzagwrThzzATPwitKgYD70JqOoQf+HurU1ymgp7
         olmc+smtUX527X0ZIayKu2JmvISQ1xmImpvzNGK4fd5tGbPcA5pzB/CPi85rTMGgOomE
         rqZHIyYuHXUWPedWRWAWsKa85tDyoWuVF/xHrwjJACQmD0ZeV2hbn0gmykOlf2Zjqq9P
         WsLR2B3NH3hxyu8o9nKhTyN32iNfo/2yfp1MZBJtMvXxya/HCCTXwIN43jNBn+OS/O8k
         ulBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OLNm/cFW3AHnoVhWlj1KF6CCU9UmImiAd3CqLh5jInY=;
        b=Vn1XV/tLK0ZSDeqmhj6KE/pPOP8mfx1aloR2JslVYNR9uShZiIxmDb1lrahPDAm4xN
         EunuW0H0zCABR3iTJKq6tRapO4ru8LxKy6ys4Sky52SGtYERmMW+POX1pRT3hUfQgosm
         jcBXme9pJ4taUkfiyZ8D7UiBWmZQ2qRzjtIxcH4UNt2hGsJc0mGuQ32HfKPLGOlOfBxX
         1Jk7eOMjOLHIcizFMUdH1Q9uyPrPhaJrTbDmW9bQuae0ArOSl99gg45XjGJuXO62v09z
         2YDQox/3SwUjiTRaTBanTQvUrABDTU5Oi2n0i81l6L/kP0JUy5DSvit70DPAI5w0spiw
         l42Q==
X-Gm-Message-State: ALoCoQkA9L+xdImPHnPdDSYehwoIhbEssHfVjmyTnknl4NkcSEJ9zFDO7vwWWe0hDp82EB6rRpRS
X-Received: by 10.42.197.134 with SMTP id ek6mr486703icb.6.1413923824366;
        Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n24si593314yha.6.2014.10.21.13.37.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:37:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id vvx9HeiN.2; Tue, 21 Oct 2014 13:37:04 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 47828E0BD6; Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change add_packed_ref to return an error instead of calling die().
Update all callers to check the return value of add_packed_ref.

Change-Id: I5d5e4a75f641c4bbdb59199a233b71e86361c25c
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index c7d0825..e0d5a82 100644
--- a/refs.c
+++ b/refs.c
@@ -1224,15 +1224,16 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
-static void add_packed_ref(const char *refname, const unsigned char *sha1)
+static int add_packed_ref(const char *refname, const unsigned char *sha1)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
 
 	if (!packed_ref_cache->lock)
-		die("internal error: packed refs not locked");
+		return -1;
 	add_ref(get_packed_ref_dir(packed_ref_cache),
 		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
+	return 0;
 }
 
 /*
@@ -3795,7 +3796,13 @@ int transaction_commit(struct transaction *transaction,
 					sha1, NULL))
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
@@ -3909,7 +3916,13 @@ int transaction_commit(struct transaction *transaction,
 
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
2.1.0.rc2.206.gedb03e5
