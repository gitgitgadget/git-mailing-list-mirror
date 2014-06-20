From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 04/48] refs.c: allow passing NULL to ref_transaction_free
Date: Fri, 20 Jun 2014 07:42:45 -0700
Message-ID: <1403275409-28173-5-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:43:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy02i-00017d-65
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbaFTOns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:43:48 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:40081 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbaFTOnc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:32 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so979383oac.4
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ia4vyvHP+tX2hoq2ml3XK7Y7KV/WTYHhqINpvQwQb3A=;
        b=CkcfDSOb0e6NmUsqVrFskkefGGaf/lu0ibL/xrUqi39PXsdWFoQbJ/64UxgekmlrqJ
         +fzkacz4dHzMJZRm5e28Lr40f5nM74YnSvEXOaLTM9DxACiOXbLLfyZN5VyC+HOhj1l8
         s+aHT/8V34Tu00OgD9tTu6B8jj3mcSIiC2OYo5W7YS0sBhyagQQFu9KOc9iTZ93KBitF
         VcuOYichElzG3WwwhBTWbRAgaLUdpYcmDkESiaizGdkCYmRB4jg3ryRGY93W033yTiYF
         g7KaLntQFv55HOsY5YlT4LNzVMr9JsAywm8UeVchm1n/58JCwbTMbCDDYSsdYsKw1nrC
         xY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ia4vyvHP+tX2hoq2ml3XK7Y7KV/WTYHhqINpvQwQb3A=;
        b=H9rbyNdf595Nu6HZp1kQK3carGP1yj2Qg5ytWzcGQDohZ9VkNYwUDEMn8le7pVwfSD
         AkuoWH6Muxc+0B86srB+UMiUIUeqFygKturegdqKfrT0J/u42no/acLhvnBO1VQTTeKX
         Cbom937HtfsPK+hocQfH+SsoIJHbgQmIE9wMsKYizcEr01BRtvSJRC5OfpRe0CtC8zX9
         I6GULObsBcmvUJLmCaJd300gUZFWFPKn0PyyBosnN73A90g9TKaf+6vN150AAfV/nl3L
         Zqa498gwtjOVCEh66IT1OKsI48YM8DTSQ2EqKRpbGqTXNrhRN+6HQrMJbV8zl7mUVN73
         VQrg==
X-Gm-Message-State: ALoCoQkMNcsiJjvusUYxtVqSiRbi5IGzimnqpRRkYUEuB6kLqoM8n3eQf0IgPrfEZkG9NZtlUy53
X-Received: by 10.182.128.166 with SMTP id np6mr1543919obb.16.1403275412159;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id b39si187828yhj.0.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 071A831C6B4;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A658FE0961; Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252229>

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
index 21ed465..1d6dece 100644
--- a/refs.c
+++ b/refs.c
@@ -3338,6 +3338,9 @@ void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
+	if (!transaction)
+		return;
+
 	for (i = 0; i < transaction->nr; i++)
 		free(transaction->updates[i]);
 
-- 
2.0.0.420.g181e020.dirty
