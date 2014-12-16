From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/6] send-pack: Invert the return value of ref_update_to_be_sent
Date: Tue, 16 Dec 2014 10:49:03 -0800
Message-ID: <1418755747-22506-2-git-send-email-sbeller@google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
 <1418755747-22506-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, mhagger@alum.mit.edu,
	jrnieder@gmail.com, ronniesahlberg@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 16 19:49:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xBc-0005n1-60
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 19:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbaLPStR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 13:49:17 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44502 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaLPStQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 13:49:16 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so13398388iec.16
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 10:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ANsudOc1x6RxKOhb/+EL0J7h2qenQXjVVncUlmKc/KI=;
        b=Bea5Dse99ra5B2TPJsGMdXZlH06gHKt9SCxqx0MjH45liSDv+8IE1qdPlvBDd+5jUF
         nt8vCG8sCXcMTXO+w82gvJk/ZxVo3NQPREETd5zaWOwvficPU13/FQqzKH5kI7WZCA/v
         8F+cL8XcfOwgbXwaT/zjlLDvCJu7COfeDSmsNp8aRRvawGF9CBQe5gv/Vs7oyclpwgUp
         QiQXaw3kKHt7FviY/PLIXzYwWSUlrKwH7gRmSkhXfhbYsyjV6MhA5Bg8+WEAhzlF4615
         HE7rvGDJvoGWV87JvNPhZ4wlRuXQaV0u5N+bgwGaLGUp3ZRGtL0cj6qk+9cfawATusZw
         0QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ANsudOc1x6RxKOhb/+EL0J7h2qenQXjVVncUlmKc/KI=;
        b=lUVZrBg43NCoNfrDPRo6DIyYayoAo9JhCStm5qH62oe3BNzD6tSZgVxaoq57zsyQmH
         FtKj8ynnhyGsvtO3JAuw0o7Hyn3KCx6FW/7z5ClBc0NmEx9fG/k23Zm9y9th7JeIEoZc
         ug71cZ9AmvWuUvijv8yR0aK7evwQAoJOBkeiO+OUkn5c2wubyMH51nABz3dSl9wekghz
         ntUjtsBBR6T0NQUxg1EPhiIxTcsxAGUzUiDfLMqWBLekwMvZ7N4vNVFIIcgQRDTPeirZ
         gv6o9GbQ8QWjdtZs/9lcCnC3WmLLIgdJqRkvYxn4RGzgmzHZ/n4VPv+AAHB0PS4LJxin
         1FdA==
X-Gm-Message-State: ALoCoQm++swiNMRaTCtRsfMWA9XqwzZ/mnCDlaN/E+hMHY7tLPb+5IjDrlGr7ewFtZmMkS+hHLRF
X-Received: by 10.50.33.51 with SMTP id o19mr4229041igi.34.1418755754891;
        Tue, 16 Dec 2014 10:49:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4db1:657a:aafa:5d88])
        by mx.google.com with ESMTPSA id e63sm633122ioe.15.2014.12.16.10.49.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Dec 2014 10:49:14 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <1418755747-22506-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261448>

Having the return value inverted we can have different values for
the error codes. This is useful in a later patch when we want to
know if we hit the REF_STATUS_REJECT_* case.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    New in the series. For consistency with all the other patches
    it also reads v2.

 send-pack.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 2a513f4..1c4ac75 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -190,10 +190,10 @@ static void advertise_shallow_grafts_buf(struct strbuf *sb)
 	for_each_commit_graft(advertise_shallow_grafts_cb, sb);
 }
 
-static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_args *args)
+static int no_ref_update_to_be_sent(const struct ref *ref, const struct send_pack_args *args)
 {
 	if (!ref->peer_ref && !args->send_mirror)
-		return 0;
+		return 1;
 
 	/* Check for statuses set by set_ref_status_for_push() */
 	switch (ref->status) {
@@ -203,10 +203,11 @@ static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_a
 	case REF_STATUS_REJECT_NEEDS_FORCE:
 	case REF_STATUS_REJECT_STALE:
 	case REF_STATUS_REJECT_NODELETE:
+		return 2;
 	case REF_STATUS_UPTODATE:
-		return 0;
+		return 3;
 	default:
-		return 1;
+		return 0;
 	}
 }
 
@@ -250,7 +251,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 	strbuf_addstr(&cert, "\n");
 
 	for (ref = remote_refs; ref; ref = ref->next) {
-		if (!ref_update_to_be_sent(ref, args))
+		if (no_ref_update_to_be_sent(ref, args))
 			continue;
 		update_seen = 1;
 		strbuf_addf(&cert, "%s %s %s\n",
@@ -370,7 +371,7 @@ int send_pack(struct send_pack_args *args,
 	 * the pack data.
 	 */
 	for (ref = remote_refs; ref; ref = ref->next) {
-		if (!ref_update_to_be_sent(ref, args))
+		if (no_ref_update_to_be_sent(ref, args))
 			continue;
 
 		if (!ref->deletion)
@@ -391,7 +392,7 @@ int send_pack(struct send_pack_args *args,
 		if (args->dry_run || args->push_cert)
 			continue;
 
-		if (!ref_update_to_be_sent(ref, args))
+		if (no_ref_update_to_be_sent(ref, args))
 			continue;
 
 		old_hex = sha1_to_hex(ref->old_sha1);
-- 
2.2.0.31.gad78000.dirty
