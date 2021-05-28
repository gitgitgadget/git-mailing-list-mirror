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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906D4C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EBB613AB
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhE1JZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbhE1JZg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79017C061763
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r10so2544233wrj.11
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jYTaphZCrPGt4gPKzb7ds5CzSlafOXTD8Kr5Bf8VWf4=;
        b=iHKXyQBE6SghZwwj8UDYIBoZw3+6lrM3xyuZ9//A06mG8YRDTfUcOFQ4OPW5A9a1xS
         6D0JDa/QVJ3PAxksx5qV4QDn4DLvF6TJRTt+ISyi0ju+YUrLYlbGLF9XM8ciunOay2ig
         iFNdfHfO89+IDqTQuBw+3Mt5UsyhJZs70rqa2Dcym7VvfKvM1sL5zOwdqGsquUVOigid
         xsfX+6kvZB5d45sb9kFI88MDef7nEvcwWvDb61YrPJs6qA3DaYa1V6Qzs+gJxXWp60yw
         nKmxsNNHRFZxWWDe2CG0jfq9UD/jbRPbVtT/W4JEWHUmgoDlv7hPS5CXAoofxMAMTrIY
         5fUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYTaphZCrPGt4gPKzb7ds5CzSlafOXTD8Kr5Bf8VWf4=;
        b=Hz7C5vFU+eD2K8O/n0kJzMBacU9HbljnaYUu6NH1FXw515J5VVGVrXVkDHDf4pzHQK
         xG2Q2kJ+anXSIm1fYXwus3ZB2PFLKfQdpSjAY1AR1ahmPy4IYp9YQN/aTrC+l8Erw58Q
         ExgYuM5YEvNQ/e1QYbDFBRjI5h+8CjsrR1srQ+8uBQDeBiclqH8fbYJXMPyIOZcUIX4F
         +Tewas3Er/a+FZDDtXGBrDajunytHD9Y78RWR2TO29b6gWsBJBnDrGAt/tepWCI3JqMy
         +2AQnMyiSuxmA4usIMwrJ3/hnQrKHf+SZmkoJ8bQLKgsAu+MmQyiNN3/uxxYo/N8aEIW
         4e6w==
X-Gm-Message-State: AOAM531gJFXYhBzhU2Bv/9Sgi6wTTgg15wrzX8ePV35DA3dZXDEiJrma
        itRY3oW+nwVwNsiLmzjrEqKXpiiid2OXBQ==
X-Google-Smtp-Source: ABdhPJyamyaKLdcdwq/8Owxnv+jZmMoZmfdMKZ8ux3wjMB6tCNpQh515MlxpdSjpLMQWDzTMuMlIzw==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr7716967wro.254.1622193838794;
        Fri, 28 May 2021 02:23:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:23:58 -0700 (PDT)
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
Subject: [PATCH v5 05/13] send-email: copy "config_regxp" into git-send-email.perl
Date:   Fri, 28 May 2021 11:23:44 +0200
Message-Id: <patch-05.13-f2bd12728a1-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
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
index e2fe112aa50..73e3d3fd26e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -390,6 +390,24 @@ sub read_config {
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
@@ -488,7 +506,7 @@ sub read_config {
     usage();
 }
 
-if ($forbid_sendmail_variables && (scalar Git::config_regexp("^sendmail[.]")) != 0) {
+if ($forbid_sendmail_variables && (scalar config_regexp("^sendmail[.]")) != 0) {
 	die __("fatal: found configuration options for 'sendmail'\n" .
 		"git-send-email is configured with the sendemail.* options - note the 'e'.\n" .
 		"Set sendemail.forbidSendmailVariables to false to disable this check.\n");
-- 
2.32.0.rc1.458.gd885d4f985c

