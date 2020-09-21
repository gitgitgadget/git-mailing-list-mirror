Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CC2C43463
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703DE20EDD
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEer1H6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgIUKk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgIUKk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CD8C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so12077675wmb.4
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZD6bk0tMCA49bNP+rQRBgjc4vQfzxXu+zU8Yd0pxDqk=;
        b=uEer1H6O63bWoCb3WRYmBduBJcLysMST/8uZkDenkvbPZ89FA/2vOQ4SAYHMwvKDc5
         01FQ3hqF4pXPwqjtIRAOVb+S+o6gYAWciYmQ+Wf4abvWkN8qG0fstU6PATO9eXhVdNsp
         Dq0Cjj1WXvyOfy4mLo2vSDkGcu4NKGwvk/13kTSdYzjphFL+3kYeifdA0P69Z6AMlfJC
         51XD4jIhtomRiKKzx9K58KoMo0RSBsewKMPktWNNNjG4ssXu7jVrAaCmEa2UFNJPIdBW
         7WvOc5QCrY/tzSrMEg8kyai7shOWJdNR3BT7x4QPajyXJQGx9zsI5N/1K8UnXe0L+NkO
         4W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZD6bk0tMCA49bNP+rQRBgjc4vQfzxXu+zU8Yd0pxDqk=;
        b=HgKxMNAuMcD+5Xf8QB2Yk4eZIxT9qN4KQB9grI7fa+JrSOiDFt2gD1ylOBRd45unpB
         RJKnOc8uAvAg1kCqObyR6s5SBvor3NM/7wsDgPfrazhRgoa3z3rSYUnJNFKm+oXRuy3A
         FBakby5YmOBScImH9oJ3qbdrs48ktaHqxyTrHPhqRrw+cfve2a1VBjbVSZpOPeYtsxkv
         BmXXpcS+5pFIIf/FLNt/1w7kZb0bmCMzv8nEdoDR0NwhQZWwHGDyebWkSUTDgUd88i/V
         s5PAs+5DcC/cY1k/nfPYOPdYYcR/pxlVLN0ZFRkzFKZ0D+GYmppSZTEJ4/6KA1rrtXk/
         7dRQ==
X-Gm-Message-State: AOAM532VfwJRl4WpcL+K0AEhxuhRCaZixzPrCsxYe+Bp2rfL4tz2xOMv
        eTkUlLDyK4S2soPAfQ3rQMxPJIuaByxDtg==
X-Google-Smtp-Source: ABdhPJwi442iF0wvPJ/3YV+96Sb0kMsT9HD/eLsG8HASRG8f3DwUiyn1w1/IJ84BA5I0H+oJKufQRg==
X-Received: by 2002:a1c:a988:: with SMTP id s130mr27008021wme.31.1600684826233;
        Mon, 21 Sep 2020 03:40:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/18] remote-mediawiki tests: use inline PerlIO for readability
Date:   Mon, 21 Sep 2020 12:39:53 +0200
Message-Id: <20200921104000.2304-12-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

