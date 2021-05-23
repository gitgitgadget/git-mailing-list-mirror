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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AF5C4707A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43638610C8
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhEWI5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 04:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhEWI5v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 04:57:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E26BC06138B
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a4so25331955wrr.2
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PtS+FhXoyW4TpEbjjsXvf2/lJgdnxzzPVrMWMgHQdjc=;
        b=XqSPjYXUAY6pSroIdyLqem+0NWFiDEx5DriRohqiRAzRRxIZfe6MzY5v1pQWhmjcNz
         oCH6EY0B3nm3jG10K+PzakyPKg670/6YtV0TCM3RKVQLQvlXRy0PkKbE7sPxiJ+iFqyT
         mqyu0Z4OrzWHVl4OGb09lg2xJQX3n9mXmbWuJCQ6abVWrvbb9HMgGYritcXnFlDltoFW
         qhc3h86e/HGP5/wbCQkTbL3N/Qz8yrJv8+H4fPFwwvjQULKRsYJ+yWrO879cqlHUJtnK
         x09Xl0+iMothb5wiMkYwWugl7F47sjj6yhz4khmDrng1Xf/FiKoVTDz6huRwEJoQ5S+d
         BmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PtS+FhXoyW4TpEbjjsXvf2/lJgdnxzzPVrMWMgHQdjc=;
        b=ZAoyAW+z3JxNGwtQm1sVkKixFdz5SEMcmlJ31a0vHlr178SFXKXYTuoOg+46F32CT5
         GeH4HKeXi8aDUwfg9COeYM+gjNSwJX3c3o/Daw2+QN5MPEl1GqPd6wN6KNbUqyW+Ml0C
         r19as5Fqa6x+JOCQkJ4YpT39JLPAAOpO/+WLCrlOHVVHN1UuQ4y5mG9sWFWFtbh2HU9l
         GP6faucCl5NTiPReiFON1NF0LHxdGxZX54Y99XgMj/v8CRtTLxU/UxSSNTUT23i0vyUq
         U6BCEK4lbw9N+/ei/3R+OXfv5QIJ2c3+1f8ZNNTvsIWQnDp+SoRbmnSARGvMVekLq6HQ
         02fw==
X-Gm-Message-State: AOAM530JE4BI5PALQ+/0QQ5JyI3if/2rG7iyd5RqbStSVciDqJHVEaun
        /oYAyKrcm+yGjAkArJZ/jOFOI8Qpr3xZgtNj
X-Google-Smtp-Source: ABdhPJyyHjiyiy4o04hfl78+jm2Mmqb3BLRYHKEtgz2SWj8bLHAdnWKh5eir/RdC46G+s5HjEf9kZg==
X-Received: by 2002:adf:f392:: with SMTP id m18mr16809389wro.69.1621760183609;
        Sun, 23 May 2021 01:56:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15sm9577839wrt.54.2021.05.23.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 01:56:23 -0700 (PDT)
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
Subject: [PATCH v3 03/13] send-email: remove non-working support for "sendemail.smtpssl"
Date:   Sun, 23 May 2021 10:56:08 +0200
Message-Id: <patch-03.13-3bbd48dab2-20210523T085231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g05cb3eebfc
In-Reply-To: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com> <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
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
index cffdfdacfb..24d73df5a3 100755
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
2.32.0.rc0.406.g05cb3eebfc

