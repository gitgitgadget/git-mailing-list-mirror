Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDB6C7EE23
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 18:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBXSkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 13:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBXSky (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 13:40:54 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDEC20555
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 10:40:52 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id p6so111700pga.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxi20DBFqbtrJDhiQcbntPLfirgswhpcAzCCoZlZJgY=;
        b=iuof+Jn7NVF/CG2vbMIemREVHiRxLR1AFIF4grAGzU2tQ95pua8XsHvpOa68pShqm+
         9thNnWjUAnMoG6hnD+Vh+q4zTT4Q3Uw4VE1x5s+aGLlcYzCKhuyPiH6ol4UZPxyjf8mT
         pMDf3D+9bNuaPWr+cHz9luSMt5NjcXV5IMFIFzPmn0EqutGkWHV/xTwXpQ2bQqrYPo50
         1MiY/38o23ATgbVMn6qR600x6PFsyBUBvRoyuV9IDqsbRW8sLHE074/ZbSc03Yh2gWNJ
         tLtJybgfhQv1s6E4/UuEH46x2Yr3B0jioLdyPmOUZpbg6Bw884r1lR0HcJMoaswIDJA7
         Ti+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oxi20DBFqbtrJDhiQcbntPLfirgswhpcAzCCoZlZJgY=;
        b=6ete/WpAXkshVGqqoi5ZNBLInjjYFuve3j9QWb7yVatWzs07JxF96AdDUNmKxrKan1
         k/cqdfzCoh88BJNISBxME07jle8RPw2nqZ9dIHTYNSzprnu4b5WjLuwvjzCl8RzjmcIM
         T9otITr2cVw+uOMMUgLUrI/Vko4blzi05K99yoRoEuDnBHIX6xhvOrl3A45Ky4ODdtLm
         MdjT9Vh4g+eTZNuqFQlAy0ATPgnaHjNE5RnnnY0Uyxtj2BM9wfkYBLTOWHld2WhxafGN
         dT7WGOvkrFrsaYp+lzC1ccn9KvIP8OG9cPaPYmpQKJfoP+9u0CYEC4oBGgBsyA2VTkP9
         6yZA==
X-Gm-Message-State: AO0yUKXla+FFLWh3lEuHSTOH5y84GRSGie60Vn/yoBBQQ/dziXXOCGcb
        KtM3x9g0wYBjEPWmD5+vrJM=
X-Google-Smtp-Source: AK7set/HWqPfOhcu87HblwOqEiUpMisr/i1jiYxzNs60weRaYbTRF2gK3tcoNPP/VyuXLEVDye4Olg==
X-Received: by 2002:a62:1aca:0:b0:5a8:d407:60f9 with SMTP id a193-20020a621aca000000b005a8d40760f9mr13983535pfa.29.1677264052230;
        Fri, 24 Feb 2023 10:40:52 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id m11-20020aa7900b000000b0056be1581126sm9180788pfo.143.2023.02.24.10.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 10:40:51 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, sorganov@gmail.com
Subject: Re: [PATCH v4 2/3] rebase: stop accepting --rebase-merges=""
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
        <20230223053410.644503-2-alexhenrie24@gmail.com>
        <b4be9cb3-c24b-4377-bab3-5d53035efdf8@gmx.de>
        <xmqqy1on0yla.fsf@gitster.g>
        <CAMMLpeQKJeZn4rcTJzFR-ixQXKQMT7t-BKvJqXV4o_4VM=tHYg@mail.gmail.com>
        <xmqqcz5z0wdb.fsf@gitster.g>
        <CAMMLpeSH1itopDuON=7ms_7Li7Qk+9dhzKjT5f7UE11posKK=g@mail.gmail.com>
Date:   Fri, 24 Feb 2023 10:40:51 -0800
In-Reply-To: <CAMMLpeSH1itopDuON=7ms_7Li7Qk+9dhzKjT5f7UE11posKK=g@mail.gmail.com>
        (Alex Henrie's message of "Fri, 24 Feb 2023 11:23:49 -0700")
Message-ID: <xmqq8rgm29fw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> The only way to truly make "[rebase] merges =" invalid is to print an
> error message and die with that configuration. I think that would be
> confusing too, especially since it's now looking like rebase.merges
> needs to be a pure boolean and an independent rebase.cousins boolean
> option is needed as well.

Oh, I wasn't aware of that direction.

I do not know why rebase.cousins, which would only be meaningful
when rebase.merges is true, is a better design than rebase.merges
that is an enum of "don't do the merges stuff" plus "do the merges
stuff with cousins", "without cousins" (which may allow us to gain
more different ways to do "merges stuff" later), but that is what
gained consensus on the list, then "[rebase]merges=" would become a
problem.

But --rebase-merges from the command line is not a pure Boolean
already, so what does "[rebase]merges" that is a pure Boolean aim to
help?
