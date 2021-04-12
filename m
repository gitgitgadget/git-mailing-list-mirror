Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D004CC43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CEC61288
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhDLLJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbhDLLJb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FC9C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p6so5759575wrn.9
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1sXkxLV2EdPFJeNxmJyl70xhIZRRljSRYA56qbNzfM=;
        b=U2eC75D+eihKErKlo+RFlD+/zBw1iqnygJCirDQSITLR6iYvrRC5g1sD09CXrelWX+
         dNeLyKFJDYkM1R35UXBnrPiI9pGZFYb6le8omy96PK457FFMPoCHQwn77q3v4SuGsdTJ
         a+O5kvakD//XJ38uxa/ZDvk1cD3Kr5hHv3zyqULPeSLjCeuFNg79uQ85yVxgELVrH++G
         ijgi5X8iNoi+/sJpZkvF+iWnPTmSHsgoW/hE3VVBhpQ8m1YPnU4jjFUEYftCZbkSQc4T
         Iv6T3/3c9VN/1wHrT0mKOCGND/pJYk1JZp9uZSHg6EPYJ+nhHbVKsSYyJEL7LQyhiABd
         Bdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1sXkxLV2EdPFJeNxmJyl70xhIZRRljSRYA56qbNzfM=;
        b=L5ywMoc6puA5zFeop/2k3WurYFSvjCyyfHDjek3K26PnVkBTVBGIrsTb6tBMYyi+dK
         3K/0WhSTBzo6WenV+ZBhhksv44s59BfvF5k7IvQxT3at69TNadR5uYmYcF/4/6WlYuC1
         uJYA7sVV87+pLAGmf81/O5wgNspLC9FqZ3twRlMRsaH7DxepEuTs/DqGkrurmAi2NZOr
         agJ+CUwCrgF36eSUcAnUbioTc3hxWLqNHli7qra+jSUxLs/YoRL4kKntgTvy3lr0yjWp
         WvyYA9AMkqa1XyEwO31w/GyNz3/PK3DLqOZEVZ8BSqc+oKGQL/bsFGf1gc3jfE/W2Ywo
         /RZA==
X-Gm-Message-State: AOAM532zUaWugLHgbk3d2H3QBnY9wi5/vta2U/uefEymJj52Y+ensVBj
        gqIE/UKaeneJY18YbPeqP/88OGGidtgW7g==
X-Google-Smtp-Source: ABdhPJxdtz0qD4oKv2wcCgFrSzsbjryur+ImlI0GjpMz81FCVtfs0yDcmrS92xt+93stOiuRmlm+jg==
X-Received: by 2002:adf:f00e:: with SMTP id j14mr6551783wro.180.1618225751402;
        Mon, 12 Apr 2021 04:09:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/16] check-non-portable-shell: complain about "test" a/-o instead of &&/||
Date:   Mon, 12 Apr 2021 13:08:50 +0200
Message-Id: <patch-01.16-8e4b4a2a216-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expand the t/check-non-portable-shell.pl checks to complain about the
use of "-a" and "-o" to the "test" shell built-in to to mean "and" and
"or", as opposed to using two "test" invocations with "&&" or "||".

There aren't any portability issues with using that construct that I
know of, but since Junio expressed a dislike of it in [1] and we've
currently got no such constructs let's add it to the lint checking. I
had various in-flight and WIP patches that used this construct.

1. https://lore.kernel.org/git/xmqqa6qkb5fi.fsf@gitster.g/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/check-non-portable-shell.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index fd3303552be..a5367346255 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -35,6 +35,7 @@ sub err {
 	next if $line =~ s/\\$//;
 
 	$_ = $line;
+	# Portability issues
 	/\bcp\s+-a/ and err 'cp -a is not portable';
 	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
@@ -48,6 +49,9 @@ sub err {
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
+	# Coding style preferences
+	/\btest\s+-[a-z]\s+.*?\s+-a\s+/ and err '"test A && test B" preferred to "test A -a B"';
+	/\btest\s+-[a-z]\s+.*?\s+-o\s+/ and err '"test A || test B" preferred to "test A -o B"';
 	$line = '';
 	# this resets our $. for each file
 	close ARGV if eof;
-- 
2.31.1.634.gb41287a30b0

