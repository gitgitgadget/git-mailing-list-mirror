Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B10C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B98320702
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFYb1tgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404031AbgFXOsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403792AbgFXOsp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:48:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ABEC0613ED
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:48:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o2so2801561wmh.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WATopKgvPgAzyxZfMXtvKku6B/p2t4DGUl/bBvKCCTs=;
        b=kFYb1tgvpPC/9z18YyKvpY6HjK4qvM2Nwt6EF60dFZ48ea5I3JdnxqLu0lvMfoChwZ
         AXbZbiHjv2PBLXXwQvvuEWUe125MQFSPszTltY9nVxgUxjvWwFgCx/VfP27HkogoxiuO
         IjWDEikLZ6IIv7N/u/egR+2vKO/67L6/6XHswGQKQByGr8ry6rOrft5Lh4oXieM4TvjQ
         dXYpALf0QpV51E0o8ya0rwUUhoeaFDk3CMROI0obIxUh1CRk5aqMPRff8xBliz81HRxs
         JjAZYZxonPC02GY8/B9/nNzWEB+IHllv+58bY7Gf3w+MH0epcKCA+LhYkBLd0+Gzsm3F
         HA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WATopKgvPgAzyxZfMXtvKku6B/p2t4DGUl/bBvKCCTs=;
        b=ksppvjEJ7bnLjTL2cqsW4wcWHsz8DvYDHZrRPKpvWkpU3QQWwtnH28b1qdg4w4v/SP
         XZ7QKsWPp244A2UKj3oZFDaxa2vjXsljubgi6xkyCiMW4imGkxb1Uuz17iMNpxQxw4hj
         02e+keBOL82z5vw1h+7kwKvu9e1ekmqML3+y3Yy/Gzf8aYmPD8L7ppCjD29o8HToc3Wx
         0Vp0bnsDX9IDyZSyxV3Bey34zCN+CpMq7C8JoyK+TzYmRIxI3XVHfSu6fa18tmwf0W18
         +2d7BgmGSH5AB4t7QnYMVFjyWJt6hndJXfA9zcWWy/qXamTIXxUdjdI5GbGCgv410E52
         h56A==
X-Gm-Message-State: AOAM532hY6IbMHuCnGt4xR1HTYjI43NbbvegPiJeqOYBVTK2eDGX6U/y
        963hoFkxpIREg0Sr0WSjN5AFCfHnyto=
X-Google-Smtp-Source: ABdhPJxAyCDZAW/a7SehABDjVIW5vxBdnnPIUjM/KfPBgBGR89avm7AGMpnjoXyXtbAyub10c0Lr+w==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr9316397wmd.111.1593010124184;
        Wed, 24 Jun 2020 07:48:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d132sm8288659wmd.35.2020.06.24.07.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:48:43 -0700 (PDT)
Message-Id: <c8e356c02f95c48fa30711f3f89133b6c05c2867.1593010120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
        <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:48:40 +0000
Subject: [PATCH v2 3/3] tests: reference `seen` wherever `pu` was referenced
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
index 9c6218f568..36ad20a849 100755
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
index 3c44af6940..c824608881 100755
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
