Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ADC520899
	for <e@80x24.org>; Sun, 20 Aug 2017 20:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbdHTUJy (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 16:09:54 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38263 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753191AbdHTUJj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 16:09:39 -0400
Received: by mail-lf0-f67.google.com with SMTP id y15so9171701lfd.5
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JnRRAwKkrIZ2UoXWTrZMKsS77Sw9T3/AWb6XFQpkfX8=;
        b=HFQOM+Xb9TYoVXq9QBdFyKkBfdBUpe/9i+5KfWkh35YfL0C9DIZOqFCdI7AEyq51sm
         EK3ei+Fec3JtY8PwXRisVFB7Heoq9L1Ote2YgwF6xgzntRdTsa4+nWgZmnw9eIkUFBPW
         AUXQ5+nqAxRijIVqhIsHATUgkOpNy2X7HJEvNS14NW13vP+lsh+/3BQl3XM5gC4HG186
         WPNlz2FW5wpK8D4HSEaolNBOQjMkbnRuWEjP35U5a5PSTdwzNncNrrWONDbtZ055MtKQ
         UxGfye3NlUboAUJpRetDfdzofMd1tFo0ExZwEJMAhs7xaLb5SbXMFPvdss8yICK/pWu2
         VhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=JnRRAwKkrIZ2UoXWTrZMKsS77Sw9T3/AWb6XFQpkfX8=;
        b=GxQdyuFREbVtKtZ/yNHNH+Pv3+Txkfpmo4muj4/wIHFnT1VcAp9zd/TKfDJr742o0a
         csVsdUqfDjaT/cs2twMTohYtk/yBiXt6YegZDYvDEh7Ig9lUG8X3mGmVC0AA562jWgKw
         mFGNQDfMd1y7vIQUmTnB60s8LF8QwpYAYX7JPRXK9uf4yrx6u6/QCiaJTdphxD/+vRMU
         z+9dh5a7NplFIl0p2cUbJpSJFeQYLGr/GmXmoCwfeEYOBYbVgkK3z9JzIJp1wW92DKMZ
         RVRxRc7Ey2PRqSw9dlgIkw0hihpPd5cIBt8xnii9Zz1sdAXJlkefZKTLZCwQcFmy0Sux
         FIlQ==
X-Gm-Message-State: AHYfb5ikaqZ2mUHDo5AUkAZSeQBXyySkSLwCpgnc/bXg97ABRZYSdYLk
        7t9ZTdSdsjicGaKTz9s=
X-Received: by 10.46.81.66 with SMTP id b2mr5268357lje.0.1503259778258;
        Sun, 20 Aug 2017 13:09:38 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id a64sm928869lfl.36.2017.08.20.13.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2017 13:09:37 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/6] read-cache: convert to struct object_id
Date:   Sun, 20 Aug 2017 22:09:27 +0200
Message-Id: <27ec6a8d1b6fc49cadf7f9e7fed2c2605e02f626.1503258223.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503258223.git.patryk.obara@gmail.com>
References: <cover.1503258223.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503258223.git.patryk.obara@gmail.com>
References: <cover.1503258223.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace hashcmp with oidcmp.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 read-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index acfb028..7285608 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -160,9 +160,9 @@ static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 	int fd = git_open_cloexec(ce->name, O_RDONLY);
 
 	if (fd >= 0) {
-		unsigned char sha1[20];
-		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
-			match = hashcmp(sha1, ce->oid.hash);
+		struct object_id oid;
+		if (!index_fd(oid.hash, fd, st, OBJ_BLOB, ce->name, 0))
+			match = oidcmp(&oid, &ce->oid);
 		/* index_fd() closed the file descriptor already */
 	}
 	return match;
-- 
2.9.5

