Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265DBC433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 17:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351809AbiAURqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 12:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345647AbiAURqq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 12:46:46 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C6FC06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 09:46:46 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 15so11170619qvp.12
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 09:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WhpjANp4B9GSTSwzxxDT5Oq5d4ekxYyL+APMDc8+dSA=;
        b=FXCCHbJ7FZQtB9p6NUTYtQe0eajWLtMvgFCFrF1ePy2YcMMjeK79ytcwLw8u+XQBLn
         XnxPAF7YWo0DfS8VoorbyeamzWwWKaTMKdoIgLMSYJHGnVEHBC4trDH87LjiBPSYp5dB
         xjwtrXg44lPocGM9AWbmaDskhNRMJNFg6YFG91iK2zTqSpOuhm4i3RGl1XBKoEmMktTa
         Py7Yo5DrFF4M3aeP1O3u1R/RRG8mSjxMyeifeCAW3AOjmPQ8NPTgqTtXt+8gErY78+Bq
         kiBL4LgQO5Dai31yZNLDIg5wqKU/TyTyN/WUyjgZYVMNrRPXDuWsdrQDMmoZIPEAzbGD
         rssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WhpjANp4B9GSTSwzxxDT5Oq5d4ekxYyL+APMDc8+dSA=;
        b=l/4zWpJsiEENe20IJ/QDBoZZQO7eD3zJUvYXtoAoqAK2ktbYOJN1ZHtqGiZ9iIKI2e
         zyyVAbYLX5VDbWjcoqJQNw2HCDEUgDFMumzlRaL5qkHDKEHCoacbtJVViYOlaZBraLsy
         FF0XzL2XfP/uciX/waLsxXLyiLOINjK2Cbr7+Q80IYoUJOKke7GLq8ZI+qFLc24HW/Cw
         DRXWoP8gDgEYr1W0YxhdARNYbiz/PitjSknN21T8wk41h97Fn+FhtDBwIqxCo8/ZnLjl
         KQqEFrdjJCVxby+8vyeqsrDxnHhFZLmeDr60d9FpobJwBavpqHM9HFA8CBKw7KPJ237q
         DXrw==
X-Gm-Message-State: AOAM5301wOaUMjDXAeImDVjpclHcwIzy94mkX4OcDRdtTXfOGJxdt2Yj
        BNBRZYxUBRiL6GNG5okgoBo=
X-Google-Smtp-Source: ABdhPJwppS8C0Ok+BPoeFhewhuW4O97jUOhk9KW6y3ZvOon/2IboH7FVMSZB7TVEAc7KeI3Hew3hOA==
X-Received: by 2002:ad4:5cef:: with SMTP id iv15mr4683417qvb.102.1642787205200;
        Fri, 21 Jan 2022 09:46:45 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id q7sm3339392qkl.78.2022.01.21.09.46.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jan 2022 09:46:44 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/2] cat-file: add a --stdin-cmd mode
Date:   Fri, 21 Jan 2022 12:46:43 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <820BFA8A-80D9-42F4-B8A6-D8746947C794@gmail.com>
In-Reply-To: <YehomwNiIs0l83W7@nand.local>
References: <pull.1191.git.git.1642615122.gitgitgadget@gmail.com>
 <YehomwNiIs0l83W7@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19 Jan 2022, at 14:38, Taylor Blau wrote:

> On Wed, Jan 19, 2022 at 05:58:40PM +0000, John Cai via GitGitGadget wrote:
>> I think this will be useful for other things, e.g. a not-trivial part of
>> "cat-file --batch" time is spent on parsing its argument and seeing if it's
>> a revision, ref etc.
>>
>> So we could e.g. add a command that only accepts a full-length 40 character
>> SHA-1, or switch the --format output mid-request etc.
>
> I would like to see a more concrete proposal or need for this sort of
> thing before we go too far down adding a new mode to a command so
> fundamental as cat-file is.

Thanks for the feedback! I realized I should have made this an RFC first.
I’ll submit an RFC separately.

>
> Between your two proposals for other commands that you could add, I am
> not convinced that either of them needs to be in cat-file itself. IOW,
> you could easily inject another process in between which verifies that
> the provided objects are 40 character SHA-1s.
>
> The latter, changing the output format in-process, seems dubious to me.
> Is the start-up time of cat-file so slow (and you need to change formats
> so often) that the two together are unbearable? I'd be surprised if they
> were (and if so, we should focus our efforts on improving Git's start-up
> time).
>
> In the meantime, this is quite an invasive way to provide callers a way
> to control the output stream. If there really is a need to just force
> cat-file to flush more often, perhaps consider designating a special
> signal that we could treat as a request to flush the output stream?
>
> Thanks,
> Taylor
