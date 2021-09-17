Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0BEC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3C7610D1
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 17:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhIQRfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 13:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbhIQRfj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 13:35:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42249C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 10:34:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p29so35114974lfa.11
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Sr3H+OlIHHwLosKxIs/lN7fT3f02ZNU57fz+wjuP/6I=;
        b=WG4hLbGo7uWjGgbe18nZBdRzOsltxUZgLkoEkOABD0WuYvqpSAjcWbLI6lh/i9EdzS
         Z8vQ05iPKYufgdsAV1sCeDLSuCOX5UgJvo9ESLxyKtzoqJwTvdnvzKjMwDK4Gh53KsjZ
         qRRuf4T2b78+mI5bE+4W4hoGx6yrCSjQYjDK4sfkn80DB+5MfGfGJ8p9fy4icMwYcRJo
         HXRMsKqn0MhrCsbj+Y2u5lKbd3hLbQbIBsqmcI9k9EW9NasDeMnk7jgEaF59eebLd7yo
         f6uK1wClCpt5L9BPqad4oNmrE4iW4bDBninILyUN4Mu3Xae8zlFd+ca9LkhgqNq7glYJ
         lJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Sr3H+OlIHHwLosKxIs/lN7fT3f02ZNU57fz+wjuP/6I=;
        b=1uWAlCU7H9GfsV4zLJ++0bzPsWX1H2ZIDpiGQDsib4ASwuz6Kb8FFht1E5IzVj2EQd
         DumLuNtB9od6Hp7CYU6CuERBe1VgtArZtzTb0H12xQWK+4YZhntqR/AsGiYndJvnTGuD
         SEO2v7orC62JM9XH+xZVzsVdtkd9J/2tzjvbX0eIi1BWDPg64PVLrb+oIbbl05RI1HAh
         FP+/51PBTb/2/589PvTjdfys2U0jcsOlh+6HF4usaIKekOqSRwfQ3MzrH/JEUGD9ESsL
         P3LgrjodbW0TIk2TD/jyEs3wf6/6LAnLUawgX3MpK9jKH2g7u8go7sWEY/s3YWl2wKoj
         zVzA==
X-Gm-Message-State: AOAM532LS/OvNL6YcnJOdGePUNOoi5TFhELT1Zhs146JKT7rf+rpoWhl
        tZaMvBh2nJbEI6qDH8oyl3WJZM+sq0I=
X-Google-Smtp-Source: ABdhPJwUiyxkgdvon4DiHRKIFxh96a5wZS19CvoYyyIdTGuiYTjXl820sLc4nJH5J+AXsrlsEmZpPA==
X-Received: by 2002:a05:6512:2e8:: with SMTP id m8mr9110944lfq.22.1631900053651;
        Fri, 17 Sep 2021 10:34:13 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 9sm571797lfp.129.2021.09.17.10.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 10:34:13 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>, Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
        <87pmtjkwsj.fsf@osv.gnss.ru> <87sfy497ed.fsf@osv.gnss.ru>
        <xmqqy27wrzmj.fsf@gitster.g> <874kaki1nb.fsf@osv.gnss.ru>
        <xmqqzgscqgmv.fsf@gitster.g> <87bl4rk7bh.fsf@osv.gnss.ru>
        <61ffe5ee-dcc9-4308-7ced-430c3891e898@iee.email>
Date:   Fri, 17 Sep 2021 20:34:12 +0300
In-Reply-To: <61ffe5ee-dcc9-4308-7ced-430c3891e898@iee.email> (Philip Oakley's
        message of "Fri, 17 Sep 2021 17:58:55 +0100")
Message-ID: <87ee9n5cob.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 17/09/2021 08:08, Sergey Organov wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Sergey Organov <sorganov@gmail.com> writes:
>>>
>>>> I'm not sure I follow. What "show -p" has to do with "diff-index --cc"?
>>>>
>>>> My only point here is that usage of *--cc* in *diff-index* is entirely
>>>> undocumneted, and that needs to be somehow resolved.
>>> It was a response to your "historical status quo that is a problem."
>>> I do not think there is any problem with "diff-index --cc" (except
>>> for it wants a better documentation---but that we already agree) but
>> Ah, now I see, but it's exactly lack of documentation (and tests) that I
>> was referring to as the "problem of the historical status quo" on the
>> Git side, so I was somewhat confused by your original response.
>>
>> Also, it's still unclear, even if not very essential, what exactly that
>> "status quo" is when seen from the point of view of gitk. Does gitk
>> actually utilize *particular output* of "diff-index --cc" for better, or
>> gitk would be just as happy if it were synonym for "diff-index -p", or
>> even if it'd be just as happy if --cc were silently consumed by
>> diff-index?
>
> Did Johannes Sixt's earlier answer
> https://lore.kernel.org/git/cbd0d173-ef17-576b-ab7a-465d42c82265@kdbg.org/
> help clarify the choices?

Sorry, no. I did read that carefully when it has been posted. Further
explanations by Johannes also only tell that gitk expects --cc to be
accepted by diff-index as it likes to treat multiple commands
universally, but don't specify what output git expects from --cc when it
passes it exactly to diff-index. Maybe it just shows the output and have
no other expectations, dunno.

"silent fall-back from --cc to -p in case of non-merge commits or
non-conflicted index is absolutely necessary" that is stated there is a
non-issue as it was always the case, and there are no questions about
it, as --cc in fact implies -p, and the latter is applied to non-merge
commits. So, how Git treats "non-conflicted index" and non-merge commits
does not depend on --cc. It's how it treats "conflicting index" that is
still unspecified.

Thanks,
-- Sergey Organov
