Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17A9C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 21:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A474D2067B
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 21:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mor0USGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgFDVJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgFDVJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 17:09:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13248C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 14:09:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so7589652wrn.11
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=a1hhyPq7Mf2K6ZXfJGOqvg5hvR3yiZBsIxeAeaAHcN0=;
        b=Mor0USGG05OZsUyQT7Bd6PLtbVw5nj8qhIlvfElj5mSyVxAluLrIT+H9DprgRAC2nG
         SPXKaftnwdXcGFQidPr9Y/Hrig3yCR9/YSI7PcueC97vxIu/LHtKBKGbEaXvnyohkthF
         u40rv8GGwlnKSeQuh7F/SkKPJTH/XDQ0sm3UWeh1dIZfM9R5q/Qp9gQFonX3SllIhcBt
         DdWsTjLPq5Gm7nYkT2APelMZ67UXcqXTsxYkJxEeIGG343YHvVTb1piqEksWYySiN4VA
         iZB9aUFUyG+KZi6EZOOd3LFBtP4emNekxHK/mXPrwIi7E1bIuyQOim9kg4UTOgoYz4ZW
         6r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a1hhyPq7Mf2K6ZXfJGOqvg5hvR3yiZBsIxeAeaAHcN0=;
        b=gkOoTsJWDxcU+35OS2Dggk3/UNASRZRmxftE5ymzOlhzkhHViDD5Wmhh26ekJBbao0
         CAUz7Qw0bKyW8+PJP3y+yM7MHwWyZiIkuaZAhJQEYoO5cp4mhoixY9LmHYMMRz303HWz
         AskBDbwVufp8xSDkBTUtyjq8rtYEpavDOlex5WifLOiST8Fb4No7TTavIzh2dX/zCX8X
         GzWNcF2Kme6pPKu2Awnp4JUMBXX8Zq3pwt/nzfE3l39XviDVjWFiUSzcPQ+XnacAiAHt
         odu8fJNu4oaWwmN5njOcoSazI7V0790o0DFt2ahulh4n7ETv8D258Bfmmw8paSzWr0rP
         0fJA==
X-Gm-Message-State: AOAM5339USk31umQhbUv3s3AspodaoHqpNyb6CbJnMdiw/y3gw9i7sBS
        7EgBXAT4D8eXU4Smbr/YuDEoVBW+
X-Google-Smtp-Source: ABdhPJyVFgTtFs02FWI5WxAYFlnbqQu7xVbC4gjfTObzkuWDo5xYkDrJlfAjSAfLpEjlgw65L9f5PQ==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr6065917wrq.316.1591304997506;
        Thu, 04 Jun 2020 14:09:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm9434174wrx.82.2020.06.04.14.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 14:09:57 -0700 (PDT)
Message-Id: <pull.648.git.1591304996279.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Jun 2020 21:09:56 +0000
Subject: [PATCH] msvc: fix "REG_STARTEND" issue
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 897d68e7af82 (Makefile: use curl-config --cflags, 2020-03-26), we
taught the build process to use `curl-config --cflags` to make sure that
it can find cURL's headers.

In the MSVC build, this is completely bogus because we're running in a
Git for Windows SDK whose `curl-config` supports the _GCC_ build.

Let's just ignore each and every `-I<path>` option where `<path>` points
to GCC/Clang specific headers.

Reported by Jeff Hostetler in
https://github.com/microsoft/git/issues/275.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    msvc: fix "REG_STARTEND" issue
    
    The MSVC build is actually not tested in our CI/PR builds, that's how
    this regression could creep in.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-648%2Fdscho%2Ffix-msvc-build-git-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-648/dscho/fix-msvc-build-git-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/648

 compat/vcbuild/scripts/clink.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index d9f71b7cbb7..61ad084a7b7 100755
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -23,7 +23,9 @@
 	    # before any "-l*" flags.
 	    $is_debug = 1;
 	}
-	if ("$arg" =~ /^-[DIMGOZ]/) {
+	if ("$arg" =~ /^-I\/mingw(32|64)/) {
+		# eat
+	} elsif ("$arg" =~ /^-[DIMGOZ]/) {
 		push(@cflags, $arg);
 	} elsif ("$arg" eq "-o") {
 		my $file_out = shift @ARGV;

base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
-- 
gitgitgadget
