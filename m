From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/6] send-pack: Rename ref_update_to_be_sent to check_to_send_update
Date: Wed, 17 Dec 2014 10:32:53 -0800
Message-ID: <1418841177-12152-3-git-send-email-sbeller@google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
 <1418841177-12152-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Wed Dec 17 19:33:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1JPe-0000VR-O6
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 19:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbaLQSd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 13:33:26 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:42569 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaLQSdF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 13:33:05 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so9204982igb.17
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 10:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iHA3YlPFyuR5ouK1kKwA8yQ0aYxO76sis9jRVmz7EKc=;
        b=TFuWrgUJoa6b1JdrFpUr8vTJgLkTEN4Eop25u47oGUN8u2pv+NQuhEH/zkIoFMuRX/
         ucVu3Q08Q6vWPRTOo40dkhCzGE+Brk5uZYW5DbFjwswMvvqP2YsTqtRbgCITBmpvSDf/
         7K6083GGMKBocGLlQI5yeXy8hWSacibHueCk2QghKPVCfvJmcG6d/gCWOs9mu2DWD0HG
         +A7I/LgFOmDT9heXchQkDaIQrRzESQPCJ5HxWn6n/u8vl0t93jnnw0IMQoOUquZORgH7
         9lqWUSy1UApkEuFKUaFc139UDUBHstAT87YCl9IU37EnHeaQnWA3XhCO869CkMqElLMc
         sbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iHA3YlPFyuR5ouK1kKwA8yQ0aYxO76sis9jRVmz7EKc=;
        b=DZ6vaKCbumxnIbrsmDuxswaHYVdNm2tjd2Fl9b9KPpNx3ld0vwlWqw0K5LmEeA+J2I
         KkOVcAd3PSASziFQpdFXmo48935s27tSpQVLxCFiP+/dkxCFFQ7NKYEUpBWGRLzBahB1
         Nbolqs4Cbei8zal4ij3ogxK2c9ofNVyP/7ZPqf0fa1yjar3Q1dxfG4k2waHK+uJb68ub
         MOXWCSgdglCNn7n0ebN0KjzcOjiBXhpMRrUcIZXK55gxv1kvPnM1vELjuTMgs3eC4Zmk
         +B6IN676z2cV7if7Tp7gjYoUB3C6gncjcZ6Fn3DvkrE66CVXTidr2eNoDaOxZEHaa4o8
         bSJQ==
X-Gm-Message-State: ALoCoQkIWNl2LW/8mtyyRrplYsCpuFzDKdxbDG45TuLenCPR2xmmjI0vMCio3hBdhciB2qiZGFCS
X-Received: by 10.107.12.10 with SMTP id w10mr25874114ioi.71.1418841185176;
        Wed, 17 Dec 2014 10:33:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9f5:d31a:4ba2:b65d])
        by mx.google.com with ESMTPSA id kv4sm8180924igb.13.2014.12.17.10.33.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 10:33:04 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <1418841177-12152-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261494>

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

 send-pack.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index e2bdd89..77e4201 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -190,10 +190,13 @@ static void advertise_shallow_grafts_buf(struct strbuf *sb)
 	for_each_commit_graft(advertise_shallow_grafts_cb, sb);
 }
 
-static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_args *args)
+#define CHECK_REF_NO_PUSH 1
+#define CHECK_REF_STATUS_REJECTED 2
+#define CHECK_REF_UPTODATE 3
+static int check_to_send_update(const struct ref *ref, const struct send_pack_args *args)
 {
 	if (!ref->peer_ref && !args->send_mirror)
-		return 0;
+		return -CHECK_REF_NO_PUSH;
 
 	/* Check for statuses set by set_ref_status_for_push() */
 	switch (ref->status) {
@@ -203,10 +206,11 @@ static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_a
 	case REF_STATUS_REJECT_NEEDS_FORCE:
 	case REF_STATUS_REJECT_STALE:
 	case REF_STATUS_REJECT_NODELETE:
+		return -CHECK_REF_STATUS_REJECTED;
 	case REF_STATUS_UPTODATE:
-		return 0;
+		return -CHECK_REF_UPTODATE;
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
2.2.0.31.gad78000.dirty
