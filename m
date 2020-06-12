Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1C0C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 17:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0A320885
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 17:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCObRIgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgFLRDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgFLRDk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 13:03:40 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73287C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 10:03:40 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id m18so2404173vkk.9
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l3B+YYsEte/LXfDzWyYCgZHs3XPlQmQsYjCewCRn7V4=;
        b=rCObRIgnTqTN6ZRCxGTE4fTHVq0LZ5UFv2zvbi+oEf417jiwz7rxfL0OXCpzCYfS+S
         tiYgtdfPQEws2wDEPEpMts77WDEIgrWnU61cGv2ISnNU2JlmW7Pp0hmgIKsvwoGMbwiO
         eWJmSSRrTBl+BHmeoFKc8D3uu7ZTUPMK6hKi+ipNO47bZ/NNb6kiThPfbb/434CyfRVx
         uZBePwcBWEfT+uMkRAobo1rVwgGBcOtJFuk0Oc2Bb675AlYaHbogihumYM3b7SgtD2k4
         ajDS0bEe2esBR5t62OJLZBtBvXE5ZoQxdKJqghMeOqJlg4d7OtyO9OOEMoOlJ6IiGkYo
         n/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l3B+YYsEte/LXfDzWyYCgZHs3XPlQmQsYjCewCRn7V4=;
        b=YX9/qp50HPJrrQi9/XFjurj5iuIXxLxjpyt+NEI6bSOwMYZWGbfb6fUVF2KoB9APfs
         b9pY/v8WLy8SNnrFuJ6qGPuZ5QqTpVm8uPKq1FmJZtGcRDIbYVN6LsJ5G6S1gutAfNn0
         fKxNXkZV7SQ2RokYL5V8fkR7dI38Blu9zIWArKZ7UHkIsNiqX+Nl1Bwq78a2r2pT1948
         SfaNbTwkVocagrIs6K+8aPhhH0yV9pkep/UQJUvmyaBxzZNb6IDv/qYQpTpvmgxy/Y1v
         CuHDB9Ew7BgiRhUCsnn0Xn2xE4QX1Q+7Vk9JT/HPdN2mLu2LVtxyI/Tyn/Wv5tEE7vbC
         Od5Q==
X-Gm-Message-State: AOAM532qd9arz9HOUOWxDjWkRqtL62QwRimz+OQ/zDafro+Tgqrk7TbB
        YnCtIkYNSBixGniiomLz1ra06wVx
X-Google-Smtp-Source: ABdhPJzMMgkl9Duko0kzUJCButSO8bcwGQmP6ZIoRQ5dJ6WyWQ+lP3d/oy7EUxi8at+Wm1qh9+nPLQ==
X-Received: by 2002:a1f:bf07:: with SMTP id p7mr11220831vkf.2.1591981418756;
        Fri, 12 Jun 2020 10:03:38 -0700 (PDT)
Received: from localhost (25.173.196.35.bc.googleusercontent.com. [35.196.173.25])
        by smtp.gmail.com with ESMTPSA id j20sm969841vsi.8.2020.06.12.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 10:03:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: GPG Commit Signing Project
References: <E7E8DC8B-BB7D-42E1-BD0E-EF59775B9E75@rams.colostate.edu>
        <xmqq1rmmg1ds.fsf@gitster.c.googlers.com>
        <20200612015556.4kvsfcwabuaxuiuc@dev>
        <20200612022407.GC6569@camp.crustytoothpaste.net>
Date:   Fri, 12 Jun 2020 10:03:37 -0700
In-Reply-To: <20200612022407.GC6569@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 12 Jun 2020 02:24:07 +0000")
Message-ID: <xmqqd0642p3q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-06-12 at 01:55:56, dwh@linuxprogrammer.org wrote:
>> I now think even that proposal is overly complicated. I think the
>> easiest solution is to simply standardize the existing pipe-fork
>> interface as the way GPG talks to all signing tools. For signing tools
>> that have different command line interfaces than GPG, we can create
>> adapter scripts. Tools that want to be compatible can adapt.
>
> This becomes pretty tricky because Git parses OpenPGP headers in a
> variety of places (e.g., at the end of tags).  If your proposal is to
> wrap new formats in a fake OpenPGP format, like some existing tools do,
> then that would be viable, but otherwise you're going to require either
> Git to know about your signing format specifically (which is not a
> sustainable approach) or some sort of configuration framework like has
> been previously discussed.
>
> If you're going to wrap things in a fake OpenPGP format, then you don't
> actually need to send any patches to Git at all; you can simply set
> gpg.program and continue.

True enough ;-)  Thanks for a concise summary of the situation.

