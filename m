Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD42BC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbiCWJPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbiCWJO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:14:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AAD75631
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h19so43571pfv.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kU1r40q4bbAX0HhIyOD0tXPK6t8gwvZYzi4SgPP1uGs=;
        b=XDCow0Ci8z4mx9LMoL2ZxVneiztivmOpqQAOo8yuZ28a1AXQvZmBEIqnlWaq6HjcBW
         gaE+rOSdeBS3/SyWiRe+efk61luKT1nSTJR5qcn3SZIcVVscoTuu4nh4f46CgNtJLXK5
         cA/7MH3C32ColvhkC2AllCe212iLV+utncNXdC7obn1jCvmiycT9MhLE+fAQb2B2X1Vs
         gBoesqX+fS9NBsx/zqnFW9X3JEYJlo99H4G+AcdTiuz2wc59GxAWd4tCLwu0uDaZ8wC7
         +ps4zjwcOnHhrEWZR0Lsh0dBlht01P5m2gVWTh5dg8n6sW0yUVlPV11XkvLCLc+D6qv2
         GLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kU1r40q4bbAX0HhIyOD0tXPK6t8gwvZYzi4SgPP1uGs=;
        b=lvhBXLM382eQfhz7pqI18EIPvgk/yrrTEsgJDv3ma+cjI6yx9omtaBOKzkgxEm2C9P
         Urk6YIISzTXlA9Y/cN/DQMihYD1JP3fOWeXhA/GRE5AcdKcZKN7iaH7m/szVfF7BX7SM
         lA2s8pg73+eUV4s4e+RdKZ4BACLl+CE3nNfgm/Cs9IVRUW6g5crwS7Quj+ECP3KxDXuK
         b8pfVcWfiweLGJxfhLkBXWx1quvXdvtSCkt3gHrRDAbRlyFbQjCVjyKx1s20CcRMWgPE
         971BXuwCFu+9LutryunJ03RZU6P/VcYcnzMlDW0iVA+c181X4j23DDXJH2LXtLi7NHhD
         tkLQ==
X-Gm-Message-State: AOAM530sZpWDUPjmXjnk7KeA+RboRCYW289GKo8JX6uaUW2WtNuIA2gP
        nkIdUEgCrBY2rQ1ffK2G/n7QC7jMjjsMzA==
X-Google-Smtp-Source: ABdhPJzmVLwbyKeTcQTwLrFwlK8Rn1qW7ZW/HUlTK6QInq4I7iq247MY2/HmYWJkKoiR0W4eO1D2VQ==
X-Received: by 2002:a65:6390:0:b0:376:7f43:e9a1 with SMTP id h16-20020a656390000000b003767f43e9a1mr24972933pgv.480.1648026804497;
        Wed, 23 Mar 2022 02:13:24 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:24 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 01/15] ls-tree tests: add tests for --name-status
Date:   Wed, 23 Mar 2022 17:13:01 +0800
Message-Id: <ef1cf83d5ea62cd4ce4dbba403b2eae654f7bc5b.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The --name-status synonym for --name-only added in
c639a5548a5 (ls-tree: --name-only, 2005-12-01) had no tests, let's
make sure it works the same way as its sibling.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t3101-ls-tree-dirname.sh | 55 ++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 05fde64225..217006d1bf 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -201,31 +201,34 @@ EOF
 	test_cmp expected check
 '
 
-test_expect_success 'ls-tree --name-only' '
-	git ls-tree --name-only $tree >current &&
-	cat >expected <<\EOF &&
-1.txt
-2.txt
-path0
-path1
-path2
-path3
-EOF
-	test_output
-'
-
-test_expect_success 'ls-tree --name-only -r' '
-	git ls-tree --name-only -r $tree >current &&
-	cat >expected <<\EOF &&
-1.txt
-2.txt
-path0/a/b/c/1.txt
-path1/b/c/1.txt
-path2/1.txt
-path3/1.txt
-path3/2.txt
-EOF
-	test_output
-'
+for opt in --name-only --name-status
+do
+	test_expect_success "ls-tree $opt" '
+		git ls-tree $opt $tree >current &&
+		cat >expected <<-\EOF &&
+		1.txt
+		2.txt
+		path0
+		path1
+		path2
+		path3
+		EOF
+		test_output
+	'
+
+	test_expect_success "ls-tree $opt -r" '
+		git ls-tree $opt -r $tree >current &&
+		cat >expected <<-\EOF &&
+		1.txt
+		2.txt
+		path0/a/b/c/1.txt
+		path1/b/c/1.txt
+		path2/1.txt
+		path3/1.txt
+		path3/2.txt
+		EOF
+		test_output
+	'
+done
 
 test_done
-- 
2.34.1.404.g92931a4a2c.dirty

