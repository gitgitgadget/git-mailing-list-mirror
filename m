Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FFFC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 12:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026AE20739
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 12:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVTtaizr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgGGMRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 08:17:29 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E432C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 05:17:29 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g139so24577169lfd.10
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 05:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9H2IYhGaxUEgNljhzTlm7QlWedk4iq4anJ4DKHUYmU=;
        b=vVTtaizr5nYHlAE1qK91EjNjxvi9w7LyvvxVYYzjPVDK+d69gUXquW799Y2MK1I4UF
         DxS3+BEOh+1Bkwu3G72W3+ircUX7WsEmEdLSi+82YTbaYqUL5h/H16LI2v9Ic6iogvBo
         yCB2oLZLUuaO/RK/+geZLPEFrGRzhIWHGCzSvs63ZUjBByGCsJ2mvabdf6eHD4Yelrwj
         DkdO2UMn895+CzW+4rXZpNACFXxa1m6iNsSH3YtpUjz07VHxWktalq8UrTd4UeBr0tDQ
         8T8nynAfscFc268P2X+KYA6NEGBgCG/Vx0FEC1V8GqDeBCQI32PniJnChelAD9mTuPDJ
         SOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9H2IYhGaxUEgNljhzTlm7QlWedk4iq4anJ4DKHUYmU=;
        b=aRkXPNmWZ7EXl0Sisy/wCjtuXwwVkq+jf34eBAyIIAMl36NZqSXteer0SlGHujFaC9
         AwEIJDWTitWIN9TwoLop9BrDYw80mfVdHlka97KOcMGHM1WIJXLtQbZyPVVDHX6NGIKx
         0sX5lk4SrHuk/LHJDaXdlTKwy2HwdVbtGdsk1rZs4DyblHdn0SosOzi73FOW0fabTEqo
         KFbe4knbSw3sWe1FXwss/XyTAR2OlGmrU1gMRz9UL3vrjgLTY52s1ZYVqbJM7I8or0AB
         eYCyWq3ONTQrFPmZVjjg0fSvZmh6JdtSwkxPT3Ow2XMJYTnGwTz65B59Q4wZ+xMq/M1p
         2xsw==
X-Gm-Message-State: AOAM531hL+qf0SOTXciSlqww7TrTaSRuUOKvUOVSOqLzPsbHBmHSBsVW
        acLcWiofCOTMuPHJgnN+K/yQP0y3z9A=
X-Google-Smtp-Source: ABdhPJxgWB7dNmTHDrn1A7fzR9ReqQ27uNrZGGWpbJi9iYPJL2qwEJOOIk4NqSEBtkkN3zAH282v2w==
X-Received: by 2002:ac2:4422:: with SMTP id w2mr32620455lfl.152.1594124247564;
        Tue, 07 Jul 2020 05:17:27 -0700 (PDT)
Received: from george.localdomain ([2a01:79c:cebf:1be0:aa5e:45ff:fecd:fe25])
        by smtp.gmail.com with ESMTPSA id w4sm132724ljw.16.2020.07.07.05.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 05:17:27 -0700 (PDT)
From:   trygveaa@gmail.com
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Trygve Aaberge <trygveaa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 2/2] Wait for child on signal death for aliases to externals
Date:   Tue,  7 Jul 2020 14:17:15 +0200
Message-Id: <20200707121716.438318-2-trygveaa@gmail.com>
X-Mailer: git-send-email 2.26.2.2.g2208536367
In-Reply-To: <20200707121716.438318-1-trygveaa@gmail.com>
References: <20200704221839.421997-1-trygveaa@gmail.com>
 <20200707121716.438318-1-trygveaa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Trygve Aaberge <trygveaa@gmail.com>

When we are running an alias to an external command, we want to wait for
that process to exit even after receiving ^C which normally kills the
git process. This is useful when the process is ignoring SIGINT (which
e.g. pagers often do), and then we don't want it to be killed.

Having an alias which invokes a pager is probably not common, but it can
be useful e.g. if you have an alias to a git command which uses a
subshell as one of the arguments (in which case you have to use an
external command, not an alias to a builtin).

This patch is similar to the previous commit, but the previous commit
fixed this only for aliases to builtins, while this commit does the same
for aliases to external commands. In addition to waiting after clean
like the previous commit, this also enables cleaning the child (that was
already enabled for aliases to builtins before the previous commit),
because wait_after_clean relies on it. Lastly, while the previous commit
fixed a regression, I don't think this has ever worked properly.

Signed-off-by: Trygve Aaberge <trygveaa@gmail.com>
---
 git.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git.c b/git.c
index 9b8d3c92e6..c0698c7d45 100644
--- a/git.c
+++ b/git.c
@@ -345,6 +345,8 @@ static int handle_alias(int *argcp, const char ***argv)
 			commit_pager_choice();
 
 			child.use_shell = 1;
+			child.clean_on_exit = 1;
+			child.wait_after_clean = 1;
 			child.trace2_child_class = "shell_alias";
 			argv_array_push(&child.args, alias_string + 1);
 			argv_array_pushv(&child.args, (*argv) + 1);
-- 
2.26.2.2.g2208536367

