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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D0AC43464
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F5E2076E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7xJVUzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgIUKke (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgIUKk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE583C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w2so11623368wmi.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HKCqyRBKCkFimtDjZK3Vt8zWnWyxMKjMz61XSZsG0Q=;
        b=G7xJVUzHjwomy3aaZXbjlMLUWLVwDgGWdRnR0hH2GMyC2af8aLP1Wbv2kUs2jkl87T
         sFM9ShRFeMmU1T7KuyDTLiMK7PAB/Gslzh7gnZnxb2yT0PA+uSzqM5wOnF4AS2sUdGL3
         gNBkwXQXbcSZhVOq8KYjRSaDyZI6Ii/hTF6VmtHbkTD0A2P+WBZpGTdaAPfBXkkCimkh
         9ux/F+YAS8clkKu69N4az9YK54WVRtYw5EVADA1GYJsw7PFh62lFki3LHYK/SLkZI/2e
         BTXqgROvIilcisPB2J4xOz6A4WgxiR7rZi1SL+iMFfvG71B1UOp5KpCc6F9E2mbaj3MX
         2D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HKCqyRBKCkFimtDjZK3Vt8zWnWyxMKjMz61XSZsG0Q=;
        b=RcqIl+zITagdMWOV2te6XDdF/nImYspVAU4WUMGVWtAZNBFOn7dDnljuYg+RYv6EC+
         r+JxfeqaixQKGy23Eau6u5J/vug6Wl50GMVyOenoy3+D9b0Dg9G9EiSwtoTSzMjcDVkd
         MDI4znfBgdmUhXBuOBPEPY97sVlFAqPAzlEkC3nbUDnNgb8g0K4odGbLP/HelA2n9udX
         KdcyAcPKnjSFvWQw4kHXXH06ZKtQbBVjMxdinUQvvzNJXLQX4tPCSraDIzQBAmQYfSSh
         VKP9HnEO9Uo2WIsEZhDs030i/1Hs13tbTAFqwoBAX7A3a0PzdPLhpE+gFQdTDtDwj65O
         0qEw==
X-Gm-Message-State: AOAM531WuWTiXq5z1FW95KzLoHI3zoDJ3Ukgv0M0Oa4XobP67rW5ITWM
        fhaYvBwQE1SqLqyYYJ473AFUlg06wAegMw==
X-Google-Smtp-Source: ABdhPJxI6CgnrmEKOmDrAMVUPmoAg0XMZ9pxDdTVLjf8tbOehizJJK2TBL1D1j6Lio8ShjduwlugbQ==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr29414843wmb.101.1600684825178;
        Mon, 21 Sep 2020 03:40:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:24 -0700 (PDT)
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
Subject: [PATCH v2 10/18] remote-mediawiki tests: replace deprecated Perl construct
Date:   Mon, 21 Sep 2020 12:39:52 +0200
Message-Id: <20200921104000.2304-11-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The use of the encoding pragma has been a hard error since Perl
5.18 (released in 2013).

What this script really wanted to do was to decode @ARGV and write out
some files with the UTF-8 PerlIO layer. Let's just do that explicitly
instead.

This explicitly does not retain the previous UTF-8 semantics of the
script. The "encoding" pragma had all sorts of global effects (program
text being UTF-8, stdin/stdout etc.). But the only thing that was
required was decoding @ARGV and writing out UTF-8 data, which is
currently facilitated with the "open" pragma.

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

