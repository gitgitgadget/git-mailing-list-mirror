From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 02/16] refs.c: return error instead of dying when locking fails during transaction
Date: Mon, 17 Nov 2014 17:44:43 -0800
Message-ID: <1416275097-3616-3-git-send-email-sbeller@google.com>
References: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:46:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXsC-0004DS-3E
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbaKRBqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:46:25 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:39243 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbaKRBpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:05 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so1149437ier.41
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0A0r1Twxj+y/+XpIFWaM7LzwiNFByTdOpSzg/dYqzSU=;
        b=QiZrbiG5VCKCKOaWCcDa5/G/Flgt+n7UWUDR2oVg8mZ8PFVFzn8Kzj1AoWyD/1vtI/
         fzDXMlHF9bRF0xhaZWehXFcVr7/Po1Yre8wHufkLsWipdIC6XXxGXzQFEJiXDGcL3M+I
         KvQvkxRt30UQYu4EJEF1Q8ATzeFQ3nAlB2JTOqYqhGMbhv/OszbyX7Z6W0l62+R+YlcH
         +7M69UnfxGvPnoYCRQIVcqXvoX+bRbmZFyxcWyCYitkNmPRG6QCBp2XS13nz/TrjTwCa
         o5TJtiYwj85VEOC2F0LxR+b5CtvkUMPDq4I14IDstwJK9S64ciPWKlTAyBuplJKuLv9I
         G2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0A0r1Twxj+y/+XpIFWaM7LzwiNFByTdOpSzg/dYqzSU=;
        b=RhYOgRSClRvJJypAQU+pZBloUeLCZxvpCDlCe0OJS4Le0MEEdgpBxmAE+saeKZ/x1J
         ADSuTekxaJb55V5hSJbsxOvVZF/Pg9Od5o9kbfOrjtiMY3kpztynWEBqp6wPPn3jHz7z
         YOBGUfLBGi7UG0owG4r2pErs87u0iuZ4LF3neyopbyQPOYxZAcFp/Rqyf2TKYeGTs4+i
         bFXVetP2Cwdj5MZtoZQXAd2poFmTLl+SQjK3/bCzMdsQvtzYoH1LEMMYR2bcdAlnhGPQ
         8YJTISMHmDSpV+JHZWdR0M31w5W5ach5D/CByTEAB5CsK7Tpbg3JSIiuCf8ro7ivwUDf
         rVpw==
X-Gm-Message-State: ALoCoQlEcenPj0P38t3SGsA9R+lRInhIM4V+Oxx1S/dzAe27nieR2T6tTDiILeR3zaksJ/AdrY0a
X-Received: by 10.42.159.131 with SMTP id l3mr5709976icx.65.1416275104273;
        Mon, 17 Nov 2014 17:45:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id p198sm5255306iop.36.2014.11.17.17.45.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:03 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416275097-3616-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Change lock_ref_sha1_basic to return an error instead of dying when
we fail to lock a file during a transaction.
This function is only called from transaction_commit() and it knows how
to handle these failures.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index f30512f..78eb46f 100644
--- a/refs.c
+++ b/refs.c
@@ -2340,6 +2340,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
 	if (lock->lock_fd < 0) {
+		last_errno = errno;
 		if (errno == ENOENT && --attempts_remaining > 0)
 			/*
 			 * Maybe somebody just deleted one of the
@@ -2347,8 +2348,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 * again:
 			 */
 			goto retry;
-		else
-			unable_to_lock_die(ref_file, errno);
+		else {
+			struct strbuf err = STRBUF_INIT;
+			unable_to_lock_message(ref_file, errno, &err);
+			error("%s", err.buf);
+			strbuf_reset(&err);
+			goto error_return;
+		}
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
-- 
2.2.0.rc2.5.gf7b9fb2
