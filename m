Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0877C433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 18:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ2SQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 14:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2SQg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 14:16:36 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5B13FF1E
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:16:35 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id c65so3656833iof.1
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RswuHlb/OIZNzqSNY90F7VQ9/NBnrT4aX1xh0IYgcv4=;
        b=xtOQbM/P7d7JpW5zF2oqI57MSO8hTcA9hcqCic75nuqwC/iJtevGvpK2kQ95x5XZCE
         uVPTa/hmi0eZ2oJbA97Mgtb9ku0F+ZHfURngdU6eJrjVhWSeKcmzZ4Cia6vVevrp1knJ
         ZeT2mT9T6yCDYsIy/n70WNgbz74WS/Hj+GXQ22kk50pD0V1zt7VRk7BbdYjaTjfAwli5
         03bNcNyIYdqarOZco1vsCF3em4Sp85YlX7cQYvrsm8/AvG+VjODFz/VGvdkRy/sBbw8l
         6xHI7o5sOLEfp443Iz1+H38C7pQOGu3iawn8h7ANNhmrQKj8N9NgMjwJ4vGfh12K0VpS
         01rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RswuHlb/OIZNzqSNY90F7VQ9/NBnrT4aX1xh0IYgcv4=;
        b=MNYB52l+a+BbJsfchSeM4Z3pAwraRDo/+LiwrniKteevhZBO0tqsm0hfpS8aV3dbJO
         ScsD8PHaXCIO/6Uylus7TvY9zOtSLp9pAOdkqL80YnmT2qzPG96t0iz25DJDFucJ8SOi
         7jBNEcWlhnUC+A/YasazpohrbnijqwM7KNib8E67ARCt18RrQJFJK15iP4lFoc2fzA88
         Rvu5OwJ4AvjsBgh9QeuUDxpwV/o0K6Rpu3aoUip9+D4v26sVD7OH2AiIWOTef+cwCoDz
         j7MwxE6pCofccTHrka+cyK9CE+XPAl4aXxItarQp42jlg2+u524fFruAR/QaRyYiBzev
         U2Xw==
X-Gm-Message-State: ACrzQf0XYJvkbVaXIsRPITEGz3dMN/PSUD/LrhJNAPHsjQF4MHS5S3m6
        zFD9WlchRvR/YjPSVMSALRopAg==
X-Google-Smtp-Source: AMsMyM7wEE1sAzv+rakPiEuVm7aQl2iXDN+lIs6+61sQInI63LztqHo+/IBE/TmKZE234qdsp2zLVg==
X-Received: by 2002:a02:c483:0:b0:375:4395:4b00 with SMTP id t3-20020a02c483000000b0037543954b00mr1985801jam.99.1667067394443;
        Sat, 29 Oct 2022 11:16:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g7-20020a02a087000000b00372d05cab42sm877877jah.23.2022.10.29.11.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 11:16:33 -0700 (PDT)
Date:   Sat, 29 Oct 2022 14:16:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/8] bisect--helper: factor out do_bisect_run()
Message-ID: <Y11uAFr/X+45kCgc@nand.local>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <033ebd37-40c7-01bc-e9bb-29d738532125@web.de>
 <221028.86v8o4aoiq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221028.86v8o4aoiq.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 12:26:51AM +0200, Ævar Arnfjörð Bjarmason wrote:
> But given the line count of some of the other changes, and
> e.g. including the free(), oid_to_hex_r() to oid_to_hex() etc. in later
> commits I don't see why we can't just make it use run_command()
> directly.
>
> I.e. I think it makes sense as one commit, but the conversion is easy
> enough, easier than looking at the same code again later in the
> series...

Hmmph. I don't think that it matters much, either way. I was initially
confused not having read the whole series, but I see what you're saying
now.

We see the same part of the diff twice here: the post-image of this hunk
to use run_command_v_opt() becomes the pre-image of a hunk in one of the
later patches to change it to use run_command() directly.

Arguably the two could be combined into a single patch, yes. Though I
find the version as written here to be clearer, since it's a
straightforward code movement within bisect--helper.

Thanks,
Taylor
