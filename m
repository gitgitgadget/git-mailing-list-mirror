Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A91D2082F
	for <e@80x24.org>; Sun, 25 Jun 2017 18:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdFYSV3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 14:21:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32844 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbdFYSV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 14:21:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id x23so25726843wrb.0
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VB+l7WZXdKthOd00zEiSiG8v9EJTijJU8iWubZ+6VTk=;
        b=Oa3ClTJsLvweaUYIKc+Zzt6MXxgrE4TSGX4YqNbvBWssRUs9ie9gGAPKf3zFRRb6RD
         8sihb8saVWfQqU6qHzCoa66DSdaZXLpzg22m42QF2tJOQkx52hHvtwVDO46yrJ1DjhK7
         KsTUmYzhXNM6JZqc7PjPr/3cFpXNyXUh75Dl5YlnSE+ZMZmegEJv6F2S2G1QXf64nMnL
         a39dMblkX76IwTbN7xt0ihtlj1oEoonSZDeRUXGYO9cb/FdTK621MXdys1wFKguPHwie
         uhRis+GHtWqv7HgM3y53uZGUiDpJrMHgTELhTIUYrKMNf4xZahI5PjECmlKhRmhalSPO
         0Etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VB+l7WZXdKthOd00zEiSiG8v9EJTijJU8iWubZ+6VTk=;
        b=Utya/rwImcodZ7+1Ol0ooX6bcHGS9YQK9AQya/0L2Yt8IYPnj1O9aXHp6tn+HuJn+s
         lWFSLVDrD2v/caiVYzt4ZTLR9vdcm2/CMFKioGA4sN1jA9XdJySyo62qGUReAbF9HLTt
         cddAnDJL0Y4tteAyXTnfR7M5Is0ZCP6apUxZthB7Xh1oD4LwbNIKXpQSgxk96yi0DEd+
         J3Ym4gRlFxs2v75tG5KMK2IJx4k8m/ZXmVpdoqv+hLUfyi6aJ0qmomC/i76SPkysEDhj
         DznJ6VC167yaktzroQS0sGng6KPNN5sF3T3ixsha4RYURP7SOfdSjnoiJ45VF+5PNRe2
         taHQ==
X-Gm-Message-State: AKS2vOyaa8l1MwoauYzBJSp4h/TuwgQu9ccpvMKVvswsfrSF1ATmPaZo
        yith4lQSf5qu7RJn
X-Received: by 10.223.128.177 with SMTP id 46mr667603wrl.150.1498414885907;
        Sun, 25 Jun 2017 11:21:25 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB71F6.dip0.t-ipconnect.de. [93.219.113.246])
        by smtp.gmail.com with ESMTPSA id u13sm13313926wmd.22.2017.06.25.11.21.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 25 Jun 2017 11:21:25 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v6 1/6] t0021: keep filter log files on comparison
Date:   Sun, 25 Jun 2017 20:21:20 +0200
Message-Id: <20170625182125.6741-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170625182125.6741-1-larsxschneider@gmail.com>
References: <20170625182125.6741-1-larsxschneider@gmail.com>
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
2.13.1

