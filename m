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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12605C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA73610A8
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhETIUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhETIUg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:20:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F33C06175F
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i17so16641418wrq.11
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0DM7g88S8qTw13CCLVk0BhRivg4tIZDvYn0SduUuGLM=;
        b=NDRavTxzIv5LaJd/JecOcgzSTecxqxtrZE7F9QtR3tW1+ZFdQxfufRivvUn2Y0x3OR
         QFZV8RvA9n9+vpgdmS2BVq/L5sO7/RMvHKOc61vO2LeJKBJMBf5dbszlwfcbv4iPEmxr
         jVzkkwW0K1Xm8Q9aZZnRSvC4TCjMBRkXyxm8eTMk3qLE4y70Z6UkQdcilJ2vbtd2AIYi
         hOpZ53y5xQrF5hdAZGt1TUJcxVLqodnfhrz82pOBW4SaEWlbrkVB59N15K0DOkC/g9SV
         lk42EjGVMS0wwwg3yEigvf1CMHNlZD8qRMSdny9Vt22dup57mHidnLj/hiHNWgROeQtj
         VJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0DM7g88S8qTw13CCLVk0BhRivg4tIZDvYn0SduUuGLM=;
        b=gPPLmuwJzfZpk5wse8iwfFXVTOMTpzDTlDiB2gDFJftZAUTb+dl+gePK+6FNQrs07W
         42XeEQaQQeUPPEjEcfA+t5ohEHJs5ThQZ747MQ+DpfcQgHA+TKg7k2CCxHfPQUm5GNqE
         t5R7gzA85M/IfeLlSer8OIx1gPahAYh7oXgMgrG2WEYi3DW5mFPMBp/XZN5vcVGmfv9o
         50GNiLeressBWdadth/kMkzx8iJYpno463PmuW/pfrLWuTGxyX11CN5/wu3llnnaAz17
         4lwadzC67R7J+s8fU080iunTqsDf9kOkl69Ld0Io8dxpfizrq0i20UPDJOaLPkXgOQts
         40ng==
X-Gm-Message-State: AOAM53256ivmK3U8Y41bDUBKVBc9fRvWI3u2vLwJJ7bc900sZriMxXPV
        qkmnnS3z5zxQ8PkRMn3qxyD5ObL1nCzB9A==
X-Google-Smtp-Source: ABdhPJyjVEPi+WVMKaDpLUasEI+WDhMarbkUUEU47SRihfYKNGIEZP1zHL5NfRIOzBYmg8vLN+7u7A==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr2965515wrd.407.1621498754017;
        Thu, 20 May 2021 01:19:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm8900004wmi.0.2021.05.20.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:19:13 -0700 (PDT)
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
Subject: [PATCH v2 01/10] send-email: remove non-working support for "sendemail.smtpssl"
Date:   Thu, 20 May 2021 10:18:58 +0200
Message-Id: <patch-01.10-8474acae689-20210520T081826Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.405.g5d387561bb3
In-Reply-To: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com> <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the already dead code to support "sendemail.smtpssl" by finally
removing the dead code supporting the configuration option.

In f6bebd121ac (git-send-email: add support for TLS via
Net::SMTP::SSL, 2008-06-25) the --smtp-ssl command-line option was
documented as deprecated, later in 65180c66186 (List send-email config
options in config.txt., 2009-07-22) the "sendemail.smtpssl"
configuration option was also documented as such.

Then in in 3ff15040e22 (send-email: fix regression in
sendemail.identity parsing, 2019-05-17) I unintentionally removed
support for it by introducing a bug in read_config().

As can be seen from the diff context we've already returned unless
$enc i defined, so it's not possible for us to reach the "elsif"
branch here. This code was therefore already dead since Git v2.23.0.

So let's just remove it. We were already 11 years into a stated
deprecation period of this variable when 3ff15040e22 landed, now it's
around 13. Since it hasn't worked anyway for around 2 years it looks
like we can safely remove it.

The --smtp-ssl option is still deprecated, if someone cares they can
follow-up and remove that too, but unlike the config option that one
could still be in use in the wild. I'm just removing this code that's
provably unused already.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/sendemail.txt | 3 ---
 git-send-email.perl                | 6 +-----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index cbc5af42fdf..50baa5d6bfb 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -8,9 +8,6 @@ sendemail.smtpEncryption::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
 
-sendemail.smtpssl (deprecated)::
-	Deprecated alias for 'sendemail.smtpEncryption = ssl'.
-
 sendemail.smtpsslcertpath::
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
diff --git a/git-send-email.perl b/git-send-email.perl
index 175da07d946..3ef194fe2da 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -383,11 +383,7 @@ sub read_config {
 		my $enc = Git::config(@repo, $setting);
 		return unless defined $enc;
 		return if $configured->{$setting}++;
-		if (defined $enc) {
-			$smtp_encryption = $enc;
-		} elsif (Git::config_bool(@repo, "$prefix.smtpssl")) {
-			$smtp_encryption = 'ssl';
-		}
+		$smtp_encryption = $enc;
 	}
 }
 
-- 
2.32.0.rc0.405.g5d387561bb3

