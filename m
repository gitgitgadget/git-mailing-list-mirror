From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 11/22] refs-common.c: move resolve_refdup to common
Date: Fri,  8 Aug 2014 09:44:58 -0700
Message-ID: <1407516309-27989-12-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:45:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnIW-0007cZ-0s
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009AbaHHQpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:40 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:58156 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756329AbaHHQpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:16 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so763529yhl.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gSD6BuA9bv3PSYvoBeVsdcXC+7MWF/STB+vRLnbJb/E=;
        b=RCaWMKUhG/HD14Lwi4NLuzIxwCmBKLiVXM56IoiTysqA47/JhNTBWNxLzNbkuj20kP
         5Ww3QSf5E381miLfys8EvXIV0RKBQIFn1Bqc0/WRC/FeqF8pOmYTqlLstA8986xVNOdI
         s5CKvJ3yFElgVB9XohH1zq5UXXwAGssB3DUeSoCgHmIawO+obCc0COQymjGseXMGPtBU
         oR77QGcoUtKt7gflhtq191HoDtJ8cIJ1r87ke40Yql4MfecvxFcylSSmmQqEwYKzr/jD
         Y9Lk++mZ3A1UM7uEKfI7cINWZdtPoW3/puLpnuXPHPGXer7wfYZURRiklgsuYljkHFkM
         nQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gSD6BuA9bv3PSYvoBeVsdcXC+7MWF/STB+vRLnbJb/E=;
        b=FK8gPM+SdJreI2ECe7PDMxSBs9T/Ppcr3PvRxp28lrvc/rfQtgy9RgsgEchluiXekU
         uGPt3BXgywQ5ufDrZQWS6bRYHQZxt+ng35KpBowPFCGiwByPOkPnhXVcjQoDpuEgK4Ck
         Ps7UUKrUeamkPaO4a2GCP8hQk0/rTrOpYP7Q1pjhs43O7aA9c0bdnn8Mb2+Rqp4R2Ooe
         xi/WEkfi8S//ep2RjJIGzuab3c9y4iSL4U6JZOSOJo8IEjZCvLGUtvjWAVsU0jsXwzzI
         vPTtIyi5HVZP+ELnFBnANRzXzZu17e89OJuTGuiQ+dL0jebD1mjoLk2XTQfiHb79SMCO
         KCwQ==
X-Gm-Message-State: ALoCoQkXrLt+cv45rZ2ZpKJ50QQjz32TlnebnTeFpuPodapNMVOe6XJpy8eYKMx/SInmMWtdNXcm
X-Received: by 10.236.29.37 with SMTP id h25mr5305887yha.8.1407516315843;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v20si505275yhe.2.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AFF295A4618;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 55F92E0F65; Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255028>

This function can be shared across all refs backends so move it
to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 6 ++++++
 refs.c        | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 37d3d14..655a1a0 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -565,3 +565,9 @@ int ref_exists(const char *refname)
 	unsigned char sha1[20];
 	return !!resolve_ref_unsafe(refname, sha1, RESOLVE_REF_READING, NULL);
 }
+
+char *resolve_refdup(const char *ref, unsigned char *sha1, int flags, int *ref_flag)
+{
+	const char *ret = resolve_ref_unsafe(ref, sha1, flags, ref_flag);
+	return ret ? xstrdup(ret) : NULL;
+}
diff --git a/refs.c b/refs.c
index a94378e..ed7bc61 100644
--- a/refs.c
+++ b/refs.c
@@ -1501,12 +1501,6 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int fla
 	}
 }
 
-char *resolve_refdup(const char *ref, unsigned char *sha1, int flags, int *ref_flag)
-{
-	const char *ret = resolve_ref_unsafe(ref, sha1, flags, ref_flag);
-	return ret ? xstrdup(ret) : NULL;
-}
-
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
-- 
2.0.1.553.geee1b3e
