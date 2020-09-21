Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43F4C43463
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E0A20773
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzdixHD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgIUKkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgIUKkm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41E8C0613D3
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so12208596wrm.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F78QEosZUXcqHNdM3pqtZwzRQrKNY+DZLbz7OwMnxpo=;
        b=ZzdixHD3T5LXWoJVTBCQQfRvsCTxbOvkRw+rbV2JkllI1kz2RYA3ICwPngg52dy1y8
         Hj/Xw7okn9xqSlCrq5FNacltxnIujDI7qLz8FK2oVbAiEM1n0xuSFM8rUdAiqz19kpZ+
         vqsAO8TTEit8uI/TSB/Hh6QYLsJSsaXbpbe5NCiWpxR3bAuCXpHTVHKc95jPiNmIqAVx
         +HiCkeUEDmxd5JE1pFwR0nFmqUL5NOCzLemHMfxIRszayLU/44vWI3NF14nmFmWkip8l
         IUMEFd+kMlh3hZPDdDRM1STWSkThyLwyb4kbVBBFs+Tpx0e+QET/9P5CBAr8V7SOh4V5
         d/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F78QEosZUXcqHNdM3pqtZwzRQrKNY+DZLbz7OwMnxpo=;
        b=rCP1mj5SadEBo4SDdJu0dJYHBuvtsR5butLzWs7jMrzo9+oEedzcK25qzMNZOs/rQD
         EP+r8BgtErD21KDyH//k4Vi3CmMGnuWLP/LNTnOUVfwYHFBfra2zCUDhKz8uQ1ywL7Lq
         6rnzRB99qeSI5RwdsgTgEE6hQccNqctkPgjfObW4+tdcwJ1jNwKyaRbSiuGUGdxl9jDG
         sBa7dsAzjPx5rCtg0XOa2XZ1m6HatAa/CURN+9eDW63O8ielzUnSuwoEuc/GdLidsGb8
         AliE9E7JcBni6KCpnNBfKxP9+s+x91HNMRKgD1Dq0GbuY1Da7sYVK6ytHQGrNlwCjTi6
         CN2A==
X-Gm-Message-State: AOAM530SmxCD2aTm2YLUGFDVwivoWBMQip7aHpxEPADjl4reJu/QyP1j
        EnkCrEuGX5uDr00AKoqLAfAgdHpQ89sOLA==
X-Google-Smtp-Source: ABdhPJzCYYbb0keHvto09aX2snYAF6BSykEy6cnvFZfG/5BSiLOIPKEODPPZtfaJ6JmTuKdd8x3g0w==
X-Received: by 2002:adf:e690:: with SMTP id r16mr51276144wrm.15.1600684832398;
        Mon, 21 Sep 2020 03:40:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 17/18] remote-mediawiki: annotate unquoted uses of run_git()
Date:   Mon, 21 Sep 2020 12:39:59 +0200
Message-Id: <20200921104000.2304-18-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explicitly annotate the invocations of run_git() which don't use
quoted arguments. I'm not converting these to run_git_quoted() because
these invocations pipe stderr to /dev/null, which the Perl open() API
doesn't support.

We could do a quoted version of this with IPC::Open3, but I don't
think it's worth it to go through that here. Let's instead just mark
these sites, and comment on why it's OK to use the variables we're
using.

This eliminates the last uses of run_git(), so we can remove the alias
for it introduced in an earlier commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index bbf68ddc46..d21c18df7b 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -395,8 +395,6 @@ sub run_git_unquoted {
     _run_git(["git $_[0]"], $_[1]);
 }
 
-BEGIN { *run_git = \&run_git_unquoted }
-
 sub get_all_mediafiles {
 	my $pages = shift;
 	# Attach list of all pages for media files from the API,
@@ -522,8 +520,11 @@ sub download_mw_mediafile {
 }
 
 sub get_last_local_revision {
-	# Get note regarding last mediawiki revision
-	my $note = run_git("notes --ref=${remotename}/mediawiki show refs/mediawiki/${remotename}/master 2>/dev/null");
+	# Get note regarding last mediawiki revision.
+	#
+	# It's OK to use run_git_unquoted() here because $remotename is
+	# supplied by the local git itself.
+	my $note = run_git_unquoted("notes --ref=${remotename}/mediawiki show refs/mediawiki/${remotename}/master 2>/dev/null");
 	my @note_info = split(/ /, $note);
 
 	my $lastrevision_number;
@@ -1188,10 +1189,16 @@ sub mw_push_revision {
 	my $mw_revision = $last_remote_revid;
 
 	# Get sha1 of commit pointed by local HEAD
-	my $HEAD_sha1 = run_git("rev-parse ${local} 2>/dev/null");
+	#
+	# It's OK to use run_git_unquoted() because $local is supplied
+	# by the local git itself.
+	my $HEAD_sha1 = run_git_unquoted("rev-parse ${local} 2>/dev/null");
 	chomp($HEAD_sha1);
 	# Get sha1 of commit pointed by remotes/$remotename/master
-	my $remoteorigin_sha1 = run_git("rev-parse refs/remotes/${remotename}/master 2>/dev/null");
+	#
+	# It's OK to use run_git_unquoted() here because $remotename is
+	# supplied by the local git itself.
+	my $remoteorigin_sha1 = run_git_unquoted("rev-parse refs/remotes/${remotename}/master 2>/dev/null");
 	chomp($remoteorigin_sha1);
 
 	if ($last_local_revid > 0 &&
-- 
2.28.0.297.g1956fa8f8d

