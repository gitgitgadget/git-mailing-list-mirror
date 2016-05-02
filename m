From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] submodule deinit test: fix broken && chain in subshell
Date: Mon,  2 May 2016 15:24:02 -0700
Message-ID: <1462227844-10624-2-git-send-email-sbeller@google.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Tue May 03 00:24:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axMGI-0003lb-3M
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 00:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbcEBWYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 18:24:14 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35477 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166AbcEBWYN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 18:24:13 -0400
Received: by mail-pa0-f53.google.com with SMTP id iv1so961434pac.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hiBGt76+2PNJmbQO5xbJu1NP3rLYisaLDWf3e6YNq8c=;
        b=eRN+f67Cx0BuuIat/OoJEQjU0sZLuery3SDBeyeZHbciRFO0cYFMd6mVMuQ4naOc/d
         yX9Hhraq8uiS59+WlLbqdhT1B0a/gs2x641pc2FfuCeGRvMJUk9AhvYzoSshAOg1NQbN
         YAFzij0EShdyP/cgpbaGSNmHnMMqThlk9Zgpo2ZTLJQqrg8PZUPmmn1m8ZZD10OpOQL7
         lYS+zauMez5SthmDjgpNpVXVW/TXjTvsG8qY3W8HMUdxIf0Wtck8GGCqwQ1hEMTPo1ca
         SGXHSLIidamb7tdX/qQekh2yE3JEzmgGhBakOXI3Qy7lR7nKgAiP14POW2BcoaoeazbG
         6reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hiBGt76+2PNJmbQO5xbJu1NP3rLYisaLDWf3e6YNq8c=;
        b=DIBWwCGA8HGncxdrJHmIRj/nVJcNipdOYAgqu1WufymZkAuVxeKRFFnh1TG71KEvc0
         rhWn72kmlV8vFNBVWOLNZdE63xBtewFzveL0N7Ckn+BxFzYaVyfCoEvmi4pnzXCa5kAT
         pXeFgrLDuwuJl+UGqvkCvMXtbgUGBHfin4txJc81QIfjWyMb562IiaIvZOXgHFNvKcwc
         DSeEVGQ2JI22FF2M7UFP39izEVcKM/e5OdFiUcvkp2ZHHEwkvUIrJWIrGYu2eFAISXbU
         GO/310PX4YYm5eOa8pHoNR61G6Ymj4NDNp/bsAudxiQATeWg2e7T50AZr0/Pr+B505z9
         0fug==
X-Gm-Message-State: AOPr4FXVZ8bGkP2vq/w6QhVuBpt46QMUWftteYFHgCfp6ZDd6iZDo19T9jA4xnmzo6L09sq+
X-Received: by 10.66.65.109 with SMTP id w13mr54594457pas.142.1462227852268;
        Mon, 02 May 2016 15:24:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9831:74f0:67fd:61ba])
        by smtp.gmail.com with ESMTPSA id 8sm266243pfk.69.2016.05.02.15.24.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 May 2016 15:24:11 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.37.gb114fff.dirty
In-Reply-To: <1462227844-10624-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293295>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7400-submodule-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 814ee63..90d80d3 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -914,7 +914,7 @@ test_expect_success 'submodule deinit works on repository without submodules' '
 		git init &&
 		>file &&
 		git add file &&
-		git commit -m "repo should not be empty"
+		git commit -m "repo should not be empty" &&
 		git submodule deinit .
 	)
 '
-- 
2.8.0.37.gb114fff.dirty
