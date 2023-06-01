Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38521C77B7E
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 07:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjFAHas (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 03:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjFAHaq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 03:30:46 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D418E
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 00:30:43 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39a50fcc719so310338b6e.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 00:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685604642; x=1688196642;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=M4eK3mNEC58LT/Cjb9JD1JmptJcUglLXac6+W0FjUgg=;
        b=W4To2TJ6qd4G2HTbheYKWMWMD4t2/kh5DWSDYjn0e/FAOF58hykBIWk3E9MeMhPvfz
         OTH3E3NeKm0ClJAt6aByaxiXelLjzfBQ1GtPl2PAp/rtnxRWNKDovfcDvRhDL9NKsJRs
         LTrA1deSszJDCZUTOmde6rrZDekwT4AucHESqGXCvpehtKYd9jGBkUqLfY1nE1cIYI1Q
         ESsU/GbpnMhS9yRiqApi8q+jIHQejuu8Y/v7nF4g9iWR5V38al5UMpcVOdetaUWauxNX
         AwMwZSi1+d0tyyNVLG5HcNBkt0/XYW/RM+S9Ccr7dXCr6thqIEK+O7r2I7CqxBaA+00u
         Ke8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604642; x=1688196642;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4eK3mNEC58LT/Cjb9JD1JmptJcUglLXac6+W0FjUgg=;
        b=d4U4rvaok552h4qm2ec/q8MEaJ+FbdlDp0m0PyFC/rKq7ksD5Qh9i/rxK4Uq8MKcd1
         trRsEvocejJoJIMr0+hhPxEQ4cG1cwNojKwkWHXuHZL2fRTFa3vwgk7gyCu42jV1XKNf
         QEOeoojuXhI/vfOYH2o391SnL1BjytosmGuTmU5vSr8BfR9OztyTU3PSnOXQLZ4PIUn6
         4X0V/3n0vHlYxojqqhqpFpiUya9e+5uQPGTd/03IUbYOslCuLNO24y003lMLMnGGgXhK
         T/YR+xU41AedXWDVyYJgdmDvlBOkm/paPPlLOUGtFGa0RkcjfzMqsGGWkCkDLkbksjDg
         H4HQ==
X-Gm-Message-State: AC+VfDw/Hz3j7CpAfx0G6uZPql9OaMEQ5DncR4M/vyP0RZaztGBE41Ch
        GyEn0a+hxcFKYWzmlT6casM=
X-Google-Smtp-Source: ACHHUZ5EYOzNuEVATYe3tfk8F8SH2X6ZM14GGsqOqJfeHGlXhbVIyBPhP76bXr/gZlyl7qGXo2PCqg==
X-Received: by 2002:a05:6358:528c:b0:121:4da7:6dc with SMTP id g12-20020a056358528c00b001214da706dcmr3306973rwa.17.1685604642268;
        Thu, 01 Jun 2023 00:30:42 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id l25-20020a62be19000000b0064fa2fdfa9esm4404342pff.81.2023.06.01.00.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:30:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/6] Document 'AUTO_MERGE' and more special refs
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
        <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
Date:   Thu, 01 Jun 2023 16:30:41 +0900
Message-ID: <xmqq1qivbpwe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Thanks everyone for the review!
>
> Changes since v1:
>
>  * Addressed typos and wording suggestions from Elijah
>  * Incoporated Eric's wording suggestion
>  * Added a preliminary patch adressing Victoria's suggestion, based on the
>    what Taylor sent.
>
> This version is not a "fixups on top", it's a complete new version. I don't
> see the point of merging typos to master if we can instead wait for 'next'
> to be rebuilt after the upcoming release.

OK.  Let's eject what is in 'next' then.

