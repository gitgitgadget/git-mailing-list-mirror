Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E138AC7EE23
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 23:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCAXPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 18:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAXO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 18:14:59 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F7F2197B
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 15:14:58 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u4-20020a170902bf4400b0019e30a57694so3604522pls.20
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 15:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677712497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4L65KWRRdWeP2/XDu7dxZwbvGdaM88uJq0Eb8lb+55U=;
        b=oF2+oLBKQooR6zGp33nwh5HFQsLzWvgNWvYckwVqGf7/BOjIV375wk3sDaJ9djSIEm
         SyfCUcYxCL4M7R0qdtV8VhkqW9Al0yknulMoxYcOvXs5UZjK1vBDb3Nt2VCONXxkT2Pw
         DUnUfPrp3NO377YFHjWCgVkzeca0qAaXQo34NqgQOXIM4olg4mG5TAukvEYEXRQvG4Dv
         ecuoPjOgIlA/1y0VFKk5ilqCV1//DpYfRcLVBx+p5tKQYdNlFs/gQU9GeczNcb9GGN/B
         6r1c8/AApxuPZX5E8o/t94EZsln13aoIfJPnBFSGa6VPyyv5vEJedjvJIFZ1DzuvFlIz
         8ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677712497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4L65KWRRdWeP2/XDu7dxZwbvGdaM88uJq0Eb8lb+55U=;
        b=QSCueHxw5UivwrwXqYzcBtTgKTKPVNr4jZOuMc4OcKzUMwV6llJi8SwSZJklLDtNr+
         1w5mKFKrtjm3Pz70kauXdohr1jF8QXBR1V+qfNafCM4Furz6pwN7Wrfdqg/LumY39YnI
         cyGfxn9O0k28RYGLyjKapWvWXlrnimErVqt708DZeMeHpxfK+T/pnUNmBXUu/FNuOTDo
         SzUdfjtvCjQnxLKW8NcNdNUqBfFiZ0ni+MXLsxKY6As4A6y2zEo8Z3pASaMcxAjq9bAJ
         ebD90qIW/+az96sNvEBvHwuRIFJbXof80IHVrHjXfA9XpgvV7w36M4axhJuc1mXpLkEh
         xCXg==
X-Gm-Message-State: AO0yUKUnADVLu32jSZnU+kFA9iRAQ3NtsYSbpeskNNvC/58LwjV7LABr
        FKJ6WA8z4tRGpS5jHZKPqTKFb2QqlAmP0g==
X-Google-Smtp-Source: AK7set82c28dKG/hmlRLPLD2vOZ9WN6Yrd3yYGFz1jNcfcajLbQXcSBuHcih4DHgHlERduQxTNPV6pPVd7kNvA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:f782:b0:19c:140d:aada with SMTP
 id q2-20020a170902f78200b0019c140daadamr3027689pln.2.1677712497585; Wed, 01
 Mar 2023 15:14:57 -0800 (PST)
Date:   Wed, 01 Mar 2023 15:14:56 -0800
In-Reply-To: <20230225180325.796624-1-alexhenrie24@gmail.com>
Mime-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com> <20230225180325.796624-1-alexhenrie24@gmail.com>
Message-ID: <kl6lwn403vyn.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 0/3] rebase: add a config option for --rebase-merges
From:   Glen Choo <chooglen@google.com>
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex! It was great to see you at Review Club today. If you'd like the
notes, they are available at

https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w

though reviewers will send their feedback to the mailing list anyway, so
don't feel compelled to address feedback that isn't on the mailing list
:)

Alex Henrie <alexhenrie24@gmail.com> writes:

> Changes from v4:
>
> [...]
>
> Suggestions not incorporated:
>
> [...]
>

I would have appreciated a sentence or two explaining the high level
changes in this series, since that would save reviewers from having to
read the whole series to get an idea of the overall intent. For this
series, I think the subject line captures the intent pretty well, though
even simple descriptions like "Add a config option. Also clean up some
problems with the --rebase-merges flag." can be useful framing for
reviewers.

I appreciate the summary of changes [not] incorporated, I found it
useful for getting an idea of what was originally discussed.

On the whole, I think the config option will be quite welcome, and the
series is mostly mergeable, but might benefit from some documentation
tweaking.
