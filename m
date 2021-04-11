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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778D8C43460
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC30611AD
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhDKOnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbhDKOns (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 10:43:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51781C06138B
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:43:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p6so3552851wrn.9
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGK1Kxgu8hbj/y1pvQybBhFhWcMZfipmMS55IPMLmtQ=;
        b=hJhHfng4ysUUGKbDNiKqQDvU1vrPbVtnec630/cYruawB7iaD1L+twLYwTGBXksEqE
         8IOMzMjzWMCSt6604MPiZECMpEWfHJGwL49ed7n236rjGMwehUvVNUNj+vMLY/AsrugW
         N4x0wf+zyfrkap7d46GGaJ/zXzkTdorpqh01gutc9xho9VNgx27VuerssZwzq55etneS
         8ccJs1XH1w4abi+Fi2lEl7hqGkIUM1HGtouHsfWgi008roS9YukGaB1EoJf+q/+BKMDX
         k0CUM01NsRLQfubV+QVRsXvkozyFa/J3T0FYYOSNftHRA4iHikqWl7sswJQKGzAdu2mM
         Dirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGK1Kxgu8hbj/y1pvQybBhFhWcMZfipmMS55IPMLmtQ=;
        b=WlL4hQ8hl5LFYaTNKhTGUTAtUPEj9XBxup1jaB1SnM+im3JgttuVY9GTvR+fLygqgm
         c3Ly+REaGNia0qM9BSCVNy2LbGsG2fSNu9g4Y75fEtqViRxJmgNf/Kdz2IYQqgQK0/3M
         A6YVSGb7UhlV4K1fcFAKxOUN4HNx8k+3L4Klnh4DIZxeScwRSeApJ88kzSl9GtWyRCpn
         AEG1xUjdsur4e2eOqaToaYJ/d0S+g7v5tQIMMLHGZWLCoqP3Nv/unqypBMBfyk0dvY/o
         +U3ZdqwXZoiJ4GzNuXlfsZC3UV1PulHS169bb79x/DHYMVO2d/HWXbdRCf0D0UsGchVl
         sPvg==
X-Gm-Message-State: AOAM530mCkMb7SYctK/EO8Ibv3OdR92fu2jJEltqvycI9u7PoneSd/ac
        hjEiHKwrQJu11Ml1nFPC5BrTXGxE1KRmiQ==
X-Google-Smtp-Source: ABdhPJxpYg4X5RLTwxLbtNrD5cvkR+17ocWQxnyjAEyT2jAEpCig4AjTY8A3JYcKSwR0qwDa2lEj6g==
X-Received: by 2002:a5d:6dcc:: with SMTP id d12mr26441823wrz.136.1618152210880;
        Sun, 11 Apr 2021 07:43:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e33sm2105343wmp.43.2021.04.11.07.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 07:43:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Drew DeVault <sir@cmpwn.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] send-email: refactor sendemail.smtpencryption config parsing
Date:   Sun, 11 Apr 2021 16:43:20 +0200
Message-Id: <patch-2.2-2de5edcf8f4-20210411T144128Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.623.g88b15a793d
In-Reply-To: <cover-0.2-00000000000-20210411T144128Z-avarab@gmail.com>
References: <20210411125431.28971-1-sir@cmpwn.com> <cover-0.2-00000000000-20210411T144128Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the removal of the support for sendemail.smtpssl in the preceding
commit the parsing of sendemail.smtpencryption is no longer special,
and can by moved to %config_settings.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 877c7dd1a21..da28c6e8b4b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -268,6 +268,7 @@ sub do_edit {
 );
 
 my %config_settings = (
+    "smtpencryption" => \$smtp_encryption,
     "smtpserver" => \$smtp_server,
     "smtpserverport" => \$smtp_server_port,
     "smtpserveroption" => \@smtp_server_options,
@@ -368,14 +369,6 @@ sub read_config {
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
2.31.1.623.g88b15a793d

