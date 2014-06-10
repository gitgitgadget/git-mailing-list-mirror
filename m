From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 44/48] refs.c: call lock_ref_sha1_basic directly from commit
Date: Tue, 10 Jun 2014 15:29:32 -0700
Message-ID: <1402439376-25839-45-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:40:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZg-0005yY-NF
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbaFJWbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:03 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:42626 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-pd0-f202.google.com with SMTP id fp1so603703pdb.5
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N7VERtFL8RmNWRCl+DENjH4lQj1ctJNmoCldAzwdXIw=;
        b=ZBiaYcgOgdcKDEaiqgLPZ4oQ1T2h3V42u2AVqeX2IT2x//J356rIY+gYhaxFtcl04Q
         HNQ778i4RT5ciXbjJWoFZ2nNKRZLZiQT6kvgWDShCW53ESHkdslOyDI+C0gUummA0Aci
         /6Lkr0fw99/tpGAh/5N4ukR3d2sac8TbeF93Ed0h/F2Ez6g2xDVKtQQSKeIPZ+YJAn80
         A+oFuVNdZFynl6PRkmPjgMCMGlwa+BSd8ASKhqHklIS1VHoMgyz7y/oSG07djAUqtBh2
         JZUlr2Y2EleNC8O6aeaqoD/6D1g2XaxiHfiwS38+X6faxiCsRSObzeWJJvQBm5/1bCCA
         IrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N7VERtFL8RmNWRCl+DENjH4lQj1ctJNmoCldAzwdXIw=;
        b=VYBVbzfHojmFLRMqYxnSiOstZWsF5+JXdzcsG38lLD18TPASmb9pBRD7SSyDHfy5pV
         CNQoAbz7CtJI37GL5R3nPnfTtyxDpa0GzdhNt0zxx2OEuEyiTo3xEXeZ+YEvac9oxehJ
         77CUlZDbhLL1V+h7ISXGk7vtSW6vYQEC47uQbaDNa6s7HgJ2MG8GeMjFhP92IditaL+Y
         OtEHXSnyOosh0qxT90akBok9ecae00e1fSN2Py7DqdZCQ/gEKVJKSdKJSvazhHTlkWbW
         mlyNmqVjBBf4QYUD2IKgmUHyiewEk/fLv1MstfZngp1q/er4iSwSHB0OU5N7aLyCkSD0
         m+sQ==
X-Gm-Message-State: ALoCoQlfImYwmmkK5HXJJ/pMN24nEyrEpYdnGAvFVdrr0AA994CEcdcpxqJAz8XagyJz0jrT1td8
X-Received: by 10.68.195.9 with SMTP id ia9mr6128323pbc.7.1402439382071;
        Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1394557yhl.7.2014.06.10.15.29.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DEA905A472D;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BD7DBE0AA8; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251314>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 5d35e2e..f482b03 100644
--- a/refs.c
+++ b/refs.c
@@ -3571,12 +3571,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.574.g30c2c5e
