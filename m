Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428521F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeEPB7R (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:59:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47514 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752595AbeEPB7A (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:59:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7E0916074C;
        Wed, 16 May 2018 01:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435939;
        bh=vqhEDAX66enHXwvH4Dbb71ck/56wkA9xwXomvQggeF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UsofWyFtGTe8xgdY8+9/cmxmr2FNO+8XXN47hukVGX9xe9eFdzcT358Flji41OLMb
         Nqtu3q7llSmzEWzGnh/cy0xlNXrQu6hq5YmqHDz997yNwnljUDEfMeXKRtUZ/InzDk
         ZokHyak+7kgsfL/mOKPL3VrRgmwm+Fd6zNn5vrzZ3TYZKvaCoAwv4NdM/Gag6kEtys
         HiGHqV4R3roxzZS5HXqx4bfH9dwD5TRSNpViAUuGTjU7h+WZIX+8jlUAIVc39a4nzX
         WZV2aF3mWBMaE2ii+BpthSYCDxZ1ym+0izTOI/JbbQyz4QYSAga4+le6mFI8ukBs4d
         BusO/JuN3XnTydBB5LXRMUEMOP3bvzrQ/FryCeXztxDuJyG3IFR2cYctCPIw3plMLC
         YjIshXUPA/it6dEip11Vb0hb88/8EWIwVtKCfpNpa/wFm8huhgg2UZZgP6ladoRmtF
         tt+QEZICdQI/xCFQgfz89QBkSQ5zfi8A6CkrGt9+Ya+HR/paQlL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 22/28] t4030: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:24 +0000
Message-Id: <20180516015630.661349-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4030-diff-textconv.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index aad6c7f78d..4cb9f0e523 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -148,7 +148,8 @@ test_expect_success 'diffstat does not run textconv' '
 # restore working setup
 echo file diff=foo >.gitattributes
 
-cat >expect.typechange <<'EOF'
+symlink=$(git rev-parse --short $(printf frotz | git hash-object --stdin))
+cat >expect.typechange <<EOF
 --- a/file
 +++ /dev/null
 @@ -1,2 +0,0 @@
@@ -156,7 +157,7 @@ cat >expect.typechange <<'EOF'
 -1
 diff --git a/file b/file
 new file mode 120000
-index 0000000..67be421
+index 0000000..$symlink
 --- /dev/null
 +++ b/file
 @@ -0,0 +1 @@
