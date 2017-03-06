Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6411B20133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754670AbdCFVIp (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:08:45 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:32775 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbdCFVIf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:08:35 -0500
Received: by mail-pg0-f44.google.com with SMTP id 25so70470248pgy.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JijJFJ0GhNNf3ogb7gNSmQ0ULL/Wn98rSODkq4VG53w=;
        b=GNbi2h8kMMFcOYvW54MnnRdBJq8AVfS20nZlsNlGHqTdObLsLnFTUmnnTazd3DNY2w
         hr/dwLQKHgQpdQV7DWB9jRg0ayY+xSAR1CKy9wmG7H8n2A3fhrjf+AZ0K+ClQb9YKEvu
         cP70dzdU/yaSuWcVV/yr4YlHUZV85rs0Mtji+NVKZ6fpu+wXHOh2ZAOXPdtJS7L4qAyh
         vdlz9YGS6J1ZsKt2WIXcHjoobfCV1lqE+NR+Pi2HxoUBbI/F1kkaa2zHTUPnLNm0oGk+
         5NAsqw1O0RWI7IMoHAxcUR1GNtbt9C70E/eHG+ZfkvJXsiedJ+jFON/WH247WELKVec+
         AZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JijJFJ0GhNNf3ogb7gNSmQ0ULL/Wn98rSODkq4VG53w=;
        b=s2hqXWR9IUeQj6kJ/GuSUn5yo3b8HJ8TIKugpGVpIN8i6X9IVw/tpA7gS2MPhptL/C
         chVz45GRYa+RCAnkC/VGp/VmUoB8pCER+83K02JYh8yiDBV/feXGgFvZKUq0vZ34CAg0
         PJ/IDFY9HNTbZSOH6HyhDAYgBxuBA8BlM/h9ozekuT/CgJk/5kUX2nekZMXz1HFxRvQj
         tZMXf+RS5E1h4TJOtXgbHNtXFt3mZqlPvQibM6xC8cDVSCI2uQoFnHqcuOYD+scLbnKP
         KEb/RQyAXPGbVP4sRnQj6sEE641esKFoHXOSY4DR1ct6OheOp1uSu6jITYuBxgb9WiEe
         Dlbg==
X-Gm-Message-State: AMke39kemcwZgLMWpfP8xQNWM5W4b25PwbaeBT6zewWDuXga2P3RoDrJ1KUcDAvtnM42ECW0
X-Received: by 10.84.241.69 with SMTP id u5mr29160556plm.107.1488833968618;
        Mon, 06 Mar 2017 12:59:28 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id 90sm28902740pfl.24.2017.03.06.12.59.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:27 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 04/18] lib-submodule-update.sh: replace sha1 by hash
Date:   Mon,  6 Mar 2017 12:59:05 -0800
Message-Id: <20170306205919.9713-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
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
2.12.0.rc1.52.ge239d7e709.dirty

