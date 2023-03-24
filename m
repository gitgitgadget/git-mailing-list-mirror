Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40FBC6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 04:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCXEbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 00:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXEbc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 00:31:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056B9231EE
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 21:31:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id kc4so776853plb.10
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 21:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679632291;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeZKmTh4Ne9ljrSwuccGWx+eIFMGsSsnvF/JkJguktk=;
        b=KRVneJbJYZQu3KWp2JLWaIJkMDQ4HkKuY+OQ4ltu7fuHq+BFg4y3JgrAXhFNkyVB1U
         Cq3TE0wl67egqjujGRURATs6gaIzrfyadTdP6fKOzi0JpRlat8yPl+sJvywTU5/mM6i3
         6gWuEjSWI3eTSBmnjDv9mX8eAwKkn80oweM6asar5UiQvvlmgzdDSKznzuZErDmI6FVb
         8z/XkbR/xAXmJO39HbIbPTWM8KRBL42CWSeLSM9xmDmjfRHEgL9f9k/e27e8Y8aieHjS
         WH+bmO1SvRIK/hrlqGI1eaWSidH89+FILk41waVbBBk+Wh8SRS6WyCLEvrsmo4G5F00c
         bdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679632291;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xeZKmTh4Ne9ljrSwuccGWx+eIFMGsSsnvF/JkJguktk=;
        b=ARoHIrRK3AZKeX5smN+FyFjKyP8pANJaQLymH3+tHWGZds/XvckvYfHvrJBLfBM9NJ
         j9QAsMC+UpF8oVE6GvmR0r3jHHOLgsY6m+CuWLMxPWM1kwL2lOXRwG2D7lhOzyowPsl3
         9lTO7pSQpLwuAkOrT4avFohPxZtPDXG7jZWY6hT/w7zQ1EnAQs8ohvlFaep+VTowXs4g
         oQKKbvxrYJm6WP+qM2gFmUEld5QYjSNPzK/k2xFjRGh6aP8LkH+6GGd7UHwtRz/aSlBt
         0St45pcOekyXNsVkJZvt/hHuG63PEAdT3X1XfMb3z9D4n/QXjrvtSHi7IPakpQ/K7jPc
         s/BA==
X-Gm-Message-State: AO0yUKWvGAxGskg00S8jeLLyHOAMoALlHLjrpiLBiEl7x6q9z8UZIMGD
        xuE4zhWmI8J5aRA7QYoBq7UsVI4YMnM=
X-Google-Smtp-Source: AK7set8OBhaq6Gyhw4r3nvqtOO5TpHpQXRpQguKqoe5M7FfICwJxH14+gx2dvBJ1t/7Qy0Vx8Ij35A==
X-Received: by 2002:a05:6a20:6a9b:b0:dd:e4c6:612f with SMTP id bi27-20020a056a206a9b00b000dde4c6612fmr1656952pzb.47.1679632291317;
        Thu, 23 Mar 2023 21:31:31 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id j6-20020a62e906000000b0062a56e51fd7sm1469288pfh.188.2023.03.23.21.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 21:31:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] rebase: preserve interactive todo file on checkout
 failure
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
        <20230323162235.995574-6-oswald.buddenhagen@gmx.de>
        <xmqq8rfn8bps.fsf@gitster.g> <ZBzfZZWthdEM+gKK@ugly>
Date:   Thu, 23 Mar 2023 21:31:29 -0700
In-Reply-To: <ZBzfZZWthdEM+gKK@ugly> (Oswald Buddenhagen's message of "Fri, 24
        Mar 2023 00:23:17 +0100")
Message-ID: <xmqq355u7ota.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Thu, Mar 23, 2023 at 01:16:47PM -0700, Junio C Hamano wrote:
>>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>>
>>> Creating a suitable todo file is a potentially labor-intensive process,
>>> so be less cavalier about discarding it when something goes wrong (e.g.,
>>> the user messed with the repo while editing the todo).
>>
>>Is there a reason why we do not always keep it?  Why is the file
>>sometimes precious but not precious at all in other times?
>>
> the unedited initial todo just isn't precious. that implies that in a
> non-interactive rebase, it is always worthless at the time of the
> initial reset.

I see.  Thanks for clarifying.

Just FYI, the primary purpose reviewers ask questions on the
proposed change is to help submitters polish their patch (both the
proposed log message text and the code) to clarify points they found
hard to understand and/or they suspect would be hard to understand
for other readers.  So please do not be happy by just receiving "I
see, thanks" and stop there.  Instead, please update the patch so
that future readers would not have to ask similar question again.

>>(and if you can reliably ensure that the file has contents
>>that are expected, that would be even better)?
>>
> i could grep for a shortened sha1 i would obtain from the branch. but
> given that the error scenario of a present but somehow corrupted todo
> seems implausible given the circumstances, that seems like overkill.

It is OK.  If it were easy to prepare the "todo should look like
this" golden copy, then doing test_cmp the actual file with it would
have been a simple way to ensure both existence of and sane contents
in the file at the same time, but if it isn't cheap to prepare such
an expected output, I agree with you that it is not worth the extra
effort.

Thanks.
