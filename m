Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D517C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6859520723
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKoq+8Jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733000AbgFWPEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732862AbgFWPEV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:04:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8001C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:04:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h5so20912876wrc.7
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ArSleIqi4egUxNnGBF4QMytVjYxAD4b1wIu6IFxs58A=;
        b=AKoq+8JwosnuUaXlEZyyNIuEHE8CNPbrNOz/hknBIzHWsxv1Oxyrdsw5hTDKdaJd4D
         nse8YSx82YTqQDofkNSuyJ0bobYGTNg55SM+IKsbI1f1L6auXnabJccC4m0cXdV4lW/e
         0gwJ5+BG3Xw/dLS6vpCvfviDDpu8nx78mrUQX2jav8cU9nckfRE+GVVqSaX01zSg2kAL
         xG3H635ADRbnkDRXPWemZBYCQIlV3Kiq5CXRp3FvovBi71v3W7QrEwvxU57oRFXJzBnH
         /0AUPEBS3+WBDMGuDXR+njtPY+so8rDnypaQTndDsZpeE7DuDNwypHCCH8bCGhrVzM0K
         0ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ArSleIqi4egUxNnGBF4QMytVjYxAD4b1wIu6IFxs58A=;
        b=MV6YzRfW/uEdknTD//1fo4poz48rxI3WEp7QpELjAptPdsL4D0iNvjRBpZNG8WUVD8
         TVJFDaFFtBoxQiHpUcoIZUDiQ4fLBxG0rLnpRwynJh7YaG4PylPPaXJbyUHucBmcPoQU
         KsfgsofOiLITLPof23Kc8wvcI4p10FOd6lvm1RGXmndd4neUKHcOdrXGcg2ocTf4jLXo
         GsTV/dHlDZ8RYBfIw+aiOVEYvvTj3TjfPpvv06S7rMvBWFoRwvi+WjU62TQfd68sEaKN
         m1k3gI85Ml/sPpIiR6g7u5xORQOtryl6sKP656PLqfc4EYLYvx978zKylytizsZEZYd4
         i8KQ==
X-Gm-Message-State: AOAM532RUat/iWOhAhgykPMAbvlYsbY/f5TSMzVjz70Ykyh5loFuLP/i
        GrAQWbBn6Q/aWRuoXK8ga3dQCyUg
X-Google-Smtp-Source: ABdhPJy8MfeLWsYJAG2T4dZG9+hhLNQCXwZfTCD+kHw8xA6/QYSbHSnbeqYItdfs6x9uGB1J1DQM0w==
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr15994899wrl.362.1592924659260;
        Tue, 23 Jun 2020 08:04:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm22876613wrm.57.2020.06.23.08.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 08:04:18 -0700 (PDT)
Message-Id: <17adbd5639f87d8f8d36b0d95e4f2fddebf3c28f.1592924655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.668.git.1592924655.gitgitgadget@gmail.com>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 15:04:15 +0000
Subject: [PATCH 3/3] tests: reference `seen` wherever `pu` was referenced
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index dda81b7d07a..8d62edd98b5 100755
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
index 77938db77f8..d11382f769f 100755
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
index aff5ef3d760..a8c2ac9d70f 100755
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
