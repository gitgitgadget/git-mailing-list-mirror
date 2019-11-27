Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81440C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5964820862
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGhC0dTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfK0T24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:28:56 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40290 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfK0T24 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:28:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id i187so7385468pfc.7
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/B9q4K+YKJneFC5VT+2PF/WAYwgMsXghLgInB403IEk=;
        b=fGhC0dTae3yukiYITiDzSuTwrjMPKdC8G2tJHV+hFgi2tXkjeCT9M4vxCQkzDd8SkH
         7Hq4Us2mK74vs3rwKux/j1LILf83YU/EO8eJsIij/79bxlYbn/bnDHomS1ZUr4FZGLH3
         /kGj/29fQTcFXHZDhOI5dYEVVu91mvamNjfBcF8JJDR3DO5q7lMG9b2DTZcPwTpvCetx
         LhRUZ4XVB8ZdpAmfX1Yq81PMuxUKynr4DA60koVu+v7103Y+DLfc4tzyukH14gH06+t5
         Y5oKq2/ptd9xcqQgWC2YedabTaKZnbKl5jDc5DpRh383hu+Mb01HjMhgNXpF4iKTA248
         lPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/B9q4K+YKJneFC5VT+2PF/WAYwgMsXghLgInB403IEk=;
        b=DO3PrCuSd5YbVmB+wKBqHrfaZ/40NzFEp35x3GkKl/DygoWyFPHahYVbQ6QGuTgu3b
         bbbniiA80Rjhh8V91NQhi7K/VWNE8+A9wMgAW+fMYaRn8QH2HH00yu0HWrhiEm2NnLUa
         pDUYxBszE6txDXWyj3y3FtY46sVF5ua7kNMWo9uTADm4EM67Hz9J3+B9URYklU1aXVnh
         NCiD86CX69khKZkRO//0M9ubjo5GwoXCZ8NskM9Nutpp7i765pabx/2sCBjR59uQOQJ8
         57mEG8zF6TInkIROSBVizAyfLGlHFSL9vWo37MPaXWempZ2tMR7WBvNrwxTr+7CFjMV4
         NPUg==
X-Gm-Message-State: APjAAAXOd0QGvf68pjNBEww+Z/Cx9RAHx2fkgqht7VRHMjdsp3P6ztdr
        cbbA2O5l889XUmZz0WhqxXsidod4
X-Google-Smtp-Source: APXvYqwCgu5jkfZiomhq6QfYcEtQvRif5znL+pBo+xomSrOp70/XRIofnV/xSBlxSrmnFDkTQ9Pscw==
X-Received: by 2002:a63:3e03:: with SMTP id l3mr6939576pga.118.1574882935013;
        Wed, 27 Nov 2019 11:28:55 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id b5sm7704863pjp.13.2019.11.27.11.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:28:54 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:28:52 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: [PATCH 0/2] Hi Peff,
Message-ID: <cover.1574882812.git.liu.denton@gmail.com>
References: <20191127125231.GH22221@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127125231.GH22221@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for doing this. Perhaps while we're at it, we want to change all
of the MARC and Gmane links as well? The series below does this.

I've based my series on top of yours so if you need to do a reroll, feel
free to pick my changes in.

Denton Liu (2):
  doc: replace MARC links with LKML
  RelNotes: replace Gmane with real Message-IDs

 Documentation/RelNotes/1.6.2.txt    | 2 +-
 Documentation/RelNotes/1.6.3.txt    | 2 +-
 Documentation/RelNotes/1.6.4.txt    | 2 +-
 Documentation/RelNotes/1.6.5.txt    | 2 +-
 Documentation/RelNotes/1.6.6.txt    | 2 +-
 Documentation/RelNotes/1.8.4.txt    | 2 +-
 Documentation/RelNotes/2.5.0.txt    | 3 ++-
 Documentation/RelNotes/2.8.3.txt    | 4 ++--
 Documentation/RelNotes/2.9.0.txt    | 2 +-
 Documentation/git-bisect-lk2009.txt | 2 +-
 Documentation/gitcli.txt            | 4 ++--
 Documentation/user-manual.txt       | 4 ++--
 t/t6021-merge-criss-cross.sh        | 2 +-
 13 files changed, 17 insertions(+), 16 deletions(-)

-- 
2.24.0.504.g3cd56eb17d

