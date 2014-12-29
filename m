From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 2/9] send-pack: Rename ref_update_to_be_sent to check_to_send_update
Date: Mon, 29 Dec 2014 13:35:08 -0800
Message-ID: <1419888915-31760-3-git-send-email-sbeller@google.com>
References: <1419888915-31760-1-git-send-email-sbeller@google.com>
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 22:35:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5hyO-0001Yf-3u
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbaL2Vf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 16:35:26 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:48819 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbaL2VfX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:35:23 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so12835736ier.14
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 13:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PZAHji6u98ddmJyqxzeg5PuRU3/flqKsHAB8rbtpTK0=;
        b=JeMaHtx6h18NNUmVK5hQUdIpbVDcgih4ck12Y2ElfkqyxlMX4mpU7BnaXXk71mxNBT
         RppsTK3phJb6+e8x59QeSGiVr9j4IYm4aTSGDcksirich64nI5VBmn6I5XW+UqwCl7zb
         +nQDQU1Y5iPK4T8bizB+vcRpgNAwg09z86/JDwclkvparpg4Pa6ZeaTkdbnWbe69U7tH
         gyPsP5xaCh0886CTyZXQ1qZJ3z3Sez6dJ5fPQwcGu5hovrabPuU+eD7xqcaNBiDh61QF
         a9Z20oakXkJp97HqlMwYn0f8mSB6OFS4hTPfVPAzVRcU2fT/NXYbofmY4qWy4SkhyWpV
         PtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PZAHji6u98ddmJyqxzeg5PuRU3/flqKsHAB8rbtpTK0=;
        b=VdY/ECuOT0AyYQRMg7y17GnlMCoqtfzPGuNwvTST73CozezMM8rKBx3kNFI+dp9WZ1
         F/hgARRyuw6M5N+BYmKIzS3m1AYmYaJgEJrfYcYByuHpbozjV3tF9TDCf7FadDIvm5hT
         d+BAF4tANtffMhR+AYkhPU6gHY4oUBzmisGp89apk6pj+c1Zcfr3W5d85quIY8MOM2rX
         1Hamx4pWRZqOPLZOQ4PpPNrvX0kir9oyBZusHUta6288r74LX6/ZdMSOBXLdjZBlQh74
         eLkya8AHJzxfCeUP5qdNZKRroF7+RI07d48/fjVRXtZ+16H3rr020yquZy/dNwyXELzM
         OdTQ==
X-Gm-Message-State: ALoCoQkid6Ibl1uVAKHnrAxVlsuItLWKNeC6kgq7t7VdVcsCjk9VIJYVyXolj1JbT9vKRLJ6z5bC
X-Received: by 10.42.130.7 with SMTP id t7mr43124006ics.25.1419888922067;
        Mon, 29 Dec 2014 13:35:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id t8sm1757418igs.21.2014.12.29.13.35.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 13:35:21 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419888915-31760-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261883>

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
    
    v7:
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
