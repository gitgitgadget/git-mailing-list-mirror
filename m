Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ADE92036D
	for <e@80x24.org>; Tue, 21 Nov 2017 15:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbdKUP0c (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 10:26:32 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37232 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdKUP0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 10:26:31 -0500
Received: by mail-pg0-f67.google.com with SMTP id m4so471975pgc.4
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 07:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5iXl6m/MxSoomGX2lM/jdjhp7j50irfxsSnYmwcw1fc=;
        b=AS4Igx8Y8pDUMLZW1Z0/A0muotiarJ2FeZl9q091SdS/DhrCoSny/T3s6AK/b+ZcJ7
         XVbwPozss5gGTSSePyTnwR15TXvATbPvySUKkgfEXSQRD52XfMxZhNs3qQxhXHxJ+0Hk
         9QXwn0+Zqx6+VlfRxvyv2aJFGwqAu8wzwZNA9e7QuurDjJRvAmo1//tJYHfNyXB3qm2y
         yqiwwvKJP+/8g+oD8SiksDkDTAOJhK4Eev0UglXd1h7cWBYcCZM5tqPV9BRwcd84Fk+/
         FbfrSktdyfgzJL8n372r158NbSxS+6N9QVANjkWlf7yZbNF5pYM136hup894TJlfRIxz
         02Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5iXl6m/MxSoomGX2lM/jdjhp7j50irfxsSnYmwcw1fc=;
        b=TluUyCHB76o7AX/JIR8q7MLv/KDMPBTaqZUyLQw+lm09/dzCVEpc5YacPctrK8DxE+
         UWtsBwGCX37Q1BOc9FMwL0vT7qUhSHew4uJNaASt0oWYAL48s9DbNCXU/0BTt8yISwyl
         +Jz7dd9U1faHQ2rfRAGKZ7mgrs6JA/o6OoMQygjfXEJekH9U1UEuI+HI1eBPvELKeWkr
         iz+LDHXuCBV6/B10bTv1RQh9pshUkhDWaFfD/XOFfFK/eJsbmx6vuun8AD5/6pbEXyku
         hDTgDMsTDyCkdljZUFe7L1vijF0bQs1qyUbghn6TylmslQ+zC6bPHMPmL9+UbTKy6Hgq
         AhXQ==
X-Gm-Message-State: AJaThX6RSXM6rziMByOi+j/VcgMX5wSh45N3uWzej7FwyjyYNPwNVq0K
        ciUASpu5O5OmZkSWtGzH2vk=
X-Google-Smtp-Source: AGs4zMbhng0OHBfv3KeqvEAisPm8+EHHx1qNxSsX2+EzJ5CYA28Ay6H2j0TaxMGB46isqwaQ5nRu8w==
X-Received: by 10.84.217.206 with SMTP id d14mr17820574plj.132.1511277990617;
        Tue, 21 Nov 2017 07:26:30 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7280:849f:7a33:ea78:e714:400])
        by smtp.gmail.com with ESMTPSA id r16sm20224662pgt.72.2017.11.21.07.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 07:26:29 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH] rebase: rebasing can also be done when HEAD is detached
Date:   Tue, 21 Nov 2017 20:55:33 +0530
Message-Id: <20171121152533.3793-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a repository when attempting to rebase when the HEAD is detached
and it is already up to date with upstream (so there's nothing to do),
the following message is shown

        Current branch HEAD is up to date.

which is clearly wrong as HEAD is not a branch.

Handle the special case of HEAD correctly to give a more precise
error message.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 In this patch, I basically assumed that there would be no
 branch named "HEAD". To the cotrary if it did, it would make
 'git' throw spurious ambiguity messages, in general. So, I
 guess it's not worth trying to check if HEAD is a branch or
 not and handle that specially.

 git-rebase.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 6344e8d5e..933df832a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -598,11 +598,21 @@ then
 		test -z "$switch_to" ||
 		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to" \
 			git checkout -q "$switch_to" --
-		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
+		if test "$branch_name" = "HEAD"
+		then
+			say "$(eval_gettext "HEAD is up to date.")"
+		else
+			say "$(eval_gettext "Current branch \$branch_name is up to date.")"
+		fi
 		finish_rebase
 		exit 0
 	else
-		say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
+		if test "$branch_name" = "HEAD"
+		then
+			say "$(eval_gettext "HEAD is up to date, rebase forced.")"
+		else
+			say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
+		fi
 	fi
 fi
 
-- 
2.15.0.345.gf926f18f3

