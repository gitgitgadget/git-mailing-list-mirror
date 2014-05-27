From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 37/41] refs.c: call lock_ref_sha1_basic directly from commit
Date: Tue, 27 May 2014 13:25:56 -0700
Message-ID: <1401222360-21175-38-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxj-0003CU-0A
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbaE0U0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:30 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:42836 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbaE0U0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:06 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so1645407yhl.3
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Hdu4TGUFx8FwKMoyipCLdvfMnQMyJipLn5l5qlw7UU=;
        b=nv9ldhZpl3eN5uq1GIOidj/aI94Rb6m8h4JGNNVT9ea5asame8wHuB8B8jABvqGE6u
         33R88elWHO5+OIOnoMJNCNtAqjGY1g6BjBZaA5ngEqYiH71FmyamsQia8ka+uQfkXPpI
         UoNghXOiaAbpUXSADtatGAgsAKbNLb51ccNUM+s2HtPu5yXFk75fHhZz0+0KNQ5WcVhc
         ZnDOrWWdk12aU5FdwIsl5MyflAdbY99OC2OlLTapDkL013V3PqUOxIBevdKrBoJb+rwD
         lDsQc0YlgMDYZMsxyBDL6fBACy6WmdWcto0iDkb5xUMf2YQi5wnguXqIIedeJeDBi8QX
         xMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Hdu4TGUFx8FwKMoyipCLdvfMnQMyJipLn5l5qlw7UU=;
        b=KaYthu6vhcxa7vFDLOt99CYlpY9CF+vFORQer+qHJggw+lk8S3lnsnZgcj214F4BYj
         WgKtUiotEfje7fdAlDoa123YGTrUyqGLw64v4dR9PzkQS0ZmFvFD/KGsVyrMOdg6dyw4
         DISXe0v72wezitOGwkkLWlDxMSMLrPRHnvzGKX4BLXjxhTBC6Aq59FNj1uAymIWoVdHO
         1EwUKjvglKSWKSOkAsYNdLxLRyHeYbodBxbRjjZdnRVoUgQmIMcN6wTT/ba4SxGs7EoK
         f6vpFqmTwUI67z9H7zj3acFei9l8s2cNMW4oFAAIuOtepMYH0bdRCSxl7UzQuCm1pZoL
         XHdA==
X-Gm-Message-State: ALoCoQkPV5ZD3N5hBYoAT3Sp436Xk8OfSbvjWDtIIweOcS11ZcjU8nJqR77Zmh2yYSIrV7U8hdJJ
X-Received: by 10.52.142.72 with SMTP id ru8mr12483989vdb.0.1401222365598;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1573756yhl.7.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 732CA2F4AC1;
	Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5341FE0C28; Tue, 27 May 2014 13:26:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250213>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 2952871..28138ea 100644
--- a/refs.c
+++ b/refs.c
@@ -3525,12 +3525,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		update->lock = lock_any_ref_for_update(update->refname,
-						       (update->have_old ?
-							update->old_sha1 :
-							NULL),
-						       update->flags,
-						       &update->type);
+		update->lock = lock_ref_sha1_basic(update->refname,
+						   (update->have_old ?
+						    update->old_sha1 :
+						    NULL),
+						   update->flags,
+						   &update->type);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.0.0.rc3.474.g0203784
