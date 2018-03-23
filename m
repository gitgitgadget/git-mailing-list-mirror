Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8AA81F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeCWVZs (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:25:48 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37442 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeCWVZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:25:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id t16so988868pfh.4
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MHDgF9Br1CtVNo5rb/Ux7w+aq6/6fA5C46yDEirg+lQ=;
        b=qOwym1i/cFuIZpQDepjB+mUt9ZSlsMUbf1U8BqTUluDTL4D+iuym2FnclcvoyUuJNJ
         kaz08Rk4xH4GVBSVUDKyz6hZNSLmLSFAC20ri2zOQAaki+6P4FjJAqXKLo1sG86S573f
         8ce/SROSS35VgVeM240u6Ns1YI+i28mn7mZSMxPcsiEdy9b8kdMxBgvQc6WTsLtTwsIH
         9W63DfAeX7tp6xoY+iq3qNb+HK9gZIK0FK5rwrq8YnCsgD5y6/VBXouimAju1cD7MASR
         69FrMcDKSOcxvD5qHqhgoNOHlEgPM7tGJqe9xyt5XrhqGBDswSTT1NGOW/Am6/D4Jgwu
         jcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MHDgF9Br1CtVNo5rb/Ux7w+aq6/6fA5C46yDEirg+lQ=;
        b=qjFH3VWpMpl27BQHpRNwlAN/qA5GymancPjP60CTCJjMQfBCz2RDQrT2WgnZb6w7dq
         6GZg0vfpDKIJB1tT2CoaFAi9zyGIoaTxdsL9WdW5S3rY8/RD8HBkFYnLH/e0a4RIMFHt
         MPHJ9epOHfpg3xwiyEk069MSvTdFIsju4/GEwxnnnh97o0w6lbXi5ssS4dZa2DWNuSk9
         cmgBN+iuDzp82dcE07zKznHzdLa/3G7sD0WL3JXznbEKyt2+KzqgCs84kjNwC0F05ixP
         +mrmy3OJoReJ/XyJl7RCb/ruLcBsZ/cqHjuyIQ1fedZyPGsefvfGpTHlGcS4jnWJNiht
         YeoQ==
X-Gm-Message-State: AElRT7E68PrftgKmz6VZdni7i/eZg7NvkbLlcr2SXtvpWw21pxZcu4Xx
        pq9B1N3Wd/mbPDRmS2VOLVTB6ydHHDA=
X-Google-Smtp-Source: AG47ELvu39cR62w8u84yWE+D2gFU40iptQDVKpkndMvbrG0RI8Fc04Ak7BdOOLh4eEVce90zxxueyg==
X-Received: by 10.99.113.83 with SMTP id b19mr22133474pgn.167.1521840345855;
        Fri, 23 Mar 2018 14:25:45 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id z28sm15380096pgc.15.2018.03.23.14.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:25:44 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gister@pobox.com,
        sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v5 1/8] rebase-interactive: simplify pick_on_preserving_merges
Date:   Fri, 23 Mar 2018 14:25:22 -0700
Message-Id: <221ad09edfa7df5e28718b677b5084bb4167d567.1521839546.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521839546.git.wink@saville.com>
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use compound if statement instead of nested if statements to
simplify pick_on_preserving_merges.

Signed-off-by: Wink Saville <wink@saville.com>
---
 git-rebase--interactive.sh | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 331c8dfea..561e2660e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -307,17 +307,14 @@ pick_one_preserving_merges () {
 	esac
 	sha1=$(git rev-parse $sha1)
 
-	if test -f "$state_dir"/current-commit
+	if test -f "$state_dir"/current-commit && test "$fast_forward" = t
 	then
-		if test "$fast_forward" = t
-		then
-			while read current_commit
-			do
-				git rev-parse HEAD > "$rewritten"/$current_commit
-			done <"$state_dir"/current-commit
-			rm "$state_dir"/current-commit ||
-				die "$(gettext "Cannot write current commit's replacement sha1")"
-		fi
+		while read current_commit
+		do
+			git rev-parse HEAD > "$rewritten"/$current_commit
+		done <"$state_dir"/current-commit
+		rm "$state_dir"/current-commit ||
+			die "$(gettext "Cannot write current commit's replacement sha1")"
 	fi
 
 	echo $sha1 >> "$state_dir"/current-commit
-- 
2.16.2

