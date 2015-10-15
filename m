From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 14/26] refs.c: move is_branch to the common code
Date: Thu, 15 Oct 2015 15:46:38 -0400
Message-ID: <1444938410-2345-15-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:47:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoUv-0006tn-65
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbbJOTrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:24 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36069 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbbJOTrW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:22 -0400
Received: by qgx61 with SMTP id 61so80923416qgx.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4WbPTkLbWdppjh6Rq8lQj4x4iZqVe0c3aTVzyHbQ02M=;
        b=f5C7M5QBnXQCUeK2i58+SlncFEcZ+s/5FBKQnd8i1zi3BmFcpUF05ceigeG2PQDp+E
         EBZOyX9oJIcA1WerBTDVoDs6plJEN7gFf9PhfgbzzkiXArGMBYEMFd5D99K7lOLBSttl
         JoHww+c2sMNbAJjRaQfGi9k1ZKsn4hlxAHkQjrWjvtIDQvbQwvpWP062l/HT4f9WThg0
         Aj7zqLks1X9LxyrSbiWzkRwQfScZb7Ft8uUXcWILGguiWeh1Ay27m6q/F/8Ex2Ew0oSe
         Nzn5+u7lw5QFTsN35JfH1uMleQXpwlu7vqZFLgneB2qU1wJkiUZNbFbLR+2bGmgTyIno
         QcEA==
X-Gm-Message-State: ALoCoQm9gU4wd+gkK+Tvv7/pNbYLRPtsQ99N4p70Njpimufcn+grj6wYbzOHrtO/lxU9EWCSJrvd
X-Received: by 10.140.25.241 with SMTP id 104mr14022799qgt.73.1444938442070;
        Thu, 15 Oct 2015 12:47:22 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279687>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 5 -----
 refs.c          | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 345bee7..5c6c743 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3003,11 +3003,6 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	return ret;
 }
 
-int is_branch(const char *refname)
-{
-	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
-}
-
 /*
  * Write sha1 into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and
diff --git a/refs.c b/refs.c
index d79ba82..f2f8052 100644
--- a/refs.c
+++ b/refs.c
@@ -732,3 +732,8 @@ int check_refname_format(const char *refname, int flags)
 		return -1; /* Refname has only one component. */
 	return 0;
 }
+
+int is_branch(const char *refname)
+{
+	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
+}
-- 
2.4.2.644.g97b850b-twtrsrc
