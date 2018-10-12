Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CD51F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 05:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJLM7Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 08:59:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39476 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeJLM7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 08:59:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so5273249pgv.6
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 22:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JMAkA1Wk04sLNOUhph+Fzp9Zlf+uOTmynoptoT4fHcw=;
        b=FSvIJ6QLdIdjTxGMA86EUhc8BjahtvaOmS22CVLgt1VDqigRr4fHiySleiLb4O67S3
         exISLwq3FuNbbrxU+n5DMEDUQljss0xUjCYFQSph+BCIJtk5YzoovfFXB1hYGIuuDPIb
         Sc5DDx1ebXrV4gsPr6uGQWePraow3ywxnZ7hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JMAkA1Wk04sLNOUhph+Fzp9Zlf+uOTmynoptoT4fHcw=;
        b=sWjtt1LoHhkCQ+bxA2U91dPU8IV/4VCL0mVQB5JCJuogBtSQk7e8mxioFO78AuNToG
         8nJkLr3W8qq+pFJNWfgMB0j0EEugtJNL0QjngV3C9l5hEUERy7kbvMJGEoR9dK1kqwNe
         /NavL902ZZEdFLQaKW6kOR09LYcTMepc30ubXJt3h2rysCPg2E2A+JOAmpvRikYxGCN2
         Hf1JnUSrn9fteeSD3sWm9Qkv1oo/6innCNPgmHslgBElo4V6WZyhLdMuo/8jNPmmE9Lf
         V1XIRmPQ734kDKVt7gdqknMDz3QFkQ0XDtcxl0MS5ZKe5498pN2/88ks8dJb2rqgfhiz
         kqJQ==
X-Gm-Message-State: ABuFfogUMz65SWcLxjBoCXxKEnA9eqOjF+RksQyxnlADRR5fB1Rq+hKk
        B3p1FRHuwEO72VTr/J8O8WBBkM3rIC+fAszK
X-Google-Smtp-Source: ACcGV63hcw7VTawJw7hX0t1SiHJNrPe+NtyU6qVZHSuL2xxkui4JRjd9Vx+cPPE8rifPtCAPkK/oMA==
X-Received: by 2002:a62:507:: with SMTP id 7-v6mr4619158pff.80.1539322122113;
        Thu, 11 Oct 2018 22:28:42 -0700 (PDT)
Received: from lgd-kipper.hsd1.ca.comcast.net ([2601:646:8581:1fcf:8286:f2ff:fe24:931b])
        by smtp.gmail.com with ESMTPSA id t26-v6sm209110pfa.158.2018.10.11.22.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 22:28:41 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Merland Romain <merlorom@yahoo.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, Lex Spoon <lex@lexspoon.org>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 1/3] git-p4: do not fail in verbose mode for missing 'fileSize' key
Date:   Fri, 12 Oct 2018 06:28:31 +0100
Message-Id: <20181012052833.6945-2-luke@diamand.org>
X-Mailer: git-send-email 2.19.1.272.gf84b9b09d4
In-Reply-To: <20181012052833.6945-1-luke@diamand.org>
References: <20181012052833.6945-1-luke@diamand.org>
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
2.19.1.272.gf84b9b09d4

