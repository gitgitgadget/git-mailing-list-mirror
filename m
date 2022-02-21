Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65890C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 01:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245508AbiBUBvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 20:51:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245505AbiBUBvI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 20:51:08 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47991517D0
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 17:50:46 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id n5so8894360ilk.12
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 17:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GXSVd4sH0p7mMUnwtX0RxjxJ6CAfa/DZyl5Zh72dGWs=;
        b=z5K2WcmuQ/Kkmw+AUpjblj0PNVrH0ndPEepsHxoY5Vaz/WqgUgomivReg1PIjmidb2
         9q8LkNtBTAJREMqJwUdO0tYWFQIx2c70SDKgbX+PQS3H1ncJbz7V1guublFloyNwUCQW
         bVUlTe8gq70zgQtqX90LOdk0ZoY++9ES8XCr+D6nQaQzUbkv2hzYzLbdroyg+EJdjA4H
         GoxS92JT/fEU8m1Fk3T/R2klEH2FBB4SjVAFBfztUIzy/3YdRtdhbQGbhu5mmlSwiuia
         pefAAQXI/uxLcmEIfUHLR26rNHiGSC58tWZ9WGD3k/99XM01FoImnDSB2F1/nadSYyMz
         806w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GXSVd4sH0p7mMUnwtX0RxjxJ6CAfa/DZyl5Zh72dGWs=;
        b=csNfz337H5QmVa23etFENaIs4B7Rotj4WAxkuE+YF84ZTYzc0EiDulJyLNMEAa3VE1
         /Tj3fSAYuRlBSEf6I1QhFzjyS7wCRg4D9VE3XBFsqAr+3eNn11GSQmxekpZwIh5lxNhc
         S8EMgq8GsNqtA6I3qhCFS9HgLjuNHR/u2/1J922Uwyn4bvS3431ohHeRMq8bACi6l/jU
         lmekCoBBNhnIqabpJbx0op5tGcLu5JnIdXSAKk1BzZ8LE8N8Th7CYu2YyIDrXRRY8Z3w
         hDuz7C0kB9jSe+eLSoq89WSJELnimNIGw3Xvgu3ejWElON+27KkfLR91dINWj53O9LiC
         vjNQ==
X-Gm-Message-State: AOAM531O1lovEu9usR19vsED9bdBY4FXzqizuknLzU3ZY70ok2R5I7Mw
        f79VGf1CFiC80DZ0X3QwNc7KhA==
X-Google-Smtp-Source: ABdhPJwvopkgSd/IRgBwLF7TJBhKNz5dQDbeeYbgSnVZZTdfjszfBhJwjIU+/KZnzZBA6/1+HVEN9g==
X-Received: by 2002:a92:ca0f:0:b0:2bf:56d4:3aec with SMTP id j15-20020a92ca0f000000b002bf56d43aecmr14195796ils.220.1645408245678;
        Sun, 20 Feb 2022 17:50:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l8sm4386422ioj.40.2022.02.20.17.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 17:50:45 -0800 (PST)
Date:   Sun, 20 Feb 2022 20:50:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] reflog: libify delete reflog function and helpers
Message-ID: <YhLv9P9VFQ6Iwv41@nand.local>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
 <Yg/09XYTruPJQVV/@nand.local>
 <F49696AE-3A00-4870-A355-A9510468F35D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F49696AE-3A00-4870-A355-A9510468F35D@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 08:43:14PM -0500, John Cai wrote:
> > One question that I had which I don't see answered already is what the
> > plan is for existing reflog-related functions that live in refs.h.
> > Should or will those functions be moved to the new reflog-specific
> > header, too?
>
> Thanks for bringing ths up! Maybe this cleanup can be included in a separate
> patch series since this one is mainly about getting rid of the shell-out in
> stash.c. What do you think?

Yeah; I think that's fine. We don't need to get all reflog-related
functions moved into reflog.h in the first series, so I think it's fine
to move things as you discover them.

I was just wondering whether it was something you planned to do at some
point (as part of this series, or a future one).

Thanks,
Taylor
