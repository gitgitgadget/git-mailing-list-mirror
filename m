Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A537C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 08:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2965A208FE
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 08:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0PWnXeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgIKIA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgIKIAW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 04:00:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D7EC061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 01:00:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so10483776wrw.11
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 01:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=pPDfLHRxkN+T0ZkCN2q3sC7QK/7yb2OeYdmEKT/El1w=;
        b=T0PWnXeLxEc6zbP6zOV/aZBKfzm60In45SMD21yRgM5G09tems0M9yss9amCLykPKm
         WlBeE5ghSUYZAVHpePu6TAkeZBvvDwXrV7v6SP2c2KXkEUbldPeMGAYoMDqnwrkaiJ+5
         IrxhPdRm+Om9GMSjEVKtZRsxBNYAz6yH1P1E+4CUvgow4AdDKXPdWig1ojMixYgv7sKm
         JYkUtrwnqTvb6CxP+pk8TRVe2tkeVYru9pFlZuvgMmcQyB/xnDeS/JnJqmu/F7AwfTzx
         TmNlykegY2ii8uAoTijdothd7hqOMYebtnjKsvSdtq4uZ0tBEydpvamHpRY8WnMmUmvH
         T5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=pPDfLHRxkN+T0ZkCN2q3sC7QK/7yb2OeYdmEKT/El1w=;
        b=b8Ya6sPIye/eLVv+fPZ11BuEb6EOubI4PcbbbNdehzGLvY4u4sU/AVp1w3ZhLLtJil
         s9SEvPHcP4A/U7HPUUV6Kt6fwn0d/vLqBjcY/znmDeV/8D9aPbsnyEwjjKyr6y8XzPNi
         CDasi6JUgJfB71qzfTmHhFIdUkOShxPryb6w6W/hYa1nIreR1+r4DOnSC4LV/0A2wxM5
         NzS7m0ySeVvx1RccQ4ku8EnLj6wdn+4Rrnx6M6x8KHNczdtMOQkfGP1FZYZoQXgrW+UZ
         qMrZMWampbdSKTMAyydDBgrAAIlOyiFzL66tcOQwCByCwQmKpJb0p/nH3ZMNW7wTKRai
         En9g==
X-Gm-Message-State: AOAM532ASZixaHYfCmjb9ma0U81MhsCI0coujSq/sNA3kVaRDfP0I+ys
        /osldPIK5f3Ijxsb/Kv1I84mll6TsKs=
X-Google-Smtp-Source: ABdhPJz6TX9QKVCEu8ItGXkCCgA7OJpSc6aBbhRnt9W7Rq8xwrjysYow31S3H2s5BRgqR180KI7U6Q==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr748679wrq.408.1599811220918;
        Fri, 11 Sep 2020 01:00:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 185sm2795363wma.18.2020.09.11.01.00.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 01:00:20 -0700 (PDT)
Message-Id: <282e524547a4998c131a8162b72a33f6129e637b.1599811217.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.834.git.git.1599811217.gitgitgadget@gmail.com>
References: <pull.834.git.git.1599811217.gitgitgadget@gmail.com>
From:   "Lukas via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 08:00:17 +0000
Subject: [PATCH 2/2] sv: added: Skip commit if all files are ignored
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Lukas <Lukas@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas <Lukas>

I used the ignore-paths option to ignore a lot of stuff I don’t need.
The ignore pattern works well, but it could and up in empty commits.
So just the message without any modifications / changes.
The patch below skip a commit if all changes are ignored by the ignore-paths option.
In order to use this feature I includes the option to read configuration for ignore-path, include-paths in several lines.
So that the user is not limited by the max. char. per line definition.

Signed-off-by: Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>
---
 perl/Git/SVN.pm         | 21 +++++++++++++++++++++
 perl/Git/SVN/Fetcher.pm | 30 ++++++++++++++++++++++++++++++
 perl/Git/SVN/Ra.pm      |  2 ++
 3 files changed, 53 insertions(+)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 4b28b87784..fa87687306 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1188,6 +1188,22 @@ sub find_parent_branch {
 	return undef;
 }
 
+############################################################
+
+=item do_fetch()
+
+Fetch an Commit and returns a log entry
+
+Input:  $path - array of strings (Paths) in a commit
+		$rev - Revision number
+
+Output: $log_entry if successfull
+		null if skipped
+		(die) on fetch error
+
+=cut
+
+############################################################
 sub do_fetch {
 	my ($self, $paths, $rev) = @_;
 	my $ed;
@@ -1212,6 +1228,11 @@ sub do_fetch {
 		}
 		$ed = Git::SVN::Fetcher->new($self);
 	}
+	my $skip = $ed->is_empty_commit($paths);
+	if ($skip){
+		print "skip commit $rev\n";
+		return;
+	}
 	unless ($self->ra->gs_do_update($last_rev, $rev, $self, $ed)) {
 		die "SVN connection failed somewhere...\n";
 	}
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 96b14538b0..c31343b6e6 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -139,6 +139,36 @@ sub is_path_ignored {
 	return 0;
 }
 
+############################################################
+
+=item is_empty_commit()
+
+Return 1 if all given $paths are ignored, so that this commit end up in an empty commit
+
+Input:  $path - array of strings (Paths) in a commit
+
+Output: { 1 if true, 0 if false }
+
+=cut
+
+############################################################
+sub is_empty_commit {
+	my ( $self, $paths ) = @_;
+	my $path;
+	my $ignored;
+	unless ( defined( $self->{include_regex} ) ) {
+		return 0;
+	}
+
+	foreach $path ( keys %$paths ) {
+		$ignored = $self->is_path_ignored($path);
+		if ( !$ignored ) {
+			return 0;
+		}
+	}
+	return 1;
+}
+
 sub set_path_strip {
 	my ($self, $path) = @_;
 	$self->{path_strip} = qr/^\Q$path\E(\/|$)/ if length $path;
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 56ad9870bc..63be69dc12 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -475,6 +475,8 @@ sub gs_fetch_loop_common {
 				my $log_entry = $gs->do_fetch($paths, $r);
 				if ($log_entry) {
 					$gs->do_git_commit($log_entry);
+				}else{
+					next;
 				}
 				$Git::SVN::INDEX_FILES{$gs->{index}} = 1;
 			}
-- 
gitgitgadget
