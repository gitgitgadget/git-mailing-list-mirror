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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B84C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9398461006
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhDKOns (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbhDKOns (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 10:43:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1794C06138B
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:43:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p6so3552840wrn.9
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s0/jkQ0ZJ6OS5jsAtHZexZ1t+xoujJfzEg93uczXBhY=;
        b=bLD3TYAIqKY0rlJKkYqZBgbgAd9VsZ5n2FER+hZIltGq03OcqV00kizGas1IVVgVl3
         HDVFfHSKQrrpYNlOWdMjy49GFGuJRjturvazX1tTB39DxsKRCq66Dds+fKHi1FIhDWE3
         hQQCoe95ec5gkPAJvgauWiBFhbXpnk2BtEbbnvfbIwhX8yWNYFazAdBeaGPGfxml/rbx
         rSGvhWesWjNhEAem5xH78ofPRowQ5nli8XHPBzTCHgcTZ/TwEl2etGhfmgO6Ly35xEaV
         4X+mR66swaTJyLSbAVWwNeABUCwyuIBRAM16R/FHZXKCt6bofTidfGSoObMlbJHZQ6FH
         du7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s0/jkQ0ZJ6OS5jsAtHZexZ1t+xoujJfzEg93uczXBhY=;
        b=mbbrwB6TYKlH3yysr5t7E9UzJjRKcqvBOJmN4qZLAHRFN61v5as6CYTwSQD+eqsNDq
         bzdkDcJDJFC8S6hlkF0gCfRXCdb1Z2gpitklcXS30vO3StCnEKYuDSR9lnnrhYKbz57s
         5T5muKA2O0tnlaDIfbdRtEtqoOUz97Lf+oxiIwNpcyATWZzXSu+heks6J70o8T1EVzwS
         ZVunjF/YbWr47sjNuXQNT5+taaDXaLyifRRZevAGPq4jSG/vqvsA5M2/7ZQ1Pz/YZOsr
         E4/XHhgC9ODuzN+bnRaOiv2phR91IbeweLrYb/xsLF4UkQ+YvD27Q0pAOIsX5Fx5kaqE
         q/mg==
X-Gm-Message-State: AOAM531nNb5Ve+ad+mNAraWH42kUS3LKLkx5Y1hDPVGrW061i+Nej6uj
        YxHImyVvl2r3oEweEFDpTVYC+uMrgloC7g==
X-Google-Smtp-Source: ABdhPJyZXVSdb8/sbrSG9pmiBC8s9KRJnmo0JTJMIKtJufr3mPbQwxJM3vaEIzNMOHEkSFxkjpAfzA==
X-Received: by 2002:adf:f60e:: with SMTP id t14mr27776059wrp.51.1618152210147;
        Sun, 11 Apr 2021 07:43:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e33sm2105343wmp.43.2021.04.11.07.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 07:43:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Drew DeVault <sir@cmpwn.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] send-email: remove non-working support for "sendemail.smtpssl"
Date:   Sun, 11 Apr 2021 16:43:19 +0200
Message-Id: <patch-1.2-ee041188e55-20210411T144128Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.623.g88b15a793d
In-Reply-To: <cover-0.2-00000000000-20210411T144128Z-avarab@gmail.com>
References: <20210411125431.28971-1-sir@cmpwn.com> <cover-0.2-00000000000-20210411T144128Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the already dead code to support "sendemail.smtssl" by finally
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

So let's just remove it instead of fixing the bug, clearly nobody's
cared enough to complain.

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
index f5bbf1647e3..877c7dd1a21 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -374,11 +374,7 @@ sub read_config {
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
2.31.1.623.g88b15a793d

