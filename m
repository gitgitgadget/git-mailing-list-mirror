Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051AAC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D946120A
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhIIO40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhIIO4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:56:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84624C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 07:55:16 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a13so2647375iol.5
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tN2cf5ZdPCsbcehG/aSzNvvf7WJTQqsYtxu/6hRZZr0=;
        b=vxkwKaR1sLf6snhqyVcuKPPzGEBJYaax3mhOMlaIObAhPOSImQS/WqU7DOvVLA/wOE
         /1zh7ajS9Plr5YET/8BCDNquBkTLGdKsuxoAPM+8FLUM7A9JBnJPDEaWkXQan7XMJQUQ
         KVR+NOcXdEfW1Ee5YLuzzPGEPMy8J8DRiA8sYnU1f68bzAyS3eNaadF+89pXIUua3Far
         r5zL/FOgSfjct4DNmTU+7Oa1nrLk/UItvTjGOPceVvcBB61BuQ/RUk2xLn/2EYZbEMvv
         k5766Clf/4f7SCrijFaT3mEIMSJe7ctJ+D1KQ/WJu/gYcauXv2dbZA4nRkZiQ4TSVK6r
         aKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tN2cf5ZdPCsbcehG/aSzNvvf7WJTQqsYtxu/6hRZZr0=;
        b=zY0EQ3WOkT1P9nGAPXm2mKyx0FXnJJjBCaFnxhvk+sF4PTF1dgmHpj1Qx8ety76Ojz
         1lUmCLPUxMDq+KC5LVy12bESFP8WBmadzH0+3xt9stpxtxJdV4g8BEZY/TGW17Rs4rs+
         uFCeA5Qw13xvJWSQ8nZlt3ufzILXIeosH8DUx0vZ7JXOea2mlqAD2wKP6meliDcrG1uv
         bAl5z978YjiCJmUC6icIu8lgSxMGobmjJ6g1pOGy9pBPijYfnK4qMQBSYAJOU+pJqf2P
         IZ0SkUjuP5eLOkmAXqRf4Os2esaFpnFT68DE1EhRiPhp7hhd95v3TIeQOOmLcllRIfmX
         xJvA==
X-Gm-Message-State: AOAM532QbN7ddC2+M9N0qUOWMjNo/k3Jak2WrpgZ08D9bO1QD3zoQie3
        +nznM27wmKUAiNJ2UPjGbmq7vA==
X-Google-Smtp-Source: ABdhPJy72cEVOuXMVr5p+tM61cr+IIFPcjBCS44+Gjo4wXGOYxd220yTghWU5dOPmykwYWC9a0QG3Q==
X-Received: by 2002:a6b:b883:: with SMTP id i125mr3061997iof.144.1631199315992;
        Thu, 09 Sep 2021 07:55:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b10sm983101ils.13.2021.09.09.07.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:55:15 -0700 (PDT)
Date:   Thu, 9 Sep 2021 10:55:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/4] midx.c: respect 'pack.writeBitmapHashcache' when
 writing bitmaps
Message-ID: <YTogUpdtjsFlbqYM@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
 <874kavkfjg.fsf@evledraar.gmail.com>
 <YTgfuAKJv1rXXm7i@nand.local>
 <87zgsmdu6d.fsf@evledraar.gmail.com>
 <87v93adr8r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v93adr8r.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 11:34:16AM +0200, Ævar Arnfjörð Bjarmason wrote:
> In similar spirit as my
> https://lore.kernel.org/git/87v93bidhn.fsf@evledraar.gmail.com/ I
> started seeing if not doing the flags via getopt but instead variables &
> setting the flags later was better, and came up with this on top. Not
> for this series, more to muse on how we can write these subcommands in a
> simpler manner (or not).

Sure, I think that everything you wrote here is correct. I don't have a
strong opinion, really, but one benefit of not manipulating a single
'flags' int is that we don't have to do stuff like:

  if (git_config_bool(var, value))
    opts.flags |= FLAG_FOO;
  else
    opts.flags &= ~FLAG_FOO;

and instead can write `opts.foo = git_config_bool(var, value)`.

Of course, the trade-off is that you later have to turn `opts.foo` into
flags at some point (or pass each option as an individual parameter). So
nothing's free, and I see it as a toss-up between which is easier to
read and write.

> I may have discovered a subtle bug in the process, in
> cmd_multi_pack_index_repack() we end up calling write_midx_internal(),
> which cares about MIDX_WRITE_REV_INDEX, but only
> cmd_multi_pack_index_write() will set that flag, both before & after my
> patch. Are we using the wrong flags during repack as a result?

Only the `write` sub-command would ever want to set that flag, since we
don't support writing a bitmap after `expire`. So that part seems right,
but perhaps there is a another problem you're seeing?

Thanks,
Taylor
