Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE9E1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 15:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbeIFTt4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 15:49:56 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:35506 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbeIFTt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 15:49:56 -0400
Received: by mail-qk1-f170.google.com with SMTP id f62-v6so5828838qke.2
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J23U6IQtOQ6vgZuX4UZmK/7c2xEeMi72y4MQgUju0/o=;
        b=RJtjRVsSxxPozI1/ZuvB8MDWXoaMdtYC5et9vTsJZBbTn7u5DaC7tlHx/8F93rFzZW
         cDRHvXx9l4fcK27lEeK8K/mSDkjYSVAlZqgLm0kFsAUOpD8Q1Vbtf+lAXW+fg35IMSNd
         zyp0jlOABZFTATnXfFHhvSg3lpPfJIkFe6flygPAMPW2h2tx816/GW+YMdXd0MF2zZnI
         DYpsq70ktcicagO4/oZ0n2jBtIw368rgk7ugi4q1oUYPfJ+tKKY2Oh/dR2oeUzkLIWf6
         QSCO0d3eiIikfemEsMezy3qJROigqTqqmcXo7oBuUxBQ3kdKbVtoLwNSLdQsexZCcY+0
         PXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J23U6IQtOQ6vgZuX4UZmK/7c2xEeMi72y4MQgUju0/o=;
        b=m2J1vQqlklX5mcTN51F+rt1Y0Z7sZ7FWUfzlDYLZZSKPKJeOPL43v28TwUkmTzqtgB
         sTou2ekGjHggkv24x3YcEra+kYe3fwJXFThGW6mjOVfsCd2CREATTKwzKC4XjqHy9Uv+
         T3ASEYozm6jAoldtz6gFEoo7WATlLsNRMyYTlzC/vxwFrFU4jrMVE6sH+JMidEHeY3Wt
         J4YMvx6Mzm5ax7a/DA1C9yJf0OBup4jP9z6RQcO5uwMTmTVs8cC+V0fIXT00Y/pMEZQE
         yoyb7y1EuveG1xKsRti4X+Vv0yK66EnlQrx71w/fs4lwhASyUPzKVeQRsvsplSUvyHEA
         an+Q==
X-Gm-Message-State: APzg51CWWgHhiPy8qpE5Gj7mhilwkacC4LTVmJF2RGng4C14A7OIXeEf
        nExT6kHdH7UvL+obfX7I38ECyDdY
X-Google-Smtp-Source: ANB0VdZxvpNJ0FCGMS6kjbM0qJBHDWCnHh+xfIHOrZdRITs7ZF1zNmYel6YHlULhM56/jCQcJKevvA==
X-Received: by 2002:a37:bf82:: with SMTP id p124-v6mr2500438qkf.46.1536246837082;
        Thu, 06 Sep 2018 08:13:57 -0700 (PDT)
Received: from linux.mshome.net ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id z3-v6sm2752030qkc.55.2018.09.06.08.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:13:51 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 4/6] test-tool: start trace2 environment
Date:   Thu,  6 Sep 2018 15:13:07 +0000
Message-Id: <20180906151309.66712-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906151309.66712-1-dstolee@microsoft.com>
References: <2ba9d81a-5578-a81c-a7d9-179864cb4277@gmail.com>
 <20180906151309.66712-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-tool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 7566b0786a..f70d5d74f8 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "test-tool.h"
+#include "trace2.h"
 
 struct test_cmd {
 	const char *name;
@@ -55,6 +56,8 @@ int cmd_main(int argc, const char **argv)
 	if (argc < 2)
 		die("I need a test name!");
 
+	trace2_start(argv);
+
 	for (i = 0; i < ARRAY_SIZE(cmds); i++) {
 		if (!strcmp(cmds[i].name, argv[1])) {
 			argv++;
-- 
2.19.0.rc2

