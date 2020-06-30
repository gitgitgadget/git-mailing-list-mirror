Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9A9C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 18:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6B8206CB
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 18:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Xp0B01Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgF3Sjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgF3Sjb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 14:39:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D439FC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 11:39:30 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j10so16371802qtq.11
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2pt/FJQKnKNHJoL+vEqGMC1FKMVBRIQ7RwqeT89swNA=;
        b=Xp0B01Je0PRfSRz0ACukkdmXCGuz3GNWcabkml3Lqtg5wrLOmx+aqCyxCYtUkxqBmN
         r60AZoo/SCaRnJFd9rfJ3m7NcCnPPO5VxvGWS2EJ7tH0b2BEmOtedFdqQk9rMrIjWKsa
         DMTfLLRJOtuM9myGutW/qz2QX2Z5TlEmpWyrKlBXgtsToClt2e/DYHbCdAAEqtlhliCe
         n+T3w6FyjjzrH+JI0fkP0xh8fUweaTW49Y2v56No5jVrKwtVTFvZoLRe9y5qJ30Tm6ny
         uUN9v4US0Gl7530px81oFpRLw3rKe/JXE801mkOj+P8qn/e92ob91hLq6Wo3nAYoYtg9
         6Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2pt/FJQKnKNHJoL+vEqGMC1FKMVBRIQ7RwqeT89swNA=;
        b=q08qte3BD1Dc1y7YMIfz4ebLVNdlXEVuovLLhTfMcgFFsuwfACkvCFV6v8E8XK/v9/
         RB/aLIymO3u9N9esIDUJEwPpsogpg5W6Faxbx/GQvnPL7R4x99125pF2Pt1VLrfNmfCQ
         P72V3oOehyESgL32dxc+DsUVJ9EaSG+gnBaH+22yl82PUCzT30R0qwvccZpHbBgeY2+K
         WyV7Ygt+pljc2+QPbSijSWHp2HkCbZwYdE23UOX5SxSx57U/dpfTDI5kUSFD0cbSQKjS
         w8+xvISmpz8ffFmeanekkuz+Jpm2YQzxUN7RNE73zjMfo2xTXLqcQLlYtnVcxv7f1KFa
         fdVA==
X-Gm-Message-State: AOAM532UZRtAzy6a5+Y8kws7J+jpYm9s6+KC+1QUfGy7VN9V2hoMVSc0
        kuYIQFqPdycV8P15iSvG8jP9iw==
X-Google-Smtp-Source: ABdhPJzKcEhzIqXWZXCS+jYJeurluHItmGTPANnFy30motoFiicB2pP4qIb7H4GFfkngoEKa2dnu5Q==
X-Received: by 2002:aed:208c:: with SMTP id 12mr22417843qtb.286.1593542369950;
        Tue, 30 Jun 2020 11:39:29 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f0ef:6367:5d8f:d7c])
        by smtp.gmail.com with ESMTPSA id n143sm3536396qkn.94.2020.06.30.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:39:29 -0700 (PDT)
Date:   Tue, 30 Jun 2020 14:39:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] t4216: fix broken '&&'-chain
Message-ID: <20200630183928.GB26550@syl.lan>
References: <cover.1593536481.git.me@ttaylorr.com>
 <5a20a97658fa8e6c874c9c9cafb2cf49e39f94d6.1593536481.git.me@ttaylorr.com>
 <CAPig+cQv3cHe5ci3mDvNKYXbVQt6Rp5icG-woaDCqfAtzZ6SZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQv3cHe5ci3mDvNKYXbVQt6Rp5icG-woaDCqfAtzZ6SZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 01:50:22PM -0400, Eric Sunshine wrote:
> On Tue, Jun 30, 2020 at 1:17 PM Taylor Blau <me@ttaylorr.com> wrote:
> > In a759bfa9ee (t4216: add end to end tests for git log with Bloom
> > filters, 2020-04-06), a 'rm' invocation was added without a
> > corresponding '&&' chain.
> >
> > This ends up working fine when the file already exists, in which case
> > 'rm' exits cleanly and the rest of the function executes normally. When
> > the file does _not_ exist, however, 'rm' returns an unclean exit code,
> > causing the function to terminate.
>
> This explanation makes no sense. Since this command was not part of
> the &&-chain, its failure would not cause the function to terminate
> prematurely nor would it affect the return value of the function. This
> explanation would make sense, however, if you're talking about the
> behavior _after_ fixing the broken &&-chain.

Fair enough. For what it's worth, this explanation *does* make sense if
you 'set -e' beforehand, which I am accustomed to (and had incorrectly
assumed that tests in 't' also have 'set -e', when they do not).

I've corrected the patch and shortened it to account for your
suggestions. Mind taking a look at the updated version and telling me
what you think?

--- >8 ---

Subject: [PATCH] t4216: fix broken '&&'-chain

The 'rm' added in a759bfa9ee (t4216: add end to end tests for git log
with Bloom filters, 2020-04-06) should be placed within the function's
'&&'-chain.

The file being removed may not exist (for eg., in the case of '--run',
in which case it may not be generated beforehand by a skipped test), and
so add '-f' to account for the file's optional existence.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c855bcd3e7..0b4cc4f8d1 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -53,7 +53,7 @@ sane_unset GIT_TRACE2_PERF_BRIEF
 sane_unset GIT_TRACE2_CONFIG_PARAMS

 setup () {
-	rm "$TRASH_DIRECTORY/trace.perf"
+	rm -f "$TRASH_DIRECTORY/trace.perf" &&
 	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
 }
--
2.27.0.224.g4cfa086e50

