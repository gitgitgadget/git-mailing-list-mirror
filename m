Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C62781F404
	for <e@80x24.org>; Fri, 16 Mar 2018 22:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeCPWh1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 18:37:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38360 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeCPWhX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 18:37:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id z9so5672448wmb.3
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 15:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7h3NrVMB6oy1I473KiNqgK/mR+wv47X1p2QPbU5hKHM=;
        b=m7prLT9dwPHaERAII7q99QtzQW6F0y2UsIIuJx5SVjq10hMwYtMLteIMTTIFy42Eck
         hydsF57PG1Jd6EWLsyXNOUA2qxaNalnpYFq3WGA3romcyR6cPY/jc1nGVHslgX0wQTfH
         REZMNl74qoCr6BzWbHS/66C3wVkwOOpVtOoybda34wpZ0SbSfEyLsnM+L/s07vGZ7v8c
         cEiSPNRjer9wrParawgM6qp1RJynIZE58IVd+9S5jl/yfmBvF98ErUi9rNr9lw00af+m
         Yqzw6h14XoYj9sc/B2lc5VysFrNxEohenpMtY9rBC7KnyMGyC/wkTc/Z2n5hBtalQYXk
         q8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=7h3NrVMB6oy1I473KiNqgK/mR+wv47X1p2QPbU5hKHM=;
        b=pskpeUxF4Jox5FvjblK2AmRtaoIh89zndaLnz6XojR8XLZxRjRp/kOEhzJmZ06++UA
         BYAIQZtHovjJgKznnhvVbv0lnNON/qUMUdrTDCbeJXJSsLT5VVwo0izvo6/8ga0WQLtL
         IReTiJkRvushnod0dSqEzF0C7oRX5x4tMFdfz07b3ssV7sLIj6tAj8aBYfD3VIP9JMxC
         baAPOutn3URSd6CB6O1BygnUvCvq4aml0Itxt+hd2uJHLTu1IqcMSjEK7Qv/1w/TksdT
         Fku0g2beepgtGYGozkq0bc/Me1ldDWOGTH70c3jlX9nWZbZUei2RsmxXuK6EMu9R/EpV
         kfbw==
X-Gm-Message-State: AElRT7HEN/aPIlDjqIHcKfowsOFXiWPobZL7i6eoqwRv+nAivacYv3y3
        QqHSz7EFOSO+z3feMz2Pr7n6dxeT
X-Google-Smtp-Source: AG47ELt8YypDNM/M/8ayzaAo8/PqqzVUHXovfBJjFqAf3zYAJRnWq8WBEU04C+nM8znKjeOcH4wHqg==
X-Received: by 10.28.218.1 with SMTP id r1mr2771999wmg.156.1521239841266;
        Fri, 16 Mar 2018 15:37:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k130sm8995339wmg.9.2018.03.16.15.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 15:37:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 3/3] stash push -u: don't create empty stash
Date:   Fri, 16 Mar 2018 15:37:15 -0700
Message-Id: <20180316223715.108044-4-gitster@pobox.com>
X-Mailer: git-send-email 2.17.0-rc0
In-Reply-To: <20180316223715.108044-1-gitster@pobox.com>
References: <20180316204306.862-1-t.gummerer@gmail.com>
 <20180316223715.108044-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Gummerer <t.gummerer@gmail.com>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh     | 2 +-
 t/t3903-stash.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index fa61151548..1652f64b5c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -39,7 +39,7 @@ fi
 no_changes () {
 	git diff-index --quiet --cached HEAD --ignore-submodules -- "$@" &&
 	git diff-files --quiet --ignore-submodules -- "$@" &&
-	(test -z "$untracked" || test -z "$(untracked_files)")
+	(test -z "$untracked" || test -z "$(untracked_files "$@")")
 }
 
 untracked_files () {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index f5b102a958..7e0b1c248c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1019,4 +1019,10 @@ test_expect_success 'stash -u -- <untracked> leaves rest of working tree in plac
 	test_path_is_file tracked
 '
 
+test_expect_success 'stash -u -- <non-existant> shows no changes when there are none' '
+	git stash push -u -- non-existant >actual &&
+	echo "No local changes to save" >expect &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
2.17.0-rc0

