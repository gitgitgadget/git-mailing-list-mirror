Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E021520C11
	for <e@80x24.org>; Mon, 27 Nov 2017 17:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbdK0RVq (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 12:21:46 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44213 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932390AbdK0RVo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 12:21:44 -0500
Received: by mail-pf0-f194.google.com with SMTP id r14so11137043pfl.11
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 09:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4evlqhAuGKZ5rG64fkRgC0Zj2ULR+0hiygQ7ZqtPaEc=;
        b=VMAEcpIxCA5iCO2TwDiOK6j8IRiJRve/AzsuLcTO0di4jKvAOI/gtFi0fIHaONi9ao
         ggKKdTy17I0eEdPJgIuw5IxlzLoWQnjL0WFeSUUlNHPZTvU4jG65sVuPS6kfSRikSGWM
         qaFQBEEoB8wUkyTpgRaOBjkGXPrMSiChTTIK/8pck+kYtI3huPyDNgcAqE7gQHp64Wkt
         Jco0fSoFNFg7A9S6N5/WOEUdR7lk25TDfknp2EmK4fcy6FdFucG8uJyd1Y4Ld9Wwji2E
         SBfIwG4k6Z+kMMhzTR7SEeZkEKpA4fwgiJ7ctbBklRgqnbmRCNGmfLYVoar8Zfaz3bkG
         Rm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4evlqhAuGKZ5rG64fkRgC0Zj2ULR+0hiygQ7ZqtPaEc=;
        b=cDBsP39ixTEbREpMCXqeNDAnNs/rYDUxC8qzP40fXe+6g1nwUg710IsyP+HyRQD4mC
         uIKxPLe4ktoATAh9j8AByaXMXT65lUrsXrO9Tu0RJ8XMcFIbSy15lbvyz1oKa41ICGZj
         LIn4EpIriz1j0GLFoL9kk3jxt1Tk57CxBwoJFd/9m6oqlro2dtbP9Q6N+++FNPM5edKe
         7BVNRtHQsF6pVPlueT6EzSxPUiNvba6CahiZz8OVWKurKHquEIWf1YpMPzc6wFgb1wks
         eEgBoXcjrOI3AeTiwsbF3kfWqg9Bve/sTw8fvJCfxksmMaKMqxAhbAwML2ob1ApE6TxS
         RPgQ==
X-Gm-Message-State: AJaThX7UmOjena9XdcDrE9MsOIq7L5GPZkJ2eyLPwXx73wVWqoC4sCbg
        oVUtTbZeJup3JuZvPa9AkogOLa/4AGQ=
X-Google-Smtp-Source: AGs4zMZRRjJTKwFdu35ibZqb188KXPklv7DiTPccsSKM7GIxAHZpCjzZgEMArUzcd3RF+0+AbfLm3g==
X-Received: by 10.99.117.12 with SMTP id q12mr38299497pgc.412.1511803303711;
        Mon, 27 Nov 2017 09:21:43 -0800 (PST)
Received: from localhost.localdomain ([2405:204:73c7:b4fb:72c8:dd31:37ff:6021])
        by smtp.gmail.com with ESMTPSA id o88sm49573712pfj.175.2017.11.27.09.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 09:21:42 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v2 3/3] rebase: rebasing can also be done when HEAD is detached
Date:   Mon, 27 Nov 2017 22:51:04 +0530
Message-Id: <20171127172104.5796-4-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
References: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
 <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Attempting to rebase when the HEAD is detached and is already
up to date with upstream (so there's nothing to do), the
following message is shown

        Current branch HEAD is up to date.

which is clearly wrong as HEAD is not a branch.

Handle the special case of HEAD correctly to give a more precise
error message.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---

 git-rebase.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 3f8d99e99..9cce1483a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -602,11 +602,23 @@ then
 		test -z "$switch_to" ||
 		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to" \
 			git checkout -q "$switch_to" --
-		say "$(eval_gettext "Current branch \$branch_or_commit is up to date.")"
+		if test "$branch_or_commit" = "HEAD" &&
+			 !(git symbolic-ref -q HEAD)
+		then
+			say "$(eval_gettext "HEAD is up to date.")"
+		else
+			say "$(eval_gettext "Current branch \$branch_or_commit is up to date.")"
+		fi
 		finish_rebase
 		exit 0
 	else
-		say "$(eval_gettext "Current branch \$branch_or_commit is up to date, rebase forced.")"
+		if test "$branch_or_commit" = "HEAD" &&
+			 !(git symbolic-ref -q HEAD)
+		then
+			say "$(eval_gettext "HEAD is up to date, rebase forced.")"
+		else
+			say "$(eval_gettext "Current branch \$branch_or_commit is up to date, rebase forced.")"
+		fi
 	fi
 fi
 
-- 
2.15.0.345.gf926f18f3

