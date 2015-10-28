From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 24/26] refs: make files_log_ref_write functions public
Date: Tue, 27 Oct 2015 22:14:25 -0400
Message-ID: <1445998467-11511-25-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:15:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGH4-0001WA-KK
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbbJ1CPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:15:24 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33448 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbbJ1CPW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:22 -0400
Received: by igbkq10 with SMTP id kq10so108258016igb.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xUgyhlBAwbdV/zoHEQ5iKVwBmDm5fS6aAY2RQ2PF62o=;
        b=FEMFtqRVsnvvH9cy+SBZ46eGpYhuvTGUdkKY8nD9ZuDxKlw3YCiLA1w7GEwYXuXoxs
         t66LMDl3DBrnfKWEmZZRY/sK/mEu7+95Y65NFyB2hgMCAQJazgbNKRvjTzvXTeDEedtG
         oWEIrfp58vQyymTFHEybhop6etfuHyZuQfk+E3ZrowXINLaNDMhPPWrvmIHGU48nbEz3
         V6AeGgIkG/bCdX6m0Qin0JXDZZonwK6YW+3iNJDicsEhusLqHZS/gesgfCUqpjbdWMaE
         bxV9ZXcn4Tfds9mAGxzF+HQTkXbVKjqRQzj4MQz7j9gd9wvKczMjckRCfFyQF/+GHAzG
         kqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xUgyhlBAwbdV/zoHEQ5iKVwBmDm5fS6aAY2RQ2PF62o=;
        b=TI+gF2wHsWpWkx27RB/HLZNj3q59DQgBzLKaUrpliQ70QvVjme9raC6YpTvMMTuSb+
         y0ozSD81OTCNot3fTWqdeU5XZlzcZ5oHvCo296qJDaClwGJPUveYVXyOpHnNyMsazMWH
         RhV5aIkU7WqXWb8I2lzx/d8dvl+i1qsPcMxhPHn0BtjS3QxJxNPNPvVLM6EWbcNP66XE
         8D609OwSOJ0+l2jb15Qk5MjRWygjgCmdhzi2CxFjEyclBuoQoMX6XVMFHku+7CKvuP1a
         ubExKmRl7nAV3Dw1kGwt0L/TBDMZwqMhGahc3pJZL7c7KlHGAeCz+150jCQtqDEGtjcA
         b/rw==
X-Gm-Message-State: ALoCoQkamsR2PijOgC6tWDsK7Ksstfe2G+4qd57c1JIFS211wQZAH5dKDEezRPfKgA5hcSd0AAqM
X-Received: by 10.50.3.71 with SMTP id a7mr364975iga.9.1445998522382;
        Tue, 27 Oct 2015 19:15:22 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.15.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280342>

Because HEAD and stash are per-worktree, refs.c needs to go through
the files backend to write these refs.

In this patch, we make one files_log_ref_write public. Later, we will
use this to handle reflog updates for per-worktree symbolic refs
(HEAD).

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs-be-files.c | 8 ++++++++
 refs.h          | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/refs-be-files.c b/refs-be-files.c
index 680641d..0eabea9 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2732,6 +2732,14 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg,
 			 int flags, struct strbuf *err)
 {
+	return files_log_ref_write(refname, old_sha1, new_sha1, msg, flags,
+				   err);
+}
+
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err)
+{
 	struct strbuf sb = STRBUF_INIT;
 	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb, flags,
 				  err);
diff --git a/refs.h b/refs.h
index ce99aef..f97a2e4 100644
--- a/refs.h
+++ b/refs.h
@@ -619,6 +619,11 @@ enum ref_type ref_type(const char *refname);
  */
 int copy_reflog_msg(char *buf, const char *msg);
 
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err);
+
+
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-- 
2.4.2.658.g6d8523e-twtrsrc
