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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B3CC47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5B66127A
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhE1JZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbhE1JZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D39BC06174A
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m18so2605544wrv.2
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bED2B3CFeTVCuzkzOamjxxfVgf4HZaMtTMYsXygiv6E=;
        b=MWmCmkcocxdY+LoDOP4yjZCl12rtmNpY/kmULIANuGf72/TY3KQaL2hIH6cTTviovw
         Vxck8l8/dZf3e9xjqw6EbESPrjNybUFUg4AmVU9pOH15U1xmTl3N4akIzyeQ3pa2KUQL
         HuBKc2qVf63bv7nfSQ4pNUVgZwRN0ZChNB2Y0FjE8s8WZF7FX2rDE0qWkh/69zHCQfkC
         T2JikJSCfrZOYiKjB3KCvMs9VcR246noCPdeuk9nnv62N+Q8MbpJfm4Wd0ktc1BFeDMl
         5bD1Td3yQO5g8wy2QoPwMt3vnZGGhOp5sBsuTJd8zqiAwyJCRSy0pv5ADvNa4UM9RBZf
         tHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bED2B3CFeTVCuzkzOamjxxfVgf4HZaMtTMYsXygiv6E=;
        b=GlY90JXsQUjY3CleKYCDrTbNHcMq/eyUPCvtmZIVR7klq5ocQDl/vbeApuMCIGO3Qi
         7yN+xD+gUVX6VJgRkaRCbRgh6hlbkCamRTtuMW+BbE64WW3eD1Yh1hZAYVc/5JNshxLK
         IqUnJ5i1DDBL7T5+dK+8BFiLD1jSV8c7zWNVgQY8wLCxfToZPl4ZeZQtt9KzBIf5TCrx
         O+vPUZFxV0v+Aoh+iw7uZVREtpw0vuQQb6xTtJNzO6zEx6mS93b3bSPkW+XgvBDNjV5T
         +XOgWb8faQErD2En4iQgHTPoT+krLioPiJh7hkaS32/U/yNkuUm+P7GaXJsivTErlR9K
         tcZg==
X-Gm-Message-State: AOAM530fLDRBdy6/nyC5xqFJMNNjorlCCUHZyzjv1To0Y2QMDKyJOrva
        +2BRWXyODN0+CCYjIe0FM8d4NPzBouiSIw==
X-Google-Smtp-Source: ABdhPJy+2alPk8zWGf6X5cJ8wK8q/ywUwF/yZP5j3LIqfWiN31OjZI32PD5MBO+hLWeE3xLa6who2A==
X-Received: by 2002:a5d:54c5:: with SMTP id x5mr7541871wrv.151.1622193840731;
        Fri, 28 May 2021 02:24:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:24:00 -0700 (PDT)
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
Subject: [PATCH v5 07/13] send-email: lazily shell out to "git var"
Date:   Fri, 28 May 2021 11:23:46 +0200
Message-Id: <patch-07.13-bd0d9535718-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
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
index de62cbf2506..38408ec75a8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -588,8 +588,18 @@ sub config_regexp {
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
@@ -777,7 +787,7 @@ sub get_patch_subject {
 		or die sprintf(__("Failed to open for writing %s: %s"), $compose_filename, $!);
 
 
-	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
+	my $tpl_sender = $sender || $repoauthor->() || $repocommitter->() || '';
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_in_reply_to = $initial_in_reply_to || '';
 	my $tpl_reply_to = $reply_to || '';
@@ -983,7 +993,7 @@ sub file_declares_8bit_cte {
 	$sender =~ s/^\s+|\s+$//g;
 	($sender) = expand_aliases($sender);
 } else {
-	$sender = $repoauthor || $repocommitter || '';
+	$sender = $repoauthor->() || $repocommitter->() || '';
 }
 
 # $sender could be an already sanitized address
@@ -1132,7 +1142,7 @@ sub make_message_id {
 	$uniq = "$message_id_stamp-$message_id_serial";
 
 	my $du_part;
-	for ($sender, $repocommitter, $repoauthor) {
+	for ($sender, $repocommitter->(), $repoauthor->()) {
 		$du_part = extract_valid_address(sanitize_address($_));
 		last if (defined $du_part and $du_part ne '');
 	}
-- 
2.32.0.rc1.458.gd885d4f985c

