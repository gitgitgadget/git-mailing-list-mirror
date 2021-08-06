Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1219C4320A
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E9461078
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhHFUxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 16:53:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59374 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhHFUw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 16:52:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1378143B5E;
        Fri,  6 Aug 2021 16:52:43 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PFVVRp9Za1vp
        K7QRO4upgx2xpdN2uVvomRFaL5YuZhI=; b=p3A2IyAwiDavhPJD/GOa8MJdTsrv
        NXJ1eXnc2DWTamepsJazEOcnxW492+FpHzns+W2YWUcdBBUAVdfi5lTX2TnqrpED
        SWDlhf2I1mph6QlITkMk4s5iRNmOoFAgU+HN2iRbQUJTAO2z8j2r/U2xPGz//RbV
        7vKcCXhNaHeWYTY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91486143B5D;
        Fri,  6 Aug 2021 16:52:43 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DCEC2143B5A;
        Fri,  6 Aug 2021 16:52:40 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 1/3] build: update detect-compiler for newer Xcode version
Date:   Fri,  6 Aug 2021 13:52:33 -0700
Message-Id: <20210806205235.988761-2-gitster@pobox.com>
X-Mailer: git-send-email 2.33.0-rc1-159-gdd7297d7fa
In-Reply-To: <20210806205235.988761-1-gitster@pobox.com>
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
 <20210806205235.988761-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 3D822E80-F6F8-11EB-B3C2-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

1da1580e4c (Makefile: detect compiler and enable more warnings in
DEVELOPER=3D1, 2018-04-14) uses the output of the compiler banner to
detect the compiler family.

Apple had since changed the wording used to refer to its compiler
as clang instead of LLVM as shown by:

  $ cc --version
  Apple clang version 12.0.5 (clang-1205.0.22.9)
  Target: x86_64-apple-darwin20.6.0
  Thread model: posix
  InstalledDir: /Library/Developer/CommandLineTools/usr/bin

so update the script to match, and allow DEVELOPER=3D1 to work as
expected again in macOS.

Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 detect-compiler | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/detect-compiler b/detect-compiler
index 70b754481c..c85be83c64 100755
--- a/detect-compiler
+++ b/detect-compiler
@@ -44,7 +44,7 @@ clang)
 "FreeBSD clang")
 	print_flags clang
 	;;
-"Apple LLVM")
+"Apple LLVM"|"Apple clang")
 	print_flags clang
 	;;
 *)
--=20
2.33.0-rc1-159-gdd7297d7fa

