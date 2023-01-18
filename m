Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8707CC38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 20:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjARU71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjARU70 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 15:59:26 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA3853FA5
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 12:59:25 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 200so21063757pfx.7
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 12:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vtibia0rjzHjlSs+e/OKi00ZDh2ffYkkMN5TceAAbAo=;
        b=d7mQ0aHNErLRBl+dyXGcUuON15+QS3lJzAZ2FCFCI6VnTFLx6kJXgvYwnNkgn5+Ela
         2XMHVPcQDw6VrbPWLw8UOZelzE7+eas5CHi/rZCKPt5Gj5El7pHuU9li3K8RajFMj0xV
         AgcK2wUsZRWGVlZ48s44dJFGUK4RvlZW6f6Q1ulT1Ia4CSblM6IqORmXTqtamzQPoQxB
         YBSumBO5JhzOawiJwHGlkAieU3OIESO1KASJnCmuhAAiCHGHIWIuiLqd8AKbyFAE8zap
         YECp0dK6HFEoOhohUuUGf+xHyXR2UU1v7XYln39lbulg0qw1NN3W2KFRliNi5C4IZdWj
         L58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vtibia0rjzHjlSs+e/OKi00ZDh2ffYkkMN5TceAAbAo=;
        b=0NiP3PE0gKdzxzMauJSrRoz1Sy/ukL1IYA1EG+xd0GV4zxTlDKtp9XMmcMJS0zFyc4
         ORW4t6yGx54RpHr9J6nRbuLUMnWAWY7PQPTmv5RpuXYlDRwxMzmTGFiLpzWOXIPLT9ZR
         ggq/s/i0XYVvZ4dM4NaarryRjJUIX6iZJdWMZd8Hqobtjnb4GdfA/9nAPMz1vmv/ldBY
         FQWy3e/jFi0LWep99qLwOQsA5/EAVvX3iXo1cXqDZM4GxgpNromX2zT/KjGS8pVO0qfM
         cHsivLv+OSWky7w8UfFw0rRS+pMnahQrt+jAMB/KuYwfgkpLD6cLX+TKt9iAANHuIvDd
         Ev6g==
X-Gm-Message-State: AFqh2kp4bZurn8kIyzeZ1yvEdDhD5lwp6oSoMK/PHuEaZGv21Qgpu9gZ
        KMoqo6crB4TZWnZAya/UTys=
X-Google-Smtp-Source: AMrXdXt55QERd0278s+LfHBdMZwd0cnVOjZA/p/9OK4hX+FZxqDYZI989gkF8jTp9pQ4Ck13AbWaUA==
X-Received: by 2002:aa7:81d4:0:b0:581:b3b3:7717 with SMTP id c20-20020aa781d4000000b00581b3b37717mr8433487pfn.26.1674075565043;
        Wed, 18 Jan 2023 12:59:25 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h66-20020a628345000000b0058bbaa5200dsm8452713pfe.214.2023.01.18.12.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:59:24 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC/PATCH 0/6] hash-object: use fsck to check objects
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
Date:   Wed, 18 Jan 2023 12:59:24 -0800
In-Reply-To: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 18 Jan 2023 15:35:06 -0500")
Message-ID: <xmqqmt6f4l03.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   [1/6]: t1007: modernize malformed object tests

Obviously good.

>   [2/6]: t1006: stop using 0-padded timestamps
>   [3/6]: t7030: stop using invalid tag name

These two are pleasant to see and revealed what are "accepted" by
mistake, quite surprisingly.

>   [4/6]: t: use hash-object --literally when created malformed objects

The --literally option was invented initially primarily to allow a
bogus type of object (e.g. "hash-object -t xyzzy --literally") but I
am happy to see that we are finding different uses.  I wonder if
these objects of known types but with syntactically bad contents can
be "repack"ed from loose into packed?

>   [5/6]: fsck: provide a function to fsck buffer without object struct

Obvious, clean and very nice.

>   [6/6]: hash-object: use fsck for object checks
