From: David Turner <dturner@twopensource.com>
Subject: [PATCH] refs: document transaction semantics
Date: Thu, 25 Feb 2016 15:05:46 -0500
Message-ID: <1456430746-5565-1-git-send-email-dturner@twopensource.com>
References: <CACsJy8DDVbz9LnX5HM_2HB+uDvqzS7LU=12gxhxJFqYPHp0Tvg@mail.gmail.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 21:06:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2Ax-0005Ys-VI
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbcBYUGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:06:06 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34647 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933662AbcBYUGE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:06:04 -0500
Received: by mail-qg0-f53.google.com with SMTP id b67so49082395qgb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 12:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+HPsqgNdQPGAh5TYr6tf+MfxWjDGi4MMHABYpOmyA9s=;
        b=ydiT/OaJyKYlzDsZQM5ffxL1IqPxtdoFiaiCHM/cZVBn5EW30lbc3iMub3dQBgyRhn
         a380/ybnPWLqNwepVH0BinkKtNgCPcZFWS3aj20IFAaAfGZ0caXdLwscyn9YWXhy0OZp
         rer2+0+oWf/eorebhKD57QuF3cxhW7mgNoKJflZosWEZFfM7UYxzuy0J0/Y5zFPG2hlz
         CNZD82cvFBWp18YHx1TQBRLSLcvlBU/dWo0Sph3zw/lFOe7nFFlzdz7crHNfL8DQgck5
         pk3j0JGRvDk6skjr/2d89rXCVZ7bvvaa8sJuOCzRdU4Bji3IT2Aw9y6/P6ptaFLM+8D9
         d71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+HPsqgNdQPGAh5TYr6tf+MfxWjDGi4MMHABYpOmyA9s=;
        b=a56zwINMoA0Ri5FThzLuYop/jIv03DmIJn8uRJfRnWAk1PXQCHPmSHEnULi1JO6zy4
         KkNDNuHR+WWKiA6zUirbdRkcwDxL4Guo9YaaHne/4fQrUMF0AORGXX3IBkAWxSn1j9+1
         57jpSZ1NB/Wm8aTjt9y4DGE0Xm+P/2/KSsINHNKvKgRHPgu1LYXgk1f7bOQ9jvcBFUWX
         uc0wicAxDic+Hxkn+Lrl1BYVSdrwnhoc1byau/mO0hmxF6TD0RjmeCVuZZWjIjoLLeUI
         JL+kOPPm3HOzY17AUGiKC1LbXgdqZCgtCf9+Q7mdvNWvAQfeE/anqKOQiLIYedFDzXgV
         KrCg==
X-Gm-Message-State: AG10YOQdkpkXMH/HQQF7P0M9EYKYfBK9nwdYe80rfjWfoYz/HD1K7Hwoc3+DcDd88M65JQ==
X-Received: by 10.140.31.225 with SMTP id f88mr58192099qgf.52.1456430762987;
        Thu, 25 Feb 2016 12:06:02 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b34sm3896885qgb.31.2016.02.25.12.06.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Feb 2016 12:06:01 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <CACsJy8DDVbz9LnX5HM_2HB+uDvqzS7LU=12gxhxJFqYPHp0Tvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287426>

Add some comments on ref transaction semantics to refs.h

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/refs.h b/refs.h
index c0964f5..9b3eaf3 100644
--- a/refs.h
+++ b/refs.h
@@ -112,6 +112,11 @@ extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
  *   If this succeeds, the ref updates will have taken place and
  *   the transaction cannot be rolled back.
  *
+ * - Instead of `ref_transaction_commit`, use
+ *   `initial_ref_transaction_commit()` if the ref database is known
+ *   to be empty (e.g. during clone).  This is likely to be much
+ *   faster.
+ *
  * - At any time call `ref_transaction_free()` to discard the
  *   transaction and free associated resources.  In particular,
  *   this rolls back the transaction if it has not been
@@ -127,6 +132,13 @@ extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
  *
  * The message is appended to err without first clearing err.
  * err will not be '\n' terminated.
+ *
+ * Caveats
+ * -------
+ *
+ * Note that no locks are taken, and no refs are read, until
+ * `ref_transaction_commit` is called.  So `ref_transaction_verify`
+ * won't report a verification failure until the commit is attempted.
  */
 struct ref_transaction;
 
-- 
2.4.2.767.g62658d5-twtrsrc
