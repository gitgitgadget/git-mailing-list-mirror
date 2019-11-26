Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A290C432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603002068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNCxpsLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfKZBSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:43 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:35661 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfKZBSm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:42 -0500
Received: by mail-pg1-f175.google.com with SMTP id k32so8117392pgl.2
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rpHaKGXuO/05++wvjv7ooAjJAPFVn1DZljz2cVHI8ao=;
        b=PNCxpsLNc5IpLcFtZKcSzJwh/yibmx6NjhZoevaxqRbjYnoS7SYfyizLI+dBDtmdDu
         55+6YbFm4j/8DywBTomE8mHhGO0XM2VMvrDPolJln7wR+ZlRskekzT1JFB0jlz61kw86
         L4y8fi/SmPc1SZbl316X9T43EvhEGg/RFauqO6q9QBVjipl0uRgcvGbFzaetaocCWqSc
         4xVUSHTFuTUETTw4hg7MSlg0vlB4m33KyoUeh50nCBdJr64nMB8UMh6PgtMmFYD6lwFt
         Tbr075dHETUCGNvZhYVL63k7HfQA2+M0+jMjEcueJW6Ln3nEtmTh+aavOwXRGUWgBlc0
         RF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rpHaKGXuO/05++wvjv7ooAjJAPFVn1DZljz2cVHI8ao=;
        b=dgTJ7tUmudT+7okb4y3frKEODcU0ae9bW7ArIoCfydfoPzeuSqrHto/iu3kEJXI6ib
         C4/ncDUj0JHFJH2flz9nPQt+BHBFqdcHqySCFjuQa1BNTefFG7C19wCEch9GEI3chEXC
         dPQXO9WFUheHtq3iOwONRV/Yz4988Fnt4SNI7FEE7fABArXgRXDdlYDM7Qx3CRVP4Url
         Y3qJHRygLvtBcAmQYTEJTS+Kn2CRd6iVvk26pMADXV2DdMmQnTPc8rjazEcf4gjCFbSp
         e7Eylwo+ncqVogbHQ0mJgJPMyzb9kuVLboXFNrFbs5nOTZX0tKp3R8BybRhQO/bpsqv2
         FDzQ==
X-Gm-Message-State: APjAAAWF35XmaIgWVRKETcm6VUs7gssGTnVSfm3rHtoOliv3UxoRIN0A
        z94dbQba8jX0tEam6BElpZ712qwI
X-Google-Smtp-Source: APXvYqygb6ClzTzYabxCdbHez/BcTLLR+Z2oCYbd4P+L27BWpCe4r++y33j9KI8TCWQX3IxImwaQMA==
X-Received: by 2002:aa7:9787:: with SMTP id o7mr38515742pfp.120.1574731121546;
        Mon, 25 Nov 2019 17:18:41 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id r16sm9891169pgl.77.2019.11.25.17.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:41 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:39 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 23/27] squash! t7700: consolidate code into
 test_no_missing_in_packs()
Message-ID: <e4ba198483b5501bdc719843470cf685ca4079f1.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of verifying each file of `alt_objects/pack/*.idx` individually
in a for-loop, batch them together into one verification step.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    We should probably squash this in but before we do this, I'd like some
    confirmation that doing this doesn't have any negative impacts.

 t/t7700-repack.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index a6c3d34277..4bcd9fcc80 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -13,12 +13,8 @@ commit_and_pack () {
 test_no_missing_in_packs () {
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
 	test_path_is_file "$myidx" &&
-	for p in alt_objects/pack/*.idx
-	do
-		git verify-pack -v $p >packlist || return $?
-		grep "^[0-9a-f]\{40\}" packlist
-	done >orig.raw &&
-	cut -d" " -f1 orig.raw | sort >orig &&
+	git verify-pack -v alt_objects/pack/*.idx >orig.raw &&
+	grep "^[0-9a-f]\{40\}" orig.raw | cut -d" " -f1 | sort >orig &&
 	git verify-pack -v $myidx >dest.raw &&
 	cut -d" " -f1 dest.raw | sort >dest &&
 	comm -23 orig dest >missing &&
-- 
2.24.0.504.g3cd56eb17d

