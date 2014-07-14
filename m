From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 04/19] refs.c: allow passing NULL to ref_transaction_free
Date: Mon, 14 Jul 2014 13:58:46 -0700
Message-ID: <1405371541-32121-5-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLP-0002z1-RW
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121AbaGNU7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:17 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:36258 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914AbaGNU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:07 -0400
Received: by mail-vc0-f201.google.com with SMTP id hu12so158660vcb.2
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HU2PFf8RmToJ7zaDEy1/nCzgJA8mk6n6ZSb7YNtT4mw=;
        b=NiAtjQuEeVKMlQDLzeJTaSGhW4revAJAD+BmqgaRv521HXog9sAMQ5ei9ekDp5dulb
         yJ7k1FVfvSPm+qFO5+UVgH03xBNqlkSkxysfIpyGNmWmamWgzm1/WhRPoH/CtyrzyyQm
         ZXZNRvrSbe96spW1ezDqcl6rB/WMy1T9s5DQLDkyfignB64GnX8OWujyhaRsJI4Qm/BV
         lFY3SXMyVOgLfQgXD5S8ttN/DfmQV451Vrhw2dvbsUjXjSkRc+Ws8dEJr2YmxntbSjHT
         yMowEN8ONyKB13UI55WX9JMJzDYz/ozr8AsfprCMa4TCQDJ4Ghqmj/5T7bxTqhOqR91C
         fnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HU2PFf8RmToJ7zaDEy1/nCzgJA8mk6n6ZSb7YNtT4mw=;
        b=evq3OFi2TXusFXcqZKvbTdalWFYAiJsqbF/j880dAAtN4kcFRxsfz5iYp3Ro9EfLOZ
         HOfx2dnDWv8UkXzl6wedD5pwIXdqC2nQzlPKF46XzY4u6nMGBzBmhF5EvTrCfY0mgRjk
         fKJAQsqQVeS+663x4LNklIV+llQ5osoruVgeKIC8k6GST2Hy3C73BP4/BMH8KciAJUoN
         TGu3wNg7jpjHfXQh6shZtUJqpgssPsbnzJvDK4XszwIgx+6EcKVtA8exQ77+ovboiwGD
         kfgbd34QDKt0Hy9JiNrhp5Yufs23VAdL7m7m+JAlaWiD1yImvID3bTmzOXbQq80c02Jy
         nGbA==
X-Gm-Message-State: ALoCoQnyc2wdK3awgKqkWWzbIdpQ3108QOpdvX+tb5OQRWHtTQKm1z5Du1wqYyeaIawA8DWIcfSc
X-Received: by 10.236.159.198 with SMTP id s46mr7800090yhk.17.1405371545560;
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si821463yhk.4.2014.07.14.13.59.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6BD1A31C391;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 19A55E07CD; Mon, 14 Jul 2014 13:59:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253524>

Allow ref_transaction_free(NULL) as a no-op. This makes ref_transaction_free
easier to use and more similar to plain 'free'.

In particular, it lets us rollback unconditionally as part of cleanup code
after setting 'transaction = NULL' if a transaction has been committed or
rolled back already.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
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
2.0.1.546.gf603308
