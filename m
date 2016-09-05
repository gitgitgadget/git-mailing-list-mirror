Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79CB820193
	for <e@80x24.org>; Mon,  5 Sep 2016 10:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933297AbcIEKYz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 06:24:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36022 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933087AbcIEKYv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 06:24:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id l65so4782304wmf.3
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CQ3CUj43FNYCXK5imz9+hUQoyvcpFKbep5IGlP5792k=;
        b=pCGjxChRNf8kXuSagYRRve6qdr3zumnLJ03FDVUUIMCpJ70rg6VXzo/WRaQyAK0QYD
         CtdafXq9VnaumUqEcch6xT2v0M7FZ4KUhZEzNpPkWvW8AcfEBesCf6EfTNbl/oofJFFz
         xlLHWKKmZtajn4byuQ1IJOy7irJ/+m9c5sRSviOOjMmJnQx372plBcl0gMxz8KLfFYzd
         lONNLaUSdhM4VGX2MSDV/g4ZKSjKwv4ZGwmU/3yzYXfngl1N+dUiHqvWZrRU8n86h4gV
         2N3+38mT+iINeEwLWu2HQGyYmmZAhyxBqwokRwEQKCggAdx2Gu9EWCBG35eulNKdD+7C
         85/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CQ3CUj43FNYCXK5imz9+hUQoyvcpFKbep5IGlP5792k=;
        b=YDUQKOd6p6sfdfh2Ry0bb7qP8nasdq3VikJfXJ4Fdk/GBUZ+9GqBTa++9tqO/VK6PX
         tL8uNgSG2J/D5FoOhgUrtD28Wa6cEpA1TAW/Kvdhse4zaJnSKV0WkISS0lRUmAOfyrID
         y+840fBmgM4GyOihxN4//DPjWOO6g8IS2TEuW16RJIK5ANnC8dazN0mtOektpVs7C9BP
         VGWlVn29/fpfc2oVvQxRSj4w0g6B4q/q5dz9iAOTKh+FdfplfVYNlVwu++TfY56lV2Ad
         eOAw3Q9nO8eUEIEhS0hMXMaAK/O9ji9dp+ycgOE8p3i1DZM8vLoyeSgql12w6pUTF6J7
         57jw==
X-Gm-Message-State: AE9vXwP7hc5t/FzMjFGpBaIrZ1qNrC32Ux2IabAUrCFLg6lOw1V4X0v7gbg2LZkWHqSlOQ==
X-Received: by 10.194.87.67 with SMTP id v3mr30290163wjz.103.1473071090426;
        Mon, 05 Sep 2016 03:24:50 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id gg10sm27001666wjd.4.2016.09.05.03.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 03:24:49 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 2/4] test-lib.sh: preserve GIT_TRACE_CURL from the environment
Date:   Mon,  5 Sep 2016 10:24:42 +0000
Message-Id: <20160905102444.3586-3-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.10.0.308.gf73994d
In-Reply-To: <20160905102444.3586-1-gitter.spiros@gmail.com>
References: <20160905102444.3586-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turning on this variable can be useful when debugging http
tests. It can break a few tests in t5541 if not set
to an absolute path but it is not a variable
that the user is likely to have enabled accidentally.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d731d66..986eba1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -89,6 +89,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 		UNZIP
 		PERF_
 		CURL_VERBOSE
+		TRACE_CURL
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
-- 
2.10.0.308.gf73994d

