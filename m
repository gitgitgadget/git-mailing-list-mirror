Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2608C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 18:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCFSbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 13:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCFSbD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 13:31:03 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0AB74A4B
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 10:30:53 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id i5so11448609pla.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 10:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678127453;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJopkQf2DRpuoXThxrFIP9InC1ZHRrFDFoKsc2EL4NU=;
        b=bOEZ/v9QVaL3YaHjdqwfOPmNzIv4zhO4qSohBtuiwhbnD42gSkY+tbjUzb7Zumvp20
         xsTgNDo9EgTGDGMMj8wEILeXVOyQHCivpc5lYTjBellVjKszDSHZcWwY3+AUrjf9E/9i
         5FhMhGWRWKZ2SsUmBLv1cYLOvU2gs6xfhCbvxgi5Jyohwoqe/L/vDk1j5cSNn3OUqCi9
         MN29eKvP6DbcYfcqQPyGBcx1WfAPuSlw3GdqWA/uxOknqCzGNF3Z2zi2fY3c+K++0lH6
         S51eyXGQ2NP1CzWXeqx5mNhAXBfHwsYXi+fMG0VjxnbjHweRBYAuAtAbyqP0hnegFarh
         Yfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678127453;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJopkQf2DRpuoXThxrFIP9InC1ZHRrFDFoKsc2EL4NU=;
        b=uWoUcitCX/O/8glHRp5ZUcqkTi0phOqgQ31BopB1sYESXtNP30/g6cghu+jjENAnbe
         x8M2SFBh+0z/Da/uAdjfJHg29W3YhxuZHZRKeIDgm5QGlTC/ByuZrZBFrYO5Bnm0+YyZ
         99qTZXK3LrbUl63NBuDAI29DHrkg3IlxJSPl8/drmWkV40xKNcIv3ivaXxNWB21U6GW2
         XT2Z+q3iR8+LFMkmpKNlPl48wUSIQ2jr0ffvqWT4PPsRe9nUCxlkOITcpCicSWCmwyt1
         Ld7XKVwfESrcy5T05d8nI1sAT2C7I9aEKrkUAHSM0o0XkuSbRxf01TiKR+tbYSdqm9pZ
         Kd5Q==
X-Gm-Message-State: AO0yUKUWdfpSXhWJXekwXJw7GBu3s14v8ZcMzs12Z+H388VimJmhPk6U
        SF/eUG6g7FiAJFX0DPseRKg=
X-Google-Smtp-Source: AK7set9qLm2HLssenpuESsiFp6MngqzXz6pGeiX66mlqCUnNB6KPn3mNFd7+d6ytpRaW6QyWmwqVXw==
X-Received: by 2002:a17:90b:4f8e:b0:237:f925:f46 with SMTP id qe14-20020a17090b4f8e00b00237f9250f46mr12284230pjb.24.1678127452686;
        Mon, 06 Mar 2023 10:30:52 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id lj10-20020a17090b344a00b00233e937fef9sm6373480pjb.18.2023.03.06.10.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 10:30:51 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v9 2/6] submodule: rename strbuf variable
References: <20230209000212.1892457-1-calvinwan@google.com>
        <20230302220251.1474923-2-calvinwan@google.com>
        <xmqqv8jiheao.fsf@gitster.g>
        <CAFySSZABteFiyBYp_S7bur7_K1GkxL3A5DiTiV47iU_t8EpWKQ@mail.gmail.com>
Date:   Mon, 06 Mar 2023 10:30:51 -0800
In-Reply-To: <CAFySSZABteFiyBYp_S7bur7_K1GkxL3A5DiTiV47iU_t8EpWKQ@mail.gmail.com>
        (Calvin Wan's message of "Mon, 6 Mar 2023 09:37:15 -0800")
Message-ID: <xmqqa60pag10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> On Thu, Mar 2, 2023 at 4:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Calvin Wan <calvinwan@google.com> writes:
>>
>> > A prepatory change for a future patch that moves the status parsing
>> > logic to a separate function.
>> >
>> > Signed-off-by: Calvin Wan <calvinwan@google.com>
>> > ---
>> >  submodule.c | 23 +++++++++++++----------
>> >  1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> > Subject: Re: [PATCH v9 2/6] submodule: rename strbuf variable
>>
>> What strbuf variable renamed to what?
>>
>> I have a feeling that squashing this and 3/6 into a single patch,
>> and pass buf.buf and buf.len to the new helper function without
>> introducing an intermediate variables in the caller, would make the
>> resulting code easier to follow.
>>
>> In any case, nice factoring out of a useful helper function.
>>
>
> A much earlier version squashed those changes together, but it was
> recommended to split those changes up; I think I am indifferent either way
> since the refactoring is clear to me whether it is split up or not.
> https://lore.kernel.org/git/221012.868rllo545.gmgdl@evledraar.gmail.com/

I am indifferent, either, but with or without them squashed into a
single patch, "rename strbuf" would not be how you would describe
the value of this refactoring, which is to make the interface not
depend on strbuf.  Some callers may have separate <ptr,len> pair
that is not in strbuf, and with the current interface they are
forced to wrap the pair in a throw-away strbuf which is not nice.

And squashing them together into a single patch, it becomes a lot
clear what the point of these two steps combined is.
