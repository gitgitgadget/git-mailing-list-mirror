Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A352ECAAD4
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 16:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiHZQCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244667AbiHZQCh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 12:02:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033D6D31FC
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:02:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso2202796pjr.3
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=DAtDii/ZDrfOMJ53eU2ayqOC70GOpVIrQ2Eu3Ax2Sk0=;
        b=FM1kK56HtkXAl8xb5cqFCrbVTYRdKy1UJCydjDvOc/3S55Yv6T7aN+meXUXlKTNp6k
         0uDmLQsbLyNb82kwGtWYmZOAARZ34fF9DVxTU9XtKVyIosZv0R2TWa45oUNlNPVK7ZL0
         iOYsQSzCqtxiAWSM+uuP3B2nbWcxfW3Ei/9eG+UJOWT7EPd9brC5IrKOnp2SL/gcFcOs
         EnUK3L5EWA9IjXSiBUTz98B1C8OvhDpJ5FMbKeNR4/o3p+j94FH6m37X2TenfcKGLP+E
         FK01Xo/p6KWzd+JRrEXByk5SZV9dee1eEr1wSJAbeSD8b0lvM4Csd49cxmQtnAYw4NHr
         H+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=DAtDii/ZDrfOMJ53eU2ayqOC70GOpVIrQ2Eu3Ax2Sk0=;
        b=ax6WerLb4daJHNPiIlAIpspK5jrkkDSMCIOzXc9RJCovZcyfJlWtf6JR556jA9gN/U
         pAVbFNjxXyMwQgjoGyKpO3Lo01+EG5uWRMQA2SwWqBlP5BMZjSGnj/ZbWATk5LvaXQxN
         xMN9Iii2ZOMWLIGfzqvCsHm8T6y14K0NNmZ8z9OGEhX7UKcVq3Z1M3LDNMQ2TLNBpWxk
         uI8dGsWktNjhx7aSX46pWSzx8yyq28ZW3ZWJK96D0EfMnZkjCgWFr3zxb3L9KDnVdns/
         Gr1+YsxSsn2NKJNUUlagk7jEJ0VpL4NlXsiiiF0Fv8AWF6pZvx2pshFzdb0ytiPn1Lp+
         pKAw==
X-Gm-Message-State: ACgBeo2fORiRrLJ1S6GdHJqRt27VgUwA3FhrCoYNS5e7I10cEyxK2x5J
        feDo1IZK48B5PrZi72XpUTE=
X-Google-Smtp-Source: AA6agR5f/KGOSYj4XsjFgo31sG6HPWHHE7difAyIq1Mwdm4hcD3jdWNYe/W02bfZvEimlbS2CVHGzw==
X-Received: by 2002:a17:90b:4c81:b0:1fb:51c2:7961 with SMTP id my1-20020a17090b4c8100b001fb51c27961mr4923303pjb.36.1661529755025;
        Fri, 26 Aug 2022 09:02:35 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ft15-20020a17090b0f8f00b001fbbbe38387sm1850666pjb.10.2022.08.26.09.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:02:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v6 0/6] [GSoC] bitmap: integrate a lookup table
 extension to the bitmap format
References: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
        <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
        <Ywf01YqJKNsGfffx@nand.local>
Date:   Fri, 26 Aug 2022 09:02:34 -0700
In-Reply-To: <Ywf01YqJKNsGfffx@nand.local> (Taylor Blau's message of "Thu, 25
        Aug 2022 18:16:53 -0400")
Message-ID: <xmqqlerb0z8l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This series all looks great to me, and the performance numbers that you
> achieved at the end are a nice payoff for all of your hard work. Well
> done!
>
>     Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks, both.
