Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F48C6FD19
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 00:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjCKAB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 19:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCKABz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 19:01:55 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3964977A
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 16:01:53 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id fd25so4683129pfb.1
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 16:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678492913;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ewi/9bRTR+il+oCj7EKuAZei4qvVvB6ZUovbtmIuep8=;
        b=BW3UNl8qT1B/uq1DgUyc2epdHBQ/lyYna04o4t+/V12taHlbzMTa30jHfPGdkRs1U2
         Iu0zwbNafVXE2WEL4NliSsaZKc+8blvVFvfwkfM8JlTSe+SgHpD8chhFMZQIBX2cUwpc
         nEUOJzhnBTWk995+bf7ESWx52WqkbJanY8wis8JgH39LExVkChYozwuPQLTCSlVlhH7o
         5+0piuBJ5LiMfG/Yc/MizN3bcBByy75T20IcxNtkhZKBoKawS5fX4aPX9GjOPFmyn14r
         oM601INGk8vqU2mTbWSyKcyh/cKUthELDjp0v2Aet8LLpgpIAwsZUeN0IjNu50IIN1A+
         z17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678492913;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewi/9bRTR+il+oCj7EKuAZei4qvVvB6ZUovbtmIuep8=;
        b=RYkVT6Ap+0KcwEFBaA1HW7ER53ZKdNbDzlBhPw4luTYGLwVTPpa/4OplyNVPOVaJlN
         vCOSjWVw8QDanwr5VW6MUd/wcwX1jBJhm1O32qwwTHD1Mo7bfWUn7O5lPIJssp1zFrfI
         cTgpzjmBQ8w71VYIO55/WXvcYWxjx90nNSyZCSsRL3nyTlQoxX93DBX03EX8yg5OtTQY
         uVk4PdWRrNynPoj2rMl9M/NjRwNaScRK6R9yPXvlhH404PE2JKqICQGD1y3ANB5PbQaK
         YyKb/foPzED5fLRhYnxfpsoOBk5wJs7lLRgINigMMj5tFe2kI4jlqbZR47STmLAa3GSc
         6Adw==
X-Gm-Message-State: AO0yUKUnC78HJfM3W6zRmCb7n3oXey1w3ZLYFPFpk4hsdJGg8uPfJ6Q4
        SwjJMJLvFi0x+ndupbmWf+DrpJlrRMY=
X-Google-Smtp-Source: AK7set+6D8vAqLg783kJ5zYINDjswKkPN9GDbeq57TvHsXyanksBuvkTn/ebsfdKhbAypThbEhdt8w==
X-Received: by 2002:a05:6a00:15cf:b0:5a6:cbdc:2a1a with SMTP id o15-20020a056a0015cf00b005a6cbdc2a1amr3936045pfu.2.1678492913078;
        Fri, 10 Mar 2023 16:01:53 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7808f000000b0058dbd7a5e0esm330296pff.89.2023.03.10.16.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 16:01:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r?= =?utf-8?Q?=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] object-file: reprepare alternates when necessary
References: <20230310212916.4138690-1-jonathantanmy@google.com>
Date:   Fri, 10 Mar 2023 16:01:51 -0800
Message-ID: <xmqqilf8yx3k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> But I guess clearing a linked list and hashmap can be a bit cumbersome
> in C, so maybe it would be reasonable to assume that this behavior
> would not change.

I think the original reason why we did not clear was because we
never knew (and we do not know) what is still in use.  Can anybody
explain why it would be a safe thing to do to rebuild the alt-odb
list from scratch?  Surely we can have a big central lock to do the
"list manipulation" part safely, but is it safe to access the
objects we obtained from one of the odb's that no longer is listed
on the alt-odb list, for example?  The code that this patch touches
clears the loose object cache after updating the odb list, so loose
object cache of any odb that goes away will not be cleared here,
which means that the code that reconstruts alt-odb list would need
to clear the loose object cache automatically?  What should we do to
packfiles that are mmaped from these alt-odbs that goes away?  Etc.
etc.

> In any case, maybe a comment should be added to prepare_alt_odb()
> saying that if an update of the alternates is needed, one can do
> so by clearing loaded_alternates and re- invoking
> prepare_alt_odb() (at least so that a developer changing
> prepare_alt_odb() can see the comment and understand what
> behaviors this function needs to preserve).

Sounds good.

Thanks.

