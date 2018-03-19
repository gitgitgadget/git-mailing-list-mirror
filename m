Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A2B1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 23:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755941AbeCSXTB (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 19:19:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51409 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755873AbeCSXTA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 19:19:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id h21so81441wmd.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wooyPkEw6U5GDHLpGrutWzu/DRy7Y2Pyt2iszaEdTfg=;
        b=QAcfnLrPkwhzfA4Y8v2f+XqSz/zwI9Lulvo8FLhkkjFnjCAiXs9s443zEw8CKRmZL4
         lDsUx8VwGettJs7A5Tp+XunWzDUVD0HZaEH85Eo9UvD9+dXdzjUtsTRaxZNLcykaFGuc
         hN2ZGQn6N9xZ6Om6nlmxVXXNrc9cfTOQe2/pH9tZ97MmBW8FgZnq5hhpMffab/OHUeXb
         KhAxX2nNbCTMG/jsW/L/3tVYAW5vw/c8PU+x0a5GcZ0kqeZEost3JoJzDGXiz51AEF0M
         4oh2hfbjueFGFiKsHoRVxuokvVWq/ragKxsnifz6QLLCu/GyvHaiO/v6RkZEnuZgdTsv
         8iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wooyPkEw6U5GDHLpGrutWzu/DRy7Y2Pyt2iszaEdTfg=;
        b=HIl9jEJCyVAkQzgcguioF8gSjhyAQ7y3+0sT0bLrVuM25coEdl/9AL919VLx1BxW4L
         RMspxOJgcMPK2GZGET5BP97smEoIgKTfuC0K9uTCrKStBFiOjgff3/4lUYOdKRyrCcag
         tUJG4TJlqywwHXDQyXvAR5fFjx9+JOBElRuKlxW5mLchy4q1khNKhbkY/Ce7cbxwsgXe
         X1Pc7yh69TYt92yfAR4QCv83LiHIT49hF9LYhIA0ggAwS3RpTExnGlNKC6G/yYgA1vOF
         hIrV2i5nmyR78cKc0FVWuYQAETA139/lDJV2Ty19TAvBKLscEFmsnsGN8nIhFt2+Dw16
         QFRw==
X-Gm-Message-State: AElRT7GPxTGO25AqReb6GFeiR3uSxRXMbrXdRYx7QCZ/AXvRF0KMxdAB
        82CQTlOGsGbN0o+/LSJpIraSX6V1
X-Google-Smtp-Source: AG47ELuuu4DXWnak3cpFF/zhr9+rZfuCns0OQuZIqu8qkKYHeKfEP79ZKK2d4fSuYuJPcmj7Bb9OtQ==
X-Received: by 10.28.132.141 with SMTP id g135mr363818wmd.112.1521501539144;
        Mon, 19 Mar 2018 16:18:59 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 142sm260080wmq.47.2018.03.19.16.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 16:18:58 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 3/3] stash push -u: don't create empty stash
Date:   Mon, 19 Mar 2018 23:21:56 +0000
Message-Id: <20180319232156.30916-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.33.g3165b24a68
In-Reply-To: <20180319232156.30916-1-t.gummerer@gmail.com>
References: <20180316223715.108044-1-gitster@pobox.com>
 <20180319232156.30916-1-t.gummerer@gmail.com>
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
 git-stash.sh                       | 2 +-
 t/t3905-stash-include-untracked.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 5e06f96da5..4e55f278bd 100755
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
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 2f9045553e..3ea5b9bb3f 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -274,4 +274,10 @@ test_expect_success 'stash -u -- <ignored> leaves ignored file alone' '
 	test_path_is_file ignored.d/bar
 '
 
+test_expect_success 'stash -u -- <non-existant> shows no changes when there are none' '
+	git stash push -u -- non-existant >actual &&
+	echo "No local changes to save" >expect &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
2.15.1.33.g3165b24a68

