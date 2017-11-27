Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6F3E20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 17:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932412AbdK0RVo (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 12:21:44 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42642 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932389AbdK0RVl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 12:21:41 -0500
Received: by mail-pg0-f66.google.com with SMTP id j16so18967287pgn.9
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 09:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFQD4Hvgq2RVDh8MWScppDaoWphYkItNrC/Sn2rzih0=;
        b=dwpKdFjOzipp8fRyRx6gsPw//0knre2BiCM291QqIUOo4BBqBsIKGEdU3QmTVyt5qD
         vByGiPIdJ2NbEL+rUaLeOm8+URTBbJTMZtSHjJJmdj4jszwJ3W2k/dytC0le+UA5jsD/
         c2pZydihutiyjAIaOG8AbEBAwjQ0ZKVlmkQwoMV6XNvASavfUn7C2EBaD8gD/oEJTBLH
         i9bDzOhvWNAorEnYBR7UA1VA+o98HUkPe15P80ubFG+EXN6JSiiJW78aGWXQPfjA/WRw
         N44UUNvMrQoQX/OaBAzL6dHyOaQEsRZQYK6L4C47+zCVpf6rnt1idiaIoTrBRq1ottuj
         SJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFQD4Hvgq2RVDh8MWScppDaoWphYkItNrC/Sn2rzih0=;
        b=Rzupx4qYd8h8kxCSLNlDlZGUk1d2hAX3BQvjj47xDBqNwcL0An5aLtMC5q8z+g5swD
         J5zc94G48BdmYzDrucS1EqLN5Jic/8gOvGvYmFPwtXfXoy1yF0WS95dSyvAIvwkFrcZk
         t7QGFQ3+qGayE2owTGrgzsOsaPyneEnhZzO2SAHuArq36IQtGsY4nC6Lc+BR1mhIWqWC
         hdpw+AF1fP4i0fZGNdHrl/ZflFgUJ083VC3vrLsNMOyN1VSTQLrSVhLdPLg0RdpifDMt
         G2ETgL9OW2zikA9Vzv2Aq1nZa6uD+C8AkyKZzNIjur9utmJ5/bqRu2jiqb3iGFUxFyrK
         5dew==
X-Gm-Message-State: AJaThX7IiLVmDGgQgE1On3fhULXzORRXYbOOp/xtz9Ua3MFPKqS/YOpg
        /A3t3zq0FNCcNEinciLpk68Q4T3tRLo=
X-Google-Smtp-Source: AGs4zMZBAX+DZMqXSk+9cvztbtESgZnfX+uyVapzL87TiOW0f5NWADxPRUZXv+hOEavZcY9YO2kiHg==
X-Received: by 10.99.117.83 with SMTP id f19mr11989858pgn.225.1511803300588;
        Mon, 27 Nov 2017 09:21:40 -0800 (PST)
Received: from localhost.localdomain ([2405:204:73c7:b4fb:72c8:dd31:37ff:6021])
        by smtp.gmail.com with ESMTPSA id o88sm49573712pfj.175.2017.11.27.09.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 09:21:39 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v2 2/3] rebase: distinguish user input by quoting it
Date:   Mon, 27 Nov 2017 22:51:03 +0530
Message-Id: <20171127172104.5796-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
References: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
 <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 git-rebase.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index a675cf691..3f8d99e99 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -477,7 +477,7 @@ then
 		;;
 	esac
 	upstream=$(peel_committish "${upstream_name}") ||
-	die "$(eval_gettext "invalid upstream \$upstream_name")"
+	die "$(eval_gettext "invalid upstream '\$upstream_name'")"
 	upstream_arg="$upstream_name"
 else
 	if test -z "$onto"
@@ -540,7 +540,7 @@ case "$#" in
 		head_name="detached HEAD"
 
 	else
-		die "$(eval_gettext "fatal: no such branch/commit: \$branch_or_commit")"
+		die "$(eval_gettext "fatal: no such branch/commit '\$branch_or_commit'")"
 	fi
 	;;
 0)
-- 
2.15.0.345.gf926f18f3

