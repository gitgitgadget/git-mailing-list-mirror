From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 22/26] refs.c: move should_autocreate_reflog to common code
Date: Tue, 27 Oct 2015 22:14:23 -0400
Message-ID: <1445998467-11511-23-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:15:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGw-0001Nm-WD
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbbJ1CP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:15:26 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33431 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbbJ1CPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:19 -0400
Received: by igbkq10 with SMTP id kq10so108257461igb.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IR1bmTyHsgpTSUQlEBslXivR71vvwmFo5zYnfC/huZw=;
        b=btOIwdPvEwThx4Bx5eKuj6KJBwANQesstoB9EI8yFX8ND1X4MlOlN1WmLm6lbeD9yB
         fawZ/copMxuIwu+0M225eKeSv/gNScnMCTkJvFzrFUbcJdd/2dZYRFTRSpMOINek10Ll
         r6+VAZ5JVo89/c/ZIDzhZ3wGdJ66Jr1S4I2Qc+jP6mhWTsaSuabRpL+gclJpLbJRdSW6
         R9ns5IaPUMWG0O/6uMlR7GSoER3drrRPFxvSnp9GbR0piSyzJqHnqyoDd52f36JOZ2Ir
         KdLpCeOBPQJBNs14nxTR0Q6+HW9VkZ6qIGqSSJrmesdzxRBFx+9uYamIwEVtFbX8ZoSs
         PFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IR1bmTyHsgpTSUQlEBslXivR71vvwmFo5zYnfC/huZw=;
        b=D8DvpQmfu5krqPCIbnKbSsA43cJytTjamNjsConxYqNzbuPrbQhNLfN0b2ZvHHLUnR
         vEfUIanz5ptA074Vne/w0R8PNF/f9aMSM8ajftqwuPpjJRi3dsdhfr2GPuyJTfQrHszf
         efcXpE94QySYthiD+425GwzpgOAKdsBzglQMF1mQgcE8lwqfO6BLkayOr11/P+N86GTL
         4WQeYvQMWDvW80c1UCl+pNYh9SPNXFR53czT3Kj5+Oj1R7vVOw7Z13gc/SnYT18u6Dqn
         6Lp+EWQtbnDYyAp58t6sZJbr2smU2EZ2Hm3ogne4+hsLvNsZB5P6TaNUu6sfQbdBlqfp
         4vCQ==
X-Gm-Message-State: ALoCoQkqZpIm+C767D7caX2Krzoa6nfBDSFN7LPWgFqakmLz5a+nlXs+z+LR7CVRitp8qP/iBvqL
X-Received: by 10.50.225.102 with SMTP id rj6mr321983igc.95.1445998519195;
        Tue, 27 Oct 2015 19:15:19 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.15.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280340>

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs-be-files.c | 10 ----------
 refs.c          | 10 ++++++++++
 refs.h          |  2 ++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 23c2f78..680641d 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2600,16 +2600,6 @@ static int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
-static int should_autocreate_reflog(const char *refname)
-{
-	if (!log_all_ref_updates)
-		return 0;
-	return starts_with(refname, "refs/heads/") ||
-		starts_with(refname, "refs/remotes/") ||
-		starts_with(refname, "refs/notes/") ||
-		!strcmp(refname, "HEAD");
-}
-
 int verify_refname_available(const char *newname, struct string_list *extra,
 			     struct string_list *skip, struct strbuf *err)
 {
diff --git a/refs.c b/refs.c
index 3867549..056c172 100644
--- a/refs.c
+++ b/refs.c
@@ -625,6 +625,16 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 						  sha1, flags));
 }
 
+int should_autocreate_reflog(const char *refname)
+{
+	if (!log_all_ref_updates)
+		return 0;
+	return starts_with(refname, "refs/heads/") ||
+		starts_with(refname, "refs/remotes/") ||
+		starts_with(refname, "refs/notes/") ||
+		!strcmp(refname, "HEAD");
+}
+
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
diff --git a/refs.h b/refs.h
index ca60de5..ce99aef 100644
--- a/refs.h
+++ b/refs.h
@@ -58,6 +58,8 @@ extern const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 extern char *resolve_refdup(const char *refname, int resolve_flags,
 			    unsigned char *sha1, int *flags);
 
+extern int should_autocreate_reflog(const char *refname);
+
 extern int read_ref_full(const char *refname, int resolve_flags,
 			 unsigned char *sha1, int *flags);
 extern int read_ref(const char *refname, unsigned char *sha1);
-- 
2.4.2.658.g6d8523e-twtrsrc
