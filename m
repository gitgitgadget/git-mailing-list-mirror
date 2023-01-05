Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F819C53210
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 02:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjAECQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 21:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAECQY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 21:16:24 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EE143A22
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 18:16:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so611596pjj.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 18:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyBNY4JdU6V6bjQs54JgfdFM1XBYyRWbVzv01FQ2+JI=;
        b=kaz5eSemSUHBniu+fYSHXZN8ZdrAOry7NELng8QH9ZdmcC2mxEhdK9FbO9/AsFRjCC
         PFZeMLDfVvZNf7oct2tkdRvGx20a07SNnph1KUrjMBLT1yuxwwUihtheyzpKdmfoyfKP
         maRAZwCnqmz3MQ4eb0T1mvWl4d7Q98/3T+K/Uyr6g8bVSgeVpXzxnbnQMD/OyUi3yqPD
         PuxfEuWY86/9iOCMHlGnZjhHuQWJJlgdc26el6o1X87ZawR2uB4P3XaS927MYn5LNqE9
         hQysdf3yoCbuLJ91GtbmMDxdoJHwt6jP4n00alj4dx04wwF8NcYfJDVuV4LXyCvINon0
         Ttog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KyBNY4JdU6V6bjQs54JgfdFM1XBYyRWbVzv01FQ2+JI=;
        b=vTTmrgKABEiQBgd27CqccdWClqxwITLDi+67zZ3NTSUYlnYLOK05BOatd7guYV0IsJ
         LQr8hsINK4eA4EkXXKbRgjusxS5PwR7/hNGmgVAcuuQXagLhJdDiOyG8SDmvtXNzCjOv
         Bu7UHTa/g2wvyy4nlCyY4nsnjLftRlmkvUIL+yttt+UWg8BIPAdQ5ZgKCfcrQpGIJBdx
         tVsPYU6NxEflZLWeME0YAdD2LfLHZVWpgZUDaGnXJ6dgANnNrJoshLES5QUHeRgEWmlv
         8JZax4cqt5A2Cf8s++ky+hxbmw9bKCO6ZpvK55WhtDmvrf8jpsdQnVV68Z34C6YtJHQF
         DAaw==
X-Gm-Message-State: AFqh2kqFbn0J2w+yGeVZC5a4kOhT9aggaD+pcDPhe5vxAmy2MUImzMug
        j2yMIGsnJm7wCR/ZW9Q/jWg=
X-Google-Smtp-Source: AMrXdXvK6wuLMtML0c1VEP2EPjDTbN62Kkpq1Tos0u2cL2H4bDcqxt8jfu4oMO4plYUTwvb2Qiu2jg==
X-Received: by 2002:a17:90a:9a6:b0:225:c983:1bb1 with SMTP id 35-20020a17090a09a600b00225c9831bb1mr51645645pjo.22.1672884982811;
        Wed, 04 Jan 2023 18:16:22 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090a178400b002261e29cf10sm236590pja.0.2023.01.04.18.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 18:16:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        William Sprent <williams@unity3d.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] dir: check for single file cone patterns
References: <pull.1446.git.1671546459151.gitgitgadget@gmail.com>
        <pull.1446.v2.git.1672734059938.gitgitgadget@gmail.com>
        <99e3c0f9-ecfa-7c26-eea5-685bc324f674@github.com>
Date:   Thu, 05 Jan 2023 11:16:22 +0900
In-Reply-To: <99e3c0f9-ecfa-7c26-eea5-685bc324f674@github.com> (Victoria Dye's
        message of "Wed, 4 Jan 2023 18:48:24 -0500")
Message-ID: <xmqq5ydlu3nt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> This clearly explains the issue you're trying to fix: cone mode
> sparse-checkout requires patterns like '/A/B/', !/A/B/*/', '/A/B/C/', etc.,
> but invalid patterns like '/A/B/C' (no trailing slash) currently don't force
> the switch to non-cone mode, leading to unexpected behavior.
> ...
>> To fix these issues, add a cone mode pattern check that asserts that
>> every pattern is either a directory match or the pattern '/*'. Add a
>> test to verify the new pattern check and modify another to reflect that
>> non-directory patterns are caught earlier.
>
> I think this is the best way to maintain the current intended behavior of
> cone mode sparse-checkout. While the idea of single file "exceptions" to
> cone patterns has been brought up in the past (I think most recently at the
> Contributor's Summit this past September [1]), it'd be a substantial change
> that's definitely out-of-scope of this small bugfix.
> ...
> And this test ensures the new check is working for the appropriate patterns.
>
> This patch looks good to me, thanks for finding & fixing the bug!

Thanks for an excellently written review, and a patch that is well
done.

Will queue.
