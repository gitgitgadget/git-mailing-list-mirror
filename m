Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E8FC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 06:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0731820775
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 06:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8pcbfaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgF3GsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbgF3GsD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 02:48:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78858C061755
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 23:48:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bj10so2859434plb.11
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=puN2Ta9uXN1ufkNSWAk0HUdKLz6aYhKWZhsH0NZs1qc=;
        b=W8pcbfaP/jli5bARb8BVpICkBIueeNH2C6aI3rxKuglwrqF3PPIb4yRYLfg6iGqVME
         S4r9zl8+yY5RF4I1QY6PR4Bno2MtEzPp6DPvP9tJxOvlgg4PVzuQQo4rx3eiDtgQ+Ms8
         32eEnDyoiGJWyHWKaEprw3qDUDczh+ozv6QBitShGgKvyfdEm4buFrdD3KZHihSy7bry
         q7ewcKMc/BzDIvO1CVbpE15MGABbYqLUaiHaENGJZBS67Y/fdZy1dqHCm7ooxK043Err
         OEdcKBcHT9p/4v5X6hXasf9xZIjHu5U2iSgJgye2GE5g0OK1zVpT7rFNf3aVCQjzAJRw
         anqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=puN2Ta9uXN1ufkNSWAk0HUdKLz6aYhKWZhsH0NZs1qc=;
        b=OP59+t2Yu7W741hiziMkYXlgjmGgVJ0mwgurcPZU+Dyxvp5pjLsOQTe/4Dl4uLo4Sm
         S+aHgTwADS05qKhJ+ZudOJSRTWYCH9OSrrTAmBhq/UP/PeXLJoqWOoJxWQmr8Bk5yVXj
         1loVDAIiQ5kjuFldZtWIvVB6U0RhkOdxGvqDQ4dRXIl+i0Vm/Gc93XcojEuYfA+F4S86
         2M+Iy4kXIM3mOn6WS+Ic2FRKdy5+804FAKRFZet0YkhnsfnPR1s4+mRyW8tKSVQ7FAo0
         5CJDudk3prn33ozoBSRRWIH0F39aeF09VZxogGjMMZdgaVdo2g2Z613fZcXcQZMr2u7W
         4WnA==
X-Gm-Message-State: AOAM533SeOhlGWMrLFE3/iCEqxMxvLgAQ2HxSyjZ7bT8WYsQyNr9IEHj
        9P2b/Z/eExHsJo/2LinwkEnosMTI
X-Google-Smtp-Source: ABdhPJwpBDGa/oZHpiNLCXMdd9OaBBvndC1ptVqSlJzt4PzwGa6UukHnTimOjEs/lYBPL/E/BEd/gw==
X-Received: by 2002:a17:90b:4c4b:: with SMTP id np11mr21045082pjb.58.1593499682973;
        Mon, 29 Jun 2020 23:48:02 -0700 (PDT)
Received: from gmail.com (108-81-23-119.lightspeed.irvnca.sbcglobal.net. [108.81.23.119])
        by smtp.gmail.com with ESMTPSA id k12sm1460501pfk.219.2020.06.29.23.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 23:48:02 -0700 (PDT)
Date:   Mon, 29 Jun 2020 23:48:00 -0700
From:   David Aguilar <davvid@gmail.com>
To:     lin.sun@zoom.us
Cc:     =?utf-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh' 
        <congdanhqx@gmail.com>, 'Pratyush Yadav' <me@yadavpratyush.com>,
        'sunlin via GitGitGadget' <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] Enable auto-merge for meld to follow the vim-diff
 beharior
Message-ID: <20200630064800.GB1962986@gmail.com>
References: <311401d63e0e$b1ffe490$15ffadb0$@zoom.us>
 <0c2401d64d14$aeafa680$0c0ef380$@zoom.us>
 <20200628103755.GB26319@danh.dev>
 <bfc401d64df4$cd189e70$6749db50$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfc401d64df4$cd189e70$6749db50$@zoom.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 29, 2020 at 05:08:02PM +0800, lin.sun@zoom.us wrote:
> Hi Danh,
> 
> > It seems like only David Aguilar (Cc-ed) works on that file.
> >Look into  b12d04503b (mergetools/meld: make usage of `--output` configurable and more robust, 2014-10-15), it looks like we need to check if --auto-merge option is available in meld.
> >Someone still live with the ancient tools ;).
> >meld has known --output for a long time but we still have a check for it.
> 
> Thank you for your hints, I changed the patch for checking the option "--auto-merge" in meld and use this option only if it's available.
> The last patch is appended in attachment, or https://github.com/git/git/commit/3b70fd0bfc4086a08e27c869ff7492d567e8fdc2
> 
> Look forward it can be merged this time. 
> Thanks
> 
> Regards
> Lin

Hello, thank you for making this change and keeping the checks around
for the older versions.

One comment on the patch -- it looks like it duplicates the version
check logic.  Would it be possible to coalesce the version check so that
we only exec meld once for the two version checks?

The changes look good nonetheless, and perhaps combining the checks
would make it too complex, so this looks good to me.

Can you please submit the patch to the list here?
Once you do, please feel free to add my sign-off:

Signed-off-by: David Aguilar <davvid@gmail.com>

cheers,
-- 
David
