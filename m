From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 6/9] send-pack: rename ref_update_to_be_sent to check_to_send_update
Date: Tue, 30 Dec 2014 15:41:35 -0800
Message-ID: <1419982898-23108-7-git-send-email-sbeller@google.com>
References: <1419982898-23108-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, ronniesahlberg@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 31 00:42:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y66QY-00086C-OM
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 00:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbaL3Xlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 18:41:55 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34342 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbaL3Xlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 18:41:53 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so13790979iec.5
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 15:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mmUBHbwaUXwfo0GCtSnhdamwk+yGpLtPsuUnUzXPbr8=;
        b=Al6seHvrVQeI9UgWGOV66cd34SqpdpqM+FblkrERKx8Ka1B/sSXzskYk3g4P7erXU5
         dCjztAa+o2RzPDcg82YS9UuAizQyV2vl+xO8EQSCMRC8WpU9ugDzjeC2YDTykd0khZ7v
         5jShNxFw2uPf0S7HakHwDrCPjMf2cJwMyVhDxIvljxW/Cf1Uly3OW2Z06fwrSxn40bPY
         X1sOcVKcSZ6rBYFJeCNn1BgB9Bh0HKDQ9uWwVWm6us4mvzDTCYJeTKLjFKHBkQq7vBZU
         bZ/4fRfQWYogMoH55fJHqZaspa5p0vroSfwidqjq9I2zGLfnOnP4Bl0QH6P/ba+uBhBc
         I+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mmUBHbwaUXwfo0GCtSnhdamwk+yGpLtPsuUnUzXPbr8=;
        b=eJ/3xnBArZ0Jp0PElHiChnMSgrdfsdeUnzKEdfLmeY5BwqEQ0BUeyCv3u7xuECuIC1
         pHqFlyJiDhwaOOCDUpJrQfhlcYjeJC+PmYWd88oqqG+BQ9DWecn79mzJ0BqjUSO8Ixb5
         ZvXinf10O9t2R6CeaYZ2KTwXRs7mJ+F8cgCPu21w+988CQ+g2ozikerwIz9KEqhffAWQ
         VW8GKkBOUsW/iQq6KZ9LwxU8QwSi22odHBhEX6OXh67CgOlHIZFYoBp9+bxZ69wuULh0
         sGg7nmCbfFYLofKAEp8YZXE9ipzi7C1V3XyYL/J3m9K47uOu6gIagS1Ki6Oyj8zJXs7m
         NB1Q==
X-Gm-Message-State: ALoCoQk29tGLGTghxrRfvbCzfVHHCr0esY6k2a8OW9j/nGRUHJUIJ4PU/2+KbzrvuAROmmAqy4/w
X-Received: by 10.50.79.200 with SMTP id l8mr23752481igx.14.1419982912345;
        Tue, 30 Dec 2014 15:41:52 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e545:220a:6cf6:2fed])
        by mx.google.com with ESMTPSA id la3sm16279847igb.0.2014.12.30.15.41.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Dec 2014 15:41:51 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419982898-23108-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261960>

This renames ref_update_to_be_sent to check_to_send_update and inverts
the meaning of the return value. Having the return value inverted we
can have different values for the error codes. This is useful in a
later patch when we want to know if we hit the CHECK_REF_STATUS_REJECTED
case.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v7, v8, v9:
    * no changes
    
    v6:
    * negative #define'd values
    
    skipped v4 v5
    
    This was introduced with the [PATCHv2] series.
    Changes v2 -> v3:
    
    * Rename to check_to_send_update
    * Negative error values.
    * errors values are #define'd and not raw numbers.

 send-pack.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 949cb61..4974825 100644
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
@@ -359,7 +363,7 @@ int send_pack(struct send_pack_args *args,
 	 * the pack data.
 	 */
 	for (ref = remote_refs; ref; ref = ref->next) {
-		if (!ref_update_to_be_sent(ref, args))
+		if (check_to_send_update(ref, args) < 0)
 			continue;
 
 		if (!ref->deletion)
@@ -380,7 +384,7 @@ int send_pack(struct send_pack_args *args,
 		if (args->dry_run || args->push_cert)
 			continue;
 
-		if (!ref_update_to_be_sent(ref, args))
+		if (check_to_send_update(ref, args) < 0)
 			continue;
 
 		old_hex = sha1_to_hex(ref->old_sha1);
-- 
2.2.1.62.g3f15098
