Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0811C4332D
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 21:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76E420773
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 21:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="kYT3IZKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgCRVSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:18:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40546 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRVSE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 17:18:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so52068plk.7
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bCyElMO+KY2WhvP/wkVXWMT1fAtusrCMShhrKf2Q+dc=;
        b=kYT3IZKUkLoHWXtTaXBoVIQVtpH61qljJGNzRsG5+0tLI1KtOv5EXEcnsAlsKTTa+C
         SFBZ76Am51bDdTaeQjJcadpa0C587rk8uD5jqo3oATqJx8fZLMwsZlFru/DXP1JTxV9V
         svdsvmtQ7DxWgA9hbMLUeYGqHL67Y9tp9yrmRgQYiiRiCV463U+OqENJQZDU4fUM5IYl
         a6xOVlzQKtWzJXfhwrZarY28IOZIC3s7Ml1uy4mnYsg1SfMy/NC2ZfkFPbf+PoeE5nWB
         oLP09bEFGtCItVo0psNxELvV5Nm/b03549+d+r6QWDHTVs7lgQCgDI/gzU613deyQiQn
         ZQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bCyElMO+KY2WhvP/wkVXWMT1fAtusrCMShhrKf2Q+dc=;
        b=JEdpYvkO8xq2OPNC+ApEulQy2EEZ69RXXSTSnT1qlW7XxHG1FSwJcaj3z2bS0XJBMY
         cMCyyDRMfgkvdpIVUIrsI1FC3wYR1Af1kA4CFanINn6vZEb/51FwlGOMdG53r5LesyZq
         PpbKeY6wqgsATzLN5qL5eQsQPAq3Z42FtUrzU+/MBSDr+9g1H9R3u9sdSXLc1+PxTNQ1
         OOXG+DPpgPPSlJd0GCwlDtXsMFlm8+0XFr+gcZtTtYnh7Iyk3gxCGT6vN8OzLEXeWtYY
         iJsNdMvxkSlQrWG03Qfbev1/0KsNBoDaYYpTOdX0Mg5EKQYOUOLPDxb0o1mPSZgqS/GS
         BpCg==
X-Gm-Message-State: ANhLgQ0Ag+5ygzZfeKIdgXIcoLS5cXjF7A2DBx1s/qnKppzkRgFZMOVQ
        r6zJJD9LzNX9sY/KcgI4EVu4uw==
X-Google-Smtp-Source: ADFU+vsNkr2LiV0R04TGHQhLxjJbrLU0YE8giT9WGrheYPVsXSvi1LKhOCOusU2fSR61sX2wTqgCdQ==
X-Received: by 2002:a17:90a:1f4f:: with SMTP id y15mr135009pjy.59.1584566283185;
        Wed, 18 Mar 2020 14:18:03 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id p8sm597pff.26.2020.03.18.14.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:18:02 -0700 (PDT)
Date:   Wed, 18 Mar 2020 15:18:01 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, james@jramsay.com.au
Subject: Re: [RFC PATCH 2/2] upload-pack.c: allow banning certain object
 filter(s)
Message-ID: <20200318211801.GC31397@syl.local>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <888d9484cf4130e90f451134c236a290a6c5e18d.1584477196.git.me@ttaylorr.com>
 <CAPig+cRgnqmwCCjFV32K_ysawHBkJN_y6=Do_oKXjjpy0BSvUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRgnqmwCCjFV32K_ysawHBkJN_y6=Do_oKXjjpy0BSvUQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 17, 2020 at 05:11:42PM -0400, Eric Sunshine wrote:
> On Tue, Mar 17, 2020 at 4:40 PM Taylor Blau <me@ttaylorr.com> wrote:
> > NB: this introduces an unfortunate possibility that attempt to write the
> > ERR sideband will cause a SIGPIPE. This can be prevented by some of
> > SZEDZER's previous work, but it is silenced in 't' for now.
>
> s/SZEDZER/SZEDER/

Thank you for pointing this out, and my apologies to SZEDER.

> > diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> > @@ -235,6 +235,29 @@ test_expect_success 'implicitly construct combine: filter with repeated flags' '
> > +test_expect_success 'upload-pack fails banned object filters' '
> > +       # Ensure that configuration keys are normalized by capitalizing
> > +       # "blob:None" below:
> > +       test_config -C srv.bare uploadpack.filter.blob:None.allow false &&
>
> I found the wording of the comment more confusing than clarifying.
> Perhaps rewriting it like this could help:
>
>     Test case-insensitivity by intentional use of "blob:None" rather than
>     "blob:none".
>
> or something.

Sure, your suggestion does clarify things. I'll apply it to my fork.

> > +       test_must_fail ok=sigpipe git clone --no-checkout --filter.blob:none \
> > +               "file://$(pwd)/srv.bare" pc3
> > +'

Thanks,
Taylor
