Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA1020401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbdFTH4f (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:35 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35221 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbdFTH4c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:32 -0400
Received: by mail-wr0-f193.google.com with SMTP id z45so16318180wrb.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DZAqWY1LEjZU93NJOfqlTfoysjlYNnnswWIKjVPLPzE=;
        b=kGO7N21SPQK9juAOSrSovqp39JSFiKGhNvdqStR498fI/bHn5Dysat4maNY4oIXN7N
         UHncPD4lDvQGbJlrZM3ARtvXBzCOoXe4mbmWFBRMH+AMaaRxPS+nNjpxyLzY2xvGO7Gu
         CvzMGDsp96209II5QRSoUzZGdbo3FvxocNKzjp14fMPsGVm6yYjwrByZnnOmQyCC0/5n
         ssfwIxr6HhPw9nmcXUSAkPWCltPgjCzeIlTLkkG2bc9GWPDiafKd/JQq1l/WwI37Znmi
         P3wYQRndWsu9VSUKADNF2RD1h8DGePYrJVz4kv2B5L5oyB/QI8VjjXyW1yRLLQyZdbH0
         bIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DZAqWY1LEjZU93NJOfqlTfoysjlYNnnswWIKjVPLPzE=;
        b=f2NmgJ5dOd5ds0P7LXCNJH0ETah8aDqtitwVhgLNs2n0G0I8lmlwyejBoavBvMgL+Y
         bDadweXqObERvjepGdCIizOYc022jky6eV3yqrvJor2e5xmwbP+pRyre685IbGuM3uIC
         1V2wHIfrFBJy93xztHsILmzscXa//hcUf385/5C0gUvkaaoLxhSoZORTPP6sEbZ4eBGH
         EzU9x0pgQiP72/dK3N+O5i1cWb8RulNwcuEG6Z2EYYZbsthBj5b7SRYA33neTPHJrA2t
         HiMb/08EUEEndcognzbstxj10osW3Avpr4xqN5Y6beirbfSOMNNTBTbd6IOJH/Vjty6C
         6Cbg==
X-Gm-Message-State: AKS2vOylYdQqmuBXpwIOk6fSh7kTzfZbBD10Y0Q68NoXZqj78VmRDSv4
        FspIOjNTZCjVDpUm
X-Received: by 10.223.148.226 with SMTP id 89mr6451191wrr.169.1497945390853;
        Tue, 20 Jun 2017 00:56:30 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:30 -0700 (PDT)
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
Subject: [RFC/PATCH v4 32/49] t04*: add 'get_cap' support to helpers
Date:   Tue, 20 Jun 2017 09:55:06 +0200
Message-Id: <20170620075523.26961-33-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh        | 4 ++++
 t/t0410-transfer-e-odb.sh      | 8 ++++++++
 t/t0420-transfer-http-e-odb.sh | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 18d8c38862..efabf90a8b 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -13,6 +13,10 @@ die() {
 }
 GIT_DIR=$ALT_SOURCE; export GIT_DIR
 case "$1" in
+get_cap)
+	echo "capability=get"
+	echo "capability=have"
+	;;
 have)
 	git cat-file --batch-check --batch-all-objects |
 	awk '{print $1 " " $3 " " $2}'
diff --git a/t/t0410-transfer-e-odb.sh b/t/t0410-transfer-e-odb.sh
index 8de9a08d7c..0c9cc3af7d 100755
--- a/t/t0410-transfer-e-odb.sh
+++ b/t/t0410-transfer-e-odb.sh
@@ -16,6 +16,10 @@ die() {
 }
 GIT_DIR=$ALT_SOURCE1; export GIT_DIR
 case "$1" in
+get_cap)
+	echo "capability=get"
+	echo "capability=have"
+	;;
 have)
 	git cat-file --batch-check --batch-all-objects |
 	awk '{print $1 " " $3 " " $2}'
@@ -51,6 +55,10 @@ die() {
 }
 GIT_DIR=$ALT_SOURCE2; export GIT_DIR
 case "$1" in
+get_cap)
+	echo "capability=get"
+	echo "capability=have"
+	;;
 have)
 	GIT_DIR=$OTHER_SOURCE git for-each-ref --format='%(objectname)' refs/odbs/magic/ | GIT_DIR=$OTHER_SOURCE xargs git show
 	;;
diff --git a/t/t0420-transfer-http-e-odb.sh b/t/t0420-transfer-http-e-odb.sh
index b8062d14c0..45e66e355c 100755
--- a/t/t0420-transfer-http-e-odb.sh
+++ b/t/t0420-transfer-http-e-odb.sh
@@ -22,6 +22,10 @@ die() {
 }
 echo >&2 "odb-http-helper args:" "$@"
 case "$1" in
+get_cap)
+	echo "capability=get"
+	echo "capability=have"
+	;;
 have)
 	list_url="$HTTPD_URL/list/"
 	curl "$list_url" ||
-- 
2.13.1.565.gbfcd7a9048

