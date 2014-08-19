From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 14/23] refs.c: move is_branch to the common code
Date: Tue, 19 Aug 2014 09:30:38 -0700
Message-ID: <1408465847-30384-15-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKb-0002zZ-9V
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbaHSQbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:33 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:34165 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbaHSQaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:55 -0400
Received: by mail-qg0-f74.google.com with SMTP id a108so416497qge.5
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8z9PCJAwuTrcXClmntsJmB1EMoaw+GhOmGIdEINvC2I=;
        b=DH4I5CTBbWJFZnaBogWKvYbPNqEBKTfGkdbUMDUPVyEqMG7063kz4JsNvEo9mPWlwI
         0PB0sP4aOH50su0trxhbDY/pYMO7PzeQ8OAqiJZ1HZ0zZC+RkO2m6TeYJAtCyz0gqIh+
         ldGgeTvLDYD/QlZZOUZWLZZZ7Q36z64/GirXA1RaPI95XD2dkaZcwNEkL/ZHaraYHE/f
         IgmJKp+8oAEhNBYUGmVeoEcBYbvsDQRDCwn59BiO+nyBNw+S+w5MT7ezBlBmO4/H0hZ8
         /ZmYL8rRaVS5TiZaYuesqcIT4TN/EmPNTHv0ycppoOZYhX1cnlCVpnjwV1Jd0yNP6Ttk
         aX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8z9PCJAwuTrcXClmntsJmB1EMoaw+GhOmGIdEINvC2I=;
        b=ERmmpIqc+R//RbolZGxkt8s0Zc1t2Qcdmc+x1BGJr84N3aFlVZeL7vgYOr0rUXnDqJ
         ldWW2wy/3DgVvipIc6SgQu6ZBofJ7fHgnQLM1J/JI+nGweEFapldOQohdUyWtZT00EDf
         ytBU0Rcxil/tcTLQaiJ7yvlFsKjrmQBPctRs97pF4AVHBWDcs/9uNvre+sZaRr/9Fl27
         u8nK3BNbbaco1MInMZSfgyLRkbS4GDXJNS3drOAswyrFmHqH/x/IMKBbcW64j53hY1VN
         FYC515E35XVdpFvTAd8o5RVQiQ3ikn0+QsipbdmN0DRHDYZ/qTKIKvwqD4fmBN6WZ0lP
         oSXw==
X-Gm-Message-State: ALoCoQmqxjKJSHM/DN3u5XaI5cxg/sA01gtyiqKGHqPIeHeZ27gYR7cfv2holbe+XY2iolmEAqQf
X-Received: by 10.236.191.37 with SMTP id f25mr18936654yhn.44.1408465853628;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v20si329149yhe.2.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6644C31C53A;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EB35BE1AFF; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255496>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 5 -----
 refs.c          | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 55bced9..70c034c 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2483,11 +2483,6 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	return 0;
 }
 
-int is_branch(const char *refname)
-{
-	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
-}
-
 static int write_sha1_update_reflog(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
diff --git a/refs.c b/refs.c
index ea5f276..9bc0a31 100644
--- a/refs.c
+++ b/refs.c
@@ -683,3 +683,8 @@ int check_refname_format(const char *refname, int flags)
 		return -1; /* Refname has only one component. */
 	return 0;
 }
+
+int is_branch(const char *refname)
+{
+	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
+}
-- 
2.0.1.552.g1af257a
