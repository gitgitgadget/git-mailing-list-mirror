Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7627120401
	for <e@80x24.org>; Mon, 19 Jun 2017 02:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbdFSCKi (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 22:10:38 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34944 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753236AbdFSCKh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 22:10:37 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so14521603pfs.2
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 19:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EdS1EByOddfYjhCvMEquEaZUws3p8PXjdxW7enlooZg=;
        b=NNOwoZR6Aqd1uuYkYmHCJ1U9GpnoVRfTEvfdRuqvAvDa91a01fk/2eD5yl7dNiGMX4
         oHEFNrIjoYL8kzFdpTS4JchDcpd9GWnbF8T5LMs/yzDXO4GZFjD8BX2ZrmTDlFY7HsPX
         nTdkmFj13Fd/JopG1T8O9azXKMCzRXNSGK4xs4kSC3LDRxKzYBNZn9T8f465kcMp49eG
         Gqrp1pHLY2E7s/QuuV+OCWyTkAQ9bsoLQGuKoTWXmtCCmGHdiKKI6R89BOTCausExVf2
         uAxJ6NHxdtfyEkrmrUnxdtsQhIUK12UcDgSBAa/uhQ4GCdDIOUfTdFCD8tp+T6iMyJOT
         /ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EdS1EByOddfYjhCvMEquEaZUws3p8PXjdxW7enlooZg=;
        b=I4mfsQvq9YCov80DdsTtuMlH+8XPWsBiqEdOy0/NATs7eo/hAmghqGWGJIWNbSUwyQ
         zYT8G2e1xaqbemhhyC98J2/w1n9s/vj0QtqlVyTjJQnA0GV1TFGtd6urd64tITiLcGPO
         KkD8B1eJm9vHLhu8+jUIB7OUkP7wHnU5WRkS8/l/iWmHYaH5FGheTWv0j8Kcq5GBFeVZ
         2VexjV5hSw3ts2VC7fTYpw9xA1Xu27308PP5VV2Osmkm5fcz7Irh9xg2cOydgdQ1UFNg
         VGTjDmgdtoUrsk/iNh7ENHzq9pKUbxxRLpQbM+wSjVqxBh14VNkeFUG8Gkyc38H2cPRO
         0IRw==
X-Gm-Message-State: AKS2vOzvdXDS37nu2I14PI8uthIf7UUzgFRFI1bhKBdsE2IxzHy3/XVW
        yP+Sdj2SUQV2VrvCBwM=
X-Received: by 10.99.114.18 with SMTP id n18mr11220579pgc.6.1497838236911;
        Sun, 18 Jun 2017 19:10:36 -0700 (PDT)
Received: from localhost.localdomain (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id r5sm16715231pfe.94.2017.06.18.19.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jun 2017 19:10:35 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Matthew Groth <mgroth49@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3] mergetools/meld: improve compatibiilty with Meld on macOS X
Date:   Sun, 18 Jun 2017 19:10:33 -0700
Message-Id: <20170619021033.22968-1-davvid@gmail.com>
X-Mailer: git-send-email 2.13.1.453.ga53a62295c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The macOS X fork of Meld[1] requires a "=" in the "--output"
argument, as it uses a wrapper[2] script that munges the
"--output" argument before calling into the common "meld"
script.

The macOS X wrapper script[2] accepts "--output=<filename>"
only, despite the fact that the underlying meld code accepts
both "--output <filename" and "--output=<filename>"[3].

All versions of meld which accept "--output" accept it in
the "--output=<filename>" form, so use "--output=<file>" for
maximum compatibility.

[1] https://github.com/yousseb/meld
[2] https://github.com/yousseb/meld/blob/master/osx/Meld
[3] https://github.com/yousseb/meld/issues/42

Reported-by: Matthew Groth <mgroth49@gmail.com>
Helped-by: Samuel Lijin <sxlijin@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
I cloned the meld repo and could not find the code reported in the original
issue, but I did find that same exact code existed in a macOS fork.

After more investigation, this turned out to be a macOS-only issue.  The
commit message has been updated to better reflect what's really going on.

 mergetools/meld | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mergetools/meld b/mergetools/meld
index bc178e8882..7a08470f88 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -10,7 +10,7 @@ merge_cmd () {
 
 	if test "$meld_has_output_option" = true
 	then
-		"$merge_tool_path" --output "$MERGED" \
+		"$merge_tool_path" --output="$MERGED" \
 			"$LOCAL" "$BASE" "$REMOTE"
 	else
 		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
-- 
2.13.1.453.gc0395165f3

