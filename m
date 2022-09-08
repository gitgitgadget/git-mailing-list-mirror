Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B6DC38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 20:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIHU4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 16:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIHU4F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 16:56:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42F4E6206
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 13:56:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fv3so12848636pjb.0
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 13:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=WpG0Ruj9Rs9Icx9M9a4YDVXZ/MPa2KwTGa0mH2fm4Rs=;
        b=hmEPKOAE+a51VFyOdFpBhdCeYj18QTr/LVsaPPgslWR9saLzpI7ZPqukCqI5dPr0NF
         RWd+lAJiEv28gMNkA/ro0EtyXWMTZ4WGF5Se+am5thRvsAq1EZfKRRKPz/0ktm1Hqfti
         ao2yrvV4BAzIQqcPPbhuTdzl/vPzSRhKcS+fdyRcHE/9pmc5XG1ahxOKLd6CYQzQcxZz
         B3qhCGmLNdXcCMVZ+fxl/J+ggExmu/51SRuS3QxvSNuRtDVZ56l1HSuFk8AHOQiirVxN
         +C+mE3qaSfyurWnLvInqpSmOVzoDWI/bQ0E5GdEm07R1Ct/LQ5fURIL39xOkXmHlx8xo
         Fd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WpG0Ruj9Rs9Icx9M9a4YDVXZ/MPa2KwTGa0mH2fm4Rs=;
        b=dq5hKQxr2MclNcAOU6RKJUrTYJ3ROiyten/F/8jau4x6iqT7ZzoImtNUFgIkb4Myl/
         0y35J7qt2DiqSAqKv9NO0KI7OWrIShQJbQ3DqvQawjn0JRV1ZpAWwV+SXYN+Zo6qVcUW
         /PCVunzDHzKAtcfVR5jmjcLnnMmKDf8VdGYbW7fiQcwr0gyry8LOK2Gu3/68f0YLQxP0
         b1CiA9GMj9MePMRNZ7n51Z0jBbz3LJTn8eK7yuSl8vZfzC3TmxHBTYABP/cQVynRAu7L
         Y9xvp+ST5XShvYUy1jjPLT2X5U/4WXZP+mmpyJ8uW81HdFJ9OXdeCDow7NK56kmaLq0Y
         IcOw==
X-Gm-Message-State: ACgBeo25vzQBZKfpNXed8fufJa4IeAswoSEz3zxcfFzLLmBsRJYLBvw+
        TC/5qMkZSws1OxJPKH5ek30=
X-Google-Smtp-Source: AA6agR5b3DU1IeJ5pt/e/OjCwFZ1D1IZzklvyUsPnhB91JRb5hXmGPMDWQoaINQedIUxzIWn3ouD8g==
X-Received: by 2002:a17:90b:3509:b0:1fb:35ed:6fd4 with SMTP id ls9-20020a17090b350900b001fb35ed6fd4mr6105273pjb.1.1662670561461;
        Thu, 08 Sep 2022 13:56:01 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b00174d4fabe76sm15343979plg.214.2022.09.08.13.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:56:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, vdye@github.com,
        git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] builtin/grep.c: walking tree instead of
 expanding index with --sparse
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
        <20220908001854.206789-4-shaoxuan.yuan02@gmail.com>
        <xmqqczc5rblr.fsf@gitster.g>
        <093827ae-41ef-5f7c-7829-647536ce1305@github.com>
Date:   Thu, 08 Sep 2022 13:56:00 -0700
In-Reply-To: <093827ae-41ef-5f7c-7829-647536ce1305@github.com> (Derrick
        Stolee's message of "Thu, 8 Sep 2022 16:46:54 -0400")
Message-ID: <xmqqo7vpoaan.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> HOWEVER: it "doesn't matter" because the sparse index doesn't work
> at all within a submodule. Specifically, if a super-repo does not
> enable sparse-checkout, but the submodule _does_, then we don't
> know how Git will behave currently. His reasonings go on to explain
> why the situation is fraught:
>
> * command_requires_full_index is set in a builtin only for the
>   top-level project, so when we traverse into a submodule, we don't
>   re-check if the current builtin has integrated with sparse index
>   and expand a sparse index to a full one.

Correct.  

Is it sufficient to propagate the bit from the_repository->settings
to repo->settings of the submodule, or is there more things needed
to fix it?

> * core_apply_sparse_checkout is a global not even associated with
>   a repository struct. What happens when a super project is not
>   sparse but a submodule is? Or vice-versa? I honestly don't know,
>   and it will require testing to find out.

Naïvely, I would think that we should just treat a non-sparse case
as a mere specialization where the sparse cone covers everything,
but there may be pitfalls.

> Shaoxuan's comment is attempting to list the reasons why submodules
> do not currently work with sparse-index,

"do not currently work" in a sense that it produces wrong result, or
it just expands in-core index unnecessarily before applying pathspec
to produce the right result in an inefficient way?

If it is "functionally broken", is there a simple way out to give us
correct result even if it becomes less efficient?  Like "we scan the
index and we see we have some submodules---so we disable the sparse
handling"?

> Victoria and I have noted this issue down and will try to find time
> to investigate further, with a target of being able to actually
> exercise this grep_tree() call within a sparse index in a submodule,
> giving us full confidence that name_base_len is the correct value to
> put in that parameter.

OK.
