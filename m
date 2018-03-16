Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EB51F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753883AbeCPUkG (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:40:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37006 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbeCPUkA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:40:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id 139so5333298wmn.2
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n9OpkSwJV0GTfW4bsDfvTbkXjDsmGb3AIYZfj4n/bjQ=;
        b=UYVPz4/xXdaIsYL7hzq2pOPnZrrIvRYyqwPpwtN38al8UFK6g3TzlduD9dUoyKhLA2
         A/hxYepCqupl/cBLkxFzo7S/hEPzhdATDidj27OZURsOvpPHRDV+uvTcPWsKbMMnRMTB
         8PK82hx+yOOjUve3pwFbwZw6YCftyy8q7RQgz82ff2daSK2Ioq/a3FeZmU+dJDRmIW8M
         gPwdLsgC6To0e1MWhAGMrIbQyI9eqmWyvaFoLeJibeVz9klIWR+hhZ6YX4XZaQ9RdXco
         fxfrhYat5yhkkKpK//wtioHydy1s4L12l27kJ9KkPA+9xDpNItM7H/spA/cb2QNh0mAy
         IxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n9OpkSwJV0GTfW4bsDfvTbkXjDsmGb3AIYZfj4n/bjQ=;
        b=kk+YrMnfB33qMEi6lwFZ8tn4etJJvYf9E/tsPljKoPz+5Dthc/15o9Ct27SSkMxpaw
         gzBpDLpQjJ3YuAUzaz74nALr/lNey3z5IK3LexQrvkEueiFEqUWGvdJwFYAmOfQdmwEy
         uFaH3u0GhXyymvxyL3pJixV7NPo/LfRF29EsTwuigdGbuEHItbn9rlMbJMHsITG4Yv4O
         ciT0WDCL/Lhz1Ft1U3WYcvmIocpK6R51sC4xZhXbfmv5O79UFo0fhsWpHlTAJrTgyCnq
         Q3rdYRuWFwbNYV9k0wjIhNCU3NPWws3XzTa39lfWUntRCJW4qLJe6a5bRgJEFT81Ot1Z
         uhfQ==
X-Gm-Message-State: AElRT7HPHAAzeFItP8FqNNISRfnzTzCGBnLcW5kEGQMoxEHllr/PvPsZ
        WvsWzMTOGk9Fd7NA/YrhxorTHBmj
X-Google-Smtp-Source: AG47ELs7uhmmrNZIVoWJbegaW2SMrHad5LwuizFIMcfnpcQ214MPoffMHkSzD3LEZRpFgl2xV9EFjA==
X-Received: by 10.28.164.3 with SMTP id n3mr2927110wme.121.1521232799227;
        Fri, 16 Mar 2018 13:39:59 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id i49sm9651397wra.44.2018.03.16.13.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 13:39:58 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/2] stash push -u: don't create empty stash
Date:   Fri, 16 Mar 2018 20:43:06 +0000
Message-Id: <20180316204306.862-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e11
In-Reply-To: <20180316204306.862-1-t.gummerer@gmail.com>
References: <20180314214642.22185-1-t.gummerer@gmail.com>
 <20180316204306.862-1-t.gummerer@gmail.com>
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
index 4de9f9bea8..dbedc7fb9f 100755
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
index 8b1a8d2982..7efc52fe11 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1112,4 +1112,10 @@ test_expect_success 'stash -u -- <untracked> leaves rest of working tree in plac
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
2.16.2.804.g6dcf76e11

