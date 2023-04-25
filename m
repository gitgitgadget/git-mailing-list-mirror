Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2BEC6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 21:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbjDYVCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 17:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjDYVCq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 17:02:46 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34AA26A8
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 14:02:44 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fb6ac1e44so75071807b3.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682456564; x=1685048564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3N2uVL9bnYt16hrz4afzwVL4T9d04czTMuFGsgm/uEY=;
        b=vTcKX6MJ/9wQ3MeRYuEZDtYMQU54FwEsarZbasgJCu9fuvXCTQevLOPD6TFQDytHrm
         /nGrRG1pSEf909mOSgZ41tHD+XQRkLRP4sRY2FjeIsb8AkFm4SgURmwRsiwLschObYTK
         K/Iv75vSReaBPU10f2VOQD6ullUfzhVCDvjtUPK+j/qanYSPpFhequABoaqoQjoenPyd
         cM7eq+8WF5uqXkh8BXMoE49/D5vah2Un4gZ1/AwGVsEQgTNgAVngFVzw3NQlubnf3h1J
         XqZzxBKBU5scVpPCFgV2XTBN9mrUZWFXDXJYY6csppL7SZ+aWRwjNy44cYHNL8bd+47w
         +J1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682456564; x=1685048564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N2uVL9bnYt16hrz4afzwVL4T9d04czTMuFGsgm/uEY=;
        b=CiXa6LExNSDvkVU5iCuZFlQNiX9TRhkCf0CFwnAa4c2ZRL6rK2w/gDIzUqSFHZFyka
         WPCCEp+j45phTGxdovWrS8ZrF9RiRRzXl6ZE9CgZypRD+jLg6zH4Q3iUPjsIzNnohUVw
         sxv2l5chkv0GNs8/ceGwJiET7oRiCvgemjpgcLKq5/tV1LnKL/AlPIfXGcqGREIw24QB
         YgILHrIdVcGgF5H2KpO7l/iUQQMyfc+4OA1uUlFPN9wp6Y56tr9IC9V0O8C3l8vu0YVi
         Z7RG1N4uxXHqo33b8OcJ0FpX2To0NHzfDedYFpdoqVcGGO4eaHnrmkuUoUpqzEsPvdzl
         tkHw==
X-Gm-Message-State: AAQBX9em2PwHaHlepPrl07UFpuU4lpToAKkM89lPfiim9eGOFhhTne4h
        UdrJwIyXqnAtMDGptj6Yc6A4xmEV0WjtFejAJrhI2w==
X-Google-Smtp-Source: AKy350aF+j82Zfutl7vm0aLAwrn46ELenSValCfh5wWl/U2q36wuRHOFOIS/rZuPTL/fL2w8hVqkeg==
X-Received: by 2002:a0d:ccd0:0:b0:541:8735:171e with SMTP id o199-20020a0dccd0000000b005418735171emr12988677ywd.11.1682456563784;
        Tue, 25 Apr 2023 14:02:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c125-20020a0dc183000000b0054f8b1f21e5sm3783235ywd.85.2023.04.25.14.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 14:02:43 -0700 (PDT)
Date:   Tue, 25 Apr 2023 17:02:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 6/6] banned.h: mark `strtok()` and `strtok_r()` as
 banned
Message-ID: <ZEg/8klMmHyJrdrj@nand.local>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
 <da896aa358eab65f2629f85189c5be4ad9cec635.1682374789.git.me@ttaylorr.com>
 <20230425062617.GB4061254@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230425062617.GB4061254@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 02:26:17AM -0400, Jeff King wrote:
> On Mon, Apr 24, 2023 at 06:20:26PM -0400, Taylor Blau wrote:
>
> > string_list_split_in_place() is not a perfect drop-in replacement
> > for `strtok_r()`, particularly if the caller is processing a string with
> > an arbitrary number of tokens, and wants to process each token one at a
> > time.
> >
> > But there are no instances of this in Git's tree which are more
> > well-suited to `strtok_r()` than the friendlier
> > `string_list_in_place()`, so ban `strtok_r()`, too.
>
> For true incremental left-to-right parsing, strcspn() is probably a
> better solution. We could mention that here in case anybody digs up the
> commit after getting a "banned function" error.
>
> I'm tempted to say that this thread could serve the same function, but
> I'm not sure where people turn to for answers (I find searching the list
> about as easy as "git log -S", but then I've invested a lot of effort in
> my list archive tooling :) ).

Personally, between what's already in the patch message and this
discussion on the list, I think that folks would have enough guidance on
how to do things right.

But if others feel like we could or should be more rigid here and update
the commit message to say something like "if you're scanning from
left-to-right, you could use strtok_r(), or strcspn() instead", but TBH
I think there are a gazillion different ways to do this task, so I don't
know that adding another item to that list substantially changes things.

Thanks,
Taylor
