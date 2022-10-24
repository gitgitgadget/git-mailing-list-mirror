Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55B0C67871
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiJXUt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiJXUtG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:49:06 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011FC2582D9
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:56:23 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id s9so1691939ilu.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WuKvG0jKc4MNSxqXTRVCQGv/5Bi387sZiurypgbsMKM=;
        b=z9Ys9+YrZVUpnvavPXl8NlSaG+Pn4OiITMLHMkl0PUs/RjTEBdNKfl8NkjXZglgKFm
         Vqchklm+x3VnJPGHFCDRGH2VhredszC7PrJ3bjehnbVPp4cqi8LUOXoQ4qcYu3LVFi96
         6TnZawaxZ9yjizUTANi2I2W9SraL9LiyuUWMtPpNR1Wxe00tlxT+XdTyghIFtP4NwTYX
         FmX/KVQTcekhRBv5NDDmlBaazKi/6wxi1cUkR8AJSx2V6SFPq5mijkPLW2jm/KabomIa
         /K7cLTZj+B2k/c7cVbfWSt0AWEDsFfnoFHvFppxnlw74vrWkf8PHAvYkv3gBsS2wzaoH
         0xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuKvG0jKc4MNSxqXTRVCQGv/5Bi387sZiurypgbsMKM=;
        b=Mf+vOyXPl93pc6k+iBNTJ5eE7ggB3t4gXqrMRtMZgLBr8bS00OkZ5y1RPlPQO/uU7P
         g9hOiBG4udMHgwY3U96Cfe+1on7K6JP+GtgdLuul42Dww98kEZCcpb6cOferQefLan1+
         GslwQg1PRCtIt4hkwPmCMeFi0GmBNAjQmgGU21Y+SM62OgEofA6jK+X6V9x1WArSGp+W
         gCMU0tgW58YnvBYCiE/Ofsh65LgeIvH4E239fjjlHkPIUUsAdSNPleShfPenNoLacIu6
         PCLuMv+GNEvncpu1vRsYbsTZTkB1+q+QJl1VYlcR6xN+J3NP3qZ7d+uskNB5ixDSndXr
         wNEw==
X-Gm-Message-State: ACrzQf1tBdFCAtvmCTUG88IrflPCO/6tbbnqsO6/8Y6Zdo2pQxHGGmfr
        yaUxV0ZX/yfK7f+/2HcIX6ka+YFLGn4gbW1B
X-Google-Smtp-Source: AMsMyM5t83oITiVi0M5zubwp61YfZAt0xrV/AAszy/f5lKSI3FyOMgLaEO47LaTRI2cN1H2Yf+cCow==
X-Received: by 2002:a05:6e02:1a0d:b0:300:16b0:fede with SMTP id s13-20020a056e021a0d00b0030016b0fedemr2225020ild.284.1666637728385;
        Mon, 24 Oct 2022 11:55:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z27-20020a056638215b00b00349bd096a82sm89602jaj.109.2022.10.24.11.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:55:27 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:55:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 0/7] shortlog: introduce `--group=<format>`
Message-ID: <cover.1666637725.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is one more very tiny reroll of my series to implement arbitrary
pretty formats as shortlog `--group`'s, based on a suggestion from Jacob
Stopak.

There are only a couple of changes from last time: one to rebase onto
the current tip of 'master', and another to address a bug in 4/7 (which
was resolved by the end of the series, but now works consistently
throughout the series).

This was pointed out by Peff in [1], and he indicated there:

> It's hard to care too much, since the end result of the series is
> correct, and you'd end up just removing that part of the line in
> the final patch. So I could go either way on re-rolling.

...but not re-rolling would be somewhat unsatisfying. So here is a
reroll that I think should be good to go.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/Y1M5OH%2FFiWNaKO6p@coredump.intra.peff.net/

Jeff King (1):
  shortlog: accept `--date`-related options

Taylor Blau (6):
  shortlog: make trailer insertion a noop when appropriate
  shortlog: extract `--group` fragment for translation
  shortlog: support arbitrary commit format `--group`s
  shortlog: extract `shortlog_finish_setup()`
  shortlog: implement `--group=author` in terms of `--group=<format>`
  shortlog: implement `--group=committer` in terms of `--group=<format>`

 Documentation/git-shortlog.txt |  8 ++++
 builtin/log.c                  |  1 +
 builtin/shortlog.c             | 87 +++++++++++++++++++++++-----------
 shortlog.h                     |  5 ++
 t/t4201-shortlog.sh            | 39 +++++++++++++++
 5 files changed, 113 insertions(+), 27 deletions(-)

-- 
2.38.0.16.g393fd4c6db
