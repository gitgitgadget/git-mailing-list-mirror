Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FCFC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B9F22241
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6eE4jAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgIPMbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbgIPKcf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:32:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DCFC06121C
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so6371295wrv.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDM2O7VWYFIaZ7PVhSFc/SgOo/6wqi6bL2en5kNgxxU=;
        b=r6eE4jAi+WYnYfGyIQSZwHM+SbOG6jUhzphyFVWzIuqJhSJU1r96SET/37E8hYl/xt
         CFUtdUfoeunjIv/ObkiZHbjGGMogII82eXkgMrZ+695kOtUb1MVSzRY73RI3LmOXKjdn
         nqoa/XMBZfX9ltvJW4duXFD4UPAq05Ld17eJuVeTP+H7Uqohxm5Y9Gv9tXycr1yF9ISD
         KXuX3C+1lWTIQ0hS7G3fW3ELPQKKRs2IrH/yUbiSEnNy/spn8TTvCPs8wvlkzsrZMr+C
         S8LSCPnUAref6Kvn5AJ833D2SRKtnogsOdsRDO/zhMWdhRHSEnUj3rUv5b5pMd4UHsXk
         EpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDM2O7VWYFIaZ7PVhSFc/SgOo/6wqi6bL2en5kNgxxU=;
        b=OJYr7SnaHCh4LkKvOJpSfYliFMIbGmXKaHkx3YsKw0nGiBZxga0ITTF3bQ5yFahtP8
         E16fSZ6jZ+putX+CqlAtKh5o9jKrDLVpBcqoZfthLpQuM7SFf33TKdOJzKGKLPSSzT7c
         IEw2Zju6WDdzSA0XqltT3X7jCJUKCjAABid8MQwrZbIabeeU7vEH/hhWQ4B2iKg5xnBL
         TcAF10WwsuT5foVCOXmdbg9S1lLVz7AiMXMP3z7Pjel2ii82e4/4HKX4Q7bDVsaYLqrq
         mVrowcdYZC9Bh/oYVcnwZuB4Z7ymB3lv03sEFQ/1W6u0vO9ITWAQmr/97hBZ29sKwHLl
         mcXA==
X-Gm-Message-State: AOAM5318nACJGbiYvPl/jtMxM/afrczobxDaBQoz8CEnpCERbuCxjGWo
        SkjAZLs6UIdlog1nesnuHz5ULh/xECLgS/kA
X-Google-Smtp-Source: ABdhPJzqTZGWlC1sUtkkW4ZC4yV9viJClBwRgiQ75WwNtn4sPqfjm/zy3A/7iMKB1nnKN1UMhC++Bg==
X-Received: by 2002:adf:912b:: with SMTP id j40mr26055086wrj.42.1600252210493;
        Wed, 16 Sep 2020 03:30:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/15] remote-mediawiki tests: replace deprecated Perl construct
Date:   Wed, 16 Sep 2020 12:29:14 +0200
Message-Id: <20200916102918.29805-12-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The use of the encoding pragma has been a hard error since Perl 5.18,
which was released in 2013. What this script really wanted to do was
to decode @ARGV and write out some files with the UTF-8 PerlIO
layer. Let's just do that explicitly instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/test-gitmw.pl | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/t/test-gitmw.pl b/contrib/mw-to-git/t/test-gitmw.pl
index afc4650b1a..71e5b06235 100755
--- a/contrib/mw-to-git/t/test-gitmw.pl
+++ b/contrib/mw-to-git/t/test-gitmw.pl
@@ -24,7 +24,6 @@
 
 use MediaWiki::API;
 use Getopt::Long;
-use encoding 'utf8';
 use DateTime::Format::ISO8601;
 use open ':encoding(utf8)';
 use constant SLASH_REPLACEMENT => "%2F";
@@ -222,4 +221,4 @@ sub wiki_upload_file {
 	getallpagename => \&wiki_getallpagename,
 );
 die "$0 ERROR: wrong argument" unless exists $functions_to_call{$fct_to_call};
-$functions_to_call{$fct_to_call}->(@ARGV);
+$functions_to_call{$fct_to_call}->(map { utf8::decode($_); $_ } @ARGV);
-- 
2.28.0.297.g1956fa8f8d

