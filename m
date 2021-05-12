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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7733BC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4364D61040
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhELNto (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhELNtj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:49:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A0C06174A
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z17so4628209wrq.7
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JpTgVjmUiFNfm6LnnOBxIvCiF9o66jgq1IGIOiecDbk=;
        b=n/y8dwiKJ56s9i+7y2bx6RbZxG4D/hOFm4HIz7Hlqg0eIVMNbPGMjuC6hV7I1J+KF5
         Ny1dlUUWuvc03Rqmz2lw9vYmlUJTT9E3PwENRgFmQEtKO424SNsIpsXKCQsdded9cX/q
         FjxxbSDhQTcWxHoN+ObBv3b61UmSfb89t37n1fgmJoEstMI5vj/RG4ZLj6uO2kT6aNhD
         bhjEfkPhowfx6sHidzzQh+ZvECbbL5KQbfQK1pJ6qpFm4jSbD9TgzCyACu3tOUb2WYgY
         KblqLRQ9i008sgEdt+ezxYj2kfa+saabFGowwW0GzWoam4Wxs+xbgneaM7qLYUmYp6R1
         xu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JpTgVjmUiFNfm6LnnOBxIvCiF9o66jgq1IGIOiecDbk=;
        b=C3nTJeAgsTDIEG1kBq0LFjsh0NF1r7yMmzuLmH2EU7pkZoSIRPxqK60FPa+RAdXRJk
         BMaxCRiIm2G+wINYuCBSRAFFXHcbdkCR4prvrVAV/N2BPKF58+dI3xbbyehH768Pr579
         ixS5F/g+CBWfJPI2QkkmPl8MjWYZp57ERgV2LsWlqNs9q6Z7vADyaDWeBIM8r90rzFiD
         +v3aR2lYT6TcN4NCbRFJsBA+Jp0Lig13DUHu/LCg6HN5Jk1pi4eocGnV6WHQEshd679y
         eCBcyEYIZFCIFZfF69QNhGog3EEB4VRvN59VMDHPFRGBOXMjmo+nVwZf2jTBauzP9rXt
         9fCQ==
X-Gm-Message-State: AOAM533IQGYVETPNZuK8Y5SkrmzvRZb3jXeXpvLQWRzbXcYlnE5QBQ7X
        YWf2TbMv/TrGzoHUKnsI0eLkbWJfpRgZHA==
X-Google-Smtp-Source: ABdhPJwxsbLLsR9pwV8+ycn8LLIY9B95R2mG0TaHj6QbkTFGuYqa/EFev0H+W22eer9P59044nWtIw==
X-Received: by 2002:a5d:694c:: with SMTP id r12mr45354349wrw.224.1620827309171;
        Wed, 12 May 2021 06:48:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm31416612wmb.32.2021.05.12.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:48:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/9] send-email: refactor sendemail.smtpencryption config parsing
Date:   Wed, 12 May 2021 15:48:18 +0200
Message-Id: <patch-2.9-c22af817f1-20210512T132955Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the removal of the support for sendemail.smtpssl in the preceding
commit the parsing of sendemail.smtpencryption is no longer special,
and can by moved to %config_settings.

This gets us rid of an unconditional call to Git::config(), which as
we'll see in subsequent commits matters for startup performance.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3ef194fe2d..f9d859da3e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -277,6 +277,7 @@ sub do_edit {
 );
 
 my %config_settings = (
+    "smtpencryption" => \$smtp_encryption,
     "smtpserver" => \$smtp_server,
     "smtpserverport" => \$smtp_server_port,
     "smtpserveroption" => \@smtp_server_options,
@@ -377,14 +378,6 @@ sub read_config {
 			$$target = $v;
 		}
 	}
-
-	if (!defined $smtp_encryption) {
-		my $setting = "$prefix.smtpencryption";
-		my $enc = Git::config(@repo, $setting);
-		return unless defined $enc;
-		return if $configured->{$setting}++;
-		$smtp_encryption = $enc;
-	}
 }
 
 # sendemail.identity yields to --identity. We must parse this
-- 
2.31.1.909.g789bb6d90e

