Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F62C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 21:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiKAVWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 17:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiKAVVe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 17:21:34 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F821F9DB
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 14:19:56 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d123so8735127iof.7
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtU4oCm45NW7plFWMVYmp605I4Re9yTZ365ODJutxlM=;
        b=hTrbr/HJ0AgswX8JMgzFyEg/lcT1cbMJOvquuGxTdcHkYgk5e598c7XN84vk1ItPRd
         QiM8vqBJsYAn7Cyf+cuXASTHhdZ1U6RN4dcL+b+20lsuHR9wX07xI1zJWKlwHf0jk16T
         d3NPAngqJiHu/tEFQPna19x5ns2wRwC0OEa/wi3JUEkESowOzI9pOlWtA0s5kzeMH1Bf
         Y6gR2cxRY39d+Y4ST6pCrWAN70Yj+CcAZ/hv5f/zN3JB5OpPYDgQu2IBhaP/ZykYZHYJ
         LXUCHMCywrqCI2qG1OvxPxxTiuaY2Y3U1c2SKa20nhr7qSKEl35bgVfMD0vBUIl6JksN
         8fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtU4oCm45NW7plFWMVYmp605I4Re9yTZ365ODJutxlM=;
        b=KtP947O/7JEWLk8fJ1cNT5X8/5juI32s3ZQaH8vI79fWA6FTthsXMeN1H1SPc3egck
         L586iV7Bqj3BW/KVrMDXzd4mYwM8OzfSeYA3cr6xvetWv6Ig4gx3ZwxJVNnymLHmdeOX
         tfafnsenoGnRc+fRjiE+Eer17u6h6eT22nXLmxgxkR+6LnH5mVArB3jMSHS5Da+1ygEn
         K2rNGQmdBgMOrnbeBmglz+w/PRmWLpBcBSXYTrkTRv5pgndIMmVSX8ntgQWJmEWYXSxK
         nHfFcnvnybECgrPeh285b05r5+Ala2auPk07A7yBXhxZEf//9Q4OzTjA2IQe7mgN4Mdx
         cgEg==
X-Gm-Message-State: ACrzQf1jYGIJbCTfRBtqSkOgPOFpjZqSfJi6OZatLxCLrsCP71mXBmbm
        aNmwU+oEUE/uEhlH/XqL8W6F1A==
X-Google-Smtp-Source: AMsMyM5BN651bPSohLjKknkN+s8Iy40MSQSo8iBkFb4rc+grw+vejtan+ml8jcer8FKNTbyEQLFTqA==
X-Received: by 2002:a05:6602:4083:b0:6d3:c3:4a71 with SMTP id bl3-20020a056602408300b006d300c34a71mr4948202iob.164.1667337595602;
        Tue, 01 Nov 2022 14:19:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a3-20020a02a003000000b00363fbcad265sm4252037jah.25.2022.11.01.14.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:19:55 -0700 (PDT)
Date:   Tue, 1 Nov 2022 17:19:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        kylezhao <kylezhao@tencent.com>
Subject: Re: [PATCH v4 0/2] merge-tree: allow specifying a base commit when
 --write-tree is passed
Message-ID: <Y2GNeqdn3oDy+OFJ@nand.local>
References: <pull.1397.v3.git.1667014975042.gitgitgadget@gmail.com>
 <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 08:55:02AM +0000, Kyle Zhao via GitGitGadget wrote:
> Thanks for Elijah's work. I'm very excited that merge-ort is integrated into
> the git merge-tree, which means that we can use merge-ort in bare
> repositories to optimize merge performance.
>
> In this patch, I introduce a new --merge-base=<commit> option to allow
> callers to specify a merge-base for the merge. This may allow users to
> implement git cherry-pick and git rebase in bare repositories with git
> merge-tree cmd.

Thanks for the update. I haven't taken a close look, but queued what you
have as a replacement on top of en/merge-tree-sequence.

Let's see what Elijah thinks...

Thanks,
Taylor
