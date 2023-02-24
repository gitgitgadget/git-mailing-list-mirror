Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A464BC64ED6
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 01:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBXBYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 20:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBXBYF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 20:24:05 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA80C1C33D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 17:24:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id pt11so15569252pjb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 17:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqzeqvC4zOIYhAuuFiwFrMSEKQcvXyweaLjrwLbLBBo=;
        b=Wd/kceoXuAH92Hb+pAD0XApU5yLwmYOQm0IrlPML2CSMRs2/QzsDnu6gi/AsHHf6va
         c1zX4B6oeV1JKnla94fKsddpMqvEnI0fJMBtVUvhUEz1kPMYurfRfDV+F76ibhqnTto4
         kOxQYvkLOMEAfENf/V805DPeuy/dNaWxEaPJAxO4zfmaq9lK9YfoPhzM1NKPmO22FeUj
         wRhnPqOSPhL3q4i2dW8kee87AguhWvc9fJM5eFSSz7pXPESRW6Nfaj0R1uEhLPK8rmZm
         BldHCcO9J85OyegtR5QwA3osUUWfeIRauIV9nz59Ew/9z4Jc00D6ksfoIvCmsbuFOShP
         i5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oqzeqvC4zOIYhAuuFiwFrMSEKQcvXyweaLjrwLbLBBo=;
        b=8Jn3KuHRssNqV/vlUNsdZb6SsEDqKFdC0n7gK0FugdsYU6s8HPLcKuGu6RhGKPlNbs
         axFNxDTfMWLyICYG8A76o4/45BbquOK9nHOc84rkTz92BhGgGJj8bP8ax0tYLIyiK+fi
         Za4ldyQVc3gVk8Dk+lKk5c2EkrAvM6Y1B8c0oFY6KtNe1tADZdZ31hI8p/ZeS+SvUDed
         2FgdPiWCknkUT2k2D9rDzEUcqsyAVVnuJtIwfuOzo7lLBgBR3rUQLmeymp7rwsO2glwo
         aEn3WWNNfmBRMgZrVFMtRuM/Idw9S/vdQ/xK448yXHq5QfBdei+yQVQhga//9vvkynCC
         uI7g==
X-Gm-Message-State: AO0yUKX8uHo+qo5x6MyfinSBkPzbLMCQCUluW1ykbqmce5gWgVSZ68LH
        Xtw8aqcb6mDIs66KsrekGjA=
X-Google-Smtp-Source: AK7set8Wubji9X2Y4aprnS3gUXTw8EsdhNAcaLYUWU+10ahZf5Sil79spF+kgNQKU1WNWnFzidIUMw==
X-Received: by 2002:a17:903:22cc:b0:19a:a6ec:6721 with SMTP id y12-20020a17090322cc00b0019aa6ec6721mr16987155plg.16.1677201844261;
        Thu, 23 Feb 2023 17:24:04 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001962858f990sm7591199plb.164.2023.02.23.17.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 17:24:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/11] Clarify API for dir.[ch] and unpack-trees.[ch] --
 mark relevant fields as internal
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
        <16ff5069-0408-21cd-995c-8b47afb9810d@github.com>
Date:   Thu, 23 Feb 2023 17:24:03 -0800
In-Reply-To: <16ff5069-0408-21cd-995c-8b47afb9810d@github.com> (Derrick
        Stolee's message of "Thu, 23 Feb 2023 10:18:45 -0500")
Message-ID: <xmqqzg933lfw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> The major downside to this pointer approach is that the internal
> struct needs to be initialized within API calls and somehow cleared
> by all callers. The internal data could be initialized by the common
> initializers read_directory() or fill_directory(). There is a
> dir_clear() that _should_ be called by all callers (but I notice we
> are leaking the struct in at least one place in add-interactive.c,
> and likely others).
>
> This alternative adds some complexity to the structure, but
> provides compiler-level guarantees that these internals are not used
> outside of dir.c. I thought it worth exploring, even if we decide
> that the complexity is not worth those guarantees.

I actually think the current structure may be a good place to stop
at.  Or we could use the original flat structure, but with members
that are supposed to be private prefixed with a longer prefix that
is very specific to the dir.c file, say "private_to_dir_c_".

Then have a block of #define

	#define alloc private_to_dir_c_alloc
	#define ignored_alloc private_to_dir_c_ignored_alloc
	...
	#define visited_directories private_to_dir_c_visited_directories

at the beginning dir.c to hide the cruft out of the implementation.
"git grep private_to_dir_c ':!dir.c'" would catch any outsider
peeking into the part of the struct that they shouldn't be touching.




