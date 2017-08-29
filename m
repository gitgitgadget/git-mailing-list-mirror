Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21861F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 17:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbdH2RTA (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 13:19:00 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35322 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdH2RS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 13:18:59 -0400
Received: by mail-wr0-f194.google.com with SMTP id a47so2714891wra.2
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hgi33F4lpzbu84LubcHflOK5Xsi9SrdiUXvakr8Rd1M=;
        b=Hk8slK0v6z+r6X+voF9ohF1x/viTPlGH8FRHnUZQ8ON01+lzrljRhWngvsFYXXL3G9
         EsyXbiJcuHyWUr+Bj7BHm81i90/t6rWsfKiSKC+O+5NAt+uHV97ic4gn3oqvUkU8OA9U
         UThTrQFUSpJDluJytAddgRDH8rFOVvNhqjhUX1g2WxMky2UfgYMJU6eDz8uLcXvoAUGZ
         ZWq4ocAFBWZ8MET2etEoQB6fxvcbARhnlts6Lqc4Wm4iQxXz7pavySMfc+qNJgv715DC
         V45Kau7zRPn+t0whJtIdyJrixkYyYa7RbqrC811RKDRQjJ6NbzDc3afBwpgl7ZoE4ZbN
         /8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hgi33F4lpzbu84LubcHflOK5Xsi9SrdiUXvakr8Rd1M=;
        b=KlczbnbMjrVRGXZP9m98mHoEo3QjD+COyyLMUCkBpF4i/Zfs1JGkaITv527piyzHQw
         qS1doS7jZ1QfdzssyzBOtAPeCTSl5KUCHnEmrfc0c8JW+Xn7x66QriGyQKQyKzL1N2od
         wPu7q6bWPXH/TrnkTSCFbwAa6RGP21cvpfvSfl3DE443PymzgC6D2cbu11hXbt+zs9Ld
         XEEyT18GDr6PhbulwmnxuakdCp0MKkrXPfeobgCUeFvtxZSNiud14Q1ikI7WuzZErdzY
         1rZmTa0HGObFdkI98ocnrqp99dZElHUeWz3dC+PJS9RY1IuRzbae/TFUzGsvj7yXPdvs
         c/dg==
X-Gm-Message-State: AHYfb5hXT730dG14HM2hm16KyZiy/CD6EeDxlfpAH+ubhf9rZrdelqJR
        iioAbgMWqN2Trshy
X-Received: by 10.223.139.19 with SMTP id n19mr645408wra.158.1504027137893;
        Tue, 29 Aug 2017 10:18:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id r12sm3054921wrr.28.2017.08.29.10.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 10:18:57 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 3/3] refs/files-backend: correct return value in lock_ref_for_update
Date:   Tue, 29 Aug 2017 19:18:24 +0200
Message-Id: <cbcdc8f166287394179c2ab7f3a0564a0d0eee6d.1504024261.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.g45c1275a3.dirty
In-Reply-To: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In one code path we return a literal -1 and not a symbolic constant. The
value -1 would be interpreted as TRANSACTION_NAME_CONFLICT, which is
wrong. Use TRANSACTION_GENERIC_ERROR instead (that is the only other
return value we have to choose from).

Noticed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v3: this is a new patch, as suggested by Michael

 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a2b3df21b..ad05d1d5f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2311,7 +2311,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
 						    original_update_refname(update));
-					ret = -1;
+					ret = TRANSACTION_GENERIC_ERROR;
 					goto out;
 				}
 			} else if (check_old_oid(update, &lock->old_oid, err)) {
-- 
2.14.1.151.g45c1275a3.dirty

