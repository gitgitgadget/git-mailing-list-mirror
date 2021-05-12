Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9C3C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB8460FE6
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhELNtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhELNtm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:49:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CA0C061760
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so3086097wmh.4
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pxOKXMSFcKzmxeR0sbz82oKefxgn26hTbpZJx+ADDos=;
        b=W+EfKMukCW45Wbs0pPWIcWf4+VpUL9YmlYANHUKgGJb3ajFLsC8MUAFFpKM7yP1b54
         +hdgOwg4AWs9aMofjnM724PkcM2J+LBsY/6ls5b4RPrSAawfWJb12KV0OSYTlKaNcud6
         WYRlGMuClWBsw+XoiuIHcUROiZzhw7viwzA2HBHNfg6W94VkSBeeFqDKCjThmyVyK4ZP
         15IjlmVX8xH1IYozdsAEOMVFi6Ze5eymTWT9AAg/QB9t97PWZxR3IOY8LsDzMbdn63Th
         ROHb+F0Ol+pxaxTqmnAVQRBJLk/tctqiIPL5nzj4cs24TsdAcRyS8/BqZ/6eARDWkaue
         ScKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pxOKXMSFcKzmxeR0sbz82oKefxgn26hTbpZJx+ADDos=;
        b=au+pbWNWcBqowhiO5QE0PzFmY6gvNs9pWBrGYdpcqJyY+KORg/npmyywL2PycIxRaW
         0BLLcw8P5yUAHC4aWNosc9v5ZovNVxi3o2QCKDdENhD5fA3oQgO84mNWHAOjYnjiJ2Is
         E/Ih5cl0jsBn9Rwo06t8gCVt0atflwk1uXhq3I2XD3eofJQmIttN3DqE+KmNDD5Jm8NV
         oeD/hf1KT6320SvhqlCYF4aKgVxS1/9uu8Dl+gPiltFHXPnc0M51D0G8qq7HYG3VtrNt
         nHWGHApO4eaccL5theAIHzqdwTlLDs9L5LJg/gRtKZZEBThmOcR/dS3G85Wsr6PZMlxc
         2JSQ==
X-Gm-Message-State: AOAM532Be3vbH+DS1xXAyyvTo6KwkQJ14G8J5eq2CTgtF/FXFX/MgKUP
        t7JUpCE81uUHnQHgt6EblEH0HsC4erCDDQ==
X-Google-Smtp-Source: ABdhPJyHlvjoQp8qoIUddY95Ank0Fn5qrQjIHWZf1ehlq6xd27bXUUslAfXz/INuefyP5OMWD0vg3Q==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr11841106wmj.170.1620827310797;
        Wed, 12 May 2021 06:48:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm31416612wmb.32.2021.05.12.06.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:48:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/9] send-email: lazily shell out to "git var"
Date:   Wed, 12 May 2021 15:48:20 +0200
Message-Id: <patch-4.9-e1df469d5f-20210512T132955Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Optimize git-send-email by only shelling out to "git var" if we need
to. This is easily done by re-inventing our own small version of
perl's Memoize module.

I suppose I could just use Memoize itself, but in a subsequent patch
I'll be micro-optimizing send-email's use of dependencies. Using
Memoize is a measly extra 5-10 milliseconds, but as we'll see that'll
end up mattering for us in the end.

This brings the runtime of a plain "send-email" from around ~160-170ms
to ~140m-150ms. The runtime of the tests is around the same, or around
~20s.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5b0b7c33ec..9ff315f775 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -560,8 +560,18 @@ sub read_config {
 }
 
 my ($repoauthor, $repocommitter);
-($repoauthor) = Git::ident_person(@repo, 'author');
-($repocommitter) = Git::ident_person(@repo, 'committer');
+{
+	my %cache;
+	my ($author, $committer);
+	my $common = sub {
+		my ($what) = @_;
+		return $cache{$what} if exists $cache{$what};
+		($cache{$what}) = Git::ident_person(@repo, $what);
+		return $cache{$what};
+	};
+	$repoauthor = sub { $common->('author') };
+	$repocommitter = sub { $common->('committer') };
+}
 
 sub parse_address_line {
 	return map { $_->format } Mail::Address->parse($_[0]);
@@ -749,7 +759,7 @@ sub get_patch_subject {
 		or die sprintf(__("Failed to open for writing %s: %s"), $compose_filename, $!);
 
 
-	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
+	my $tpl_sender = $sender || $repoauthor->() || $repocommitter->() || '';
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_in_reply_to = $initial_in_reply_to || '';
 	my $tpl_reply_to = $reply_to || '';
@@ -955,7 +965,7 @@ sub file_declares_8bit_cte {
 	$sender =~ s/^\s+|\s+$//g;
 	($sender) = expand_aliases($sender);
 } else {
-	$sender = $repoauthor || $repocommitter || '';
+	$sender = $repoauthor->() || $repocommitter->() || '';
 }
 
 # $sender could be an already sanitized address
@@ -1104,7 +1114,7 @@ sub make_message_id {
 	$uniq = "$message_id_stamp-$message_id_serial";
 
 	my $du_part;
-	for ($sender, $repocommitter, $repoauthor) {
+	for ($sender, $repocommitter->(), $repoauthor->()) {
 		$du_part = extract_valid_address(sanitize_address($_));
 		last if (defined $du_part and $du_part ne '');
 	}
-- 
2.31.1.909.g789bb6d90e

