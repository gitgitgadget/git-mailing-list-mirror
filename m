Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E15C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF4764F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhBCDbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbhBCDaU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:30:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFE4C061355
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g10so22585839wrx.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ry+NHp+m6HJlLxN0CnCzN9iiemEIkb5w0ex+4kE35YE=;
        b=Cg5/pgmfs2x1+zFAqz3mZIInCs8+5h1upAVGNa12SnQTVtIHhR21qP8vMQvFhUfAEQ
         F+aTKJqjb0sk/WHjkNuNWEgViMWyVgsxul57Ul+75an7lp0eje60SVMDBhISFhcUrdSE
         mmScPC/khw3K/0ZTSETsr1GZOTmdngnwp7P5u9+pjVJpixEkdkSA0AkkCLp9gqxS4Zp2
         SyF7PwdKkdC52zz6+wiwC6NOhuxO/+EXgTMyux3EVi8qrNp5h7OtMXMzKlJkg6hezFlK
         xyje1FNZeJIXqE8sDW/wjwnTNqGV2WcjaSqsa3kzB5UwFwxONefCYOQODLAyx+meTTj+
         nlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ry+NHp+m6HJlLxN0CnCzN9iiemEIkb5w0ex+4kE35YE=;
        b=nqjSOY8iNg9aHJEHpi/LkNa72eNGT37WC4V8nt2hQnwKyoJ+veycNumXmWyKzaoLvH
         AZsFXnMei58lqa84yJAi+CQPt6QwIW8UXSoYJgmmk2EhGGhpguEAf7YLPutOCK4X3/sQ
         gD1+e6p0zq64yq+PMC/1Hez5W6zAJkm5THidTuPfN/QBXePTKY7lN+4ujhdI1fJpW2bE
         ukfLhls23fsWvN+HhcVyB2eCnbZLLDWObJEgEFNYrW76wSna6LjMUcwdLMrbwN7ktu0E
         QEKHdJ2LHR7YluHS9/iNwrjtA0v8kw97JweqDPAFJciHoDJk0psKYJuQo7JLNVuxrKQO
         C/VQ==
X-Gm-Message-State: AOAM532BVcxmZ/wCYzfbm3PFkLBNkclyot+j361E7N40JVhmp9wgzF2v
        WK9VWelqMUOQp/xVo42VWKaXDLJY+q2FWg==
X-Google-Smtp-Source: ABdhPJxE3SUp7QNHq7Nhs+h77omC60Ilnwt6uHyIcWtcyFZGdnSDP0JzMO7LZn8uU+exMSVumTn2cA==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr1038726wrw.255.1612322916327;
        Tue, 02 Feb 2021 19:28:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 19/25] pickaxe -G: set -U0 for diff generation
Date:   Wed,  3 Feb 2021 04:28:05 +0100
Message-Id: <20210203032811.14979-20-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the equivalent of -U0 when generating diffs for "git log -G". As
seen in diffgrep_consume() we ignore any lines that aren't the "+" and
"-" lines, so the rest of the output wasn't being used.

It turns out that we spent quite a bit of CPU just on this[1]:

    Test                                             HEAD~             HEAD
    -----------------------------------------------------------------------------------------
    4209.2: git log -G'a' <limit-rev>..              0.60(0.54+0.06)   0.52(0.46+0.05) -13.3%
    4209.8: git log -G'uncommon' <limit-rev>..       0.61(0.54+0.07)   0.53(0.47+0.06) -13.1%
    4209.14: git log -G'[þæö]' <limit-rev>..         0.60(0.55+0.04)   0.56(0.48+0.04) -6.7%
    4209.21: git log -i -G'a' <limit-rev>..          0.63(0.56+0.03)   0.54(0.48+0.05) -14.3%
    4209.27: git log -i -G'uncommon' <limit-rev>..   0.61(0.55+0.05)   0.53(0.47+0.06) -13.1%
    4209.33: git log -i -G'[þæö]' <limit-rev>..      0.61(0.53+0.07)   0.53(0.47+0.05) -13.1%

I also experimented with setting diff.interHunkContext to 10, 100
etc. As noted above it's useless for -G to have non-"+" and non-"-"
lines for the matching itself, but there's going to be some sweet spot
where if we can be handed bigger hunks at a time our matching might be
faster.

But alas, the results of that were:

    Test                                             HEAD~2            HEAD~                    HEAD
    ------------------------------------------------------------------------------------------------------------------
    4209.2: git log -G'a' <limit-rev>..              0.61(0.53+0.07)   0.51(0.46+0.05) -16.4%   0.51(0.46+0.05) -16.4%
    4209.8: git log -G'uncommon' <limit-rev>..       0.66(0.55+0.05)   0.53(0.48+0.04) -19.7%   0.52(0.49+0.03) -21.2%
    4209.14: git log -G'[þæö]' <limit-rev>..         0.63(0.54+0.06)   0.51(0.44+0.07) -19.0%   0.52(0.46+0.06) -17.5%
    4209.21: git log -i -G'a' <limit-rev>..          0.62(0.54+0.07)   0.51(0.46+0.04) -17.7%   0.53(0.45+0.07) -14.5%
    4209.27: git log -i -G'uncommon' <limit-rev>..   0.62(0.56+0.06)   0.53(0.48+0.05) -14.5%   0.53(0.46+0.07) -14.5%
    4209.33: git log -i -G'[þæö]' <limit-rev>..      0.63(0.57+0.03)   0.58(0.46+0.06) -7.9%    0.53(0.46+0.06) -15.9%

I.e. maybe it's faster in some cases, but probably slower in general.

Those results are going to be crappy because we're matching a line at
a time, as opposed to some version of /m matching across the whole
diff (if possible). So that approach might be worth revisiting in the
future.

1. GIT_SKIP_TESTS="p4209.[1379] p4209.15 p4209.2[028] p4209.34" GIT_PERF_EXTRA= GIT_PERF_REPO=~/g/git/ GIT_PERF_REPEAT_COUNT=5 GIT_PERF_MAKE_OPTS='-j8 USE_LIBPCRE=Y CFLAGS=-O3 LIBPCREDIR=/home/avar/g/pcre2/inst' ./run HEAD~ HEAD -- p4209-pickaxe.sh

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index cb865c8b29..5161c81057 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -60,7 +60,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	memset(&xecfg, 0, sizeof(xecfg));
 	ecbdata.regexp = regexp;
 	ecbdata.hit = 0;
-	xecfg.ctxlen = o->context;
+	xecfg.ctxlen = 0;
 	xecfg.interhunkctxlen = o->interhunkcontext;
 	if (xdi_diff_outf(one, two, discard_hunk_line, diffgrep_consume,
 			  &ecbdata, &xpp, &xecfg))
-- 
2.30.0.284.gd98b1dd5eaa7

