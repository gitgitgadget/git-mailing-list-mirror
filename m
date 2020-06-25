Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BBCC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31274206C3
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iw6vjksG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404688AbgFYMTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404684AbgFYMTF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:19:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194D1C0613ED
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:19:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j4so3144297wrp.10
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uTAZCiPBgTXSmwQOskIQagbHSzfgkIhxWaoX6yxfVro=;
        b=iw6vjksGx2lUyI04hIN3f3lH0U0DM+z3nqZDXvGx3XH+AYDSqZI66crUMSqukfZFrN
         5aF6nudlbqh4eKoCF7xqauiTWULGoWeiTRrDWAtrlUHhaHPo+GAQpwrzHOAMVlTqH9UB
         /oz1VM1iZCe6tAQjjmQMxHihWbFZ4N83/lX5ZVacTzH7IKtvftQAosHra9kQxF5R1Em5
         IUJN8D4FC92NdPb6J5zQHym02qSaHdfTPavIzjMVTQ5zwsqivW+KWSr9tzCJV72++Do/
         WBPOynfArTRpoLihqcRZ+Ncil1OLoOLurA1LLkxnmvJyfvlT/iBgLb5TrObJAMQm9qRh
         s/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uTAZCiPBgTXSmwQOskIQagbHSzfgkIhxWaoX6yxfVro=;
        b=nIoNbjV5+D7CNk5SlnH4WW1OlXdR8aDBgbwcGXWBU2sKQfxYvgEp1mf3hHyfIFNy/p
         gK4dGwqe7Lxf7WDUWP9Bpk2RdLisLH5wNHuf60e1T3oTJdBxAL6jLri7S/h8pMx2Q7KB
         uWJwERxRuwWNNVLe8lYjr/XU7dAdPH73kna19QpONfbvrDv9YUlXTq6r5wofWshv+Diw
         jWDUXWWVU/WcXsa4OCGIr6HiJLTHTQr9t0dBHj7NEnQ08Cb4Pc/ydM5cv/Ggg2ACe7JJ
         PAitzEjJJWzQqKgeePp3WzisfemgSx+tNNaeXeX25cOFjhuAiCC71u2VNTKCI147Gaf4
         rjhA==
X-Gm-Message-State: AOAM532slnfadiierno5sujbtak5VMfahqUs7ZP5KEzAg2g8N5ZiTdeq
        rEYnAC9XnyfmBk6Ko4p+DcLxD/z8
X-Google-Smtp-Source: ABdhPJzNJgbyOCVgczPrwwYVfox4DQKIyvVRpLSxqGEqK9jLRQKIY4shXobzzSYrcp/zclUwjKCB9Q==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr24854215wrn.179.1593087543631;
        Thu, 25 Jun 2020 05:19:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2sm11900887wmo.44.2020.06.25.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:19:03 -0700 (PDT)
Message-Id: <e38ade2ee060bac1e92869de1121d1e79d9d6a56.1593087539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.668.v3.git.1593087539.gitgitgadget@gmail.com>
References: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
        <pull.668.v3.git.1593087539.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Jun 2020 12:18:59 +0000
Subject: [PATCH v3 3/3] tests: reference `seen` wherever `pu` was referenced
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As our test suite partially reflects how we work in the Git project, it
is natural that the branch name `pu` was used in a couple places.

Since that branch was renamed to `seen`, let's use the new name
consistently.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh     |  8 ++++----
 t/t5516-fetch-push.sh | 16 ++++++++--------
 t/t9902-completion.sh |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index dda81b7d07..8d62edd98b 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -988,7 +988,7 @@ test_expect_success 'remote set-branches' '
 	+refs/heads/maint:refs/remotes/scratch/maint
 	+refs/heads/master:refs/remotes/scratch/master
 	+refs/heads/next:refs/remotes/scratch/next
-	+refs/heads/pu:refs/remotes/scratch/pu
+	+refs/heads/seen:refs/remotes/scratch/seen
 	+refs/heads/t/topic:refs/remotes/scratch/t/topic
 	EOF
 	sort <<-\EOF >expect.setup-ffonly &&
@@ -998,7 +998,7 @@ test_expect_success 'remote set-branches' '
 	sort <<-\EOF >expect.respect-ffonly &&
 	refs/heads/master:refs/remotes/scratch/master
 	+refs/heads/next:refs/remotes/scratch/next
