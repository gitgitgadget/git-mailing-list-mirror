Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF4BC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 19:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCHTfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 14:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCHTfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 14:35:09 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F0CBA876
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 11:35:08 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v11so18705369plz.8
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 11:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678304107;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30K+jj769f8uuT7sxRkUl/g8FLILrddBF1FlesNLHec=;
        b=QJ+LvuYP0jhHFWXq+UWdHsWVuNbEWUhcga5msV7DJfDaJNpjLh/l2p+4h1om9APoJc
         SSAgMULJb90yMVwkZEVBhJhKVs3XDkv5qMHeH2kbeWXsEWvnUccfupLFTHn2baEDeQ2K
         Oyxe2wJG4dxSZfEjV1b5ropnRac2XGv/lUGBKShFANa0j2OQ4+4BvwHcLLq3p2EYyKGz
         MM47esWsF68Hb1gRcIfV1xUhfrqwKPbV6KbvF6LxLrIupTmQHWMp6U9hiYpPnwt97fxg
         XgQjaPlqWCZNuI8rAJrTkp8mQ/JiN1lcUR+hlrXqBkvxZN7NwntF6U6SE0Qd5RagF9Ft
         SWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678304107;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=30K+jj769f8uuT7sxRkUl/g8FLILrddBF1FlesNLHec=;
        b=33TceLs9Mx9niHNIv6lVp2q7Bp5j3YWf08uR2hwnanURGzOg5RpKYdIpPtyV7pDUH/
         aoqCpfO32LiOCB++jIBx0m3XaOzAU0ZQgKv1J+ApmmxexX2etPDrmfu+5HdmTfNt1BG1
         Y+3tZ704UUpwrYKXtExkV/YAaZtKW/DdPvF9knjJGUMnPGsoNZ/bShL5GLKdL9q1YKao
         lAtsn2PeQk31EXuOKTTvfPt3DYz4V2VMoC8t/6Ue7evzjguZrbUf4RDQ3PzWOuC5PX1Q
         j/i4oBaSLxRgexNCERvz0jEAa56iYvRKPBV/4yNBUC7JnN4QFBeR4nmOWnq1OLkEh6ja
         Yl3w==
X-Gm-Message-State: AO0yUKX6kApFcUdTtplk6Vapwhvenx1xLZIL9ZAK2g+TFBF9RNTGo2Fo
        moAr/Usz06AhTJxdPRiKfk+YVB0w9Q0=
X-Google-Smtp-Source: AK7set8N8X4N6hfoEtFmzSYpWq0xi3gLbHM7HKeaQsroQBbr251eJ+1Pw79yDaMhKzGE+0Xb7z777Q==
X-Received: by 2002:a05:6a20:6925:b0:bf:8a97:6e48 with SMTP id q37-20020a056a20692500b000bf8a976e48mr17728208pzj.37.1678304107375;
        Wed, 08 Mar 2023 11:35:07 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id j13-20020a62b60d000000b0058bca264253sm9714847pff.126.2023.03.08.11.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:35:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] object-file: reprepare alternates when necessary
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
        <pull.1490.v2.git.1678301252360.gitgitgadget@gmail.com>
Date:   Wed, 08 Mar 2023 11:35:06 -0800
In-Reply-To: <pull.1490.v2.git.1678301252360.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 08 Mar 2023 18:47:32
        +0000")
Message-ID: <xmqqedpzt4t1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When an object is not found in a repository's object store, we sometimes
> call reprepare_packed_git() to see if the object was temporarily moved
> into a new pack-file (and its old pack-file or loose object was
> deleted). This process does a scan of each pack directory within each
> odb, but does not reevaluate if the odb list needs updating.

Very well explained, except I do not know what is meant by
"temporarily", which to me implies what was moved is moved back
later.  Without "temporarily", it reads perfectly well.  While I do
not think of a good word to use to tell the readers that the moving
is done by somebody else while we are trying to find the object, if
there were one, that would replace "temporarily" very well.

But other than that tiny nit that does not have to be addressed at
all, everything in this patch looks good.

Thanks.
