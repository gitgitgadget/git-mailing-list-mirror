Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9021C433F5
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 23:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhLEXrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 18:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhLEXrj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 18:47:39 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B456C061751
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 15:44:12 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id p13so8546014pfw.2
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 15:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mmx/Snvxb3F6IGjXO4Qriy15E6ELazICG4fDx8cqfi0=;
        b=n469aWMjgJtmdgmbbot6DV5/6aDB9X3MVTwxcxE/xxhh+K3rd9X8ZJqd/tcw2f09w9
         xFnE24XRkBBCceOV2ZZkUXgXwhwvAfmvTYtHxRs0f+wsjf6DHymlCy6GiA49eiIQkUW0
         2oeXU9WbsxoCc2seQPRvEhU9xLU18iAmDcsHQqklv7Mq6YbIuLVK9DPM21+Ezxo5YRNO
         WX6Mpq7p9/oGwj5UiKqTD3rnP8xDS3i3rB9vHJqP/u5Dd1DD9TAeDGwinRrqNXe5hv0w
         y/D6w2K4SJ465BpHtWpWddA6IAJ4EehLQqz8Ou4oipezACcguOa0kRPvBD0YE+W4GmX4
         faaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmx/Snvxb3F6IGjXO4Qriy15E6ELazICG4fDx8cqfi0=;
        b=zuiy9K0+ndmhIb3m5ueOHL7ZT/XqSP8OLWOx7seSZHZavvX80qQBu9SMYsQ+4XQIgn
         MbzQSbujcwoiWbdqJwTs/Kc3OUC5YGGpbO+nL1O1Ah7eqoSfwhU+VuyLfaU1OIGDK0WN
         fsYAK75dr+PxpJxlsxpb60iWqkObFjapjVRtOegZKU88zJG4h80lr5xFGWIJXZnTAHyG
         0B9zXBYfT726fZrithrLgyL0/2TQJm9xv2S2U5D+4oVXI1Rshvsh08u5+tMsJVh4UW54
         z4ZO+10NvjTtl6IY1DCdIob1Ci7YnE8v5QmwoYzCqLIB3U+Vu553Em3iqz+dpw1MgHb1
         O3cQ==
X-Gm-Message-State: AOAM530qKp/L4EcVhnxM2ejs6+RfgNbSLZFaMrRA+owDws1xlCDpZ011
        ATiZIzy8BMErT+PUQ2ubHKc=
X-Google-Smtp-Source: ABdhPJzjfTlzx97+Z2Lgt/Ga1NBZQC3omEXwVPt1ZOo8ZgjyWJ9QiIrgmGXXHsnWpUvVHwPDUOp+Yw==
X-Received: by 2002:a62:5142:0:b0:4a3:4d13:e7da with SMTP id f63-20020a625142000000b004a34d13e7damr33681820pfb.84.1638747851440;
        Sun, 05 Dec 2021 15:44:11 -0800 (PST)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id 11sm9472897pfl.41.2021.12.05.15.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:44:10 -0800 (PST)
Date:   Sun, 5 Dec 2021 15:44:08 -0800
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/2] tmp-objdir: disable ref updates when replacing the
 primary odb
Message-ID: <20211205234408.GA26229@neerajsi-x1.localdomain>
References: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
 <d8ae001500c788cdabf4e6918da0a7ce89a48fc6.1638585658.git.gitgitgadget@gmail.com>
 <xmqqtufmlxmb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtufmlxmb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 05, 2021 at 10:23:08AM -0800, Junio C Hamano wrote:
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> >  	/*
> >  	 * This object store is ephemeral, so there is no need to fsync.
> >  	 */
> > -	int will_destroy;
> > +	unsigned int will_destroy : 1;
> 
> <CANQDOddCC7+gGUy1VBxxwvN7ieP+N8mQhbxK2xx6ySqZc6U7-g@mail.gmail.com>
> ?
> 
> (https://github.com/git/git/pull/1076#discussion_r750645345)

Thanks for noticing this! I also lost one other change
while splitting this out: we are referencing
the_repository from the refs code, but as of 34224e14d we
should be picking it up from the ref_store. I'll submit
an updated series as soon as it passes CI.

Thanks,
Neeraj
