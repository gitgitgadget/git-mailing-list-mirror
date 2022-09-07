Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18909C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 16:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiIGQqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 12:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIGQpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 12:45:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6F4A2A8D
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 09:45:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so11691443pjp.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=9EsBUkQDK1hIh8jz0G18LjDbYQcu1OFyV09uEUoj7r0=;
        b=q2Sfiq+uh7OjphUya2twO6t5oF/3tgw1xhTicFxCVypDO7lLWsGLSgRCmopoUXtu/q
         3bN0W8enHDbip6HMaXXZ+YE11ysGDQSwrZVkD/O8p+XmxiV+IgMLJ32bBllOxdNa+R7t
         BrZ+PxwZ4tbtPy03JbsR8+XvX/hwCitQ0wjJ/EX72aDRoUbt/8r/2sLFFr3kx8iLSuI1
         yuHn6PdpvO7x2S6aBH3vazDfr5O+glyroIjmhBNzgglZTea3QN/1V1CzYWYEDQtNP4BM
         UaofIH8TVSZRECo0eVMCHdtS3kNnJrNlFrYbFkWASJoxPsXceSfYENMU9FPd7aet8CDb
         4YaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9EsBUkQDK1hIh8jz0G18LjDbYQcu1OFyV09uEUoj7r0=;
        b=JMXzLGm27dZrrJIc9W5KXEumTOLzoBd6quIAUOB8/dmfkcvXydL4M5XekGszvuZm7J
         HKWLlZ55NMriM25W8mA4LF+2NwoW1r3TF//lNe3rcQFGlnWmmXyFwcKwabfXYU6EXdmb
         U8Jsiysrka9Qb8uX2FjBvX55/tA6k6Sbg3aVQ87gE10HkiMb+GEJUbYID8njAohItZGV
         gz0kVfsrV5nRq1MUriBACL54R7JTgE7m1hBfKdCuj+7gZRZx+KrMk7Ig4r2bD//5Ejjh
         nouV9cEaqF5zMHduU8fTjusF+nuTUS+ayPC0i7eZ3/xQpQ2L3m7pGjXEj/YHQF3TVZ+S
         IZMQ==
X-Gm-Message-State: ACgBeo2EReRPu2uh6LjKIP7Iv7QdmXr3J4KFGS2k0TedcdZ818sfIgmx
        fRnVcYvtL+uchqEof4kxaLwVri+w0fA=
X-Google-Smtp-Source: AA6agR5F09auq4zbDOSovYZ0lgb/aiEZTQl0gsMGN77T3WX9tRjzuSAFVjRbqWCpza/kOWljRveLlg==
X-Received: by 2002:a17:90a:520a:b0:1fa:d8f9:5400 with SMTP id v10-20020a17090a520a00b001fad8f95400mr32034499pjh.42.1662569145037;
        Wed, 07 Sep 2022 09:45:45 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id jf15-20020a170903268f00b00176ca533ea0sm4894271plb.90.2022.09.07.09.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:45:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 0/9] docs: de-duplicate sections, add more
 CONFIGURATION sections
References: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
        <CAHd-oW71qvhG16YtMweA26SDCLKn+LHZe13njn18CD==9Ewbnw@mail.gmail.com>
Date:   Wed, 07 Sep 2022 09:45:44 -0700
In-Reply-To: <CAHd-oW71qvhG16YtMweA26SDCLKn+LHZe13njn18CD==9Ewbnw@mail.gmail.com>
        (Matheus Tavares's message of "Wed, 7 Sep 2022 08:51:48 -0300")
Message-ID: <xmqqy1uvxhdz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> On Wed, Sep 7, 2022 at 5:27 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>>
>> This series:
>>
>>  * De-duplicates and combines configuration discussion that was split
>>    or spread across Documentation/config/*.txt and
>>    Documentation/git-*.txt, moving it to Documentation/config/*.txt.
>>
>>  * Includes that relevant Documentation/config/*.txt in the
>>    Documentation/git-*.txt files.
>>
>>  * Introduces and uses included prose for those "CONFIGURATION"
>>    sections in various Documentation/git-*.txt files, informing the
>>    reader that what they see there is included from "git-config(1)".
>>
>> This v4 addresses the feedback from Matheus Tavares on v3 (thanks for
>> the review!): A hunk belonged in 9/9, not 8/9 (init's config is used
>> by e.g. "clone" too). The end-state at the end of this series is
>> exactly the same.
>
> This version LGTM. Thanks!

Thanks, both.
