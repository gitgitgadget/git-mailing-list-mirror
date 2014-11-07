From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 14/16] refs.c: make add_packed_ref return an error instead of calling die
Date: Fri,  7 Nov 2014 11:39:03 -0800
Message-ID: <1415389145-6391-15-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:49:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpX0-0005Wg-93
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbaKGTtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:49:10 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:55659 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbaKGTtH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:49:07 -0500
Received: by mail-oi0-f74.google.com with SMTP id u20so546308oif.1
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TXqIUKvmucyaP7Tk/k7xaT80Pl46tcfI4Iq1aLlllcg=;
        b=onA1muHe0+QRaf6PYPGiCcdSS8lzRMOGd6zej8SRGd/FPdyo1lp9pROmObK769U/FO
         P2IswShOuh4/MasuTYstFoO4hpOiib138Ch0YHCR3NG7WiFzwChCn5tGJ5PPImmxJvwz
         N6LZLjFx4y86Pcim7k7uNYS46x277OXLEqpuWQNMQVBzMdSYZwHoq0QDZh5X67bX8zX2
         z9Cc+4N//2ZvvWOyW0Q9Z3w71uK5WX2Oe7UM3+WxWl/qzaB95/U0p/ZzPLeIsGSjKH2/
         tRCiDTz2oGeNP0SDQXybS5Hp3obC8cYfsOYRSeP4HOZsHpQtUnYq0SidNvxLPz0KITKK
         rqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TXqIUKvmucyaP7Tk/k7xaT80Pl46tcfI4Iq1aLlllcg=;
        b=GkNxYujmd55msUD9NqTINki3NlvSmmXjXhCxrryaTODOFuFPNGYty2NNcfxM+toI5T
         0ppyXBOzSq9dAAimLWSD2mGjovU4bQZ/916r9mNXPI4LjcIBsFb+bxpxek8POvM5nxbT
         QiSi6OARfXH5JFkeOizC21Xomu8dGSo1ZEJS0c6TD5F7kzsAUQk6/52ptNilGiDU23iI
         51588KH3jfYyMQgkM1evJIOLsStRTmQ6fnaHTSmU0EDUuJ+BchaTodrDW84iPfDczcKW
         H9WmzzAOE7tvnJc32XrCgvUK5eVVnlQfLBL2zCSXbf39EZrljw2/Fa8yxUt11rBL+m6+
         j9PA==
X-Gm-Message-State: ALoCoQlPaloZHQw2zGZWc/aXCjE0lfyu59YKqkPf84Tg7L5Yowsef0yNVdTsdC4X3y7LVJ7vdiDV
X-Received: by 10.42.10.132 with SMTP id q4mr16442197icq.25.1415389746720;
        Fri, 07 Nov 2014 11:49:06 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id 5si403282yhd.6.2014.11.07.11.49.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:49:06 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id RhO4CP0s.1; Fri, 07 Nov 2014 11:49:06 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 04E91E0D7C; Fri,  7 Nov 2014 11:39:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change add_packed_ref to return an error instead of calling die().
Update all callers to check the return value of add_packed_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index b59e2b8..0829c55 100644
--- a/refs.c
+++ b/refs.c
@@ -1229,15 +1229,16 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
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
@@ -3827,7 +3828,13 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3941,7 +3948,13 @@ int transaction_commit(struct transaction *transaction,
 
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
