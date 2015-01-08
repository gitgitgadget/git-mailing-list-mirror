From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 07/10] send-pack: rename ref_update_to_be_sent to check_to_send_update
Date: Wed,  7 Jan 2015 19:23:21 -0800
Message-ID: <1420687404-13997-8-git-send-email-sbeller@google.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 08 04:25:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y93ho-0008Lm-0y
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 04:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbbAHDYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 22:24:04 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:63604 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791AbbAHDXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 22:23:54 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so900924igb.3
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 19:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=06ns29n3YgSopVV5HxL0WCuQ40Rs59KJxwMecSgXhUA=;
        b=Hl6fuvRmzDMLgrN/ck1jU3cQrasCHtkPuM5rqmLa2vueIKtV2pxyvclemzoJdTqZvA
         IPDHwEPLRQoeuepWpKGV71vrGCrKtOOSJhGnrFjv95QO0f83oeSQ27BGxYOqqEDdXbVi
         6P//z/9QQQXCag+MBxNMkRZqD1JWhOx6e8bvD5AwxSEaa3wzoyVINDKchy/heBKfeTPS
         BUflxFs5smzSPW0nILZCKwe4WsaJFZwVyWnIdqxvJkudTHY+pgAAR6jKsfpgi3ke1kHm
         wKy25Pi6j2a6w9hz3fQsN/ePO5DjtWHroQZ07zwzSQiE+4nt8lyEFJabhFGB+956vTBR
         K1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=06ns29n3YgSopVV5HxL0WCuQ40Rs59KJxwMecSgXhUA=;
        b=M8FOF1T8ebWZDlXF+mr3XRqB8EHwRiuQnSYQaa8um5QYPFhwELlkxxwIqYga/a9P7O
         fDK0ye4cNtgJ92Q3te9cYy6wbeOWE2OObYpi8p0QCY2kbK3ZF0+x6X+AyEKwKN93LlXV
         LigusP9Gv7P8wlbHZIgPKMJX8HPSC/UCwtQw0QKL1RPS6WBRpYUQvej6Y879UYG2bT5g
         je890hRwdbXx7S45+P55hfSEbH8gwao8a9DOOGhLshmIHKV2FEWeqzZ2JTfMIWCDLDGL
         ooD2KTPib/je1Jx2+MSUvc0g8tkm4oYJqdD6e4okiAivtz6hqEeoerog1nci3jpFhk3k
         bkaQ==
X-Gm-Message-State: ALoCoQlZOPKp4/YcBWoPdtOF73+Kx1IVj8AlUJuuuMIXRtt6210bt8mi0pe7z258Zh2SfU+q10L4
X-Received: by 10.107.130.30 with SMTP id e30mr6595359iod.87.1420687433220;
        Wed, 07 Jan 2015 19:23:53 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:948f:12c6:eb26:9b9c])
        by mx.google.com with ESMTPSA id b2sm1756775ioe.2.2015.01.07.19.23.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Jan 2015 19:23:52 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1420687404-13997-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262181>

This renames ref_update_to_be_sent to check_to_send_update and inverts
the meaning of the return value. Having the return value inverted we
can have different values for the error codes. This is useful in a
later patch when we want to know if we hit the CHECK_REF_STATUS_REJECTED
case.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v10, v11, v12:
    * no changes
    
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
