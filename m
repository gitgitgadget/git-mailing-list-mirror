Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC9DC636D4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 22:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjBJWCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 17:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjBJWB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 17:01:58 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7F5D514
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 14:01:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id d2so6639637pjd.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 14:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpQznfHHfkHwcDOAqDo2pbBUtKX67PvvkB1Ns7t9Sds=;
        b=JyuZmMKyIxkCA5mGiEHpuFcGJWSwl9SKPShLTTAG1nHGfywfYfmjNJ5mzqlM3mAZKw
         MWJX4nRHoQZ/IDI5UNToI7w7t4+zIkekPLvOIb28tztuQ+brP+IRvvwcN8E9IKX9yS8O
         04xdNpl/tk2Fu4b0kDg6XFEutd0nFg6jbdCb09g2TKT8fs6PYxr/MuxDAR1KQRcI0i3m
         HxDeJ1utIWB8YEGYrxytX4bO1fFI94wJWDNVoqcHgadXorjD/yaKCXRUcRiSS9PNc4QB
         xehXayWqhvFD3/SKWJw74lp/KbOOkENDyGjwRFiM6tT0OmYsaFDAd1jJwjSC2nTbQq1q
         cf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IpQznfHHfkHwcDOAqDo2pbBUtKX67PvvkB1Ns7t9Sds=;
        b=X4BnAmeVSnvfCnzWb+WfHMcTtzmuMyWLVH2iuEpTt/iy1yaDvgJGIwDqDAa5TFlW5a
         5JumpYnLYkyTk+He3qAQslqP50D4ZN6ck3+xvD4unMr4p+bmFOaD0stOW6iGGzu0Gx0H
         cXAsAX6kfO+7Ri+cDriklFfspXM3Wgiu9Iolfq5BipfrzMmBLj98QUElt6UWfh3d4KgB
         yvla8mmiWbhUK+hfwQn2i4rlbWWeo3KZqQLbSQBizN5UxV2OEQcd/C+emrQ5u6mkU4+j
         zVyJ0hbhzHM4RYe8B9pAsygIue53rO6S0ZHJ+4mmLxPprkuE9zI8b5g5bWgG9elJrkJR
         LWLg==
X-Gm-Message-State: AO0yUKWKsZN5d7Ia5c9b5VkWvMGKm79I/T6VpML3GivieZ4ewFYcyIG/
        j+XWen5EHUXAzT3j8gBC18U=
X-Google-Smtp-Source: AK7set+5zB8qkRMYzIgeoT+/vGMijoiBCKvWmkcnF4Ph2KtCM7UBqWrSKY3Zk05evowAJR+iXVOEqg==
X-Received: by 2002:a05:6a20:6901:b0:b8:8a94:5bf with SMTP id q1-20020a056a20690100b000b88a9405bfmr18397301pzj.21.1676066517099;
        Fri, 10 Feb 2023 14:01:57 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0056be1581126sm3819789pfi.143.2023.02.10.14.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 14:01:56 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] {apply,alias}: convert pre-processor macros to
 enums
References: <20230210171338.81906-1-vinayakdev.sci@gmail.com>
Date:   Fri, 10 Feb 2023 14:01:56 -0800
In-Reply-To: <20230210171338.81906-1-vinayakdev.sci@gmail.com> (Vinayak Dev's
        message of "Fri, 10 Feb 2023 22:43:35 +0530")
Message-ID: <xmqq8rh5gox7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vinayak Dev <vinayakdev.sci@gmail.com> writes:

> Revert changes to alias.c, and change variable types in apply.c

When you send out a rerolled series, you do not have to show your
past mistakes.  This [v2] is structured as a three patch series
whose first one makes a similar mess as what [v1] did, the second
one and the third one then revert some parts of that earlier mess.

That is not what you want to show your reviewers, and more
importantly, that is not what we want to record in our history.
Rerolling a series is your chance to pretend that you are much
better programmer than you who wrote the [v1] patch.  The review
exchange is to help you do that.  Please take advantage of that.

You may find "git rebase -i" is a useful tool to help you pretend
that you got to the ideal end result without these "I tried this
first, which was wrong in these points, which I correct in a
subsequent step" steps.

Thanks.
