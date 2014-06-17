From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 44/48] refs.c: call lock_ref_sha1_basic directly from commit
Date: Tue, 17 Jun 2014 08:53:58 -0700
Message-ID: <1403020442-31049-45-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvif-00041f-7n
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933394AbaFQPyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:38 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:61044 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756347AbaFQPyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:08 -0400
Received: by mail-yh0-f74.google.com with SMTP id b6so1052277yha.3
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oEtcZGEbXAgEFULoUiV4EJngbN+saSc6Cql5KvheSf8=;
        b=Nst0poZOgGlTuCwZo7mSSeu3nHl63sXPiF70AwMnxUee4tW21q3RwIwcZLyvA18lnX
         pv9s8GJlHLQAmeIExvNva6diZglaA/PYF9dyrXaaZGrNGbyftt5+EV2nC3ZcQG0kvhgU
         LsH60bbIfjAGbBAkam9uZ1LfItEpn4bgZynRe3WXmb/FZGLjDD7pR4BD2i/P/ms9uQWx
         5nBF2yphgbCfTzpaYd0DFfR//3nwlovc9B+XbLoWwC4pc0bThtDBXStpfpu/O5IWOSg2
         2i1BVFc4IbAg0kUGzMrVmvdRmSaNc8IE4tkrUjNxfmzDjsQjS+9be+UHYt7wzD9uY8K9
         Es3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oEtcZGEbXAgEFULoUiV4EJngbN+saSc6Cql5KvheSf8=;
        b=SAnUrJ3Q4jRfngubY1y0Sa/FEYhVWh9t1TtGjrg6WbGaR0Pqpyg0EaIGkqwbF369Wy
         +V3H4R7nYJcYbgOqiZK8B7ywCL1GMOAfaxmgsRlIJby0r1p9DMG/0CaTxnZIqIA8Vpea
         7VdDoxzeUlucEhyeGV1gchRFwwela/Yqhf2bn6E2TiQuUF/4y6IPeX/tPbg8cPpYAzmV
         U6yFO4N92JkH6RuMpcNUeAJcwVsEjifBHaqFGfH4IMES7/q89qk/U/NHAGjcvOtA5Jpr
         340GjAv+RR2di8I7xn9ChGTqhVKWF5OszfCDsoOqcKUL4nxe8i31qp3QkrPaqDYGzS+4
         lm1w==
X-Gm-Message-State: ALoCoQmghCHJd0VQTkiI+iPmII6mVXqKJk6AAx2RojasYTSKryT3EqY69ouFwhP5efLbrwN3CJNH
X-Received: by 10.236.24.196 with SMTP id x44mr7167yhx.15.1403020446005;
        Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si1208722yhk.4.2014.06.17.08.54.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D257E31C76B;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B22E0E106F; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251880>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 31d41fb..610e063 100644
--- a/refs.c
+++ b/refs.c
@@ -3596,12 +3596,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.438.gec92e5c
