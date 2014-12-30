From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 2/9] send-pack: rename ref_update_to_be_sent to check_to_send_update
Date: Mon, 29 Dec 2014 18:36:40 -0800
Message-ID: <1419907007-19387-3-git-send-email-sbeller@google.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Dec 30 03:37:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5mgM-0001pL-Ol
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 03:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbaL3ChJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 21:37:09 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:48646 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbaL3ChF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 21:37:05 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so13027676ier.32
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 18:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hee6X8Ahmay1UFjpm9qmsPRAt/tMAL5XewzbmlYAM/s=;
        b=J52AGET0CRNsQSe6nm8cgxOMlW972EBhifW4pcwUxWBYw8PpLrlxNHvyLJRZhNCW3k
         /dSzS4+kyyF6STjmAXbJsZNkx9NDo+EzwThfIZzzux5t4mSmzYu7L9Kkq5RyHLJenGR8
         efiUTGi2NITyoAm33/Y5r9tsBoxZLZ8gl1K56e4bx4CYvjCTQogyX5lOuKPJW50xd3yG
         5LNr/CxNDPnsbbFwhE5xhx0aZ1ioUBts0akDOsldoWleCFFehd6kWVPhmTQyfd0C7D1C
         RZIt2oM6D+Hgs1gxMrOBwfNATk8VQTsR8F+TDDFBpbKC1bEuHXRWJCocyKxO0F8tXwoX
         Dybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hee6X8Ahmay1UFjpm9qmsPRAt/tMAL5XewzbmlYAM/s=;
        b=YjLVYmxH8V7HloO/quRtivc7XoU6FTlobtI2QMCHxtmQQ6ypNRhmFqlKJiu1CtSPjN
         Mh/MylTZh4oQ568HQZAVEZVGRSqmTriflDbDkjZYBBDJw0oqEFuqTjhq4KCrlIljAFRA
         32IBPaoiSiuaSNjbarnuiIFY/UHPmhoxuiE1JdztIO35iGzwTIgpiL3zPRVgS6oXEWcZ
         Oms1Z60dLVq70dkw48M/iLkB3Dcu1/gzsKaogbYhUQk8YygC3X8/lrDbosS5plx4LJCU
         Njv2+rVGEdvckN6p9Tv3Hx1Xn9EOZHDbobqSWZtNPVbTdvbBQ4o42V4r/RpokeFuVdyo
         958g==
X-Gm-Message-State: ALoCoQno0hEvgsQAeYW1QGaiF7sAj3VtThtEz4EWDynmPRdhZsgYxbrYDmRtGiYLckBep/jvm/as
X-Received: by 10.42.72.138 with SMTP id o10mr43564220icj.73.1419907024635;
        Mon, 29 Dec 2014 18:37:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id e63sm18505685ioe.15.2014.12.29.18.37.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 18:37:04 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419907007-19387-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261902>

This renames ref_update_to_be_sent to check_to_send_update and inverts
the meaning of the return value. Having the return value inverted we
can have different values for the error codes. This is useful in a
later patch when we want to know if we hit the CHECK_REF_STATUS_REJECTED
case.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    This was introduced with the [PATCHv2] series.
    Changes v2 -> v3:
    
    * Rename to check_to_send_update
    * Negative error values.
    * errors values are #define'd and not raw numbers.
    
    skipped v4 v5
    
    v6:
    * negative #define'd values
    
    v7, v8:
    * no changes

 send-pack.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 6d0c159..b7d8e01 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -190,10 +190,13 @@ static void advertise_shallow_grafts_buf(struct strbuf *sb)
 	for_each_commit_graft(advertise_shallow_grafts_cb, sb);
 }
 
-static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_args *args)
+#define CHECK_REF_NO_PUSH -1
+#define CHECK_REF_STATUS_REJECTED -2
+#define CHECK_REF_UPTODATE -3
+static int check_to_send_update(const struct ref *ref, const struct send_pack_args *args)
 {
 	if (!ref->peer_ref && !args->send_mirror)
-		return 0;
+		return CHECK_REF_NO_PUSH;
 
 	/* Check for statuses set by set_ref_status_for_push() */
 	switch (ref->status) {
@@ -203,10 +206,11 @@ static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_a
 	case REF_STATUS_REJECT_NEEDS_FORCE:
 	case REF_STATUS_REJECT_STALE:
 	case REF_STATUS_REJECT_NODELETE:
+		return CHECK_REF_STATUS_REJECTED;
 	case REF_STATUS_UPTODATE:
-		return 0;
+		return CHECK_REF_UPTODATE;
 	default:
-		return 1;
+		return 0;
 	}
 }
 
@@ -250,7 +254,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 	strbuf_addstr(&cert, "\n");
 
 	for (ref = remote_refs; ref; ref = ref->next) {
-		if (!ref_update_to_be_sent(ref, args))
+		if (check_to_send_update(ref, args) < 0)
 			continue;
 		update_seen = 1;
 		strbuf_addf(&cert, "%s %s %s\n",
@@ -369,7 +373,7 @@ int send_pack(struct send_pack_args *args,
 	 * the pack data.
 	 */
 	for (ref = remote_refs; ref; ref = ref->next) {
-		if (!ref_update_to_be_sent(ref, args))
+		if (check_to_send_update(ref, args) < 0)
 			continue;
 
 		if (!ref->deletion)
@@ -390,7 +394,7 @@ int send_pack(struct send_pack_args *args,
 		if (args->dry_run || args->push_cert)
 			continue;
 
-		if (!ref_update_to_be_sent(ref, args))
+		if (check_to_send_update(ref, args) < 0)
 			continue;
 
 		old_hex = sha1_to_hex(ref->old_sha1);
-- 
2.2.1.62.g3f15098
