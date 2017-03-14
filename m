Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6FB120951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbdCNVrn (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:43 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33089 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbdCNVrI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:08 -0400
Received: by mail-pf0-f176.google.com with SMTP id w189so75907655pfb.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rqDss7J37ThjNdf5lMMhdKokun+YRQgUNAPIsItxOb4=;
        b=qUYWnnV11aI4g1h5uuLGrXZtBij/jK+gkes/1haf31yVJ7F82sIcvhaTLwxL7TGJjL
         /33y8HIF/0hAbx3nMqjbf3WrkyKQYSEWnp2RqQ6v09nHVuRRQRhTqvr3vTj7IHddOZns
         pj5ftq+kTex5XL6tUsjuCMxGCrhkBYSh1PJqalKaFyekk2a23ds8/eAX5oUpONPKhA5r
         1VJ1m3gKkTZo1tZYqrA2PHHdvHKk/wDou+/8izaxVOnztB1x1fkxDPyApT9EeRxqy5ZD
         q59yg1qywSFrp76zsgfgGgRs630eUEnjFuHoI1yjMYA9M7ZGg0kgNqRLUREUavcqct9j
         lDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rqDss7J37ThjNdf5lMMhdKokun+YRQgUNAPIsItxOb4=;
        b=DHMTF8slAKENjaTmSW6N4aZQhSB94/CH62mJSb2z/tPLL8KZ3JHwEUivANONTop1S3
         i1XqkpVVuBbAlTTKGsYzqBOoYAB3+EH3sWKEOeHdkEQ8Ma+d8hTIKpRqv7gwsKrlDZdQ
         yb2V3NKkdIHMgw1YxFe9H/dVD5zqf64K5i2dYy/mHNHsIrr8sOFo2TpxP2pZ5E7ubTua
         FSHoEEZ2GgPeqrfha1xTv3IZWq+n7n7SvjCpGpNc8PWaCsNJbbqqs2gu2RDhql8EHADK
         d7xeydPYih1EjQRchRB1n7KlC7iG7/GjwY700mMNF9Y1TA+NIBWVL6nand68Wx81WePX
         plQw==
X-Gm-Message-State: AMke39nP126y0QJ6Gr7pPVqIpCJXYdZptuYNAf/rOcLEUfkI7JKBf1K7YiTlcQeMKrSnR2Us
X-Received: by 10.99.114.70 with SMTP id c6mr46621997pgn.163.1489528016869;
        Tue, 14 Mar 2017 14:46:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id d3sm40324223pfc.51.2017.03.14.14.46.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:46:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 06/19] lib-submodule-update.sh: replace sha1 by hash
Date:   Tue, 14 Mar 2017 14:46:29 -0700
Message-Id: <20170314214642.7701-7-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
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
2.12.0.rc1.49.g0cfd38c5f6.dirty

