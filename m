From: David Turner <dturner@twopensource.com>
Subject: [PATCH 22/24] show_head_ref(): check the result of resolve_ref_namespace()
Date: Thu,  7 Apr 2016 15:03:09 -0400
Message-ID: <1460055791-23313-23-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDl-0007MT-Qj
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbcDGTDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:54 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34421 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394AbcDGTDq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:46 -0400
Received: by mail-qg0-f46.google.com with SMTP id c6so71719980qga.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=sLR8vLTn+t1+CArlds3EWVZ51R775dTQmKJFM6nSxKo=;
        b=QjmtwU/cfFJUf94CFGsLITKU7WCs4VhNE9cuSwwZaIu7yLltCgslWqyzp0DYJ5K1Er
         Efiq55pxHkNVoDH3f5lDl4hOtSO0huCqv4S0SzNABJ1/pxzxRYd93LMY0cwp4Lp7A+Mm
         aig01NapyyII8t+K/pzN3r7dxi8duq0c5H9KKWOf/6HrnH4lD2hexFxM0bXBNgFNk5ln
         F72ajPldQJt3xcoqYtFbgsjU72UwNyH5mQIxCJTkxhpB94wl1asSmFXRV4Z3FbHV/N7e
         RpZxudzEblHqwPI+98pRTwVCIjOr+lez9GHB/xhqgvDa8I/hlSOIZyDr8Zp7Weo0BVLu
         RRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=sLR8vLTn+t1+CArlds3EWVZ51R775dTQmKJFM6nSxKo=;
        b=koESfSL2cQ81XQZx7yOl+TjRf2PlHDuHAFtJL6MnFHAtTCEBmpz9fF1xh6UHREMYg9
         K0P2ipLxXrx01ZLb8zcPjXzZ1vwz0bkt6W0vF0+tdcAJqYcSZG4QZf1M42tbVd3kXF+m
         /TOiuammeXIZKb7MTB2ixbg77tXf+mDLM/51PK5mOapp682dF4uIqMNIUkbx2fE+ytFI
         KR7OB6c9dMmIvEct7xi2gvoBaRnsLc4l99lUIXkxxiagJzYb2u213C1/SzBtVYnNFxev
         YV8xHgAMWya2VLr6PNMkSFqk1GuOuJFrYMA9tp6mqgF+YJC9fsqa03A8ukVVjPtgOcdn
         jszw==
X-Gm-Message-State: AD7BkJIA2NkZ9oVXzWC2LVxrEGAjrZupzQ4nfCTLOVE7dE4QFsXUkQAEpDj6Nl+4LRx7Uw==
X-Received: by 10.140.86.101 with SMTP id o92mr6101445qgd.49.1460055825276;
        Thu, 07 Apr 2016 12:03:45 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290964>

From: Michael Haggerty <mhagger@alum.mit.edu>

Only use the result of resolve_ref_namespace() if it is non-NULL.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 http-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 8870a26..2148814 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -484,9 +484,9 @@ static int show_head_ref(const char *refname, const struct object_id *oid,
 		const char *target = resolve_ref_unsafe(refname,
 							RESOLVE_REF_READING,
 							unused.hash, NULL);
-		const char *target_nons = strip_namespace(target);
 
-		strbuf_addf(buf, "ref: %s\n", target_nons);
+		if (target)
+			strbuf_addf(buf, "ref: %s\n", strip_namespace(target));
 	} else {
 		strbuf_addf(buf, "%s\n", oid_to_hex(oid));
 	}
-- 
2.4.2.767.g62658d5-twtrsrc
