Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6041F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 23:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfJSXhL (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 19:37:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39803 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfJSXhL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 19:37:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so9874674wrj.6
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lS/pArNmS6Fxb20FkG1KRKYDpXafDbK4YiIiy9cTGl0=;
        b=b6rQ3GqK9XFab4eTBcRjZTgVCPofhHkGWXo+/x7FYCuIBLBn4YePxJACokvLJZQCNp
         Gkxkdq15oL9nN4ueQBFOC2g7bI+F4uCEPUxTIOcOGGdqizFfyuQJxelsTRW0VzT3oGAV
         G+9dyTe0z5C3aP14FjVmM5pzrfR3hUqGYjtiiIlJ+SYzOx6SnEifvYHOJPPrjQXK3dvd
         vzxTBsAE1QuFDPoeToYl0/Pncgu2Yb5mknjBrlx9d1X+UXMnPS2VcHFqNV3te9Pkv06/
         syT/O+6WQJcgza7cww4FJNXbKBkM3C/4RHARjj5Ltq3iA4D+sx7iZLeG31wsAstEx6Ib
         v5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lS/pArNmS6Fxb20FkG1KRKYDpXafDbK4YiIiy9cTGl0=;
        b=C3b1VESwsrOl5bee9e2k1IjR4D+N401W818NUZyXjutRC9zFQZRi3nZm6L+lWhCb1r
         Rk796EP603jI1uQKWkUBy530/UTjOdyIemQ64XcMXSvV7qV8YRBw8wcGpjGLByhPXPDh
         Okhf/a3+l5ZFeNElP4sxR2qxpuV1FZW4209Ts14HWJ9tDHq4PzzeKnu9h/l3zObdm1sU
         j9f8M3Wbb3KNSH5GhigrIrMCAElzI6UEhnoY7EIyxgOiU9oOz7NNG4p5n1BXXDQ+A737
         azptNgyGprM9MeZbta3cR1iTzpQes0Tb9UgOVHFuNMOtoe00LiU80DleY/5Sf/5P0bAd
         YGbA==
X-Gm-Message-State: APjAAAUXTQ65vLyivtxSkBWczlWtSC+5tSH922aQ4hB0f87jGEK2azEW
        ziGORXLlRqwqojoUPxRwLJE=
X-Google-Smtp-Source: APXvYqymhodZw50trZNcIxVkB1WfDG6nyDu1o7HlkZA28GgjVunTBiOH0a056KmodshbMtUeN8irdQ==
X-Received: by 2002:adf:f447:: with SMTP id f7mr9151962wrp.210.1571528228984;
        Sat, 19 Oct 2019 16:37:08 -0700 (PDT)
Received: from szeder.dev (x4db31b06.dyn.telefonica.de. [77.179.27.6])
        by smtp.gmail.com with ESMTPSA id o70sm13706145wme.29.2019.10.19.16.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Oct 2019 16:37:08 -0700 (PDT)
Date:   Sun, 20 Oct 2019 01:37:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: [PATCH] test-progress: fix test failures on big-endian systems
Message-ID: <20191019233706.GM29845@szeder.dev>
References: <b0bec82e-ad0a-32f6-e2e6-e1f0e6920639@physik.fu-berlin.de>
 <20190731071755.GF4545@pobox.com>
 <f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 19, 2019 at 11:38:40PM +0200, John Paul Adrian Glaubitz wrote:
> The testsuite is failing again on s390x and all other big-endian targets in
> Debian. For a full build log on s390x see [1].

Gah, my progress display fixes strike again...

I think the patch below should fix it, but I could only test it on
little-endian systems.  Could you please confirm that it indeed works
on big-endian as well?


  --- >8 ---

Subject: [PATCH] test-progress: fix test failures on big-endian systems

In 't0500-progress-display.sh' all tests running 'test-tool progress
--total=<N>' fail on big-endian systems, e.g. like this:

  + test-tool progress --total=3 Working hard
  [...]
  + test_i18ncmp expect out
  --- expect	2019-10-18 23:07:54.765523916 +0000
  +++ out	2019-10-18 23:07:54.773523916 +0000
  @@ -1,4 +1,2 @@
  -Working hard:  33% (1/3)<CR>
  -Working hard:  66% (2/3)<CR>
  -Working hard: 100% (3/3)<CR>
  -Working hard: 100% (3/3), done.
  +Working hard:   0% (1/12884901888)<CR>
  +Working hard:   0% (3/12884901888), done.

The reason for that bogus value is that '--total's parameter is parsed
via parse-options's OPT_INTEGER into a uint64_t variable [1], so the
two bits of 3 end up in the "wrong" bytes on big-endian systems
(12884901888 = 0x300000000).

Change the type of that variable from uint64_t to int, to match what
parse-options expects; in the tests of the progress output we won't
use values that don't fit into an int anyway.

[1] start_progress() expects the total number as an uint64_t, that's
    why I chose the same type when declaring the variable holding the
    value given on the command line.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/helper/test-progress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 4e9f7fafdf..42b96cb103 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -29,7 +29,7 @@ void progress_test_force_update(void);
 
 int cmd__progress(int argc, const char **argv)
 {
-	uint64_t total = 0;
+	int total = 0;
 	const char *title;
 	struct strbuf line = STRBUF_INIT;
 	struct progress *progress;
-- 
2.24.0.rc0.472.ga6f06c86b4


