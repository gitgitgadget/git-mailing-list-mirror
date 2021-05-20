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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B9C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AA4610A8
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhETIUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhETIUi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:20:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86558C061760
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z17so16644882wrq.7
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mcpi+veS1ouLAzwPPjWff4qtV+I+ikDsFN1D1lOXCXQ=;
        b=mX9LlIGO3Mnr5PWtUdefttycEabxGn+TaJ7xJIqa+iGco6yXntbVwQUw6kRxYocqaW
         u3y03X9FBLQToZfZ6rfA15iR7l9GE4MhSMji6eoFyENTF4vog8hRgHepgVMvAO4V16N0
         Lc+FTBxmIPJGEKa/jpByYAiuCLSOZnbYhE+QO0wOXh8AeHZar+bZvaHosK9AkjgXqNDm
         AfutoEhc6bLiRqqMp9LTIVPTSA/A7y8oAu19CXI8bhsnuqxtT2U9RGcZXwcakNfc8g+3
         qiUrtWP6fzYwevuluatFDXiMcxjdqM68cSUGIsV+FDOeICBv/ROcETcbTVUcKXvtST5g
         vAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mcpi+veS1ouLAzwPPjWff4qtV+I+ikDsFN1D1lOXCXQ=;
        b=gOztidgF8KA4bi3wwhzSqjJxl/RZXozb644/m5V4K/lxJ1UJGhqZnlCTP9SVe9FiHC
         LJaTRHm//Cu9wrEzEP4IQxPEhjSSpSyk5GAONffHGj5W6GN8tQah+yau4VgryC0pRhEY
         iqZMLYRWjYQHPi71+1P7BDYXY2OK1SltMhGfDBx+CXwm/lN7pAVcOJ9QYRPQkRel/IQV
         FsZWVg/XxcVaysUZpInF/6UCmjcBWkrC1m4kD3h8Cufm3HY1ENn0k4u3wAAJ3EXWZ+sC
         1CtbSHDhkftoCPm2k9pEPXQhNPn9KLXN49NW1GbEp/WKynXxqPM9m0S8mgBN3rLPuw9z
         2Ckg==
X-Gm-Message-State: AOAM531NZ7r2V06SC432YRoEopQM9PRL8FNFF1I8ZPa+Ju08dUTkqA1w
        CzAdJ5uddN++Cyr68QxJGpVDkyZ7In0mYQ==
X-Google-Smtp-Source: ABdhPJzkmlyKo9c0q+p1FWAfTefvrkDEac88qPJJYq6pkRfuYw0lartlEnZQWbpVOb3HjYwzDwiRaw==
X-Received: by 2002:a5d:4588:: with SMTP id p8mr2961492wrq.216.1621498754881;
        Thu, 20 May 2021 01:19:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm8900004wmi.0.2021.05.20.01.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:19:14 -0700 (PDT)
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
Subject: [PATCH v2 02/10] send-email: refactor sendemail.smtpencryption config parsing
Date:   Thu, 20 May 2021 10:18:59 +0200
Message-Id: <patch-02.10-b87f53adbed-20210520T081826Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.405.g5d387561bb3
In-Reply-To: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com> <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
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
index 3ef194fe2da..f9d859da3ed 100755
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
2.32.0.rc0.405.g5d387561bb3

