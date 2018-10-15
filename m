Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929771F453
	for <e@80x24.org>; Mon, 15 Oct 2018 11:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbeJOS7N (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 14:59:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37659 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOS7N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 14:59:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id j23-v6so9513484pfi.4
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffdq98kySWVmKhM7VB6+p5/IbsOlzT1X5C/f8NIg+6o=;
        b=MAGo/h+VA6qTNT1ibKFaGE2nrHAgz1YTOWA8pJdWNUfv8jvmqnaKPjvV5ce2gZYQFZ
         WuCCCnpQi56EszVqwDIRQagJ7oQUN5bv9F8Cvvlz7vbkFNHBnxtGSA55jJZJTrN0LIO/
         n1ck5yl/Dpa3ZGJxqW0rynqlZqSP4eC9foYW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffdq98kySWVmKhM7VB6+p5/IbsOlzT1X5C/f8NIg+6o=;
        b=iEKZObKrnEMRkV/jHRPVEHtEctsKLsE1jkAp/A0fs8SM3AaEmjEXJxmdXHW8IlsOhF
         5F/Fuh/YpFp2SNrPvAT2XaQhzUL7b0C+JH1srIC7EPOBBd5RFPWD8BIkGB15QFHIZF64
         UN0tcvy+TAUYb/vuEB4UrDUhi511uPxRLfl1YZ+2PNtNTq4j6YXe4maQ27jxKd3hPrwU
         qQRGFT7117Qydy4d8ziolHEAORM1q4whLXPO5w8W7bSjFdLp6dO+lIaV9taUJwNc0Jru
         Rwt8fyuSaISyUwRhvkEnfV6sGnyEfaHkD5SnXvwH8XO6QSpPZkJA0pA+mPV8gjuSBRPG
         IppA==
X-Gm-Message-State: ABuFfogr877znAptuLIwGiZ7g2qGyEvsieiFWM8395uBqdlGx/rJmSsL
        rk3WsDqlEK7iLtozqtetZxALvoF6zdqXtihv
X-Google-Smtp-Source: ACcGV63C0KTEKxoJMRxK9z1/UMl7tgHBIJhCLEqoR8HNZxYvYloEzoa2UgJNMQX073gEnlxhBBaAPg==
X-Received: by 2002:a63:8c0b:: with SMTP id m11-v6mr15785653pgd.422.1539602065481;
        Mon, 15 Oct 2018 04:14:25 -0700 (PDT)
Received: from lgd-kipper.hsd1.ca.comcast.net ([2601:646:8581:1fcf:8286:f2ff:fe24:931b])
        by smtp.gmail.com with ESMTPSA id e22-v6sm11352461pfi.61.2018.10.15.04.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 04:14:24 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Merland Romain <merlorom@yahoo.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, Lex Spoon <lex@lexspoon.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 1/3] git-p4: do not fail in verbose mode for missing 'fileSize' key
Date:   Mon, 15 Oct 2018 12:14:06 +0100
Message-Id: <20181015111408.17618-2-luke@diamand.org>
X-Mailer: git-send-email 2.19.1.331.gae0ed827e6
In-Reply-To: <20181015111408.17618-1-luke@diamand.org>
References: <20181015111408.17618-1-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If deleting or moving a file, sometimes P4 doesn't report the file size.

The code handles this just fine but some logging crashes. Stop this
happening.

There was some earlier discussion on the list about this:

https://public-inbox.org/git/xmqq1sqpp1vv.fsf@gitster.mtv.corp.google.com/

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 7fab255584..5701bad06a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2775,7 +2775,10 @@ def streamOneP4File(self, file, contents):
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
         relPath = self.encodeWithUTF8(relPath)
         if verbose:
-            size = int(self.stream_file['fileSize'])
+            if 'fileSize' in self.stream_file:
+                size = int(self.stream_file['fileSize'])
+            else:
+                size = 0 # deleted files don't get a fileSize apparently
             sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
             sys.stdout.flush()
 
-- 
2.19.1.331.gae0ed827e6

