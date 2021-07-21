Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905BCC636C9
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 16:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE5261208
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 16:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhGUQMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhGUQMC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 12:12:02 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BABC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 09:52:39 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id m20so2856387ili.9
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zPiWqCFdOFiciJ2cGrfjERG1/QquONpABIGN/ptvREk=;
        b=MKDqcc7dNUM8cwZ51Qk7feNcNqo99d5pJCSfPA9nHRnJMONzGLsZz+f78UryOoHpRS
         KP/pRQv6bzqwvYnhIaQaTUuEjQ9J0eKB7cFbO4AX6mC0uChS91Fpk5nD12rCQ/MXIVmf
         3/fUJD0YLLcTGxVypcjiManhE3APIxNrL+HEAK5ntJsZxafkAVTrglUxZMRkL1mwyJe3
         E9PxFq3zrtqcElWCY/ZXeM6CgH6CBzPLvG6G8CtFZevGNLXRu+LI/bfwZ/FV/7/VYXw6
         bJxOUATFZeIV9qUdmp5WyVuv2Fu9t/Wtix2yG4ajoAHtG7FBNRuO7X1fExKUwKkmHMYt
         leXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zPiWqCFdOFiciJ2cGrfjERG1/QquONpABIGN/ptvREk=;
        b=OwailB3FVig6fCt5KiMp46O1fVr96URCOBPV9+3vqANDqUy1q1TSLS9nlpmtmxU/+9
         kWgk6nQ9APaTe3ECnSj3phE9ZL2QxpqrivVWqRAQm+aB542KH4VUgbc+K1juaTTbcc39
         fFf67sHjZQ5Gnt6MguhBoU3Pp721KxHy53fYJti9hrw53jFBvUXeEv9HpYrhT7jjCw4a
         K7IUZrDYV/9hKdcOTLZw67DFmlpV2YNz3lBe/kvT+2ds8pBy8PgkhpLF8qLRp3IwWg9p
         kkV/imb97aHdwMz0GWaEJ3ntQjnMFqHNvY+pnpi+l0umAskcrLyqYuAmF7qNC55ndDdI
         bgcQ==
X-Gm-Message-State: AOAM533ttti6iFdWPeGG7I/iv2TigxXh2+wUmUMMxYNPqSNxX0otUxiu
        hTL/DwFKlJXs6A59gNj8lyVhQ90ilXEHC5cm
X-Google-Smtp-Source: ABdhPJzj/pvIXAZxN9TjEk/LhTGBlZHqs07e/Pz859gDvu+zXcUEwbFVl+SBkiLYZXIkPqH7g4s3FA==
X-Received: by 2002:a92:d083:: with SMTP id h3mr25151166ilh.157.1626886358442;
        Wed, 21 Jul 2021 09:52:38 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:2c46:d8ae:a4c3:9466])
        by smtp.gmail.com with ESMTPSA id f3sm15049334iob.30.2021.07.21.09.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 09:52:37 -0700 (PDT)
Date:   Wed, 21 Jul 2021 12:52:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com
Subject: [PATCH v2] multi-pack-index: fix potential segfault without
 sub-command
Message-ID: <12804130427fd71e88ce10aed283c1f9cdd330ef.1626886330.git.me@ttaylorr.com>
References: <YPfWkzRtQKthOgZx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPfWkzRtQKthOgZx@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since cd57bc41bb (builtin/multi-pack-index.c: display usage on
unrecognized command, 2021-03-30) we have used a "usage" label to avoid
having two separate callers of usage_with_options (one when no arguments
are given, and another for unrecognized sub-commands).

But the first caller has been broken since cd57bc41bb, since it will
happily jump to usage without arguments, and then pass argv[0] to the
"unrecognized subcommand" error.

Many compilers will save us from a segfault here, but the end result is
ugly, since it mentions an unrecognized subcommand when we didn't even
pass one, and (on GCC) includes "(null)" in its output.

Move the "usage" label down past the error about unrecognized
subcommands so that it is only triggered when it should be. While we're
at it, bulk up our test coverage in this area, too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
I didn't realize that we are veering away from test_i18ngrep in new
tests, so here's a version of this trivial patch with grep instead.

Range-diff against v1:
1:  8c0bb3e0dc ! 1:  1280413042 multi-pack-index: fix potential segfault without sub-command
    @@ t/t5319-multi-pack-index.sh: test_expect_success 'load reverse index when missin

     +test_expect_success 'usage shown without sub-command' '
     +	test_expect_code 129 git multi-pack-index 2>err &&
    -+	! test_i18ngrep "unrecognized subcommand" err
    ++	! grep "unrecognized subcommand" err
     +'
     +
      test_done

 builtin/multi-pack-index.c  | 2 +-
 t/t5319-multi-pack-index.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5d3ea445fd..8ff0dee2ec 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -176,8 +176,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	else if (!strcmp(argv[0], "expire"))
 		return cmd_multi_pack_index_expire(argc, argv);
 	else {
-usage:
 		error(_("unrecognized subcommand: %s"), argv[0]);
+usage:
 		usage_with_options(builtin_multi_pack_index_usage,
 				   builtin_multi_pack_index_options);
 	}
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 7609f1ea64..c0ec5a6fd3 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -837,4 +837,9 @@ test_expect_success 'load reverse index when missing .idx, .pack' '
 	)
 '

+test_expect_success 'usage shown without sub-command' '
+	test_expect_code 129 git multi-pack-index 2>err &&
+	! grep "unrecognized subcommand" err
+'
+
 test_done
--
2.31.1.163.ga65ce7f831
