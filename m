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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C11C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491042223C
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spujKA1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgIPMUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgIPKcf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:32:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2274FC06121D
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x23so2234128wmi.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZD6bk0tMCA49bNP+rQRBgjc4vQfzxXu+zU8Yd0pxDqk=;
        b=spujKA1/zBRb5J/h1AqQsGSYrzlgjPTLxfn9P1M29OPrjlxapQCIW45Tpbg2cKFSnL
         i5GINHN9xH+CXql0KkmWJMDFGLw0Q94fpPxWkpOuaQgkncfq8TGZxStYdevZ1IaHC73O
         A7jL/K/VQsdAjyfY5eQfYnL4xpvNWOqPSPjln8/032JtK9IQhBShlW2Tm+51I4+NppY5
         AwWGgyS/Jdl/hGo5Yyycaug8GfVLG+COE+o/WKVKCJuF6BiNmJ53fOLHExe2S2Ym3QN4
         bQ2C7x2iqnjKF0yFriwfsc2wKqSoDF8UFE1kRG1z1Y82TibsUaYZScfrFn46IBCqVFqg
         kX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZD6bk0tMCA49bNP+rQRBgjc4vQfzxXu+zU8Yd0pxDqk=;
        b=HtcmCyHQaSJBgsYRvJpLJc+CjRqSyWTvNNvexAxLi6uzxBCRf/Vc15f/KaZMHb3UMS
         qKOJ5af/lzyv/ZnLkriGjqNdntt4nEzitg0Qppu1EMxGU1EP3mTkeOiOu4AuGZEfaJi7
         8cGJngOC9yt0XhpBmWad/yOg0jJY81CTXo7AIl/RaQFUWGbUFq/thpF7KLNBca3MGAEK
         wcxSK0AxlkqA2B+t+s6fK9Wqj1QW/UzoggP615Xckl+XLZnW4TMx2uqo3HYNmQZHjfo6
         JZKM1j/0drrblgFTbpNeMOA1igMmIntzFzD2xDw2MnnJKtleKmW7bojjWUdmxkkvfj04
         hMpQ==
X-Gm-Message-State: AOAM531v++vueneHbmpn+EWw011gRTw36pQ5c6IVezy6FxnSagQkXvI8
        GF/KN7KibORR/DA9gzElVs4O71IVHHNXkw0p
X-Google-Smtp-Source: ABdhPJwRgRIWF3MxHAWPmce9UpUc4ATES/PmWWRX17+OBCpJE3xjkw1FLmmFlHR5mf2kvbVsK8xp0w==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr4192235wmb.13.1600252211528;
        Wed, 16 Sep 2020 03:30:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:10 -0700 (PDT)
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
Subject: [PATCH 12/15] remote-mediawiki tests: use inline PerlIO for readability
Date:   Wed, 16 Sep 2020 12:29:15 +0200
Message-Id: <20200916102918.29805-13-avarab@gmail.com>
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

Replace the use of the "open" pragma with a three-arg open in the
places that actually care about UTF-8, while leaving those that
don't (the config parsing).

Unlike the previous "encoding" pragma change this isn't needed for
compatibility with anything. I just think it's easier to read code
that has localized effects than code that changes global settings.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/test-gitmw.pl | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/mw-to-git/t/test-gitmw.pl b/contrib/mw-to-git/t/test-gitmw.pl
index 71e5b06235..c5d687f078 100755
--- a/contrib/mw-to-git/t/test-gitmw.pl
+++ b/contrib/mw-to-git/t/test-gitmw.pl
@@ -25,7 +25,6 @@
 use MediaWiki::API;
 use Getopt::Long;
 use DateTime::Format::ISO8601;
-use open ':encoding(utf8)';
 use constant SLASH_REPLACEMENT => "%2F";
 
 #Parsing of the config file
@@ -86,7 +85,7 @@ sub wiki_getpage {
 	# Replace spaces by underscore in the page name
 	$pagename =~ s/ /_/g;
 	$pagename =~ s/\//%2F/g;
-	open(my $file, ">$destdir/$pagename.mw");
+	open(my $file, ">:encoding(UTF-8)", "$destdir/$pagename.mw");
 	print $file "$content";
 	close ($file);
 
@@ -171,7 +170,7 @@ sub wiki_getallpagename {
 				cmlimit => 500 },
 		)
 		|| die $mw->{error}->{code}.": ".$mw->{error}->{details};
-		open(my $file, ">all.txt");
+		open(my $file, ">:encoding(UTF-8)", "all.txt");
 		foreach my $page (@{$mw_pages}) {
 			print $file "$page->{title}\n";
 		}
@@ -184,7 +183,7 @@ sub wiki_getallpagename {
 				aplimit => 500,
 			})
 		|| die $mw->{error}->{code}.": ".$mw->{error}->{details};
-		open(my $file, ">all.txt");
+		open(my $file, ">:encoding(UTF-8)", "all.txt");
 		foreach my $page (@{$mw_pages}) {
 			print $file "$page->{title}\n";
 		}
-- 
2.28.0.297.g1956fa8f8d

