Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E065C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 16:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjCOQCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjCOQCP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 12:02:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F52D92BF2
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:01:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id rj10so8776819pjb.4
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678896110;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFZZHKtYF85yX9pK+gC2AVwVpqV9WMiIQEPxKE+9r+k=;
        b=OhVvhUlUwiW9nLsAQXnshShvJ5ynf1ivHPc7oiFClz+woNb87glinDtY/L5ihr2V7R
         HfAWLCvWvLS6lEEr4HCwPUwpZkaY//dNwF3IFu9VGk6G2KLmUuAD2/F9J/Dabyukr07U
         YAosGCm1WK6HtPX72s4ILPPpUjAeKzofpk5X0p0mS0QitO5ya+zB3LKqSF0DCD6fudL6
         HIk3h+bHLBSj897ijqqwfhWiDu2VyhXWE1FhiSkckpJfh13x93vrKxtuZ8fZLhMAX4iB
         vtI4GDhi6dofWZ64/4iN80vyfuu4qz5DOw1G1g4IsiyrSn0sZ+IOdxZQwPhbCKtirq/H
         oTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896110;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFZZHKtYF85yX9pK+gC2AVwVpqV9WMiIQEPxKE+9r+k=;
        b=dAoIQ4+K+hHgjcwPuOraoxgsJvC8tbwtomZtN6oRZf5reHhZj048QQndXJ5OkzQCSv
         BiQHJ2gOhSTdPfSY6WamiY+ozNheCfcUjWikEWLdTXWH8wV0d7jRFs7DB44/He9oiNPe
         8u/Pu660tB/pvRcZftm/1Da/QxqoYAWBRD6kvVcO2g+AOzPKD3mwYbi0Y3+CYqIoXGAw
         SV6oKpC8rS8j1YWSzj/Rm7FzGqCopm9FvdwxDn56m8u2FcAOKi7XCR5Tr25ouIDW5o8D
         zBzWGH1UOSLQ6lSuiZv5QY0Adn//wWEyrfu8h9nwpVJt/oa2KEOhbNnt11tGgT+Lmbau
         bXdw==
X-Gm-Message-State: AO0yUKXxTQQZcYAKJ6GbYvP/1vhphOikSvZhadaeNUaDCQDZuoEU5YvW
        xqh3q0+HCuSHbHwan42zr62jwSO8SuA=
X-Google-Smtp-Source: AK7set8CnXgqNF5vNnyo+xMPXI83m5B9syAYbdt6HnKx+0ekd/fUHDkBZdKlmko3IwDPMQPqy26prg==
X-Received: by 2002:a17:902:ec8b:b0:19e:b5d3:170f with SMTP id x11-20020a170902ec8b00b0019eb5d3170fmr146235plg.4.1678896109821;
        Wed, 15 Mar 2023 09:01:49 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902bd0900b0019c13d032d8sm3792309pls.253.2023.03.15.09.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:01:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 7/8] for-each-ref: add ahead-behind format atom
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <82dd6f44a33279551bb638357df4bc82253283e5.1678468864.git.gitgitgadget@gmail.com>
        <230315.868rfyxfus.gmgdl@evledraar.gmail.com>
Date:   Wed, 15 Mar 2023 09:01:46 -0700
In-Reply-To: <230315.868rfyxfus.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 15 Mar 2023 14:57:20 +0100")
Message-ID: <xmqqh6umovf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Mar 10 2023, Derrick Stolee via GitGitGadget wrote:
>
>> From: Derrick Stolee <derrickstolee@github.com>
>> [...]
>> +ahead-behind:<ref>::
>> +	Two integers, separated by a space, demonstrating the number of
>> +	commits ahead and behind, respectively, when comparing the output
>> +	ref to the `<ref>` specified in the format.
>> +
>
> As a potential (expert) user who hasn't read the code yet I'd think the
> the "<ref>" here would be the same as "update-ref", but glancing ahead
> at your tests it seems that it does ref matching, so "refs/heads/master"
> and "master" are both accepted?
>
> Since nothing else uses "<ref>" here I think we should clearly define
> the matching rules somehow, or maybe we do, and I missed it.

I vaguely recall noticing this in the previous round, but doesn't
this only require a commit-ish, not even a ref?  It is parsed with
lookup_commit_reference_by_name().



