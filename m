Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D6DC6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 16:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCBQTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 11:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCBQTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 11:19:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5DF7DA2
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 08:19:19 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso3314738pju.0
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 08:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Og/Orqv4kCc70JZfRf7EUiaInuv32eu27LvdnPna+y4=;
        b=bH64sJgvFG3ShR1zFnU+cp+M/crOVO3NvWUUSDfF+A4I6zWPiPMMfzS+eZKF/GKm7P
         VJbnP1jTIhR8nIs2lZD6hQUFdK7rJvSwwJVb1JZRIy0WLe8lm2psBddF7D8fdz0KbNzz
         kJMpFkpsIH7yLGD1YMQLk1pNgUlKMeqb2F6SA9GWUE3dNZDIcXVSBtsemmjFUpoh09L6
         SNQtHuMw2yfLbJLISZfPmeodmuWkvLKKRVm4UyQuDnF1wBjpc2QUuJjWq4Z/5/DC58pe
         dofsMjPlGtpTEP55R/wJzvaIn6vqe4HCGcoxXmdBheEV6d+41FXBJj63xHGztkWQ7q9w
         3djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Og/Orqv4kCc70JZfRf7EUiaInuv32eu27LvdnPna+y4=;
        b=yA1NzyF/Emf3ZyBNBVfWAshZbDlZbBluiMFkFjTwZpouOnyN7h5e3eWDdAty5bOml7
         RMrtw2JVR8ZPRQBtRuB2ogQ+o08snkd2clm/aad3zHk28YTCPxoaxHrtJaJ1adwDREXJ
         W8EUeV35cqPHqjvJ99qkH8zmw1Zj/BJTREnqTEGCc5+ZIOPPOrvxSRtJJ5YO855YDlM5
         iMV7OdVUehwo/XWT37+zPr/9BMTP+Kb+QsWJr2OlcFY94Dja4tILbqjEYRAJGDzggwLR
         hXgBwEukTU+II10QL84Zz9eXSigMR3lfZ2LEoCFvgAfBudRAeqZ/I+xi2NCAOz/mqW3Z
         AhOQ==
X-Gm-Message-State: AO0yUKXUTcIX2jz/bnIFkXyCrBZCVxck8slwxVktdDOEQqJa+y9Jhv3/
        zdKo2YzrS6QGuNfxtM374Tc=
X-Google-Smtp-Source: AK7set9jgXu7nlPWLzzvovr3lJMdRFxduwb6aMdUZHwHdEF/9oyR9sa2UMcYUUiU86SHq6mcHd08ow==
X-Received: by 2002:a17:902:ed13:b0:19c:dedd:2ace with SMTP id b19-20020a170902ed1300b0019cdedd2acemr8915164pld.18.1677773958491;
        Thu, 02 Mar 2023 08:19:18 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902ee4600b00199023c688esm10593167plo.26.2023.03.02.08.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:19:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Humphreys <behumphreys@atlassian.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 6/7] merge: ensure we can actually restore pre-merge
 state
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <887967c1f3fd6f03cf1d0bb3c19ed16819541092.1658391391.git.gitgitgadget@gmail.com>
        <xmqq35eul95b.fsf@gitster.g>
        <ZABNceY3cSWNb75u@F407C5W6RY.office.atlassian.com>
        <CABPp-BEJmnAB4QX_HMnNaZ9vEh_mKiqka_uZRm_E_LNuOBiFsg@mail.gmail.com>
Date:   Thu, 02 Mar 2023 08:19:16 -0800
In-Reply-To: <CABPp-BEJmnAB4QX_HMnNaZ9vEh_mKiqka_uZRm_E_LNuOBiFsg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 2 Mar 2023 07:35:30 -0800")
Message-ID: <xmqqmt4vktx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> The great news: the fact that this affects you means you are using
> non-bare clones in your mergeability checks, and being forced with
> every merge to first checkout the appropriate branch, and pay for the
> penalty of updating both the index and the working tree both in that
> checkout and during the merge (and perhaps in doing a hard reset
> afterwards) in your mergeability check, despite the fact that a
> mergeability check really only needs a boolean: "does it merge
> cleanly?".  Doing a full worktree-tied merge like this is really
> expensive, and while the above Git changes may have made it even more
> expensive for you, the real savings comes from switching to a bare
> clone and not writing any working tree files or the index.  That's
> available via running `git merge-tree`; see the documentation for the
> --write-tree option in particular.  GitHub switched over to it last
> year and GitLab should be switching soon (or may have already
> completed it; I haven't checked in a bit).

Nice.
