Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3EE01F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfHMM1R (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:27:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52862 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfHMM1M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id o4so1193377wmh.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7cMLCe7Tn9V2Rz3rzEmefYJxohZzhmWgiLfDv0VcZ2w=;
        b=W+3GN+2Ls3pIjmw5RcGhsJdyRPsXVBV+Fk+dlJnBHsTe4GsBkIfoxirXfBrlNFIJTX
         jf9FQl23hVkc8AtXaN6j6hVdJoV27oTITxrbPKOxN9hGhBJT0We7/pI1cuHoND3qEZNB
         DrGQYKCCyxsawJoXpNEE1zwgH1xhHWLcRUv5Iq6QDPgf8IAX+i9GaY4rt6G/yD3fyLsZ
         BLadleKwtEGF58wXazycOQoOQdw1EGpreEDWGqsmLsZn5HaCWAIzDf2L/8k4/TfqoPBw
         5lVp614FUPkB9K3IEEjzOVbX1/53dVnf5njKwdF3wbqVS27moWBJYJLjzPby6PJVbBcs
         f41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7cMLCe7Tn9V2Rz3rzEmefYJxohZzhmWgiLfDv0VcZ2w=;
        b=qTKxhUanYQt76zAKUmrMLS+jU5EVWYdLDq2GBTjMJvau5ndjnohPObQyGg5pJJOQqi
         pIL8xOKqzKV6RjvhObiz6VDT1fRkOSLH1tNRf5OrhQNBiyVnV78qjNrTvbotOUb7onL2
         SmmtxNSHSwBmw+UjqU41yx4Yq2pqusaNPJAvzPml9jJJm4+fk9pf5BAjOeSvJ4d4i24D
         18wZ6LTWGIGxT7jZODRFXmRLmXaA6jAAYvb7ei7azcfsNRqvKUJjeKmnkPiQamNgz6Qi
         U7TSH7v6SJjtDmCaua3AB7386ij5o5f30aN5gYfjycQpkhs2tVVmVxx+e3DEQYcpjB2V
         ohXg==
X-Gm-Message-State: APjAAAWtxF6o4qDVQiqoZc8B+3lIbX5gI1TtVBpZOAM60/yEX7tHni83
        yHzwyUUDfaoTltV5wkNEF+E=
X-Google-Smtp-Source: APXvYqw7qHQKk1TPik/jkmSfWUJ48v+peu19BEEBVuuBss2Ty8sdZy+DVrlv/8Gl+ogvCxLE/nTa0Q==
X-Received: by 2002:a7b:c04f:: with SMTP id u15mr2887142wmc.106.1565699230655;
        Tue, 13 Aug 2019 05:27:10 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id r5sm1978069wmh.35.2019.08.13.05.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:27:10 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 06/11] completion: simplify inner 'case' pattern in __gitcomp()
Date:   Tue, 13 Aug 2019 14:26:47 +0200
Message-Id: <20190813122652.16468-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.350.gf4fdc32db7
In-Reply-To: <20190813122652.16468-1-szeder.dev@gmail.com>
References: <20190813122652.16468-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The second '*' in the '--*=*' pattern of the inner 'case' statement of
the __gitcomp() helper function never matches anything, so let's use
'--*=' instead.

The purpose of that inner case statement is to decide when to append a
trailing space to the listed options and when not.  When an option
requires a stuck argument, i.e. '--option=', then the trailing space
should not be added, so the user can continue typing the required
argument right away.  That '--*=*' pattern is supposed to match these
options, but for this purpose that second '*' is unnecessary, a '--*='
pattern works just as well.  That second '*' would only make a
difference in case of a possible completion word like
'--option=value', but our completion script never passes such a word
to __gitcomp(), because the '--option=' and its 'value' must be
completed separately.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b51cb31ea1..fc437bf3eb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -340,7 +340,7 @@ __gitcomp ()
 			c="$c${4-}"
 			if [[ $c == "$cur_"* ]]; then
 				case $c in
-				--*=*|*.) ;;
+				--*=|*.) ;;
 				*) c="$c " ;;
 				esac
 				COMPREPLY[i++]="${2-}$c"
@@ -360,7 +360,7 @@ __gitcomp ()
 			c="$c${4-}"
 			if [[ $c == "$cur_"* ]]; then
 				case $c in
-				--*=*|*.) ;;
+				--*=|*.) ;;
 				*) c="$c " ;;
 				esac
 				COMPREPLY[i++]="${2-}$c"
-- 
2.23.0.rc2.350.gf4fdc32db7

