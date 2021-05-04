Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBB4C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 09:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD3A613AA
	for <git@archiver.kernel.org>; Tue,  4 May 2021 09:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhEDJLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhEDJLy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 05:11:54 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4B4C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 02:10:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u25so10218554ljg.7
        for <git@vger.kernel.org>; Tue, 04 May 2021 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IkMmyuWq9Z3peg+3nDVjMuXtUf6GtnV29NTrH6/Dx5I=;
        b=Ye0+5TTy0JlOJUSx7VfGpullxOiR4Z+iKGQnDfccMMkjZqXNt27fDi5nkR3d1qolB8
         RQfa0OoL39mrah1jC3FXFMUoDwFqG6dfTgDm/MmKY62jKfXQp7GgNx2bsY6xSmi4g0cs
         VpIJ5DwFt7r98/RDG5hGxbdmkdmVKDedO9cSQA1FidIF+BANORz0SiRgeSuntk6EMwXT
         yRVx2sISE/2LGuwoYXf0JnEXAqFijZ2SBh4+v5+Ba3c6O1jEVoVQqce5/tI29uYPLdOT
         /EqokCXF9trJcpR6cPiPjxBbu1XnVb5mzV+Z2tURKE/XouggYS9WN4ctRWEq+S0MccR1
         8T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=IkMmyuWq9Z3peg+3nDVjMuXtUf6GtnV29NTrH6/Dx5I=;
        b=nVkzpB+F+ayVUEeMmzFSj5O2JMtNh/ZP0+247q8ViYsjqFKKn9K3VSgYSB57n116uD
         CsSqhDsBR57N2dRC7G7rM/BDWDtXnaZC3FCjCi3flC3GE8NZ3DzWE5IANCBUFNOJLWnn
         QAEkdHrxAIQu/tgUHzzEvF+1AhvIG1BmwsO9yK+aNSDVBQEh1xRFUzFC/9aWd1ifzhXv
         BGdrTRfK1UKr+/jJoJYmvV4fYlETjH3+wN4HVYzHeWNLom2t+/F40ZrVRvjpHe90AZz5
         k9N5S8e6TA+tCfh4E+ycbkdR7byA+JmdQPKPTzZWUbEuEjJ379T+C7TqZrCmBfGiGjfG
         XmCA==
X-Gm-Message-State: AOAM532hM6SKeRfpuCN87NvXPUs5i+cUKSDIZnJhH7YNkPLNw9N3t1sl
        6vrBH4C7apdwx+64vjlgwZXJ+GvnSEQ=
X-Google-Smtp-Source: ABdhPJzOoS8S5QyguwybCi831ghv5N2tHMZe7JO3A7trbNi/PThsejtITsE1Rvvzw3/RfjOBBO6NBQ==
X-Received: by 2002:a2e:bf2a:: with SMTP id c42mr16181000ljr.208.1620119456961;
        Tue, 04 May 2021 02:10:56 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x35sm210697lfu.149.2021.05.04.02.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 02:10:56 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g> <xmqqy2d0cr5l.fsf@gitster.g>
        <87v9837tzm.fsf@osv.gnss.ru> <xmqqzgxfb80r.fsf@gitster.g>
        <87czu7u32v.fsf@osv.gnss.ru> <xmqqtunj70zy.fsf@gitster.g>
Date:   Tue, 04 May 2021 12:10:55 +0300
In-Reply-To: <xmqqtunj70zy.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        04 May 2021 10:15:29 +0900")
Message-ID: <87eeemhnj4.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>>  * "--patch", "--stat", "--cc" etc are to specify if we use the diff
>>>    machinery and what kind of output is desired.
>>
>> So, in your view, --cc output is not a product of "diff machinery"?
>
> I view --cc and -c as an enhanced form of --patch that is also
> capable of handling multi-way diffs, in other words, choosing --cc
> should be to say "give me textual patch for all commits; when there
> are multiple parents, condense multi-way patches".
>
> So, yes, strictly speaking, --diff-merges=cc was probably a mistake,
> and in the ideal world, --diff-merges should have taken only one of
> "compare with nothing" (optional), "compare with first-parent", and
> "compare with all parents".  The last choice could output diffs in
> various forms, like traditional -m (i.e. patch output separately for
> each parent), --cc, -c, etc.  "compare with nothing" is optional
> because we could also control on the "output format" side to say
> "produce no output" (ala "git show -s").
>
> But such an idealized orthogonal design without special casing will
> often lead to usability problems and complaints that -m alone does
> not produce anything, so I am OK to have cc and friends as the value
> for --diff-merges for that reason.

I basically agree with what you say here, and it's in fact very close to
the first variant of the design that originally came to my mind, and it
was reality that shifted things to the way they are implemented now.

That said, what do we decide about -m to finally join -c/--cc party and
start to imply -p? Last time we've discussed it, we decided that -m has
been simply overlooked when -c/--cc started to imply -p. Should we
finally fix this?


Thanks,

-- Sergey Organov
