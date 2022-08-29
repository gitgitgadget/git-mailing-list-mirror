Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4652ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 10:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiH2KVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 06:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2KVl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 06:21:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD3545981
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 03:21:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c59so3280237edf.10
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=XsVMTK5QC27h6rgVlcgJBIry5qIkmKxVuny8Hwpi8K4=;
        b=Qk+An9gupZ77TwkicP11fl7gzu7x4UdmcoGIpbap2bIsgLmSffC25jx9yjXDOWe9uV
         JKcO6C+Oa2g8/nwRaBLwF8FHQOSQnBDpC9ngJuSSUcw3G8pJIrIAwp3VC3pkbhA50Lia
         QY0qTdbrtoc2Vsdjt6nPJBFHWk5N9+gPqxeSHvnK4X06g2x+BKRJi6ZpzTonNJEmfaAx
         dNAvQP9XRy0G6lecgprUTBmva3Yhs95cXUDIGaXmyPs2bUmth6TqC9NZQeWIy7qRcE3l
         P3I8C7vEH8PVMMmsImBu9qN8LEnkSvh32LQM2kPZLVIH0WGN1JU10RzkgPM1gNyV2Sc4
         GCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XsVMTK5QC27h6rgVlcgJBIry5qIkmKxVuny8Hwpi8K4=;
        b=xbGJB7R3zMsrBp1IULOhKLdTNvo55NAy7MuMFKvV+dZoD9nT8ivd6a2CMcaXv/ottx
         5vOoTmqYXyevDAwpI+Lz3CziNNjbjcDU1zplD/LMBQy3uMXNNHzIjLt/fkDFjOt2MLxl
         mSBGpbsmJ8G2lZrbGwKqK7cGETl3FiMDRvDPWH9pfSVqvUG56yw4Wh2L1KOYfmF8ngSu
         j1kqFe+5VQ3sKyJezvvVBn0yG5UqQDtlowaG31FHjq9HQWkCXFiZpjMJdrjY5yNlz/C8
         WEnkASnUpt/lAjHTJR9SDMFp5KzJX9RNVyXNptS7btbqFvDLp7f/IuUsMkNcF2U+oAye
         2Tyw==
X-Gm-Message-State: ACgBeo2rgmurq1Xltkxy0V6J7v6b307YZnyJqprGLcRxyehW6LB5wwqG
        DBQyhGU3zR2/6FM53bWd/5MicZrUNCs=
X-Google-Smtp-Source: AA6agR7dweFa4KKnfHwPMN2bn3hJdFIW0mMHO33e6zMBpvdSUO4gZFAepJPITk0nJDgEldYaQBAcrQ==
X-Received: by 2002:a05:6402:1446:b0:448:5081:efc7 with SMTP id d6-20020a056402144600b004485081efc7mr5281118edx.428.1661768498999;
        Mon, 29 Aug 2022 03:21:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v1-20020a1709064e8100b0073d7c35fea8sm4329017eju.59.2022.08.29.03.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 03:21:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oSbth-001ekN-1K;
        Mon, 29 Aug 2022 12:21:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 05/16] bisect--helper: make `terms` an explicit
 singleton
Date:   Mon, 29 Aug 2022 12:20:13 +0200
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
 <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
 <92b3b116ef8f879192d9deb94d68b73e29d5dcd6.1661604264.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <92b3b116ef8f879192d9deb94d68b73e29d5dcd6.1661604264.git.gitgitgadget@gmail.com>
Message-ID: <220829.86o7w32vv2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 27 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
> -	free((void *)terms->term_good);
> -	terms->term_good = xstrdup(good);
> -	free((void *)terms->term_bad);
> -	terms->term_bad = xstrdup(bad);
> +	free((void *)terms.term_good);
> +	terms.term_good = xstrdup(good);
> +	free((void *)terms.term_bad);
> +	terms.term_bad = xstrdup(bad);
>  }

This is pre-existing, and dates back to 0f30233a11f (bisect--helper:
`bisect_write` shell function in C, 2019-01-02), but it appears this
cast to a "void *" was never needed. Perhaps some C++-ism that crept in
here?

As we're changing this all around perhaps it's worth droppping the cast,
or it could be left for some other "remove redundant casts" series.
