Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35614C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133AB6137D
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 23:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhFXXhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 19:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXXho (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 19:37:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EEBC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:35:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a11so13144142lfg.11
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3KpHHWSV7VDeA9t/YV3bY1BghlZF23uUPlRFhIFu78=;
        b=ib3eIiQpOHXGd5qQ6wmapowE77rNhd8YOzw1myjNdum4YX2Wi05drQPITuWIySSvdM
         AcIXqFruwwajv6IQnZ0+ixIJ8tGrUtOHEcS3+CWIhURlryYc5uVjrBoN+Q6wAkwqQfWb
         urzv4vDwU2fEcOXqAvRU1eFtV4xa0V8GJg8SCGnvWY0Ak9mMOS3bbMbxxiiPtKb8OItR
         PV/64A7l3iQByR7TlYJ80FaxsLu9POYXEVbeX7Waprz0rabT/x1TTjBZS+rFwNPK9NZD
         jQm5M1HIM9k/3puqHmXSgie4y0V4V6RpkdnfdWlWGV5ZeDv/vSnyY28w3aYgg3M9rrZc
         SfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3KpHHWSV7VDeA9t/YV3bY1BghlZF23uUPlRFhIFu78=;
        b=l1t9nb36QY3zOO4QwezexlgL4MvHGZMxhaeNkJH1UlFH9qrltsiXJPuwhWflsUGOTT
         31UhfAYl20LANOjVRU4QgZLYojeEifKgUIebgkjJ+MU9EJ9UmJGQeifJzM2OBFP6EcWl
         BNR2qL1WAyL46LelZR20xz3+SFT75Wah+eNF1zBAWSAORdZo5dHYfyRu1l8gN/OGDyjx
         A3zDYjoSosxoreMEMalfSFA8ALwbZ1P4d0OSvxu8m29JHA3YcaxtKbTA6GFDSplwYCpq
         BENFPb63jq6EgcUWjLeqKaOKRQDZnoTCx4lod88TSIi5ppgYeBqv/jXLUp4bYev902NG
         jF/w==
X-Gm-Message-State: AOAM530uHr8YA4mSZXjWJ5FPdsUl5geAFC1ZYA2Dn/GsBlaJngQ4CvO6
        jJkjbsYyhTr8tQxeeGZ3QWs=
X-Google-Smtp-Source: ABdhPJy3PvOt7da2CsMO7IMpDAxv8BG0/XwBKKSg2KgEihqkJoatcPfZ1IhXbutoZMw+rB31idPb1g==
X-Received: by 2002:a19:ac45:: with SMTP id r5mr6014196lfc.449.1624577722133;
        Thu, 24 Jun 2021 16:35:22 -0700 (PDT)
Received: from raspberrypi.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id l27sm452152ljb.90.2021.06.24.16.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 16:35:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     avarab@gmail.com
Cc:     Johannes.Schindelin@gmx.de, emilyshaffer@google.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: Re: Why the Makefile is so eager to re-build & re-link
Date:   Fri, 25 Jun 2021 01:35:16 +0200
Message-Id: <20210624233516.23564-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <874kdn1j6i.fsf@evledraar.gmail.com>
References: <874kdn1j6i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Ævar

> {command,config}-list.h (and in-flight, my hook-list.h): Every time
> you touch a Documentation/git-*.txt we need to re-generate these, and
> since their mtime changes we re-compile and re-link all the way up to
> libgit and our other tools.
> 
> I think the best solution here is to make the generate-*.sh
> shellscripts faster (just one takes ~300ms of nested shellscripting,
> just to grep out the first few lines of every git-*.txt, in e.g. Perl
> or a smarter awk script this would be <5ms).
> 
> Then we make those FORCE, but most of the time the config or command
> summary (or list of hooks) doesn't change, so we don't need to
> replace the file.

One possible technique to fix this is to generate to a temporary file, and copy
the temporary file over the real file if it's actually different. I see the
Makefile already does create a temporary file, so how about something like
this:

diff --git a/Makefile b/Makefile
index 93664d6714..9b2f081a2a 100644
--- a/Makefile
+++ b/Makefile
@@ -2216,7 +2216,8 @@ command-list.h: generate-cmdlist.sh command-list.txt
 command-list.h: $(wildcard Documentation/git*.txt)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
-		command-list.txt >$@+ && mv $@+ $@
+		command-list.txt >$@+ && \
+		if ! cmp -s $@ $@+; then mv $@+ $@; fi
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\


This seems to work fine from my basic testing. I think it can even be written
more terse as `&& ! cmp ... &&` but that looks a bit weird to me. In any case
it looks like it can easily be added the other relevant places in the Makefile
too.

Øsse
