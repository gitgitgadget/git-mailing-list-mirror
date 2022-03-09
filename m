Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ECDC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 21:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiCIV7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiCIV7J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 16:59:09 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C247639F
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 13:58:09 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id h7so2501813ile.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 13:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=snjG07+mTq8p1iTP0hJv2AhHjqZkcdEN4VgQYZ5k8cM=;
        b=eb2fEShZRqS04rFCm14GsRo1jWf8u5XbgwXXUx+8xm+dTmDcosLqxa8wYlxNryLLoo
         8nQOLS2X19ctN0IP1ivT6iYQdpZnG05w7sq/u2J2vHv7NJo4BXnZd3XZEke0+67iVfja
         U8cKg7/8peLaukcXIVhZC/531ed/5YhFKhxh900dF3aPJ0mRt21DS0xfjds8P9BjjBFB
         VN54HA9/xl10IdAEeyxT0VU2VBc2QOeHAI3GbjUTJiGFcYaMzpgTDZvBFGHIONe9nzrt
         5y3lPtRP8q9vkc09aCci5XuisoeY3zbdC3emYh62BhWrG+0WChIt9ADT2Cl4Glwci8nG
         oHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=snjG07+mTq8p1iTP0hJv2AhHjqZkcdEN4VgQYZ5k8cM=;
        b=JmBCT9wB8G97o+hAn2YYpd3AOzTVWUkz6GaLJYtUTXKsSCa5CGyGx+EOT+3q5heod5
         C8e+/Ctg3MorpH1ucMUclTtGprNAI2Z2Ltxc+ADpCc1MLn0A8ftv9rIXC1HqXlBF06Fi
         MXYmfNPkbR5nMp10XjVOITJlsmnAAihs6OzLpIwDowOCHm8RRkJheLFEWQzKOLZi3JLE
         fyNztCHfOFGDY+GT1rcObR1ML9OOEMZ1bvgsAUDrwuwo3fbmq2e5ODqug1cRvkiilnLw
         +rlkRiKmZreOp2UrJp4QOPfMXGJDE4eDb6WCYin4OPTfIvpYuIWRjyblc+DvuhSa2miT
         l+Mw==
X-Gm-Message-State: AOAM5306MsAKDojhMb/W/c11FmZZmPjizOxm5nvHF/BSsQDILSzMKaue
        IxMTZkLkN8eO8AShNAuDH1UciQ==
X-Google-Smtp-Source: ABdhPJzqVHaZf/j2gjPVv5gFuTV63aifKpWByx03UNJq3ItH2AaD2yBC94iggNr0/Ba+PTgFBobAfg==
X-Received: by 2002:a05:6e02:16ca:b0:2c6:7857:a0c4 with SMTP id 10-20020a056e0216ca00b002c67857a0c4mr1252858ilx.97.1646863088794;
        Wed, 09 Mar 2022 13:58:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w10-20020a056e02190a00b002c6637e1a1asm1763964ilu.47.2022.03.09.13.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:58:08 -0800 (PST)
Date:   Wed, 9 Mar 2022 16:58:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 10/24] revisions API users: use release_revisions() in
 builtin/log.c
Message-ID: <Yiki7+BSi5sNamRf@nand.local>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-10.24-a89f0da4fd7-20220309T123321Z-avarab@gmail.com>
 <50873925-a5bc-7df8-1407-371eb904e38e@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50873925-a5bc-7df8-1407-371eb904e38e@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 09, 2022 at 02:12:15PM -0500, Derrick Stolee wrote:
> On 3/9/2022 8:16 AM, Ævar Arnfjörð Bjarmason wrote:
>
> > +static int cmd_log_deinit(int ret, struct rev_info *rev)
> > +{
> > +	release_revisions(rev);
> > +	return ret;
> > +}
>
> This pattern of passing a return value through the helper
> function is a clever way to get around adding "int ret = ...;
> release(); return ret;" lines.

Clever indeed. I originally thought that cmd_log_deinit() was going to
be a wrapper around release_revisions() that also freed any log-specific
bits of the rev_info structure that are used exclusively by this file.

But that is not a great pattern, since having to track which file(s) use
which field(s) of the rev_info structure sounds cumbersome, error-prone,
and fragile. So I'm glad to see that it's really just used to
temporarily hold a return value.

I wouldn't be sad to see this as a macro, either, maybe something like:

    #define LOG_TEARDOWN(ret, rev) \
        do { release_revisions(rev); return ret; } while (0);

to make it clear(er) that this has a pretty narrow single purpose. But
even that doesn't seem like a great idea, since many of the uses have
the result of a function call as the first argument, which obviously
would not work with this macro.

So it's probably fine as-is ;).

Thanks,
Taylor
