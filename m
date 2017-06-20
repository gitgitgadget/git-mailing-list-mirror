Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B8620401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbdFTH4W (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33706 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbdFTH4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id f90so21268709wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IwZ+PPDsZCrEn1Ch7McawWVoCgtFzXsQeZK3fYrlVMk=;
        b=SGQ2NuueTbQC7PCrsOUpU2CrX0pcWa6z40FHPlGGKhJ9C/6qmewOl6P/dA1dY2/GWT
         eixXqerQt2eT4KwJlG3bOAJNH3Na2gSAIW6T7DOYiBDwTt7X5q2hXdaquTAbaat3X+xt
         gTAVDNwREcaekd/HWTktzuJOz3EjMAm6w4jBLxtDaWkPhcvKjs3pGm+ed97HQqsqQ4+V
         D5QVblWF3YeVfI1yeHorax3cfvAfCgUG1k8MLNS2wvAHSbVIOj4U9CTt/R4AmZ7LfFHR
         LvLXgo+MTQQnwWdj1VbYbwKSWnGADYCELYnm/VLvbvLN9tabEFYPRAK+rCTVZZKiu+fs
         fHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IwZ+PPDsZCrEn1Ch7McawWVoCgtFzXsQeZK3fYrlVMk=;
        b=J4SThdJGnnYVFdR2cYQDZfzh2G1/NK6xfEcFrZBpB7yl/IHCujN2mt8GdUYKncG+0n
         i5o5xTiLj3XhalB0LJZbdzg2A2brn3pz4nNWEVyFC1lAAcUxDUe+FF2t4qF5vzj+xJzU
         wL/iddA8e9nt/QzJTfNKMQpwAk1Sb19Ec2G0zmgm0YJvMIpVm0BWi0y+TlNvm97sKjsI
         GLvAM7wBSJnwauKz0Ia0bDJB66qZ18seSA+KBY07HYfTj9HSpT1PVgYP+b0VdBGJtYFP
         O+NxXI00hRU7Gdpvp3GwqOR/5P3eczPjbQNi8aGQpATmaRpDlxkItwz3zk/2DrHjQGAW
         hOdw==
X-Gm-Message-State: AKS2vOytybEbCcN3PlyW2gJslLm4Zhfye7iL/a69DjMkg34W6N+ZkJvc
        SC9rnLcDvxFVCnYK
X-Received: by 10.28.147.148 with SMTP id v142mr2701350wmd.1.1497945367830;
        Tue, 20 Jun 2017 00:56:07 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:07 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 14/49] t0400: add test for external odb write support
Date:   Tue, 20 Jun 2017 09:54:48 +0200
Message-Id: <20170620075523.26961-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 6c6da5cf4f..3c868cad4c 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -66,4 +66,12 @@ test_expect_success 'helper can add objects to alt repo' '
 	test "$size" -eq "$alt_size"
 '
 
+test_expect_success 'commit adds objects to alt repo' '
+	test_config odb.magic.command "$HELPER" &&
+	test_commit three &&
+	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
+	content=$(cd alt-repo && git show "$hash3") &&
+	test "$content" = "three"
+'
+
 test_done
-- 
2.13.1.565.gbfcd7a9048

