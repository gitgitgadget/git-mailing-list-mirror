From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 04/48] refs.c: allow passing NULL to ref_transaction_free
Date: Mon, 16 Jun 2014 11:03:35 -0700
Message-ID: <1402941859-29354-5-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:04:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbGo-0003Ju-Vi
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbaFPSE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:04:27 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:42675 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442AbaFPSEW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:22 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so1129910oac.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mwIt+rYXc3LXr419b0k7Igh+hYHbrbGyNqZrh2WE0A0=;
        b=hNF2eHjI5BZJN6rCCk2h8o8Qn9Z/16k1RLDi6VUuB78QMbe1zE6Zi1mBuSK6bNztXL
         VL9y1pJ0ylMxpEhtrjmCu7kTv5OzMdc5Iy9ZmpRg6mcj7lDyoZPvw6kx7J93QatizKnq
         setd3Cf6docbH03BAyeWMjoK4AeuK/tvRQxA9TAPOWNPmAxNs1R0bZDTNarQocE24dYi
         91TYSLdg9ttKedygWPE351Tb8DAVg7jcZZoZmzI5K/sAkuEkMTHaoKFFamn/h93csL7p
         h/FaaDLv+NPagk1zEMmouDwGj882h6eY7lLnp65SH6YsEzbi0fRj1Bs60LqDiS9PcddB
         edcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mwIt+rYXc3LXr419b0k7Igh+hYHbrbGyNqZrh2WE0A0=;
        b=GoFOrrdfVnVbyG5paI29HqDDq9Si+svPj2ye5t64IwXuSqMyT7U9B3/u5vEVT/og+Y
         +DBNHrj6B/NyjGAEn1bUHUTsFbdz+iaTrYqaSRCOYKJ4EZAhYWJ8SCbP6BerftkTImRX
         b5wSJdkXUvWmZPqJhObkfzeSF4E3Yel4ZOloNswFLA1FUoWiCW04SZwskUDLxgtKQ/h5
         a4rg8oVOUHj4UH0aDfQ3gpeaWktur9ORsLsGPHB7OVsNLWPVMN5R+e9r5mCRlx2qqx81
         jP1fjm4fYBrJ6azDOKTcfb1zuo0lnGKkR51RrklDN2xZ2fl3qyI2vJhfzHMAIZpBJUKW
         Y98Q==
X-Gm-Message-State: ALoCoQmtEizxWpn3NkZERDoSg0HezXy4BkpKDjhdwU+GeCtCf6ityTAfcxjjCmhSLXR2co6P+2Wh
X-Received: by 10.182.118.230 with SMTP id kp6mr108456obb.42.1402941862260;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si996124yhl.7.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 209355A490D;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C9551E05A0; Mon, 16 Jun 2014 11:04:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251742>

Allow ref_transaction_free(NULL) as a no-op. This makes ref_transaction_free
easier to use and more similar to plain 'free'.

In particular, it lets us rollback unconditionally as part of cleanup code
after setting 'transaction = NULL' if a transaction has been committed or
rolled back already.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs.c b/refs.c
index a767ef6..0faed29 100644
--- a/refs.c
+++ b/refs.c
@@ -3312,6 +3312,9 @@ void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
+	if (!transaction)
+		return;
+
 	for (i = 0; i < transaction->nr; i++)
 		free(transaction->updates[i]);
 
-- 
2.0.0.282.g3799eda.dirty
