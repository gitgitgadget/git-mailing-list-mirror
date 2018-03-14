Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D691F404
	for <e@80x24.org>; Wed, 14 Mar 2018 21:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeCNVnl (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 17:43:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42253 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNVnk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 17:43:40 -0400
Received: by mail-wr0-f194.google.com with SMTP id s18so6206054wrg.9
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 14:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JImPYVETg0auxUiDNjFGn9IGwnSofmt8aMahUvsKNzI=;
        b=oiAYC7LnpDmRjTVmtcLZpvYkh1Dy7IvEg8hFC6zb3RZx4Hl/q+K+6/YtoSX/Yi5xuX
         8BPQIkhxrItw+5oFDASAdgPcauMxma/6yK1N0D6dVtMacuRhuLb01hgj2zh94+Pu7BsQ
         AC5bgvivRhqqLSYrI11mqOaF1r88LgIP1r8tmqUIuzlqcAlW1a2DsjFaJUdFN1t2680C
         CdCB64Ey8EUgoRG77BUHaYYcj4lGbzvVuLcqZBqmOgAKr8iailzaXLMueRQGsHKXehTL
         vMLBip7PbZuWPyTjGy4RfwqyAhcVra+ADDs/yAHTvT4r2dVxLMkZfeBvTCwcilsTjnnC
         /A+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JImPYVETg0auxUiDNjFGn9IGwnSofmt8aMahUvsKNzI=;
        b=r28guZ0EKd0NNqwwrnKTruIp+j0Z1J2he88RSk+A3ECKEfUU0yi6EwVE7YDqW/rIx8
         VI/eB9rHxSkYm7kvebmZUDRvUe2c2v7/wltxvnLGsYpdcO6Yl80DtX/3fg74iqMUwigk
         KtddRNWWcINim9XBaubMscql5nrWmVxHUdOSyfZ1SpuyihpE3HiKXzIyoevJklS9y+aK
         R/GoemZvOsgz05wvgV/YPbmeEiDRmQLf+F83gpwMCnCrduVj/iwzKlosg62siaEjJ7SV
         pkNcsxipRDeuUsW8FCTb0rTlQE/7XYGfUqaHpNagQMgdLghxh27X5wODxX/x59zc3DkW
         /05A==
X-Gm-Message-State: AElRT7F+D8YCYWVAW8gtseSa8BHBWIuwSaSZAGbRY319HUMi1uUK5/Yl
        aZUgjXW4WC4kQ4Dqo+qAGBdDPre5
X-Google-Smtp-Source: AG47ELtOvCTZV91ivzrmzvckEadK5Zo7PN3c11PGTt+dA8hrtpO/qNdOHqHlDiwYXmqm1zGKCiKsRw==
X-Received: by 10.223.133.214 with SMTP id 22mr5330575wru.130.1521063818796;
        Wed, 14 Mar 2018 14:43:38 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id u127sm3084966wmd.30.2018.03.14.14.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 14:43:37 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/2] stash push -u: don't create empty stash
Date:   Wed, 14 Mar 2018 21:46:42 +0000
Message-Id: <20180314214642.22185-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e11
In-Reply-To: <20180314214642.22185-1-t.gummerer@gmail.com>
References: <20180310111215.GA14732@hank>
 <20180314214642.22185-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When introducing the stash push feature, and thus allowing users to pass
in a pathspec to limit the files that would get stashed in
df6bba0937 ("stash: teach 'push' (and 'create_stash') to honor
pathspec", 2017-02-28), this developer missed one place where the
pathspec should be passed in.

Namely in the call to the 'untracked_files()' function in the
'no_changes()' function.  This resulted in 'git stash push -u --
<non-existant>' creating an empty stash when there are untracked files
in the repository other that don't match the pathspec.

As 'git stash' never creates empty stashes, this behaviour is wrong and
confusing for users.  Instead it should just show a message "No local
changes to save", and not create a stash.

Luckily the 'untracked_files()' function already correctly respects
pathspecs that are passed to it, so the fix is simply to pass the
pathspec along to the function.

Reported-by: Marc Strapetz <marc.strapetz@syntevo.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh     | 2 +-
 t/t3903-stash.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 058ad0bed8..7a4ec98f6b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -39,7 +39,7 @@ fi
 no_changes () {
 	git diff-index --quiet --cached HEAD --ignore-submodules -- "$@" &&
 	git diff-files --quiet --ignore-submodules -- "$@" &&
-	(test -z "$untracked" || test -z "$(untracked_files)")
+	(test -z "$untracked" || test -z "$(untracked_files $@)")
 }
 
 untracked_files () {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index fbfda4b243..5e7078c083 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1103,4 +1103,10 @@ test_expect_success 'stash -u -- <untracked> doesnt print error' '
 	test_line_count = 0 actual
 '
 
+test_expect_success 'stash -u -- <non-existant> shows no changes when there are none' '
+	git stash push -u -- non-existant >actual &&
+	echo "No local changes to save" >expect &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
2.16.2.804.g6dcf76e11

