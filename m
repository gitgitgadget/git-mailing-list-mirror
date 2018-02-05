Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526CC1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeBFAHk (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:07:40 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38097 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbeBFAHa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:07:30 -0500
Received: by mail-pg0-f66.google.com with SMTP id l18so136959pgc.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5UmkpueRV1mttYoQSe5nhlouybBv59CUSjr5W5tTCG8=;
        b=N2d+bUeJbhGdyMOgI90MA6QerNWipDDvBA4v82cOSy9YBG2Pg0eyKkBqlNpN7r7cWc
         td5Apsxk8ekkWXy3vYHNMMeFRFmanMwu7t8Y0m5f5+3zb+oF8+ipEyn6BxiCqAw7FbTe
         56sdYa8A7DOSpF1N3/48uLUKDDtNebGwobfhsJX5HNGohx3xrb+RHcp21XlzCSnVakNF
         FcGRmEbxhr2jDvWEfMLl3N1ZlF2ZDbonFA4hQsNEj6QOPYVIo64q0MshIAJIQGN4SzIP
         TFd38Eb/gbJdo/g6HPtTjZDkaxc4Pmsd0OMSb8DN6XFI5AiyBdvETirxVpDOA3zz30HQ
         xbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5UmkpueRV1mttYoQSe5nhlouybBv59CUSjr5W5tTCG8=;
        b=YPtlIVrJmDKtNwJ8LT1ARg95msD/AgPKFux1VoNhoJP5BUikoToI4oEjRH4tBgQRdO
         HmnFSXkK9YIn91fHaGeA/SD4+NVrTPWs/lf2ZCq1oqtG2iwELS0QAg1cpBbRUrugEFww
         n7PkBlfLeXcTOIq90NmTUEg2jTLl0CbculzxNzOnHExksJM5q7U/+jd4gcjvXjwaX2wL
         g+XaeYndj+bAnebdPUpM0uQzSfesqL0fiZ5WDNpKzq6E5lO8t1+qmww4o0rubZnRAn6E
         Pfq++pPXei5WwY8fZ2NbgOc+kqk8o5SecJq24nPCWBHZooavj1RrYb5ibnwaMCPsjEWk
         eREQ==
X-Gm-Message-State: APf1xPCXQ6fFhagUjbDwbUV+vnXylLl+JSWC7naNxx96mfWscGRUSGQ+
        C8Zy7WGIFioKBgA9mM4OCsQrvdMi1gE=
X-Google-Smtp-Source: AH8x226Vxsyg7BQ7+rO5RIM2BYo/vMe0hdG/WIybSw/2lMqIEPos+XPeBIdyNkMkvnBOZbg1+WEwpg==
X-Received: by 10.98.83.71 with SMTP id h68mr518359pfb.198.1517875649150;
        Mon, 05 Feb 2018 16:07:29 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n1sm5678642pfh.185.2018.02.05.16.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:07:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 064/194] repository: allow lookup_replace_object to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:55:25 -0800
Message-Id: <20180205235735.216710-44-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/replace-object.h b/replace-object.h
index c61ee66e95..f4666afc2a 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -21,14 +21,14 @@ extern const unsigned char *do_lookup_replace_object(struct repository *r, const
  * either sha1 or a pointer to a permanently-allocated value.  When
  * object replacement is suppressed, always return sha1.
  */
-#define lookup_replace_object(r, s) lookup_replace_object_##r(s)
-static inline const unsigned char *lookup_replace_object_the_repository(const unsigned char *sha1)
+static inline const unsigned char *lookup_replace_object(struct repository *r,
+							 const unsigned char *sha1)
 {
 	if (!check_replace_refs ||
-	    (the_repository->objects.replacements.prepared &&
-	     the_repository->objects.replacements.nr == 0))
+	    (r->objects.replacements.prepared &&
+	     r->objects.replacements.nr == 0))
 		return sha1;
-	return do_lookup_replace_object(the_repository, sha1);
+	return do_lookup_replace_object(r, sha1);
 }
 
 #endif /* REPLACE_OBJECT_H */
-- 
2.15.1.433.g936d1b9894.dirty