-	+refs/heads/pu:refs/remotes/scratch/pu
+	+refs/heads/seen:refs/remotes/scratch/seen
 	EOF
 
 	git clone .git/ setbranches &&
@@ -1016,7 +1016,7 @@ test_expect_success 'remote set-branches' '
 		git config --get-all remote.scratch.fetch >config-result &&
 		sort <config-result >../actual.replace &&
 
-		git remote set-branches --add scratch pu t/topic &&
+		git remote set-branches --add scratch seen t/topic &&
 		git config --get-all remote.scratch.fetch >config-result &&
 		sort <config-result >../actual.add-two &&
 
@@ -1028,7 +1028,7 @@ test_expect_success 'remote set-branches' '
 		git config --get-all remote.scratch.fetch >config-result &&
 		sort <config-result >../actual.setup-ffonly &&
 
-		git remote set-branches --add scratch pu &&
+		git remote set-branches --add scratch seen &&
 		git config --get-all remote.scratch.fetch >config-result &&
 		sort <config-result >../actual.respect-ffonly
 	) &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9ff041a093..12ae04c1fe 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -747,42 +747,42 @@ test_expect_success 'deletion of a non-existent ref alone does trigger post-rece
 '
 
 test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks with correct input' '
-	mk_test_with_hooks testrepo heads/master heads/next heads/pu &&
+	mk_test_with_hooks testrepo heads/master heads/next heads/seen &&
 	orgmaster=$(cd testrepo && git show-ref -s --verify refs/heads/master) &&
 	newmaster=$(git show-ref -s --verify refs/heads/master) &&
 	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
 	newnext=$ZERO_OID &&
-	orgpu=$(cd testrepo && git show-ref -s --verify refs/heads/pu) &&
-	newpu=$(git show-ref -s --verify refs/heads/master) &&
+	orgseen=$(cd testrepo && git show-ref -s --verify refs/heads/seen) &&
+	newseen=$(git show-ref -s --verify refs/heads/master) &&
 	git push testrepo refs/heads/master:refs/heads/master \
-	    refs/heads/master:refs/heads/pu :refs/heads/next \
+	    refs/heads/master:refs/heads/seen :refs/heads/next \
 	    :refs/heads/nonexistent &&
 	(
 		cd testrepo/.git &&
 		cat >pre-receive.expect <<-EOF &&
 		$orgmaster $newmaster refs/heads/master
 		$orgnext $newnext refs/heads/next
-		$orgpu $newpu refs/heads/pu
+		$orgseen $newseen refs/heads/seen
 		$ZERO_OID $ZERO_OID refs/heads/nonexistent
 		EOF
 
 		cat >update.expect <<-EOF &&
 		refs/heads/master $orgmaster $newmaster
 		refs/heads/next $orgnext $newnext
-		refs/heads/pu $orgpu $newpu
+		refs/heads/seen $orgseen $newseen
 		refs/heads/nonexistent $ZERO_OID $ZERO_OID
 		EOF
 
 		cat >post-receive.expect <<-EOF &&
 		$orgmaster $newmaster refs/heads/master
 		$orgnext $newnext refs/heads/next
-		$orgpu $newpu refs/heads/pu
+		$orgseen $newseen refs/heads/seen
 		EOF
 
 		cat >post-update.expect <<-EOF &&
 		refs/heads/master
 		refs/heads/next
-		refs/heads/pu
+		refs/heads/seen
 		EOF
 
 		test_cmp pre-receive.expect pre-receive.actual &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5505e5aa24..3fef499322 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -494,7 +494,7 @@ test_expect_success '__gitcomp - prefix' '
 '
 
 test_expect_success '__gitcomp - suffix' '
-	test_gitcomp "branch.me" "master maint next pu" "branch." \
+	test_gitcomp "branch.me" "master maint next seen" "branch." \
 		"ma" "." <<-\EOF
 	branch.master.Z
 	branch.maint.Z
@@ -545,7 +545,7 @@ read -r -d "" refs <<-\EOF
 maint
 master
 next
-pu
+seen
 EOF
 
 test_expect_success '__gitcomp_nl - trailing space' '
-- 
gitgitgadget
