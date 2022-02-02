Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791AEC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 01:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348763AbiBCBHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 20:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbiBCBHt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 20:07:49 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115AFC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 17:07:48 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a8so2864144ejc.8
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 17:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=xpsc5jt1qXIT9mQJ3bwuAr1pZlGGaZaaZSy0F3EehwQ=;
        b=mDjNPLuS27rjdPg4FPYhb8sYhDoSB0Nw6ETj8rUFsGdCL3F3Hqal8TAluI/FOrfiby
         mWmdL2YL9TVuY+cqm64Vp4OekMZGVMJ1ksF5wtMvsgVIgIprzSYtGYafmNysYM4NECMw
         p+iwJpDhWiVJ2AuCXsUCfIXqAurnuJsewBzuZaIwO3+oI/B7xPjAaEd5bKOzOrxfAXHa
         qx9mpPCrFdwT7v2wyiyQtW5cnYn7nlEIPAHnNeMIhpb/gMcrMWteT/4nIiHYfG4UCErW
         JpiiT3qgDEdPbw+DB0KQSYqwze2QMOAhB8xdO4PO97LCm0ShW5e7NhxZrTQWm9WaQ90H
         0XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=xpsc5jt1qXIT9mQJ3bwuAr1pZlGGaZaaZSy0F3EehwQ=;
        b=lOTiodaMrMc+Yuz5Cg2XWoYCHL01E8JR4P3xb869FZGRx45i/B1VLs7d6byGix5yHf
         Vz/cno6WSA69VbMXxRKeE8gk247eP3QL6UWbY3deIgB9NsJHsGL21RmImisNxzNlVNYP
         dGddnrzHdmPS/B3ZP6OH0vnrwzYOwGDSfKSc7mXJulq9trjlzixcixwMFNKzmVFUb4qw
         a+qXj0KkFJBGXDPQ2TF7UuRj2jSzjlZ0dvN7+KCFIN1N93e34rsFujXuwB08ImYHcMmd
         tZUdOEWc9/T6cB3YJAnfS4tadqW3hVqaDc9tfT9+weqw2w7q7B9jBfOpP4HHyoxXVrAF
         PBEg==
X-Gm-Message-State: AOAM530qh/zRYU7G2pANZfNBof2HNrW+GeXbgNEAVQfOL+VIvUih5gpi
        oITSsIMS3JkhPK5/8F9ommRAu1h8UDiLJw==
X-Google-Smtp-Source: ABdhPJw0L0UosFOc4LMLJB9F12rZjiJlFd5EZHrnBv12Oz98iL8vRPcURv9j1o4cDgDTvvDyA2qWgw==
X-Received: by 2002:a17:907:9495:: with SMTP id dm21mr27165999ejc.87.1643850466282;
        Wed, 02 Feb 2022 17:07:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a6sm16195361ejs.214.2022.02.02.17.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 17:07:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFQbA-004npp-VN;
        Thu, 03 Feb 2022 02:07:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 12/15] merge-tree: provide easy access to `ls-files
 -u` style info
Date:   Thu, 03 Feb 2022 00:55:48 +0100
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <2188a8ca1e77f2f5f8249f8b810775205ad529a6.1643787281.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <2188a8ca1e77f2f5f8249f8b810775205ad529a6.1643787281.git.gitgitgadget@gmail.com>
Message-ID: <220203.86mtj87o67.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 02 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Much like `git merge` updates the index with information of the form
>     (mode, oid, stage, name)
> provide this output for conflicted files for merge-tree as well.
> Provide an --exclude-modes-oids-stages/-l option for users to exclude

This.

> +--exclude-oids-and-modes::

No longer matches this.
