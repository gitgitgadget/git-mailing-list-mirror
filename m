Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC7DC71153
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 18:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbjHXSlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 14:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbjHXSko (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 14:40:44 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE28170F
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 11:40:43 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5920efd91c7so2304517b3.2
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692902442; x=1693507242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwIGYx6MV+VgULgQNSv6od3eZVna7D++wu4q+ZGhhnA=;
        b=tvxHbYUCtS+2I0haBq3q8uIuAOas3wHo3j+QZR79v/jzxx9q/FZBlbrMoqGKILeyyG
         6u4vtq3IeOuVmTPmeJ8Apz5VdtFLaiLGoYUFtJWSY4Ahx40MSdA5+17bH6WDC2qRhMnT
         96HZUCEJvfNW2Wt6LwxKeAv+YDpbA15zmUKfOHDvVlPExFTSVbIBJusPQxMtstMTR0iS
         VN6WhudFltgXxrKwrT4s7+b/3MjJgOBnOXYfmd0tGR+32f7/kDaaaq9yjdxOLy92dQHc
         ME0nu4pCk7MJk56I+PxmfwnLrKFhIIggowYJyrcSNNZRGPdnMqEFqfLkD5K2pCbafWNZ
         Q38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692902442; x=1693507242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwIGYx6MV+VgULgQNSv6od3eZVna7D++wu4q+ZGhhnA=;
        b=c9FtWKWXo2zRqb7zkZbU2a7ikp2m4CNAYOxbElAaBiCeyJoMCK3dfbP7krtII0QRdo
         L6qZnDKa2UVXukbVPsfNTMz7rKsShnQJN4O4csu5ikCEu3/D3NtNpb9+cVv6ZYq/KSiR
         icu5x35bfIWtzoVPWuzXN0xQfHmRylzcZsrwKPT2LGbq5Tg9K5QzMJ1/Zz2795kTbefC
         f3J8/FwX27osXJFZlGgoGfBAGn0JtPf1jxZqp1diStBI6DKvCDJMrfadlczslfLAFrhg
         hVYInleIq64+koaN2p8lGLAdps/QHlfb9E/smDGFvvs2EYjU2J0PEt35HdKvnKfD1Fzr
         kUkg==
X-Gm-Message-State: AOJu0YxVav4eOcDApXPxVeEBq+84GDxEsQgvzw1nwjwXkvGQ9hAG45az
        TlJ6VL7F89z944vGsFAsNFqMmJIOIPo6hQhghdW5Zg==
X-Google-Smtp-Source: AGHT+IH7tQIwvmbFQiNAqALfJuJsJxWdIkTUi7UWaqwEfQrtXJ4Jw712mPy1wUsxGPqxplQTUtjabg==
X-Received: by 2002:a81:5346:0:b0:56d:2d59:dc30 with SMTP id h67-20020a815346000000b0056d2d59dc30mr17110628ywb.24.1692902442251;
        Thu, 24 Aug 2023 11:40:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l18-20020a81d552000000b00584554be59dsm37993ywj.85.2023.08.24.11.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:40:41 -0700 (PDT)
Date:   Thu, 24 Aug 2023 14:40:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 2/3] leak tests: mark t3321-notes-stripspace.sh as leak-free
Message-ID: <cfeca8894201963b7443fab7ed59c6a596e0ac3a.1692902414.git.me@ttaylorr.com>
References: <cover.1692902414.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692902414.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test was leak-free when t3321 was originally introduced, but never
marked as such:

    $ rev="$(git log --format='%H' --reverse -1 HEAD^ -- t/t3321-notes-stripspace.sh)"
    $ git checkout $rev

    $ make SANITIZE=leak
    [...]

    $ make -C t GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_OPTS=--immediate t3321-notes-stripspace.sh
    [...]
    # passed all 27 test(s)
    1..27
    # faking up non-zero exit with --invert-exit-code
    make: *** [Makefile:66: t3321-notes-stripspace.sh] Error 1
    make: Leaving directory '/home/ttaylorr/src/git/t'

Mark this test as leak-free accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t3321-notes-stripspace.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3321-notes-stripspace.sh b/t/t3321-notes-stripspace.sh
index 028d825e8f..36abdca5ee 100755
--- a/t/t3321-notes-stripspace.sh
+++ b/t/t3321-notes-stripspace.sh
@@ -5,6 +5,7 @@
 
 test_description='Test commit notes with stripspace behavior'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 MULTI_LF="$LF$LF$LF"
-- 
2.42.0.3.g4011eb6a8b

