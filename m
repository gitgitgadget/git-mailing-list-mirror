Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543FD20C11
	for <e@80x24.org>; Fri,  1 Dec 2017 06:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752923AbdLAGKK (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 01:10:10 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37678 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbdLAGKI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 01:10:08 -0500
Received: by mail-pf0-f196.google.com with SMTP id n6so4223626pfa.4
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 22:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w5dDFmJXykoKazKm2onG8mJ0lRpJ3eoj1vKw4X2rVUk=;
        b=KtPAm0Z/Qrsxi7ZG7XW9o+xVQGUzi36rLRsZbhgksr2BSL0Db19WLxANmo108eZ0p8
         UzMrA3zHqo7kFRQugYLjmMaiPSrqumB2F4fv6ZcTfkiUYHAquSIP+DU4OdJ33I3XuZrg
         CsuJglCTyAhw8o9j8uYXigJtv04wQhQUHtQKGD3bapiSfD6+Uwe9/nkpOx4dYQjVH23u
         hndTHwTMI7fFHW3I0PqVQrj1vFWd9W8cW4wMqjbf4quAKdg7sXwU3OooPHywTwMc9iij
         pSGYYv9BbwAs+BNuxfUNXzWnzSjvDUjM2f6C/i/ZmwpRApDMo/LcTl7UF8TQysbQNLXJ
         RxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w5dDFmJXykoKazKm2onG8mJ0lRpJ3eoj1vKw4X2rVUk=;
        b=IA8aFrSTGIhFBqUWeexRjgEeltWHvpQMe67XpKUcEBN7mmH5TbgrmNV11nDGa5Vh5e
         xKQsc6/RI+kCLaBZ0Pwne6Iohl++qnASS6eaQyE6ah+cqTA8VizgEjSdn6lqAWn0Tzzp
         n3StYl44RgmqBtG4gJ6/GlGJ2ukqaVWDb+nP7kh9R9FOzZfw8cX0ByL+BlutJq9o5xJg
         EHry3W/B4Uyc258295yVtTvw7wEDJ21xNcLVnhuEmswKFadCcfdZSGFMknYI4ESc4rNb
         jnygx0aZ0LpEGjdzpcDFlfJpGe2dgRENvf9+ZzOeXm0BMzOOAHoQ37tpXbLj+0lOFUFa
         5C3Q==
X-Gm-Message-State: AJaThX7ofCpoI/CfwvOaJGvg9arcL8KepqfK2l/musoT0O7QnulpUY3H
        OoYSKr+pkGTgsHF0qih/MVs=
X-Google-Smtp-Source: AGs4zMbIDGsAS4M+AK5+29AJQmbBd/S9YFGorQEApxK9K8IWNeNvSdbz26LuhypD5K0ILDXmu1Dvog==
X-Received: by 10.99.137.194 with SMTP id v185mr4781608pgd.160.1512108607893;
        Thu, 30 Nov 2017 22:10:07 -0800 (PST)
Received: from localhost.localdomain ([117.209.247.216])
        by smtp.gmail.com with ESMTPSA id o23sm9561197pgn.92.2017.11.30.22.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Nov 2017 22:10:07 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v3 3/3] rebase: rebasing can also be done when HEAD is detached
Date:   Fri,  1 Dec 2017 11:39:35 +0530
Message-Id: <20171201060935.19749-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c
In-Reply-To: <xmqqlgir8770.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgir8770.fsf@gitster.mtv.corp.google.com>
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

Changes in v2:

	- avoided unnecesarily spawning a subshell in a conditional


 git-rebase.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 3f8d99e99..1886167e0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -602,11 +602,23 @@ then
 		test -z "$switch_to" ||
 		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to" \
 			git checkout -q "$switch_to" --
-		say "$(eval_gettext "Current branch \$branch_or_commit is up to date.")"
+		if test "$branch_or_commit" = "HEAD" &&
+			 ! git symbolic-ref -q HEAD
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
+			 ! git symbolic-ref -q HEAD
+		then
+			say "$(eval_gettext "HEAD is up to date, rebase forced.")"
+		else
+			say "$(eval_gettext "Current branch \$branch_or_commit is up to date, rebase forced.")"
+		fi
 	fi
 fi
 
-- 
2.15.0.531.g2ccb3012c

