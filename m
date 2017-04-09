Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622B21FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 19:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbdDITLO (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 15:11:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33301 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbdDITLM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 15:11:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so6316295wmb.0
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ceEZbOWtHmnt4JeyH8vrNg8BRe6aleiMs9i3mYgIurM=;
        b=RZztG78JIUARskYRi5Dn2W+S74pERxudN8Eu7lpWMRKgjLPO2zBXpDhwVV6b4BJJis
         Zwzk2AhE/ifsLlycs2w7itgIObj8gOVYpy3Fk7dZ+adkvtWqWzT5I8PkJaDD9hWsp0In
         KMtgH4SMljjdZWwax9vpv/Y/4nngapuvOx9qafbPNpoegRD+mm5FBahXB5JN5o5ucZJc
         E7iewDmQKDYCa/aeDLti2k4i9eEYQW1QuKZYC8+QiFrloYUpkwQGh6/vccJzcql3aqpY
         +HIzi+FVVQYT7Ageg68g1Jq60A5rLiz3VsVIsNTAOeTsAgb1+yUP0+VnvJZs55ddFnCy
         f6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ceEZbOWtHmnt4JeyH8vrNg8BRe6aleiMs9i3mYgIurM=;
        b=A4AInU8RYPAlOzEZcedXy0risZjEvK1arKrhGZWVa6ETFY8pXhiM3RpYJE3MmS6laQ
         ereSvRpJrlGxTeytTcGLwHGhEN73wsBWemIgIisP+ISjacZPqdlai9J6EMwgRUz215ub
         IOOHAEKVvPft9RA2VTV1x77GsbGn9z/oL7sDpxof8JFSVrRHMbAxYUl/8NI2kDO88GO3
         dtlimy7XlXoC6K5Xi34hPboHVpzilWhv3Yybgkpf7BL5l4Oj3y/S0HIb0xiSvrsCx6OR
         wipcT7EsqFn4Iu3+nxnX8smJr2mbQokXdywaKvUz3PIR4h12PiGmX3l+fZkfbCDhErnv
         VxuQ==
X-Gm-Message-State: AN3rC/4i5ngaqLgkyiChrta9FscSCsXhUtkc3t4ndKX6jVuZneWFf7bt
        wCP+5a2BNsQCMHFE
X-Received: by 10.28.105.8 with SMTP id e8mr7233028wmc.122.1491765070801;
        Sun, 09 Apr 2017 12:11:10 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB5F77.dip0.t-ipconnect.de. [93.219.95.119])
        by smtp.gmail.com with ESMTPSA id k13sm7319675wmi.28.2017.04.09.12.11.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 09 Apr 2017 12:11:10 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com
Subject: [PATCH v3 1/4] t0021: keep filter log files on comparison
Date:   Sun,  9 Apr 2017 21:11:04 +0200
Message-Id: <20170409191107.20547-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170409191107.20547-1-larsxschneider@gmail.com>
References: <20170409191107.20547-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The filter log files are modified on comparison. Write the modified log files
to temp files for comparison to fix this.

This is useful for the subsequent patch 'convert: add "status=delayed" to
filter process protocol'.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t0021-conversion.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 161f560446..ff2424225b 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -42,10 +42,10 @@ test_cmp_count () {
 	for FILE in "$expect" "$actual"
 	do
 		sort "$FILE" | uniq -c |
-		sed -e "s/^ *[0-9][0-9]*[ 	]*IN: /x IN: /" >"$FILE.tmp" &&
-		mv "$FILE.tmp" "$FILE" || return
+		sed -e "s/^ *[0-9][0-9]*[ 	]*IN: /x IN: /" >"$FILE.tmp"
 	done &&
-	test_cmp "$expect" "$actual"
+	test_cmp "$expect.tmp" "$actual.tmp" &&
+	rm "$expect.tmp" "$actual.tmp"
 }
 
 # Compare two files but exclude all `clean` invocations because Git can
@@ -56,10 +56,10 @@ test_cmp_exclude_clean () {
 	actual=$2
 	for FILE in "$expect" "$actual"
 	do
-		grep -v "IN: clean" "$FILE" >"$FILE.tmp" &&
-		mv "$FILE.tmp" "$FILE"
+		grep -v "IN: clean" "$FILE" >"$FILE.tmp"
 	done &&
-	test_cmp "$expect" "$actual"
+	test_cmp "$expect.tmp" "$actual.tmp" &&
+	rm "$expect.tmp" "$actual.tmp"
 }
 
 # Check that the contents of two files are equal and that their rot13 version
-- 
2.12.2

