Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B659C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 16:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCIQbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 11:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCIQav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 11:30:51 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771FEF0FE6
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 08:22:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y2so2600043pjg.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 08:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678378922;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGnMsTP0gEAlBi6NQDWu1PVgPMCG8V7YHhbr+Su4F68=;
        b=TJ/EkRIL5WEOHHVXoDLX0WX6nIXHRaOa3YpUlfxRcLc0PY+ZfNPrulm7CXUb/POBcY
         1PBvnGCTgQfecpqT/FA+WgmKUptUf1A179J1roo7LzxX4nS74dyEnAboMlghN+we6l3S
         wydTT6/UP8mQZ/Z+7rItKrc97My0YIoQ/NU3ke87ojBVPqdyuvwZRE2WYGPbStM42+uV
         DosQ+cCF8urDiKTt2glJjVOHNifM0pngpntcoX1UT2ZeqE+cMtRrDxEQDlQV3T8EiKxK
         ktgStMhKXrPZtJoLmPhESofhEYlUDw5cqncfq/7nyxdNk++LZaMjudmudN44z4xl3XFE
         5OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678378922;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XGnMsTP0gEAlBi6NQDWu1PVgPMCG8V7YHhbr+Su4F68=;
        b=QYhDBEwiDkM2kYkAcj4LcJS83CKo7BF+n/qbwSkEqkBtGUSjqgfLeNn4mJh2A7EOBd
         A6F3DnoZgY67mxedhJHvauJpKd4Kjx4lQL8mVp2qtOQRbx11ZgiZeCgfH4LXTML1HLqZ
         Iela6nEvNMGUC/cVFTigKG6tkeCYnYok5DKBLrr3onJWZlYSKXX27H0DRNKJrRN8HaQ6
         SXL3ijH+wv1QUdSWcGFlhhIRfrGrR2vu0HA8tJRdLB2bOnw8cQlmZaEbH4D7hrOEhWE5
         nDXHlXlBY2Akt905c9x4JUUWVaB8hsi0aoif7rcnYAV8qKzAk/QFcIQIsait9L+Twi+g
         fcCw==
X-Gm-Message-State: AO0yUKViPqiDU2wpUeVVP8r0r9rzVpghJZqpmvZpSdWGsrpTAnWnRRan
        Bgkk559uiw7I63VNDMLG+V5FwalQAjs=
X-Google-Smtp-Source: AK7set+7rp6gq4l+C9xEMn3oQHRxUED6htfu17+Mprr3rc+QIU6nbx3kyib1cE4FCmfhRGo3x8eV1w==
X-Received: by 2002:a17:902:7e0c:b0:19e:2ea1:c0f5 with SMTP id b12-20020a1709027e0c00b0019e2ea1c0f5mr16836466plm.33.1678378921875;
        Thu, 09 Mar 2023 08:22:01 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id l191-20020a6388c8000000b004fc1d91e695sm11323257pgd.79.2023.03.09.08.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 08:22:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Better suggestions when git-am(1) fails
References: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
        <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net>
Date:   Thu, 09 Mar 2023 08:22:00 -0800
In-Reply-To: <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Mar 2023 22:17:11 -0500")
Message-ID: <xmqqedpxq4if.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Mar 08, 2023 at 09:15:53PM +0100, Alejandro Colomar wrote:
>
>> I had the following error already a few times, when some contributors,
>> for some reason unknown to me, remove the leading path components from
>> the patch.
>
> The reason is probably that they have set diff.noprefix in their config,
> and git-format-patch respects that. Which is arguably a bug.

FWIW, I've always considered it a feature to help projects that
prefer their patches in -p0 form.  Of course, Git optimized itself
for the usecase we consider the optimum, i.e. using a/ and b/ prefix
on the diff generation side, while stripping them with -p1 on the
applying side.

I wonder apply.plevel or am.plevel would be a good way to help them
further?

I am not sure making format-patch _ignore_ diff.src/dst_prefix is a
good approach.  If we were wiser, we may not have introduced the
diff.noprefix option, made sure diff.src/dstprefix to be always a
single level, and kept -p<n> on the application side as an escape
hatch only to deal with non-Git generated patches.  The opportunity
to simplify the world that way however we missed 15 years ago X-<.
