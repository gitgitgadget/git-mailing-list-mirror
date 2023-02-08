Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1290FC05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 17:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjBHRni (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 12:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjBHRnW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 12:43:22 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB065455A
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 09:41:23 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id a23so13141376pga.13
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpPZeSUa486A8AZj+eQPz82Pir6WlSfChNCPGgR+UbQ=;
        b=TKP3D+aYM/1EK2i/jJkEyoJ+aErziVsPEIc2yavZMnD9AhLac21Qbn7chMnVPPq8rs
         +8olJMJYMIUBFZ6C7VhIDlVpW7DbM6Q36AWkmU6y3vmPt6LB8epXslNwP/KzMdCoDCBx
         Cgxlqab39tac3Zc6bgetwX+RO5BPKLLe5HtbHDke7spvmV1F10V+H9fwawq2OE1ELJpt
         ALop5nZAX6zWNnkbiWGfo6hctst3lrLAht7X5tFfExM8Cc6zeNuqtaPlSeLp0R68aTod
         GE4aJiIJNFlZHx1QjJjF7wOF1imJRq0VIvoptYG1nM79+iIwp8LCXohaAwYAq+wjwIKD
         Af3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gpPZeSUa486A8AZj+eQPz82Pir6WlSfChNCPGgR+UbQ=;
        b=YjMIDDjXOEufU8rtu3UDOGlxzcTy4R4nTeG5SYTbbnfASN/X833qiGpRL4L72p2KYI
         TKhItND9Lnj00jkJfKVfOFSIwfanPsywYB6rVQk7qt5GFUtMn27OSedvKcQe0OfgHr1K
         ht+DC55mmTlVipUOsDrcqa6N9VAaft6BCFsr3g5vCHbDRT3lX6Arg8mnMZH4p1k9zx81
         bmVoJ6i8LXO64MOOySA97MjHc4Sd3XI6NfKcAI8aASaZEhthkIY21z68VywaoxXCvmIX
         aPIxfxCDvGUzNQG+Z1i7qzqDX8lg4pCGmzo1V5KmRBqYY8uMtHAxnpgDGzo2VRB//S9w
         eZ/Q==
X-Gm-Message-State: AO0yUKV561tp+sT+QwhGAMycY2/cdnTzpKrCVdLHbwg7Wjpd/cwbNzml
        69cMBWtZtAR9/rbre5ibSPM=
X-Google-Smtp-Source: AK7set8qynAZOpOEP/ANgmXHUuLqwALHqgfBgiXFyfksJBygavMKP1niTL9ibg7ePt8oC5wHwvndfA==
X-Received: by 2002:a62:502:0:b0:5a8:499f:8689 with SMTP id 2-20020a620502000000b005a8499f8689mr1616596pff.23.1675878007654;
        Wed, 08 Feb 2023 09:40:07 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id h21-20020aa796d5000000b0056bb36c047asm11487098pfq.105.2023.02.08.09.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:40:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     William Blevins <wblevins001@gmail.com>, git@vger.kernel.org
Subject: Re: Unexpected (bug-like) behavior in `git ls-remote` matching.
References: <CALJHx121C+=mAmfWxko0PUy1QBjfezM4ft6uE1+cyiH3gaLQ2w@mail.gmail.com>
        <xmqqedr0vd1l.fsf@gitster.g>
        <CALJHx12DetwZ=+aMEG6Ss4P3fMTeLN2styXuPw93C5N6yg98NA@mail.gmail.com>
        <Y+POCxHMzrZj2bwz@coredump.intra.peff.net>
Date:   Wed, 08 Feb 2023 09:40:06 -0800
In-Reply-To: <Y+POCxHMzrZj2bwz@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Feb 2023 11:30:03 -0500")
Message-ID: <xmqq357gt5s9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think the tail-matching behavior is not what we would probably choose
> today, but that is how it has behaved since 2005, and we are not going
> to break backwards compatibility in a plumbing tool like ls-remote.

The tail-matching behaviour that was Linus's preference (his
show-ref behaves the same way) has one interesting feature---looking
for all 'master' branches in different hierarchies is trivial.

In today's world, it would be tremendously benefitial if "ls-remote"
can trim not just the communication between the repositories but
also the enumeration of the ref namespace at the source repository
using the pattern, and tail-matching would not contribute to it at
all (unless if your server side adds special index).  If we used
prefix matching, our refs API can take advantage of it in reducing
the cost to enumerate refs, and on-the-wire protocol has ref-prefix
capability to help it.

> Likewise, something more elaborate like full-path globbing or even
> regex matching would be possible, but would need to be activated by an
> option.

True.  We should be able to do a bit better than just tail-matching
with an option.

I would not recommend sending over regex as protocol capability the
same way as ref-prefix works, unless we adopt something that can
match linear-time like re2 and use it everywhere, as you can send a
pattern that is deliberately made inefficient to inconvenience the
other side.

Thanks.
