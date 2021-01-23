Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE5FC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 12:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B72123B08
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 12:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbhAWMLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 07:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbhAWMLr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 07:11:47 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16493C06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 04:11:06 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z21so5698893pgj.4
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 04:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=lBtnQgkEJCr1b/zsccsgh34Qt5gcXmxMRes9em599NE=;
        b=gvSado1TkZ5Z6e4jGbJ2wuhdD/VcCfXZy+/srpy/w0ocaKkYwAmpVWGkrLPI/A8nwl
         UPOb4Oq7j7nK3o/34GFlDplonbFcHEcmxZzod7c18uOAs/axiuaIRjZw9kWmL5P45xEk
         XUXps/nHuQ3oF2CIJ9QPURhwJtxtBcayBxnO/Ai+MOjNjcwx5+m7gowoqy/9gvddB8qC
         IdGWVli1d/ObIQ73ccW88J1d2LEliLQiotHYeTo1hZZTqzeY7l/VObluDGmVAsLEOr3D
         /jBv6fGux58TtkqN3AwAGzYas7AS9a0h98eo0dJ0ziK9XDcONKQ1UhtkYTRPE7iRfmPx
         PeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=lBtnQgkEJCr1b/zsccsgh34Qt5gcXmxMRes9em599NE=;
        b=PaXW+hqza5qjf/cqJi9FbKQPeyRSUKfR+NKNAH+TFUQs0bZjsQVb1/RXb4lfgvyjL4
         fD/nZXGAI72qSs46IDUEzLAKl2kASEbi7lCNKerCYcwDJXAJegMGABBc90Qd/2aqvhof
         uoRb2S92JU06ni+W7QpCtEYIisMw6i1QIWTlAwB/6KfjfE+3iZK+NzcW5SWhMYR7NLoN
         ADuBK5saAe4RHhBnhemtHhZynVYi2W92oEEN5C4a3zVjudyeaGrirXKrOph15jZQhK5K
         1XGeYns19d1fKHdaAXVXGFTKvMIBQqzzUniurbAZdRdyQk65OTOSrM4z/D/Mk61XA3ZK
         aaQg==
X-Gm-Message-State: AOAM530O6YLTbDcaeGqpa9X0sT15boJmU7a5wWB6sue0cwIek+keYbwe
        Af2rXQwqgehauklrOa2F6B0=
X-Google-Smtp-Source: ABdhPJzX95mqFTguU8mKJPddxbllOnSkotFPdD7WlxCurAu4JEwd63nAwY4o/I/6nNO7QWKWZdWYRQ==
X-Received: by 2002:a05:6a00:238b:b029:1b4:af1d:d3ff with SMTP id f11-20020a056a00238bb02901b4af1dd3ffmr9405018pfc.66.1611403866473;
        Sat, 23 Jan 2021 04:11:06 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:69a:b5d0:11ae:5c4d:1150:139d])
        by smtp.gmail.com with ESMTPSA id a4sm11784062pfg.41.2021.01.23.04.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 04:11:06 -0800 (PST)
Date:   Sat, 23 Jan 2021 17:41:28 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, jnareb@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v6 00/11] [GSoC] Implement Corrected Commit Date
Message-ID: <YAwScMcw4sP1ZAJb@Abhishek-Arch>
Reply-To: YAYFCbVvEL+GbQOl@nand.local
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
 <2437ba7c-f9d9-34bd-5e08-eff96cadcf91@gmail.com>
 <YAYFCbVvEL+GbQOl@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAYFCbVvEL+GbQOl@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 18, 2021 at 05:00:41PM -0500, Taylor Blau wrote:
> On Mon, Jan 18, 2021 at 04:04:14PM -0500, Derrick Stolee wrote:
> > I checked the range-diff and looked once more through the patch
> > series. This version is good to go by my standards.
> >
> > Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
> 
> I re-read this series now that it seems to have stabilized, and I agree
> with Stolee that it LGTM.
> 
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>
> 
> > Thanks, Abhishek!
> 
> Incredible work!

Thanks a lot for the reviews and help in identifying the reason behind
(relatively) minor performance increase when we switched from useless
'commit_graph_generation()' calls to direct slab calls.

> 
> Thanks,
> Taylor

Thanks
- Abhishek
