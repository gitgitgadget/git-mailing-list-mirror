Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EACC433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876F061A89
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244619AbhKOXS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351736AbhKOXQb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:16:31 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DFCC03E02B
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:17:58 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r7-20020a63ce47000000b002a5cadd2f25so9789443pgi.9
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BfhQgxJV6e2Kp5quTYBL4Kq89Agh0Lf/baQ6D2nhsV0=;
        b=WLby3HnhxUJFG6dZ1AyK3GZe7SaAfK+KBmjTcndyrm+fTTamDTAEp55p7Y7kIiboAD
         RBe0S35z4rD+Ut0Nivu5OTnBFvZtOMdl1xqklyvwHTc366qnZbCt8AnaEMIP2AD0tHfL
         c6MJ0K40o5fy/orp7Cjz1AkMBXoMCOXT3IwB97onPd7/K1V9HvCqznVDFOjV7jDLq1fB
         pkQw5zWFEDaIPdNrzxRxm4r6WLxMgunKn93BTE2athEoicZf5ppuDIgRJDwFq/06F8iD
         LvROPheEmzrUYkHztnb/FguoeP5FZ41zya9zBXch3kfskCTUZBTDN7+Juv1ENDEdVOLm
         yMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BfhQgxJV6e2Kp5quTYBL4Kq89Agh0Lf/baQ6D2nhsV0=;
        b=bjgJ7J3ODHgM6c6IIJEifxAw1Y3trFpkPDOFRpuWUabRMDrx3Wy9KLADN1Jp2Mv3VR
         SveopVNOZa3oJp/yOGiiXdIPqO7E/W6Bj7Z+nDNlZvCTjxES2vPypLdD8nfNPO+yEu9Z
         wTAUQwD/j6lqF1bpzRJT6+0vsxSsEeAt5s4IyBgpRHVX05sXT07QEaUy8flcyFoEgsvc
         wi9FYkKPTCGjn+Um4ffTljBUv4CqrFgPXxVjVpog/fJFA0MEyYhkpqIqrfD7ol6rqiML
         3MIvyXJRfaedaSA0SAXLIgGTRBgfsM/YMNtwTMbOkJtcYWipvv4M7Tr2+WgFDK6xWzx0
         lAmw==
X-Gm-Message-State: AOAM533hj3kL33nqoehbPBlCjYKbKHCrodh0pOsnAlyb72k5KeZle2Ka
        WqMq5Lcy9dw7Q/MnHlHdG8TthgGkYjo8kQ==
X-Google-Smtp-Source: ABdhPJxmJHFLoeH3x9/o8tUwazQzGy7hNv9uHMLQrN8Nos2X2S4RANgjBgHxqvCOp7u8lV9AjoPhcJO/vQBidw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:33cf:: with SMTP id
 lk15mr2498120pjb.85.1637014678369; Mon, 15 Nov 2021 14:17:58 -0800 (PST)
Date:   Mon, 15 Nov 2021 14:17:56 -0800
In-Reply-To: <kl6lv90ytd4v.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lczn1jc6j.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lv90ytd4v.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v1 2/3] config: introduce repo_config_set* functions
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>>  - A change like this should make existing config_set() that only
>>    works on the_repository into a thin wrapper, e.g.
>>
>> 	void git_config_set(const char *keyu, const char **value)
>> 	{
>> 		repo_config_set(the_repository, key, value);
>> 	}
>>
>>    But that is not happening here.  What prevents us from doing so?
>
> I think it is _possible_, as long as we plumb struct repository through
> the call chain all the way to git_config_set_multivar_in_file_gently().
>
> [...]
>
> I will attempt this plumbing, which will allow us to make
> git_config_set() a thin wrapper. However, if this turns out to be too
> difficult, I will implement branch --recurse-submodules with child
> processes and leave this for a future clean up (as hinted at in the
> cover letter).

I believe that this plumbing is already doable but it would take an
extensive overhaul of config.c as well as some cleanup of path.c.

This is more work than I am willing to take on right now, but I'll
revisit this at some point.
