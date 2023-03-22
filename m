Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FBDC6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 20:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjCVUxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 16:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjCVUxF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 16:53:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AE555B0
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 13:52:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q102so5133088pjq.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679518366;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7ORZzY0lKNWqhESXJlUXNT9nwGHWdpP0rs+1RhinKc=;
        b=Wnv0Y1KSUzqntjn0+FVurWUrcKr6BF7hUDrL9lPqXbOvjj4Imj7XABSr5vUrW0qTAc
         u9Cjw6xGK++hVTmIZSNNjVkcfGqJ/rlqoVP4pA8AR9ZZ9c/AL+i0F2hue1S7iWV/y2Ow
         Ez5yD5o5FCLsTHnyknc3aMxvT04sLfXC25JUwTr3pujqQJz6WaWuhAXjS12PnTP4cxtp
         bLocKreZQeONILuXZQ2DcErmBrhFXXblYbLJjiF7A0He4AEgh0HW1A0yGiMo5CE8riLm
         vWIW3pYuyc35X4E8djJhn6GHejx/271O6APJbL5NUJvEIOSjwETkUg0euI7wbP62yrmF
         2E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679518366;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a7ORZzY0lKNWqhESXJlUXNT9nwGHWdpP0rs+1RhinKc=;
        b=2WuGsKYZpX9FMDvltIkrT51qZpklxQqHSRrQ1yAqaRzMjdhYQKIAUb+SyJ3xXmXJZs
         Ly2j6uR3S76fPUWeHtPdtrFR+F9lAIB4T6eJUXa/hP/5tdWDbU4gIWyQ8dy7+0b+hXsi
         n98ZSO3iz2QxTZGj0VeYGm0jtQ/2YinuiTB30ouf/VsXEM0z9ZHgddIxPs3Db6LogFFm
         qEc7KUZRWUXNsxFicJkr++aytELZocUawoEy4J20kjm+vZLjLdXiNGluPjoPodcwQVPX
         3ly55xoI2zkf3/MmzuYsQfQIT+30gKWVLgNNVkvMLf72YFbzuk4lIGOY507YQyzW5hYz
         OtgQ==
X-Gm-Message-State: AO0yUKWb+jLEyS8JBiXfNGNjl3H/sKpjy2b7VECtIB8NDymUPGGJ3nQG
        D0MPgnjwvBw0uAYKeDo9EREvnhSnzsU=
X-Google-Smtp-Source: AK7set9Inx20mK3p1TWCAcG41s77dJpum4lqOPWJ5TE4ClAkovusEm20w/hZDXKE12rR/+5Tloo3OA==
X-Received: by 2002:a05:6a20:4f26:b0:bc:b9d2:f0f8 with SMTP id gi38-20020a056a204f2600b000bcb9d2f0f8mr680848pzb.24.1679518366411;
        Wed, 22 Mar 2023 13:52:46 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id t21-20020aa79395000000b005e5861932c9sm10470328pfe.129.2023.03.22.13.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:52:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Clement Mabileau <mabileau.clement@gmail.com>
Cc:     ctmbl via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix mem leak in branch.c due to not-free newly
 added virtual_name variable
References: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
        <27f27f3afd76fc974350c0c94e20307879eead84.1679478126.git.gitgitgadget@gmail.com>
        <xmqqmt44enj3.fsf@gitster.g>
        <bd5207a0-9783-6a15-93da-0904ecd21341@gmail.com>
Date:   Wed, 22 Mar 2023 13:52:45 -0700
In-Reply-To: <bd5207a0-9783-6a15-93da-0904ecd21341@gmail.com> (Clement
        Mabileau's message of "Wed, 22 Mar 2023 21:00:54 +0100")
Message-ID: <xmqqv8iscxuq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clement Mabileau <mabileau.clement@gmail.com> writes:

> I just did it!

Nice to hear.

> Thanks for the review.

Well, I didn't "review" anything, though.  I just commented on 2/2
that will become moot in your updated version, and I didn't even
look at 1/2.  

The change(s) as a whole need to be reviewed by somebody.

Thanks.
