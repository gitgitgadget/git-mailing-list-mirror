Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3EE202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbdCIWQG (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:06 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36451 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbdCIWQD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:03 -0500
Received: by mail-pf0-f171.google.com with SMTP id o126so33729643pfb.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZDF3DbMhnPfCIAUK5zifzrFLjOCrVQX9po73ND/L8NU=;
        b=iav0vGOxsLlT0EZQlkb1rgq7eG+pau2ttFre0KUzrHsbzkN4Z/kpxz2AlsYgJjxGX3
         wB8l94SW5fhSR4A7APzNh68y16JLZlXgzg1jwZ8JLgdpc0BOU3YCdtBCLWpFyyi6w5WO
         u56cpjbVnSJ4ybRnyJXG9yIxrKs9kx7hpnxGeld5Iq293T8ifHGWQoZ011+3a1/bfddJ
         8NeOjpDKn9lcBDLqixJX27jAFI5npQwS5rHNjbKJrTYAd/wmYELmutCOwZ9B4HfAXzMm
         xybd5VtWmGDiouj7IRM2tc9KERFidvErhfbxS5kpsFSKH37OG/j+yA6JY7KrXr5Wnm5X
         vbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZDF3DbMhnPfCIAUK5zifzrFLjOCrVQX9po73ND/L8NU=;
        b=Z1bogvhEqT8E8+QBpWRCohGqRz7z5/ZKLlq8kymR7nJavuVsrHqB4kRgrgLdAl8/x1
         b6T7ahuS8VjeCyYQmuCoUJdeVDZVn+edxXvtMT6wIiz+kAGEnDlbxxzw5qFubj1ExlNz
         6gQ3I2hMqmJZk6i0pTvwizAJfBMItKmMpdsWhS3ikIqbq8TqCh7OuSs0OCUnekC7zr7i
         aWObmZyxXhVI3L+L6i+IHPcXX8s+1WopZgBlzDwc4ev7enDPwxyivDqZFCIwehKsgRtf
         Zk7Uzk7wHtBTqF8oI/yoi+NBPK6o1vdTvuIUeuPESh6Fa2QhogRMO0fHlfUtcvW95Xaa
         e67w==
X-Gm-Message-State: AMke39ljwfnxJqSMqrS/5O4GRKbaVZyvdkacZlK+nGRUUPFBjYZ0d/yuSKXm8aFN0IbI18/4
X-Received: by 10.98.212.81 with SMTP id u17mr17011934pfl.75.1489097761620;
        Thu, 09 Mar 2017 14:16:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id e129sm14376792pfe.8.2017.03.09.14.16.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:16:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 04/17] lib-submodule-update.sh: replace sha1 by hash
Date:   Thu,  9 Mar 2017 14:15:30 -0800
Message-Id: <20170309221543.15897-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cleaning up code by generalising it.
Currently the mailing list discusses yet again how
to migrate away from sha1.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 00128f28b5..f52c49c838 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -171,9 +171,9 @@ reset_work_tree_to () {
 		git checkout -f "$1" &&
 		git status -u -s >actual &&
 		test_must_be_empty actual &&
-		sha1=$(git rev-parse --revs-only HEAD:sub1) &&
-		if test -n "$sha1" &&
-		   test $(cd "../submodule_update_sub1" && git rev-parse --verify "$sha1^{commit}")
+		hash=$(git rev-parse --revs-only HEAD:sub1) &&
+		if test -n "$hash" &&
+		   test $(cd "../submodule_update_sub1" && git rev-parse --verify "$hash^{commit}")
 		then
 			git submodule update --init --recursive "sub1"
 		fi
-- 
2.12.0.rc1.45.g207f5fbb2b

