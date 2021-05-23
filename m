Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17637C47083
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA103610C8
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhEWI5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 04:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhEWI5x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 04:57:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3784C061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x8so25278056wrq.9
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=taEm+52K+03ydelXLmfAaSTlfwMRye4C6IG43ggL5G0=;
        b=Kv1LTaLOHn1rCLzpcuOFVSSXTsEj2pAi++6YXadyjz+CQIoCZXZO3g0FJ50d4BiBUA
         9GExylPSXs8J2l20popebhyXhScPabgIBs24ZdBuoDbFpLZ1V/mVaeTCavhzYWpwMJQB
         +RxuxAdPsS9R9FqRnHOxdOarQ27ekVTb/hado42yOd+YAxfc+R9QzfBgmGjWv0h0CFkP
         vjnVyBY9te5OHzAbypiDqx/oK/kpBX3crhHizYamJYlJFYyDyKkKlhLlkpzswfDfLR9G
         zzFpMPmnd+zPE1Ot6/9URrAANscNbO3BnellKSpklqE61ijcJ++sPJaKHXyvt1ZTsLFB
         Y43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=taEm+52K+03ydelXLmfAaSTlfwMRye4C6IG43ggL5G0=;
        b=n7ZD08rVqLdOOMrt6xoZcFoU8SFshJ3+crp1YrqHLC0SYtWUpIjZs1xDhePCW9VLJw
         Wz65jM3imDF5L8IZQE1o3VyUWRv3vmtLXQV6yqJNFYP0P8C3Jf34oDXf9t9xYM0MegEW
         a2aWmWTCKp9oA1kCy7VkE3Qonh+CMpbVs4Dcgt0rGnfwULBqkyeGW/eIVhwyCV7KLcxy
         Wi0VaQmMSuSKO+W/QZN2xZpNwQYNyd3k6XYwOJGELaMI/G9cDgd7/JE6crd+uNd5IuMa
         j2hs3iR9How7AJgzA8cVno4V1AgdPnDVuPr2r9cWjR6+GLUENNO7h6mS+YMj+pfjUrCe
         aPiw==
X-Gm-Message-State: AOAM530BZyhuxPQkIXM0f26csG/OwwiTHmQOUubCAl3YL1hQDjXUQnrb
        YuExl/lTu887E9FPOeg4OXIbiUK0x9+cJbkB
X-Google-Smtp-Source: ABdhPJxmgECse1P0rq5HlqOhbhQvCdJRkLVJdK+bn204fOKCRBMWBw+DkCqH4v1xL30KadIhQfi/oA==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr17126052wrt.137.1621760185324;
        Sun, 23 May 2021 01:56:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15sm9577839wrt.54.2021.05.23.01.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 01:56:24 -0700 (PDT)
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
Subject: [PATCH v3 05/13] send-email: copy "config_regxp" into git-send-email.perl
Date:   Sun, 23 May 2021 10:56:10 +0200
Message-Id: <patch-05.13-c12f69a411-20210523T085231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g05cb3eebfc
In-Reply-To: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com> <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The config_regexp() function was added in dd84e528a3 (git-send-email:
die if sendmail.* config is set, 2020-07-23) for use in
git-send-email, and it's the only in-tree user of it.

However, the consensus is that Git.pm is a public interface, so even
though it's a recently added function we can't change it. So let's
copy over a minimal version of it to git-send-email.perl itself. In a
subsequent commit it'll be changed further for our own use.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3d8362b5f0..95a69d4c51 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -380,6 +380,24 @@ sub read_config {
 	}
 }
 
+sub config_regexp {
+	my ($regex) = @_;
+	my @ret;
+	eval {
+		@ret = Git::command(
+			'config',
+			'--name-only',
+			'--get-regexp',
+			$regex,
+		);
+		1;
+	} or do {
+		# If we have no keys we're OK, otherwise re-throw
+		die $@ if $@->value != 1;
+	};
+	return @ret;
+}
+
 # sendemail.identity yields to --identity. We must parse this
 # special-case first before the rest of the config is read.
 $identity = Git::config(@repo, "sendemail.identity");
@@ -478,7 +496,7 @@ sub read_config {
     usage();
 }
 
-if ($forbid_sendmail_variables && (scalar Git::config_regexp("^sendmail[.]")) != 0) {
+if ($forbid_sendmail_variables && (scalar config_regexp("^sendmail[.]")) != 0) {
 	die __("fatal: found configuration options for 'sendmail'\n" .
 		"git-send-email is configured with the sendemail.* options - note the 'e'.\n" .
 		"Set sendemail.forbidSendmailVariables to false to disable this check.\n");
-- 
2.32.0.rc0.406.g05cb3eebfc

