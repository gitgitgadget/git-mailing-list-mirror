From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 6/7] pack-protocol.txt: Mark pushee field as optional
Date: Wed,  1 Jul 2015 11:08:18 -0700
Message-ID: <1435774099-21260-7-git-send-email-dborowitz@google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 20:09:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAMS7-00055Y-Mz
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbbGASJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:09:09 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37261 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbbGASIx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:08:53 -0400
Received: by igblr2 with SMTP id lr2so40440093igb.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tAas5KvnczjxznIsPXYGkscCvNtXbEl0qgpjXOkwvtI=;
        b=TKVbJ/mfo0f8vKthlHSKaACrpOaLCPsasGG6wlD8M7pw3ZsfkpIkzbGh5d5fnuSnDz
         dRNaJBM097xb8TP+ReAhlgvlxiMb5BsNEjMYhYWj13J+9KZHKF53CZ6DFVINIejz720o
         KTdwFW4egsV/UyNL3qyyfnEqSjVqUODBu8VApQykD+3L3Qj+DQHb0XzqIf2GKZINs+ep
         IfSdfsJt1dsPFex5PioAuFZCqm0Z8iJvV7I41I+FEbnwncTD65wyXF1jyW0KNygaOd/S
         NJ6JD3cfEp4GCgYoepBm8rGS4L++2bxxSQ5M1IU5XxnRlqdYt/SRebrCwyYvllGR4raa
         zbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tAas5KvnczjxznIsPXYGkscCvNtXbEl0qgpjXOkwvtI=;
        b=AtZwOQncdwxABmwpISZSH5FE8n7vsV0lNYNDbJhznDprPpinhd4YyiSgzyNwMQcQwH
         iR+DZDQ3g3JegXllIn9soROxJti7X9penPOM3d7tPsbx59bDT2QFZdL4AvoRJnPj9Kay
         6hSxTuj4ChNuiSVO8jJHYb2P5CXW1ExvJ803HBIFwDUx/dJVjXDwInx4bo334cepguXm
         zunlY/Vaiy/yHXr1thykOKlIWNfi91JuwC/PvCZr5mi2S2I1qx6i5deICRfpdWnhSE90
         EUwhnz+HpgFnKQB+bK4YafQ+7HLsMh44pvUKmo1Wzaq5SWaC0eFanGa/PJ9oy1qbgbqy
         ARaw==
X-Gm-Message-State: ALoCoQnTdaqYghMBSS03XFxawbPsiyNo9M/Jk2B4vKHZTbiuJnKSzTBVAMSZhsc9x2K3xXpSheAT
X-Received: by 10.43.54.20 with SMTP id vs20mr5955587icb.96.1435774132435;
        Wed, 01 Jul 2015 11:08:52 -0700 (PDT)
Received: from serval.mtv.corp.google.com ([172.27.69.27])
        by smtp.gmail.com with ESMTPSA id k2sm2782076ige.1.2015.07.01.11.08.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 11:08:51 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.573.g4eafbef
In-Reply-To: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273173>

send-pack.c omits this field when args->url is null or empty. Fix the
protocol specification to match reality.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/technical/pack-protocol.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index f37dcf1..98e512d 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -495,7 +495,7 @@ references.
   push-cert         = PKT-LINE("push-cert" NUL capability-list LF)
 		      PKT-LINE("certificate version 0.1" LF)
 		      PKT-LINE("pusher" SP push-cert-ident LF)
-		      PKT-LINE("pushee" SP url LF)
+		      [PKT-LINE("pushee" SP url LF)]
 		      PKT-LINE("nonce" SP nonce LF)
 		      PKT-LINE(LF)
 		      *PKT-LINE(command LF)
@@ -554,7 +554,8 @@ Currently, the following header fields are defined:
 `pushee` url::
 	The repository URL (anonymized, if the URL contains
 	authentication material) the user who ran `git push`
-	intended to push into.
+	intended to push into. This field is optional, and included at
+	the client's discretion.
 
 `nonce` nonce::
 	The 'nonce' string the receiving repository asked the
-- 
2.4.3.573.g4eafbef
