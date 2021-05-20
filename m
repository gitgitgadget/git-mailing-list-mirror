Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E4DC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 19:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00AE60C3E
	for <git@archiver.kernel.org>; Thu, 20 May 2021 19:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhETTkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 15:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhETTkG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 15:40:06 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D656C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 12:38:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f12so21229479ljp.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zJssdoV2o3mlCb50nmzf4XcX8iF7PzhB3RVcpnwE1dw=;
        b=arwjDPpMlY5aYgvLoTbhTW/mXRWYKIB/0bJV2ugc6UYCT7dl1LB78kPipzj39m4j02
         lJwnHt77L/609XG75sVyqLgkUFKHinwUkfdl9AaGNVus5T5fN/5q/xLHIu1FeH1UgUhC
         l1eZjSkqcE4PQvK7edb2fOPzq9jrZ3FFv/9BUuur0BsXcnHxYG1iEwxbpDSZb6+7gClw
         MV0OJvdGaGWi2cKe7a8HgHiWZNuZ0HrtzAdMOhBduWS6V2jeZEDdQDEdXpGwywBWPJH8
         N5C0bOc4lkkd0f6jSmOUDsYNTY9tDPhALzUuihBlsQwsYi3uoHLs7ocs+HqoKDpe1bkQ
         sekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=zJssdoV2o3mlCb50nmzf4XcX8iF7PzhB3RVcpnwE1dw=;
        b=JRpjSwWOmPKZJfSbCBufgl25RkSbfiKOUfq6fN1nX6iPYvdz9TgbjFRHGnObiCQWF2
         Ko/kIaYd1RRaJWMEWe3gxaJqNUMYXQ2yGPuG9DYz3Rgwz3w3kIDR9OJPMSuqjsWuUVy9
         8Xqmb//2+PofXH7xOnvq/5WkrJ/oUQFZ87l2Sic9AwFRGuZC8BHkgN3Q3MdrHgdKRVus
         d9Ex6scJkohYE8ESERvg7I8Dp1rxjHfZzmsjAuZVOyVnNqUG3R8x1gTMB3klVkQP0Jpe
         oRcc9wcBv9cTbI+xG5g4Fs/RhUo8ATseDDGJYSzXcIauQvTLY/rMwKifCouy3+dwVGaD
         vMRw==
X-Gm-Message-State: AOAM532cG4MVtbp9H51cFZKgKttVqv+KbkdRkhvuhW6Eicx8htaM8D2a
        teEHaSKDF2ufgwpZngGX0gycX42ddcg=
X-Google-Smtp-Source: ABdhPJzFwbvXQIx7FVYPOIxR7NKwL+IJgsY4hE3TR5ymtgfJDiqedTpS8Z/GwUyDh5H/GlNScv5noA==
X-Received: by 2002:a2e:b44f:: with SMTP id o15mr4198353ljm.497.1621539522194;
        Thu, 20 May 2021 12:38:42 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p6sm383649lfr.163.2021.05.20.12.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:38:41 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <YKWHo9gZNp+i3fH9@google.com> <xmqqmtsqwb9g.fsf@gitster.g>
        <87v97dfsyg.fsf@osv.gnss.ru> <YKaverOKIAJpJl3s@google.com>
Date:   Thu, 20 May 2021 22:38:40 +0300
In-Reply-To: <YKaverOKIAJpJl3s@google.com> (Jonathan Nieder's message of "Thu,
        20 May 2021 11:50:34 -0700")
Message-ID: <871ra1b3gf.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sergey Organov wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>
>>> This is about "log" from the "rev-list" family, not "diff" to
>>> compare two endpoints, so "git diff" won't be affected, and "git
>>> diff-tree" is not affected, either.
>>
>> You are right. I've added a test for "git diff-tree -m", and the changes
>> don't break it.
>
> Good.
>
>> Can easily re-roll if you think the test worth it.
>
> I care more about the commit message than the test --- i.e. mentioning
> that this doesn't affect commands like
>
> 	git rev-list HEAD~5..HEAD | git diff-tree --stdin -m

OK, re-roll to follow...

Thanks,
-- Sergey Organov
