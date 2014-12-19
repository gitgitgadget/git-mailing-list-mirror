From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/7] send-pack: Rename ref_update_to_be_sent to check_to_send_update
Date: Fri, 19 Dec 2014 11:38:56 -0800
Message-ID: <1419017941-7090-3-git-send-email-sbeller@google.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Dec 19 20:39:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y23OR-0005Zt-Vf
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 20:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbaLSTjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 14:39:17 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:52352 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbaLSTjP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 14:39:15 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so1328787iec.29
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 11:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mo6cp/ShfK7p9Uw4p/IYZj1M1G2m+kXnDwcJISvhbDQ=;
        b=aBAnXuNMHZdN3vqYxzyh/neak7qnvDmM+9tshW6xGqJGh88CDyKU09zwx4ePuBFQsM
         wyGKl26jClylAWsxqAuc8Q+t70t307OJvEv0W8H8dT/BbKWV6u/x6Jwetu+TS0fDUSpx
         5NAP7UtTo0+b3lw6ED71kX8OgteIvnwbd04n3aMn1qC//nIvW+kwbuKMhs/a2Lx/FE/U
         uLJbl9D191KJmMKX9AQ766eE6+Kv3Sq2PnlQmGSBCoXga8w5O7solyed8On3b55mcqQs
         ZauT1xJTWrplv/mIpHF16XS9d71SxT+hZwVxfNSrjOxHwsPEvU1UjCxA2TBdO0hYs+cP
         b4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mo6cp/ShfK7p9Uw4p/IYZj1M1G2m+kXnDwcJISvhbDQ=;
        b=CmxNAab1ZQDWVF7X3ikYC2ZV+F5ts3kKBOEU7IzDaUW+Hjqf0QdBVzDUm4tLD+GqIZ
         +8gPm0yRQsmP0X925u2QS9gOcHvRDi60hLekFBu4mvWh4r43KrqfxF4H7a8GNuIJV+Ud
         hJ4A5zlYtanwwN+dVO8L7/3PituKImhQiqFeV7PXqWSBCyMnruhrWTldm21VbvS423LN
         e6HQLLpV/xD98HuTWv0XjDrTPl9yQxd2uQhRZCr4urffYSzlV35nYOEGcTMbYMxRqk9K
         rca2dlKh/JMKJz/BeT7hl6Ysqz+55oNiU/AUFMPXdu12cISSiavhU/dO0WzhLike4/W3
         aE3A==
X-Gm-Message-State: ALoCoQl1GBS4JOhJ5kOSaWEEWmb/P+gCr0m7tK33AB6PXVf6t15iM/MAxrcZiJrwq1kj7k/Y1UsY
X-Received: by 10.50.127.146 with SMTP id ng18mr4781999igb.17.1419017954517;
        Fri, 19 Dec 2014 11:39:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5827:d4a2:8bd5:ac5d])
        by mx.google.com with ESMTPSA id qj3sm1284852igc.17.2014.12.19.11.39.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 11:39:13 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419017941-7090-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261588>

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

 send-pack.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 6646600..465e6fb 100644
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
