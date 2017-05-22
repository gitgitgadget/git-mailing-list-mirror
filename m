Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8982B2023D
	for <e@80x24.org>; Mon, 22 May 2017 13:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759907AbdEVNuJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 09:50:09 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34725 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759904AbdEVNuH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 09:50:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id 6so7018065wrb.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZQJqi6yieVVG05EWp6npXJ04hvzmH8PrSLC1srFkNYY=;
        b=hN873b/7SpD5BOd+r5UC5298cUoUH2cTWak0WlixUFIc4/gC564fpDNCJsh+vTFC76
         eb3YEuWAn72eEsW0giF7LjN44Fbkrwq8qq1jI+KbocFynVdmlK9mPt8sabIVkx4ilvW7
         YKeM3Bxw3oh4jMkwJno8KpS/CruSKchj2FiuWwgMLMu/z4kiSM3D1o0RQYBrMhk0wMOM
         slaM6ChRSR1yXiEvdCX4WuL1q/OhJsCQIsW7dHBHDc0AtqMxFv10hwct6LlOx2GYBYfS
         fFaJIE+jcAcEHkH6f52ucM3UavoS4hfren30takRmBXXGh1WRt5SqAQ4Ha//VtdJebj7
         rvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZQJqi6yieVVG05EWp6npXJ04hvzmH8PrSLC1srFkNYY=;
        b=k4y3bNUM2yYWj73XmW8wBnwtIsV4r5ArhdQU7te+oCPeKG20Dfh/ggdKXvvrn3S8iW
         KH+lk7U+/jSjNn1oLFFYp/Ms/shnjGj0eIhfBCgwQV9jDdKdRP4YDVB2/rEjnt+ZYu99
         4MRqyBRR5UKi346S7Ko6QPU+wdv7/ZupMz3fOB7S8sNGDZz2czzVNfG26dSDp48e/GA9
         88DUtP3S/M5bJXyrum85v+7WNFBOrkiuET9KmLDirIOcNpzdchiU7l1AXCCfauGFNgqn
         AYRZABUrar03pn38oDNo9BTthHzHt8WAGmyRzAr9BCU+eNTp81jl0KFrXi60OvHpCJDv
         nOMg==
X-Gm-Message-State: AODbwcBRBNsQ1lIySORLipyyyFg9SpC62/puZIsrMhCOiWvlu+rsNYSb
        5qPFRZlqyWydPg==
X-Received: by 10.223.176.37 with SMTP id f34mr11563067wra.93.1495461006044;
        Mon, 22 May 2017 06:50:06 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id y3sm22638070wmh.21.2017.05.22.06.50.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 06:50:04 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com
Subject: [PATCH v4 1/4] t0021: keep filter log files on comparison
Date:   Mon, 22 May 2017 15:49:58 +0200
Message-Id: <20170522135001.54506-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170522135001.54506-1-larsxschneider@gmail.com>
References: <20170522135001.54506-1-larsxschneider@gmail.com>
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
2.13.0

