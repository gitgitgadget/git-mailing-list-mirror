Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A258CC38A02
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 13:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJaNUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJaNUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 09:20:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549FE659F
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 06:20:08 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso15882958pjz.4
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWHI3RH0sCOvqCn1nv7Ab8R0aYhg0+sNmZ6kpGyGuAU=;
        b=Vc3z2rGCkJmNa5roFMkvqZzA7CUec7EOyzTNsQWYUAvtEVyWgppUZBZvgw6/pMt3S2
         aBQYtNwPEeerBbaiWd8Gv9B68XtrfJzqB6e67U6tXzK+MeF/xhgPb5GyDT4hKY4PrsFS
         wvDRSZ+5sc5FMpv+fJk0CKW4vUfnwCOW+3WmFxsOKCr4Blbch75p8Xdvmkulj/GL2KOD
         K3V02s2oNLT3zGCo1gVP5p90bypdrWXI9NFsz+95iQXOO1i4jaeWDCVOu1EAEmwoIAzL
         AxT6PFvVmpNxOkqqx/1nFRSZmSHOoQ7Qjm63QahQFgux18/I5cq+Hp3GbxzCDnvUmxtE
         L61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWHI3RH0sCOvqCn1nv7Ab8R0aYhg0+sNmZ6kpGyGuAU=;
        b=NrprEwlITEDTLKK+2lJ54z2RuKvnMeXNfPGjo6ZHOa6+vW12DBh8ANDX7CSfuKLxgB
         LpqQOWTri6mSWH++CjA5cm8j5jXw5Uz8nRGyJ7HLG/ps58Ycpfdpe50mfHnn2dAIrAhT
         U8TeduFJLewCjHD3nHVO7+T1sQQ5F76dmVYYWmgoa1iNtAllvdpeDAKO1rLO4h74AA7W
         BZj01I8ywCgn56VawOj3ZHtAPQ59KK5o7qzBvfyvQWq35+qoM+pn/eAgpGIsspuem51m
         8HC2Tj6ceuQ4G8/dgqRkU7C49NeWuaUfVzij6aON0p+lwEMugohBrr9GGxIVVAP1Lxpd
         X89w==
X-Gm-Message-State: ACrzQf2FTJNFeGyXfz8ZcypvdsVXvaAPsYj+issMQ6c4782ctzBiK4fF
        U7BmbQPdVKOf71cwMZVPuhHQftdveVD1Ew==
X-Google-Smtp-Source: AMsMyM7m9P4K/W6joU5TeDnBL9wENjY0yqFQQjoY35AXkmZm0O6j4M3z5HLNcXTwVpfPiasTSq5MVg==
X-Received: by 2002:a17:90a:a415:b0:20a:f813:83a3 with SMTP id y21-20020a17090aa41500b0020af81383a3mr14964220pjp.238.1667222407839;
        Mon, 31 Oct 2022 06:20:07 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.38])
        by smtp.gmail.com with ESMTPSA id e1-20020a056a0000c100b0052d4cb47339sm4562984pfj.151.2022.10.31.06.20.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2022 06:20:07 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Mon, 31 Oct 2022 21:20:02 +0800
Message-Id: <20221031132002.72629-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.581.g7a5d018042
In-Reply-To: <221027.86czaeb1xt.gmgdl@evledraar.gmail.com>
References: <221027.86czaeb1xt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ævar Arnfjörð Bjarmason" <avarab@gmail.com> writes:

> But isn't this a general sign that we should perhaps have different
> output when "pack-objects" and the like is run "locally", v.s. when
> we're running via some server process, and end up spewing a message out
> that the user can't do anything about?


I think that maybe we could just use "trace2" to print the detailed
informations we (git developers) care about for some diagnosing work 
and do not output the warnings to the client users.

Maybe it's a solution that satisfies both scenarios.

Thanks.
