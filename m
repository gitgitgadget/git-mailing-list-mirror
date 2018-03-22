Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8DA01F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeCVQ5o (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:57:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35035 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeCVQ5l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:57:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id y186so3600648pfb.2
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SKgM5cPwHXIpLgxrjSWUC7FbrNhhwqi6THHy4ifMzyU=;
        b=Gqd5zUut93G+5UbCR9FZL6An6/My5S4vjNE/Qo38W4/jGhqpXYoOh8mdXlRJagMTbR
         JFw7xLCzf693O71fN6dek9bajhAm9AVzd2zz+xT4By3WCGU3vwWUrc/D9bSjuN47y2sg
         MXkvCffuoeMF1TqboEQgfCJz81xK00qtxp5G6mBgUdZVNkkHXEPUIS3aCW352sZk9h27
         ThZ4HgjOIouazyeKixACvLXXv6NRuwD8w4bCnkOYeJ5E46mB13KeA1p4Pi01pEYaEs/F
         /yzayUUvyK+i4HDjWd+6+yxzgVCo+ze9Vf6qUJX5N2X2OPW620Ff4rIC4aAyn0OOrys7
         Z3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SKgM5cPwHXIpLgxrjSWUC7FbrNhhwqi6THHy4ifMzyU=;
        b=iR8BRJWlmKqgvX9ffyeKa88wt49agMkZA2wRDCI2VTZykxYVNnmMCBQntIbjaAhYEC
         HW4y1KemIH7Sw0PHzV9bTSuixuiIVnorflQBHj2SFFt5VUXlD2+dcsEPLjQG0we7KT1w
         GOn2dmTZMuSreHCO225hCYtjvW+LaNmZpBd/iLwgg54RKDRPYhmYKz7P4XDUe4IXj45J
         1pfqK8fffUL1NaK4mEzZykLFhaycuHH5gUHAMwQa7Fxtejr+UPzpwOy8nJpT+qvC+Ztq
         TBMy0JJLr02i5F9svFZxagZR2tej3BLY6OOgEOt+2OYOUD/xBL6Qw9hHB7+TgaP+JalV
         6JAQ==
X-Gm-Message-State: AElRT7Hn7xHG51sdW1ALE5Z+ZAjeEevvK6JEAvgHgWbQ19/3R/OQiqYs
        2Nurwan60ci3c0QCPL5kCGfG6Q3QHkA=
X-Google-Smtp-Source: AG47ELvB0LS88WNqJxwBAqgwY32BvNn4Dj1xtBJxX2bdOXMl63XuudPjFpRrYCPx/S4ZznkEdNabdw==
X-Received: by 10.101.64.139 with SMTP id t11mr6658873pgp.119.1521737860623;
        Thu, 22 Mar 2018 09:57:40 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id 2sm15043830pfo.70.2018.03.22.09.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 09:57:39 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: [RFC PATCH v3 2/9] Call git_rebase__interactive from run_specific_rebase
Date:   Thu, 22 Mar 2018 09:57:22 -0700
Message-Id: <47b224af1c22900a69d0e292935f37a719b6a9f3.1521690197.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of indirectly invoking git_rebase__interactive this invokes
it directly after sourcing.

Signed-off-by: Wink Saville <wink@saville.com>
---
 git-rebase--interactive.sh | 11 -----------
 git-rebase.sh              | 11 +++++++++--
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 561e2660e..213d75f43 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -740,15 +740,6 @@ get_missing_commit_check_level () {
 	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
 }
 
-# The whole contents of this file is run by dot-sourcing it from
-# inside a shell function.  It used to be that "return"s we see
-# below were not inside any function, and expected to return
-# to the function that dot-sourced us.
-#
-# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
-# construct and continue to run the statements that follow such a "return".
-# As a work-around, we introduce an extra layer of a function
-# here, and immediately call it after defining it.
 git_rebase__interactive () {
 
 case "$action" in
@@ -1029,5 +1020,3 @@ fi
 do_rest
 
 }
-# ... and then we call the whole thing.
-git_rebase__interactive
diff --git a/git-rebase.sh b/git-rebase.sh
index a1f6e5de6..c4ec7c21b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -196,8 +196,15 @@ run_specific_rebase () {
 		export GIT_EDITOR
 		autosquash=
 	fi
-	. git-rebase--$type
-	ret=$?
+	if test "$type" = interactive
+	then
+		. git-rebase--interactive
+		git_rebase__interactive
+		ret=$?
+	else
+		. git-rebase--$type
+		ret=$?
+	fi
 	if test $ret -eq 0
 	then
 		finish_rebase
-- 
2.16.2

