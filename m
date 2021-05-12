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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52171C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E59E61040
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhELNtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhELNti (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:49:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E298AC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q5so4234083wrs.4
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDGE4toW+Y0vBiMEDRFhVG/0d3IJywzHa8cP4ZmsdOg=;
        b=P3yLOqYuTvGgiORW+nZ2H+T6NGmO8GulacSHTxHMp/UUtvZxMynfN3KW6PVh7y7fQ7
         T8x4n9HMzvYWGRFlQ+UpOCumuW/M8IJntJaPI7pxmKu08TghCLmaDZkw6XRlU4IrcCxn
         eluP8pDk78Mr3ap0tpmCiDnuvdIu5of2hQbwdaDDn6+9KaGdw7oUTSnaPOgXys4HY9E1
         wO5KhJ7xgscIvl9GHfJZ1dJ9bua529RMjzEbQeBNIl4SIvO3Gh7ZW8ZuCA2VLdMnd/DB
         wqETmF+0c5lmWCmPbA8SukqwT4/nrQ8BnbbIJ2A6rh2cFd8VWj4Ma5DEbrXWkV9kb6Kr
         2GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDGE4toW+Y0vBiMEDRFhVG/0d3IJywzHa8cP4ZmsdOg=;
        b=ITPE4fjgCIwpux/2aYzL2tXvqAS0eyjWd60ksnR3K58wRW+rdUvDf21KtcKYLr/xmv
         GMHMBZKUeGhgtZPwl8aBai6i2ole37qUuTmnfg6/6dCgQ1iYw8RhwVzGymh5RRK564u7
         sxzOiEDgIEVOXP8/gGYNH6wbFn6jkh54UbRZ1l6Wes18hV+HEgimxJPahb/fal8Bg3wA
         gk5kKOHI7IOJGkGBaU5AWcimkCLDe4MWZxfgLW7h/xMJ8VQOu+KteqUAfy9MbJKJaTue
         cBPSnHUTLFMbnfhXH4M2ZryBFDYIwc3D7FthmNwJ2ftD1/x6K32CK6UlqALVdLFTu2ZL
         a3iw==
X-Gm-Message-State: AOAM531odysXDcNJ2tswkwTrIFwJ2FPSv9jAL1v1/qtwKNvu42t8j906
        jppN/wAaQcsP2qIaT9+hNOyvk6Xm52PQ/w==
X-Google-Smtp-Source: ABdhPJzpgoIr/SzijsiZTYBeMF+HJ0txvraXuctCQAUvv0xt3vPIBQoeqJvxEho6LAMCgQ6aBLVTDQ==
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr9725128wrw.362.1620827308436;
        Wed, 12 May 2021 06:48:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm31416612wmb.32.2021.05.12.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:48:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/9] send-email: remove non-working support for "sendemail.smtpssl"
Date:   Wed, 12 May 2021 15:48:17 +0200
Message-Id: <patch-1.9-85b706d43f-20210512T132955Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
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
index cbc5af42fd..50baa5d6bf 100644
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
index 175da07d94..3ef194fe2d 100755
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
2.31.1.909.g789bb6d90e

