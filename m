Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87451C47083
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6509E610CB
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhEXHyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhEXHyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:54:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2443FC06138C
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r12so27487977wrp.1
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYjFULJOGIc0JTvqBMn8jvHhOJ9l2dnpvR9TfKTpmeU=;
        b=ppdTDtgT17YlgcVWql/i/dfGhSuLUh9JS3PFGq48w8FHeqf92tYE9pzn6yIY236L6L
         zTch+AA/TS/L0aWobTRw9UmgiW1wt7INNPbXMbpuR5NNL6wg55IPvwjOiHLrdX/dqnE/
         hpvNN9IN+xqABB6qnYGVvFmYs1xrmNzUkygsma+5X782KfM1exfsyf4DntyPpveiLdNI
         jJlHJ77Fuy+f8LIn7DZEiSz1zoGAGdTZS9PT8ah9MXvUmixBipbGNx2VLAiWrQmbjQxp
         AGt19ok/30qt3jpegRjyilb67WsguiXJ3X1JLDGAnlgSJG//910l5Mlp5u475tEOXjYp
         ItgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYjFULJOGIc0JTvqBMn8jvHhOJ9l2dnpvR9TfKTpmeU=;
        b=BBmr0BbdCr6Jb6d8HzFb6orii8m6KwCRG2siyZ1nqu8jo9awg7ER2GefyRwMILU5h/
         cDfKFq0i/ebIE9IKNpDAhfcttxiDKoD4jE/cTfzoQbM8jDz3yIkdnFdCPkzvKiq3G67s
         RvuohQ9LWlYSE1aLLfPB0s1UKTveLk709dsAGM5GvpZl9gAiebO/Li2DmGkLtt9CXZBu
         9iOcAI+sU1PR9h4tZkHGS/GGy72OVGI18Zshvcs5r2dq+ihYSzpXPcCIJfC9xRADhtrs
         3ISCKbY4vnwBP9RMUjLnu1u+DGduZv1vunP/jOOKibCrcNxMiyKy9Orq5u8X56ciXD2a
         YDlg==
X-Gm-Message-State: AOAM5318xCREJWxbPY2qUqJXgRm3SOjRh+ONLsmE1KXmTN1gTu853QKi
        L11aQjxnSLripolFNyY5NbNBrLO5/BCenHvS
X-Google-Smtp-Source: ABdhPJyatld6KzcBfOg7Zd6NZ0n+4u5R7/uPf+95elVP4v+xcFHPySgOT2AJ98X0bxjhfuqAlJav2w==
X-Received: by 2002:a05:6000:1865:: with SMTP id d5mr16875699wri.126.1621842791575;
        Mon, 24 May 2021 00:53:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u126sm8540459wmb.9.2021.05.24.00.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:53:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/13] send-email: lazily shell out to "git var"
Date:   Mon, 24 May 2021 09:52:56 +0200
Message-Id: <patch-07.13-491eefde6a2-20210524T074932Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.385.g46e826f1e55
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com> <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
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
index d294681cf39..56bd5b0e50c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -578,8 +578,18 @@ sub config_regexp {
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
@@ -767,7 +777,7 @@ sub get_patch_subject {
 		or die sprintf(__("Failed to open for writing %s: %s"), $compose_filename, $!);
 
 
-	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
+	my $tpl_sender = $sender || $repoauthor->() || $repocommitter->() || '';
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_in_reply_to = $initial_in_reply_to || '';
 	my $tpl_reply_to = $reply_to || '';
@@ -973,7 +983,7 @@ sub file_declares_8bit_cte {
 	$sender =~ s/^\s+|\s+$//g;
 	($sender) = expand_aliases($sender);
 } else {
-	$sender = $repoauthor || $repocommitter || '';
+	$sender = $repoauthor->() || $repocommitter->() || '';
 }
 
 # $sender could be an already sanitized address
@@ -1122,7 +1132,7 @@ sub make_message_id {
 	$uniq = "$message_id_stamp-$message_id_serial";
 
 	my $du_part;
-	for ($sender, $repocommitter, $repoauthor) {
+	for ($sender, $repocommitter->(), $repoauthor->()) {
 		$du_part = extract_valid_address(sanitize_address($_));
 		last if (defined $du_part and $du_part ne '');
 	}
-- 
2.32.0.rc1.385.g46e826f1e55

