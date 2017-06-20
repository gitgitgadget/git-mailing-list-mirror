Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC47A20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbdFTH4d (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32810 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbdFTH4b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id f90so21270001wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dx5RKdCR/Q2VBc8GkqzSPCkJBntKUK5ry1DbRCUE0ZQ=;
        b=L67ORtjnCIBwg8QdDctpoIoBj3WAQoMfinul9AsmXD4OWzhwuiKJjl0qda1Y8YlUzm
         RcH2+IsE8tkuZfxpHNeDqBMz9wu6smTkdZiFQI1vUl6M2AhSn4iVLdloYMf3Q0h2TXTx
         gbZ9wKt3zQh99KuCU5w9+iuVutcsunFWjbO7PAnFrpmbi21atI+Yhs5gtZNH+Mt+hP5V
         +Ad4bTu7RP4rhNUzKaR0Oncj3hhe/Xqclo241f4yqD5/NUyDbSzDMo8dXAXmMUJtuRGq
         BKjlo21at2xCkRYD55MzR1DlhN+jeb2azc3VW0ixsNpBFYDCRPgxeluvrQ70DChBMYlt
         GHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dx5RKdCR/Q2VBc8GkqzSPCkJBntKUK5ry1DbRCUE0ZQ=;
        b=R3rW+LdBhJMv73R9FJ3po/WILra1TzeVDEK1VtoSm9yJCgLKivZ4Oggf3EYcQCGBqC
         Tvu42IZAiqoqZDqnB+OI93ETe5JRy8UrtqN712HeAZZtZyG8X89bawjXyriSJpQribGv
         2wSRJlyYUR+Ndm2qhN1XhK2DiK0H8EOUa9AA09NuvT6DhQ87koP328cb4BXQ8UoS34Uh
         VMEhRC8jCXZWT7XIzlU6eYCfGhPwkU8yISSVMD/R6IxSGCSdGNXjQdBW//Pq2pU0H+5A
         ukqXfDPOk/pD03/MhnQwRXPUgyM/w+tqxWvrPepd/nXSQQh7BAyOpt0yGkYloaxesPAt
         VhmQ==
X-Gm-Message-State: AKS2vOyTHySEwGhT89fZHwbXx0aNCHmaP61++ZPKXlsRJQ0mn+yKxUGo
        EOl8kSeZVKGMtnGe
X-Received: by 10.28.92.13 with SMTP id q13mr1749071wmb.20.1497945379563;
        Tue, 20 Jun 2017 00:56:19 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:18 -0700 (PDT)
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
Subject: [RFC/PATCH v4 23/49] t0420: add test with HTTP external odb
Date:   Tue, 20 Jun 2017 09:54:57 +0200
Message-Id: <20170620075523.26961-24-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This tests that an apache web server can be used as an
external object database and store files in their native
format instead of converting them to a Git object.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0420-transfer-http-e-odb.sh | 150 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100755 t/t0420-transfer-http-e-odb.sh

diff --git a/t/t0420-transfer-http-e-odb.sh b/t/t0420-transfer-http-e-odb.sh
new file mode 100755
index 0000000000..716d722e97
--- /dev/null
+++ b/t/t0420-transfer-http-e-odb.sh
@@ -0,0 +1,150 @@
+#!/bin/sh
+
+test_description='tests for transfering external objects to an HTTPD server'
+
+. ./test-lib.sh
+
+# If we don't specify a port, the current test number will be used
+# which will not work as it is less than 1024, so it can only be used by root.
+LIB_HTTPD_PORT=$(expr ${this_test#t} + 12000)
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+
+start_httpd apache-e-odb.conf
+
+# odb helper script must see this
+export HTTPD_URL
+
+write_script odb-http-helper <<\EOF
+die() {
+	printf >&2 "%s\n" "$@"
+	exit 1
+}
+echo >&2 "odb-http-helper args:" "$@"
+case "$1" in
+have)
+	list_url="$HTTPD_URL/list/"
+	curl "$list_url" ||
+	die "curl '$list_url' failed"
+	;;
+get)
+	get_url="$HTTPD_URL/list/?sha1=$2"
+	curl "$get_url" ||
+	die "curl '$get_url' failed"
+	;;
+put)
+	sha1="$2"
+	size="$3"
+	kind="$4"
+	upload_url="$HTTPD_URL/upload/?sha1=$sha1&size=$size&type=$kind"
+	curl --data-binary @- --include "$upload_url" >out ||
+	die "curl '$upload_url' failed"
+	ref_hash=$(echo "$sha1 $size $kind" | GIT_NO_EXTERNAL_ODB=1 git hash-object -w -t blob --stdin) || exit
+	git update-ref refs/odbs/magic/"$sha1" "$ref_hash"
+	;;
+*)
+	die "unknown command '$1'"
+	;;
+esac
+EOF
+HELPER="\"$PWD\"/odb-http-helper"
+
+
+test_expect_success 'setup repo with a root commit and the helper' '
+	test_commit zero &&
+	git config odb.magic.command "$HELPER" &&
+	git config odb.magic.plainObjects "true"
+'
+
+test_expect_success 'setup another repo from the first one' '
+	git init other-repo &&
+	(cd other-repo &&
+	 git remote add origin .. &&
+	 git pull origin master &&
+	 git checkout master &&
+	 git log)
+'
+
+UPLOADFILENAME="hello_apache_upload.txt"
+
+UPLOAD_URL="$HTTPD_URL/upload/?sha1=$UPLOADFILENAME&size=123&type=blob"
+
+test_expect_success 'can upload a file' '
+	echo "Hello Apache World!" >hello_to_send.txt &&
+	echo "How are you?" >>hello_to_send.txt &&
+	curl --data-binary @hello_to_send.txt --include "$UPLOAD_URL" >out_upload
+'
+
+LIST_URL="$HTTPD_URL/list/"
+
+test_expect_success 'can list uploaded files' '
+	curl --include "$LIST_URL" >out_list &&
+	grep "$UPLOADFILENAME" out_list
+'
+
+test_expect_success 'can delete uploaded files' '
+	curl --data "delete" --include "$UPLOAD_URL&delete=1" >out_delete &&
+	curl --include "$LIST_URL" >out_list2 &&
+	! grep "$UPLOADFILENAME" out_list2
+'
+
+FILES_DIR="httpd/www/files"
+
+test_expect_success 'new blobs are transfered to the http server' '
+	test_commit one &&
+	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
+	echo "$hash1-4-blob" >expected &&
+	ls "$FILES_DIR" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'blobs can be retrieved from the http server' '
+	git cat-file blob "$hash1" &&
+	git log -p >expected
+'
+
+test_expect_success 'update other repo from the first one' '
+	(cd other-repo &&
+	 git fetch origin "refs/odbs/magic/*:refs/odbs/magic/*" &&
+	 test_must_fail git cat-file blob "$hash1" &&
+	 git config odb.magic.command "$HELPER" &&
+	 git config odb.magic.plainObjects "true" &&
+	 git cat-file blob "$hash1" &&
+	 git pull origin master)
+'
+
+test_expect_success 'local clone from the first repo' '
+	mkdir my-clone &&
+	(cd my-clone &&
+	 git clone .. . &&
+	 git cat-file blob "$hash1")
+'
+
+test_expect_success 'no-local clone from the first repo fails' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 test_must_fail git clone --no-local .. .) &&
+	rm -rf my-other-clone
+'
+
+test_expect_success 'no-local clone from the first repo with helper succeeds' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 git clone -c odb.magic.command="$HELPER" \
+		-c odb.magic.plainObjects="true" \
+		--no-local .. .) &&
+	rm -rf my-other-clone
+'
+
+test_expect_success 'no-local initial-refspec clone succeeds' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 git config odb.magic.command "$HELPER" &&
+	 git config odb.magic.plainObjects "true" &&
+	 git -c odb.magic.command="$HELPER" -c odb.magic.plainObjects="true" \
+		clone --no-local --initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
+'
+
+stop_httpd
+
+test_done
-- 
2.13.1.565.gbfcd7a9048

