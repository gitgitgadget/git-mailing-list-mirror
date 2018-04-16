Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792931F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDPWl3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:41:29 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38735 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeDPWl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:41:26 -0400
Received: by mail-wr0-f195.google.com with SMTP id h3so17626848wrh.5
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hguPNllHob7XhEyV/qywMproLGU2/7pPr7HVaDfgPok=;
        b=NwtQ+Q/xKtNAAYAJ9rg8qfols2EL9uUQLo0wwp0lFYPJpC9Ae/FvSwBWHWLqETxSby
         xtdA4c7R6KOZQT3+Ptvs1KOzd1PKdVyDAQNigjUrfBwEyqgVnF2hRFH24E5kNjlCVfEy
         cD8OKBSWjVrye0x482xO0ldlTMy03YZLk2GUIpjL6KtuI5HwjFwS+BoLSbUdKvpqvxO1
         Q58rFSmNhUBtaT/p61Gsy9aibHdErKkvonQChxcHB2ABHt9pWIltuiXDLEMkvwI4B9q0
         ocioxtFMBxyQlWnC9lVe54LEVLsWfEEtKxoF0HO+a9UKlPedjBPMBAHd8hiZsCuxY1J/
         kYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hguPNllHob7XhEyV/qywMproLGU2/7pPr7HVaDfgPok=;
        b=cChHRtDMsZ5brt45wS6bh3QuwhvaUnIphmbzVJwsaLoFrpD+Ay4Q5Rue4AGD6exf+U
         q6dEOd6pojq5V1xMYdYjmMOPfCGYWyzugbGfvqfctN0lpXPdBSUsyBDm6kYdX7HBpf/d
         jXF7t9+1S0+N/uYuxpYTCwkWZhZ0Dpi/8TIibjDCFOYgtOgVDVcQQ7gn8VWlQ5zylB1k
         UhGP+ZVLTHzsP8XGgOlO3yCNIyVFN2U+Ba9rqS2dgUTgaOBJR9bPla9RwXTwvblbo80v
         GHhUz8qAwNwTIlTXPmdbrtAm86t9a+nv23p8IGfiZVCOKNa12n0heH38NNkPpF5e19w+
         N+/g==
X-Gm-Message-State: ALQs6tCFbwath2BdPHNgfXaOXRvFH5gkWMpGbV+lPciuQAlONGTbKR2b
        d/zXSyzsqGs/LEeHNTvKK6L8Cw==
X-Google-Smtp-Source: AIpwx4+09sZWvj5v4WsZTUprNlDwMSUfS0ioP7HGaFpKhi2t439Upuc6mu/SUXt248f6Ge5AvfxZdQ==
X-Received: by 10.28.228.130 with SMTP id b124mr76441wmh.100.1523918484907;
        Mon, 16 Apr 2018 15:41:24 -0700 (PDT)
Received: from localhost.localdomain (x590d89db.dyn.telefonica.de. [89.13.137.219])
        by smtp.gmail.com with ESMTPSA id p128sm14977788wmd.45.2018.04.16.15.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 15:41:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 04/11] completion: support completing non-ASCII pathnames
Date:   Tue, 17 Apr 2018 00:41:08 +0200
Message-Id: <20180416224113.16993-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <20180416224113.16993-1-szeder.dev@gmail.com>
References: <20180318012618.32691-1-szeder.dev@gmail.com>
 <20180416224113.16993-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unless the user has 'core.quotePath=false' somewhere in the
configuration, both 'git ls-files' and 'git diff-index' will by
default quote any pathnames that contain bytes with values higher than
0x80, and escape those bytes as '\nnn' octal values.  This prevents
completing paths when the current path component to be completed
contains any non-ASCII, most notably UTF-8, characters, because none
of the listed quoted paths will match the current word on the command
line.

Set 'core.quotePath=false' for those 'git ls-files' and 'git
diff-index' invocations, so they won't consider bytes higher than 0x80
as "unusual", and won't quote pathnames containing such characters.

Note that pathnames containing backslash, double quote, or control
characters will still be quoted; a later patch in this series will
deal with those.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++--
 t/t9902-completion.sh                  | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 72cd3add19..7072555960 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -369,10 +369,12 @@ __gitcomp_file ()
 __git_ls_files_helper ()
 {
 	if [ "$2" == "--committable" ]; then
-		__git -C "$1" diff-index --name-only --relative HEAD
+		__git -C "$1" -c core.quotePath=false diff-index \
+			--name-only --relative HEAD
 	else
 		# NOTE: $2 is not quoted in order to support multiple options
-		__git -C "$1" ls-files --exclude-standard $2
+		__git -C "$1" -c core.quotePath=false ls-files \
+			--exclude-standard $2
 	fi
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index ff2e4a8f5f..a4f2c03b93 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1463,7 +1463,7 @@ test_expect_failure 'complete files - quoted characters on cmdline' '
 			"New(Dir/New)File.c"
 '
 
-test_expect_failure 'complete files - UTF-8 in ls-files output' '
+test_expect_success 'complete files - UTF-8 in ls-files output' '
 	test_when_finished "rm -r árvíztűrő" &&
 	mkdir árvíztűrő &&
 	>"árvíztűrő/Сайн яваарай" &&
-- 
2.17.0.366.gbe216a3084

