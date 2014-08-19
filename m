From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 12/23] refs.c: move resolve_refdup to common
Date: Tue, 19 Aug 2014 09:30:36 -0700
Message-ID: <1408465847-30384-13-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKX-0002zZ-6K
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbaHSQbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:03 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:57091 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbaHSQay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:54 -0400
Received: by mail-oi0-f74.google.com with SMTP id a141so1440115oig.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=32GKLAgRYQQB45RsDbLQ9IWzTIhDfAf5HP8HWcQp8q0=;
        b=Gsp6aRuoMT2B6ErmSmbH6pwjXrYuV4Kc1dM40jSrBp728d2X/4MEHKpyyLqNnL3VSh
         AEMmI/LD11A25ko402JFCfjpUFKQGJt0yyeve5bsgd/IAcQj+28ZqJZx5+ZIhTKlQXuH
         3D+sAMUYsKRDOFNp/7u3cky6GvmiHESVHji0nQFVsFMiptXGMu2UhhNTWZkI8FqfR+6J
         1oTMvF4IUpUdxtWjgICldhy0+Pr2f4ZaIEsFP9ExU0/okCgRKM+bvTCwujtbtXhkYesY
         n5wxfq05Ryg1Zx8LIomqV4rxjk8H3/NXOETqU14hZczBR6b1pZd67ySp6ZkUK1Z694x0
         hwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=32GKLAgRYQQB45RsDbLQ9IWzTIhDfAf5HP8HWcQp8q0=;
        b=m0OPahrXHno+qBCiO7zHAV8RFuwIzXGfRlzukO9Afb9XOmz37YV0kMsLTFU9BMNSxj
         PHynTV4iICfNB2bxy9mkxmybiDDhKvMXYTOEPPivxqA06syoNM74uGhnd+G0dVv03UhP
         Rn1c6R08BGw82mW1ixlo82uOvSfzO80Mhov5a8MlKkhkyrThirRo+c8Ns3o9Gs9Ytxa9
         A7n+rvqbG2JkYtI061yc6kGQi1oUJJIIzU9SgrB4P0BV9rrehUZcoKYgbjKThfOFWI5G
         i/Ghozsu+zucIaApCQJDUZJxysENZK5uZarZ9O8um1EPk1F+6JTxdCaYoP0k2wYpVKLQ
         l4/A==
X-Gm-Message-State: ALoCoQnBF/aHSZcr89tzYUgnUJEtaGfaUnJlNyHOzu6n9otRWPxzCjcgvuBMR1ykY0KK+WEIWRko
X-Received: by 10.182.107.135 with SMTP id hc7mr713802obb.48.1408465853483;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v20si329146yhe.2.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 52CE25A4428;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D0674E19F8; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255482>

This function can be shared across all refs backends so move it
to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 6 ------
 refs.c          | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index a94378e..ed7bc61 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
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
diff --git a/refs.c b/refs.c
index a0e6d81..b8582f8 100644
--- a/refs.c
+++ b/refs.c
@@ -567,3 +567,9 @@ int ref_exists(const char *refname)
 	unsigned char sha1[20];
 	return !!resolve_ref_unsafe(refname, sha1, RESOLVE_REF_READING, NULL);
 }
+
+char *resolve_refdup(const char *ref, unsigned char *sha1, int flags, int *ref_flag)
+{
+	const char *ret = resolve_ref_unsafe(ref, sha1, flags, ref_flag);
+	return ret ? xstrdup(ret) : NULL;
+}
-- 
2.0.1.552.g1af257a
