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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADAFC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578D960698
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhETIUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhETIUk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:20:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40377C06175F
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d11so16634654wrw.8
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M4faH6RYNlO/pm7Bw4L8i9QvqiyCzYWNSdjahLmtu5Q=;
        b=RXVwJmTDDl/8byXD5KcZEEoN+cQONdgJCbfplXdbT8wdgC8g46UZymKa6r7Qv7CSJ2
         0i9mDyGaQT2ta9KC/xwam3sUaZvxfvwdhadwJDKZwPXZ9j35zqGLaAKRmgTs1KA82bET
         0VflilLm9XI+5zwcLdk6lYYmn9hkg+atLjTDZvTbbSE37L2K+A3M76wr3hDfQ2Zde6EZ
         2trXFxeEjsrVbbA9OzeqeBNv5X1gMZiq7UGfSddKJeH1XC20WBG9Nw0pqk6Sl5/40bW4
         eOr5GzpvpmnHeFTDEMJ7t7U4jZfCNVOu1tZmZ88e2mvrjRxiWBGaN5lAQzGVj+mtyrKv
         pdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4faH6RYNlO/pm7Bw4L8i9QvqiyCzYWNSdjahLmtu5Q=;
        b=IkU0cREGk49kwbwvw9o2s+os1fC8ZyXm3/fB46t877IQzZHHdARnmQNNp2X/oCpg33
         +GJXwsM3M9Hib4R0YEVtpvI8pfI8eDoXnecikL6jLX0U36IaV/Ph1fgNBx4Wr2C1ArKq
         QObFf85KX5phkxK62so4Q88UHPAkC7U/AvqY5zLRRMma5Pg/WUiupIW6lNgX8+N2UyD2
         Esk9DFnjmyMuG/XSLVwvQJSQ5o9wjbmffDwHj87j5HDCcD7Qo5p+/0uRKwukenwm+wPx
         GgVCTxQBa9aRwl0uKYyop2+y98RIhuLyh+psKtKqbEaxsXwx92s3XUlTcJgZDcOxNXDm
         E4hQ==
X-Gm-Message-State: AOAM5318Tt0TO0i1XvUd6Hx8tGAy8zT6MzqXfPcexUdfc3NvZlvJDgtO
        M18rsTb79gE8PbHECNQPWFMY67KsdMfTlA==
X-Google-Smtp-Source: ABdhPJxJhQc7chkKElkwnuYxYMeJk51mzik2AZlGYUC7QCOlaxCGkdgxqxqh3xBADiPRw2bnlkC6jA==
X-Received: by 2002:adf:ea0d:: with SMTP id q13mr3022298wrm.161.1621498756526;
        Thu, 20 May 2021 01:19:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm8900004wmi.0.2021.05.20.01.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:19:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/10] send-email: lazily shell out to "git var"
Date:   Thu, 20 May 2021 10:19:01 +0200
Message-Id: <patch-04.10-acee22b77d2-20210520T081826Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.405.g5d387561bb3
In-Reply-To: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com> <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
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
index 5b0b7c33ec6..9ff315f775c 100755
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
2.32.0.rc0.405.g5d387561bb3

