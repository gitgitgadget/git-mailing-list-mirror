Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FB3C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 23:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiCCXaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 18:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiCCXau (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 18:30:50 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F15107A80
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 15:30:04 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q8so7716803iod.2
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 15:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kbOPKXE7uy/I7ESqnrkJXzywBlpOhUFXk+fizf7ITFY=;
        b=Ro8necfv8c6rpkqeI3DLAM597Di5hmVxsVihMaa/DLx3W5MJkXJ2zh8+dgGo8AMY86
         iijkcpplTvMpWdKiy/xSBSvjWC2LYC3xcANZAFhNAYDDbP2fzNZnHM0z/iErvrmGPt/q
         Pi38+G+fFZI+J8B4JVOdmZrqBt2ME3B1W2R4lIwdCCl/2P+8d2k+2EaXhGQUdjPFQqV/
         a7/5hODfHlRChT/5lsNBJNT2kcLOwteV5m3Eawk1XY06O74aZWCDnQSQu/k434nPDnMG
         rQATl9k+RVcXgIej3yYAydlmP//6uhsCzYHbypaz/DUDxshiRuZb8JVx/9UX4OzmsowJ
         A7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kbOPKXE7uy/I7ESqnrkJXzywBlpOhUFXk+fizf7ITFY=;
        b=cwYtxAGbC84Zn8jZ+E77kNVmg8synpimkNlxNk9kWc3CvuuQiCktKQg2svhroVjj7s
         l3K3H7G/AAz2XlUfJOPS0VDqKe8LfRWHxWiKUI6bmU5y2V+5LG0eGJXJtESKZgwdKxrl
         QHOpyprdFPYXuMICgiRriV81ZC584zxUNjiLrvLwKv6Ze/IoSecQvu4J77i+8LpJ9zkN
         gZLHWXNMRTrVJopk4M6UTacazyVrgy8orPHtofulhAUp2Ac0XDfJPUP5YyAJig3qAvgF
         +OidIgXplYXYnh+AmAIIxRP1MMCFSvGD7RRaMxx1drnqSMwSSeQLvtt1jgDZKaxTPR1Z
         B20g==
X-Gm-Message-State: AOAM532/xD4Emthy6KwcbDDKLosswGXj5+EVRCGMPh4NKQASNtKpLJ0v
        wDTSvfW6/AOSV0AYd0v2eMefnw==
X-Google-Smtp-Source: ABdhPJys2UnITPKrYrW/5quMVgj20m4bFS9ijsGEHBXm2gT//v/nCemmR456kXEg2FU0MAkK2YIFAg==
X-Received: by 2002:a05:6638:381b:b0:314:8258:39d4 with SMTP id i27-20020a056638381b00b00314825839d4mr30868828jav.172.1646350204097;
        Thu, 03 Mar 2022 15:30:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s12-20020a92cbcc000000b002bd04428740sm3348222ilq.80.2022.03.03.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:30:03 -0800 (PST)
Date:   Thu, 3 Mar 2022 18:30:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, derrickstolee@github.com,
        avarab@gmail.com
Subject: Re: [PATCH v3 2/2] builtin/remote.c: show progress when renaming
 remote references
Message-ID: <YiFPep6PU/7wcEQH@nand.local>
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <cover.1646346286.git.me@ttaylorr.com>
 <d5b0a4b71027619123b7284611692d3a9c128518.1646346287.git.me@ttaylorr.com>
 <xmqqk0da7hdb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0da7hdb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 03, 2022 at 03:20:48PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Instead of a more complex modification to the ref transaction code,
> > display a progress meter when running verbosely in order to convince the
> > user that Git is doing work while renaming a remote.
>
> Is it still "when running verbosely"?
>
> I thought that tying this to --[no-]progress was the whole point of
> iterating another round.
>
> 	... when the standard error output is connected to a
> 	terminal, so that user knows Git is not completely stuck.

Ah, I glossed over this (stale) reference to the verbose option. I'm
almost willing to let it go, since it doesn't mention `--verbose`
directly, but happy to change it, too.

> > This is mostly done as-expected, with the minor caveat that we
> > intentionally count symrefs renames twice, since renaming a symref takes
> > place over two separate calls (one to delete the old one, and another to
> > create the new one).
>
> That's a nice note to leave here, as it is a bit tricky to reason about.

Thanks, it's the sort of thing that I'd hope to find in a commit message
if I were confused about something.

> Do we already have an entry for the --progress option in the
> description part of the documentation?  I think the way progress
> works in the context of this command is pretty much bog-standard
> one that we may not have to, once the user has seen how progress
> options work elsewhere.
>
> If not, then we'd want something like this squashed in, perhaps?

I like the suggestion, but I agree it's probably not necessary since
this usage is standard. I thought I had written something explaining the
option explicitly in this section, but apparently dropped it when
preparing this patch. Ugh.

Thanks,
Taylor
