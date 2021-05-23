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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BFAC47081
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED03610C8
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhEWI6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 04:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhEWI55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 04:57:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8482C06138A
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h3so581951wmq.3
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxFgfqPIcJMBUXRoqrB4xHKVNoLCiFWUqE4eHlP1NPQ=;
        b=OXVOCOp7acIJ3hYna7VCscevwEBlVcGlYIc6O8bgtc3U/iNls41UmLBt/oIgzGq2+J
         ZriCCMAad4TXOMbOhtDrsQuXNp+JioUt49NGR59M/92iDhoYReLI4cUBmMdGZDQvU9ws
         NNvdQ6IyatfkwGyULLAlN5Qw/M+l4u9MwbdQ7SlEXMAuE4iVhieABeEHqQemXs/pcuYl
         yvRwpTA3y90kRwcBEecyc8oGJyfx7787rF6eWXLdXOfib2LyX05ncOCmy5hhNKtFZ65R
         1/FN6Gq5p5NB150nKsUB+8s5y9Jibj9z5ihcGgy93Z6Vn+AppvlPlbLZw69D4bP/du/b
         gpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxFgfqPIcJMBUXRoqrB4xHKVNoLCiFWUqE4eHlP1NPQ=;
        b=e94xXqFWyWscuHYV09FwT1Lgbr6C6WwrK1jnek+ugcxUwG14rdUXVCwKAWO51U1rVI
         4mf69sGAZDpfh570ij0gUdJV9EJdUce9ZxZWBmB59h0FK9tSRyoYFuMhdZKKkLYphsAk
         ZdnZLDah3CtEGiDxjIz990ihJXla29J2k7/be1C897cdilmdn47cCQpMWKfrtGbD5bbQ
         HrEqkfVLPHM580Xji1zniDn8W8VLQmYKPOHejQMzYFtJO9oGqOAHtuHOGeeyJ1t/FCXX
         IR5mloLkPOD8Zqu22V0GEO5IS6TTTMGJNH+TiwVZK5Ie9TCVYTAiw2Nj4Q1lOXMVETDX
         Mg5A==
X-Gm-Message-State: AOAM532zUhwN2IjmyOldlSwIO7cPoZNmth7lNDeNluJwg/1T9Be0r28I
        Y8Y2hgsdV3JKJZx52qHwy2wzzxs0uJ1ZtBHQ
X-Google-Smtp-Source: ABdhPJyOIcB+7U5MJZbTb4uVuIFzV2JiLiWLrRjaQJYA7KHUWyRfjbM7WdQ2d0GxoEPqGem9D/65qA==
X-Received: by 2002:a1c:b646:: with SMTP id g67mr14997824wmf.117.1621760186951;
        Sun, 23 May 2021 01:56:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15sm9577839wrt.54.2021.05.23.01.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 01:56:26 -0700 (PDT)
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
Subject: [PATCH v3 07/13] send-email: lazily shell out to "git var"
Date:   Sun, 23 May 2021 10:56:12 +0200
Message-Id: <patch-07.13-4326c2f99c-20210523T085231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g05cb3eebfc
In-Reply-To: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com> <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
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
index d294681cf3..56bd5b0e50 100755
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
2.32.0.rc0.406.g05cb3eebfc

