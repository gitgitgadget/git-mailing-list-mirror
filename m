Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023D9C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 10:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiFWKqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiFWKqR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 06:46:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF324B1D4
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:46:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mf9so19842415ejb.0
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=aprpM09llfiDp4i2olMuBTeQrf8jco4xv70ctuRG7Dc=;
        b=EjKcV82ad4oUNZvtYjDq5cKkdP1swGPrjStZswVQwMwdFrvb9i1qYyyOM5fCEzLxNL
         cDP8D3VvGiU1ZUeHPue/698RpeepOPMUXIiOluJ+g+oBwMbfM9gi0+j8A5KBHnzBO9xd
         FGR30SpJ/4CMP9nvOK58SNdPi+1GANPcZv8TMpIe++0/N1GQ0FkxU75a0MxQ0QAGizZd
         9N9hZME0yLCXvauc6uZxu2aO1IorwRsqPq3BNT9hfXRwlSq37NWHlPMJdMNVMCIS1k+7
         /U6NXbSwpRiOUFMXHXf5S5hPKHuD1CfvdK/8qlfwoLJ5Utf1ZXPiP7WFrB6BlWqIcsjN
         fNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=aprpM09llfiDp4i2olMuBTeQrf8jco4xv70ctuRG7Dc=;
        b=bSoqlSvRbYTn+8kb6cl56K+/hqTQsJYtK7MEVdCcmp2uDprfzr+/m4abE5r45CRP18
         pLnRPG2c8ZKn7AjbAy9AyWN7U23h9JyOBdUBlmshlmhrqYICPbtMoaL2d9SUafdG9NC6
         jJVsG7wpn6JW/LV5uAAheQxGTBYbfO7URkru1BeKBc+3MA+lvPQRZrQhs5vcfKK84Y2U
         o4HrCL0tHVR4dgKVg1+mGZ6rKoOW/kFFg1fBI9s99kZrD4bgRKw78U02CzVl8jAPCTaL
         t/QGAxbSB1z9S3O9iAM/i2oOsTURYvkne9j2PrvbdKA2c5ScwyJBmDbs9CYIBswIf8ew
         2rlg==
X-Gm-Message-State: AJIora+pjlfJlRqHUtiu+RZpCgPTeEyRbe0fIkvsnp/7+LMRo+J/KjUl
        U8xDEveh5vsJh36hJXkxt8PG9svj61jgoA==
X-Google-Smtp-Source: AGRyM1ufi54vp329OXBJIRq6VFS+M+Tbv0SyYnKH2NVMuNmgKRiQ6nbgcg3OTs7rSgLU5S3kM8xg1w==
X-Received: by 2002:a17:906:58cd:b0:71b:cc19:58ca with SMTP id e13-20020a17090658cd00b0071bcc1958camr7373447ejs.682.1655981175013;
        Thu, 23 Jun 2022 03:46:15 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d554000000b0042a2d9af0f8sm16838366edr.79.2022.06.23.03.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 03:46:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4KLl-000rrN-Mt;
        Thu, 23 Jun 2022 12:46:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/2] Integrate Scalar into the CI builds
Date:   Thu, 23 Jun 2022 12:41:44 +0200
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2206132246010.353@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2206132246010.353@tvgsbejvaqbjf.bet>
Message-ID: <220623.861qvflksq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 13 2022, Johannes Schindelin wrote:

> On Thu, 2 Jun 2022, Johannes Schindelin via GitGitGadget wrote:
>
>> During the review of the initial Scalar patch series, it was suggested to
>> include Scalar in Git's CI builds. Due to some conflicts, this was postponed
>> to a later patch series: This patch series.
>>
>> Note that the changes to the GitHub workflow are somewhat transient in
>> nature: Based on the feedback I received on the Git mailing list, I see some
>> appetite for turning Scalar into a full-fledged top-level command in Git,
>> similar to gitk. Therefore my current plan is to do exactly that in the end
>> (and I already have patches lined up to that end). This will essentially
>> revert the ci/run-build-and-tests.sh change in this patch series.
>>
>> This patch series is based on js/scalar-diagnose.
>>
>> Johannes Schindelin (2):
>>   cmake: optionally build `scalar`, too
>>   ci: also run the `scalar` tests
>
> Upon further reflection, I would like to retract these patches for now.
> They do seem a poor fit within the Scalar story arc: in the end, they
> won't be needed anyway (after moving Scalar out of `contrib/`).
>
> I talked to Victoria and she kindly agreed to drive the Scalar upstreaming
> from here (after v2.37.0, I imagine).

I think at that point we'd basically be talking about integrating some
version of the patch I sent to do that back in October. I re-rolled it
now, including finishing the CMake part that I punted on before:

	https://lore.kernel.org/git/cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com/

As noted in the CL I saw Victoria pushed out a WIP version that was
taking the same approach, but as she apparently wasn't aware of the
previous effort in the area was bound to still run into the same issues
with the parts she missed, which that 1-patch series addresses.
