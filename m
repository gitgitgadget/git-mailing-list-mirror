Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813F12023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753825AbdCBA4x (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:56:53 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35945 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753763AbdCBA4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:56:50 -0500
Received: by mail-pf0-f176.google.com with SMTP id x66so16170319pfb.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hGM18GTnTofYYgZpNNG5lwo5GRy1iTSh1N1vzvi2qe8=;
        b=Z4IXlFgnVh64cP8M8eBQeMyKwwHBv10cJverI9bK9TdhONx+o6cQTMljWX4WR5yTML
         +LKMVrekc3DdmvNKyKU4baTZo6BMlvXa0Mzw8LkUk/7u6FMDV5mISTIIrkdYylA90x71
         FGVSEggR3VD4eYPucrz+MnCJ9wOToFu7zyEnlf/XQ0QKFKy9f58XmLAbZRNxY83wIF9x
         teuq79s4JY7z+zswPgKztmpNln83fl9XlTrz1JEcCRgL0+ANo/kwNYsBHESNRNJnmAl5
         VdDQJHp/hAQAF+K42eHtnr5Jov0tAK2jsPlgnXqcr1/tIDoZHzT0hC+TyOaMVhG8D1tI
         zh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hGM18GTnTofYYgZpNNG5lwo5GRy1iTSh1N1vzvi2qe8=;
        b=rI2tF9HXQysgQNzmpR3rAlb81i9rxifLhcNu5564TNKoWx6YNvku7Gjpm33FZXBXt9
         z8XWU456jBTKdYnAIhs7JY3TP2fqNVePx78DEf7fIcE9WBfCCpPn0O8NajfKtIM5vNYt
         eiS1bejCuCifraXWENHf9LQntJBek6iZMzguIqpFuzYMfP7g0BiL5h+DbNdGB1LiYGmm
         N9lmgWT8Qoebf8vDtVi5Pcg9zvnkEhjivLKCJUpemh2miPcEBEZCP8J3xWmaQ9yM/0mo
         xmbMECIVlweRyuazNAPCIZGOX7dvnEU0a5QuXBVRyHC3x7LMvY6phQWOn73PfwDDpGT5
         l5Aw==
X-Gm-Message-State: AMke39m0gJNNW1JGLPYYnOnMWj8EcCaSWTSl29m7VssQiMEKWqAEWbSaogvCYl6yFCUzBTgf
X-Received: by 10.99.168.76 with SMTP id i12mr12060210pgp.73.1488415688829;
        Wed, 01 Mar 2017 16:48:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id b67sm12771120pfj.81.2017.03.01.16.48.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 04/18] lib-submodule-update.sh: replace sha1 by hash
Date:   Wed,  1 Mar 2017 16:47:45 -0800
Message-Id: <20170302004759.27852-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
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
index a906c92cfb..83202c54fc 100755
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
2.12.0.rc1.52.ge239d7e709.dirty

