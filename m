Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D2FC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 16:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C976C60C4A
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 16:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhKQQvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 11:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhKQQvp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 11:51:45 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF201C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 08:48:46 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id jo22so2429739qvb.13
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 08:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e91CNcwuel24YmiDLmwFWwTiYVWK5Gvu2Jq0grkPth8=;
        b=KgKK+MDlE8WJDbhM9yaCje/iJt9Svj8zXcLXcjFJdv4xN2i7DiKANeOpY2D4JPHvku
         jbiiqnmP5t03SlCn+QtBeJj8L2q30WWpSEx+lwFEFbNBp8nVFYHgPhGW6Qz4naXyhFmW
         hC68ASqS/gmStyDGY/wI8MUcEso0GbAuKVO8973UcrpXfhwTi5YXcPzwLE5QzIPULnGY
         70RX7YGlv7hVHPJUCTPN84Q7O2hUw/h0CzPWRofwCs0DMtGS9SXpH7l4rBp3ICl+Tlxb
         arA7UMX1zc9eOsK597G0JHNT1rEg9YCzCrVino8/mwViPBy+duNRhjbRKjYWNlxRRF8N
         obrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e91CNcwuel24YmiDLmwFWwTiYVWK5Gvu2Jq0grkPth8=;
        b=a6c/1JAakLEstAMgs80IwcTnSGvBP7L6SM9ynJeok92PVobD8A+oYmzsY8BdRhJmCg
         7x1cTqBidIRzWTWM1lgkqdF5WcuesZxp9jq219F3R38+bBFouW48tbpgDW42mMHdut01
         bQP2x52xg2AvtSPe+7UpF2vgPrBXhAZhdqc4YSpja1wWDk1OucvIYtMedPdGR5SOdBxb
         3Aqdl8x6wLqrJ8IR9xeH5Micfo3Lf8oI4uNa648Dee4zPlseo1bDprYB5QTWlgBX9TA7
         cVMVm+dJGo6W5724rLFk1DWFNmW+ya+Sk6ISPJwBFOmR99DmqLM4Is7o/c9HMen9aImK
         puQw==
X-Gm-Message-State: AOAM530ucMuJI7zuBlovu50skXspXLhI5vly3C3TLxGjviktTruNByy1
        lB2qVm9Y6ebRZpZy8HJXP0g=
X-Google-Smtp-Source: ABdhPJxLY3akA4+Xl28peTFN262VGAz4C24N5iZOwargxKRJJCv5G20B+GVR0DPY3/28PfKLmnP9Tw==
X-Received: by 2002:ad4:5eca:: with SMTP id jm10mr56864089qvb.54.1637167725938;
        Wed, 17 Nov 2021 08:48:45 -0800 (PST)
Received: from samxps.. (modemcable158.252-203-24.mc.videotron.ca. [24.203.252.158])
        by smtp.gmail.com with ESMTPSA id h2sm141059qkn.136.2021.11.17.08.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 08:48:45 -0800 (PST)
From:   Samuel Yvon <samuelyvon9@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, me@ttaylorr.com, samuelyvon9@gmail.com
Subject: Re: [PATCH v2] builtin-commit: re-read file index before run_status
Date:   Wed, 17 Nov 2021 11:48:42 -0500
Message-Id: <20211117164842.36381-1-samuelyvon9@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <xmqqpmr5nekx.fsf@gitster.g>
References: <xmqqpmr5nekx.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for the time I took to reply,

Junio C Hamano <gitster@pobox.com> writes:
> And moving the call would affect both the contents of the status
> buffer (i.e. the list of paths got changed starts including what
>         pre-commit did) and the "committable" bit by counting such a change
> as a true change, avoiding the "no empty commit by default" check,
> in a consistent way, hopefully.  I wonder if we have test to
> demonstrate that, and if there isn't perhaps we would want to add
> one.

So, just to make sure I understand well, the concern is that an empty commit
would trigger the commit routine, run the pre-commit hook, which may add files
(thus making it an non-empty commit) and then push 100% automatic changes to a
repo. I agree that this would be invalid behaviour and very odd, I will 
make sure no empty commit is allowed.

Junio C Hamano <gitster@pobox.com> writes:
> Samuel Yvon <samuelyvon9@gmail.com> writes:
> > However, calling run_status after the cache reset does not update
> > the status line to state of the current index in the case a
> > pre-commit hook is ran and changes files in the staging area.
> 
> And if this change also affects the "committable" assignment in a
> consistent way, it should probably want to be mentioned in this
> paragraph, too.

What do you mean by "commitable assignment"? 

> I am not convinced by the claim that there is no need for careful
> transition plans (yet), but I personally agree with the end state
> (with the above suggested tweaks, that is).

With the last message, I agree the safest option is probably to leave this
configurable for now and off by default.

So here's the next steps that I intend to take to get this merged in:

- Add a test for empty commit (if non-existent) and ensure the behaviour is the same
- Add a config option (or maybe a switch?) for migration purposes, with the default
  being the current behaviour.


