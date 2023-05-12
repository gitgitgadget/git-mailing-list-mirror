Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B98C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 04:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbjELEH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 00:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjELEHz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 00:07:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A522D5B
        for <git@vger.kernel.org>; Thu, 11 May 2023 21:07:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aaf70676b6so67506325ad.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 21:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683864473; x=1686456473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgoxGtxaWC9Ei1T7t1eC2ViFsP2lJ9yTU7sUFU8o9P0=;
        b=aWRg6kaT1l2Roj1CokMv6pf1Vuib2j2DgrrsJoj5aaPizrXXPjCVdPQuTU/j7fraJJ
         3Hvn6/h18Hco/58x3HPq5pl8/VybDcgZMdcogOIMqqGdPAGU0hK5hAHfLX+tYEcOPfVw
         gt//t9CkXsV1byMLgn9JIFAc/ExUy0qzLbQwYgNE7pNwzmhi9h1/GORL3lXs0HehOaR7
         7MMSuEAHGvWfXhvQS4d/SmaceKO8Bz2RSdSK/Tdu1jfcA3E7wPxn1IxU9+NJor7iJt09
         Uj+xzupChHgTRoUBgQpYBEd5d2kEyFpV8hEA++JZFI2HGlSF35yNxmJ20pGTi5yZSxIV
         XwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683864473; x=1686456473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgoxGtxaWC9Ei1T7t1eC2ViFsP2lJ9yTU7sUFU8o9P0=;
        b=SzGDvTXC1kBl9quxGZmhRZDjlJ0ypk3PnjfMGWKw0jacr4Myhv/3slUyOVNA3nn3b4
         eABvm80jT3T1gZyXZNBh3me8mLfWmT6P8gTyky92Cbpaim6480T21SmIbWlsemB+qEv9
         hThqZketEP7nrFp1qKkrm25coS7BDDQMo3xrmaflpYMczmruL1f5WijuAl/7jyf3THdV
         onkfMQvTwV8L+NFn/T6uv4x6kP8ghrmiXJQ/3fsHFp/MXbMRlBaXp+YV67yOpwarqJu1
         egVIDPqXkj+nVn6GrgTlDYh6HOg7+wwN0toHJXB4lbSlG7qQXrneUWPr4u1HEiMCoFKp
         P4fQ==
X-Gm-Message-State: AC+VfDxpnedNf3bcVrz+vZhB5UOmsUI8RsqjAGMen7fQ6/eZUacDiotd
        Zg9WnONlgdyCKPKJKTBlfTI=
X-Google-Smtp-Source: ACHHUZ6wKBnTT4jwsbTP/5kGJZX1W2ex/koyqWaOaOwpPYNqQ5TDvJyG3FAcTItAiJf8GPGs+rg8Qw==
X-Received: by 2002:a17:903:2292:b0:1a2:3108:5cc9 with SMTP id b18-20020a170903229200b001a231085cc9mr32136463plh.40.1683864472755;
        Thu, 11 May 2023 21:07:52 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.52])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001acae973449sm4982746plt.162.2023.05.11.21.07.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2023 21:07:52 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     code@khaugsbakk.name
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Fri, 12 May 2023 12:07:46 +0800
Message-ID: <20230512040746.2069-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.516.gd3e7951b
In-Reply-To: <2908b005-9478-4c59-ae8e-150be44a15a9@app.fastmail.com>
References: <2908b005-9478-4c59-ae8e-150be44a15a9@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

>I realize that this series is going to be merged to `master`.[1] I was
>trying out this new change since I might have some use for it when the
>next version is released.

I'm glad there are use cases for the topic.

>The test case[2] `append: specify an empty separator` demonstrates that
>`--separator=""` is the same as the default behavior, namely to add a
>blank line. It has (according to the commit messages) been like this
>since v5 of this patch.[3]
>
>v4 of this patch special-cased `--separator=""` to mean “no
>separator”. And this was the same behavior as the original
>`--no-blankline`,[4] which eventually mutated into `--separator`.
>
>Why was this changed to act the same as the default behavior (add a
>blank line)? I can’t seem to find a note for it on the cover letter of
>v5 or in the relevant replies.
>
>It seemed that v4 of this patch (with special-cased empty argument) was
>perhaps based on Eric Sunshine’s suggestion:[5]
>
>> Taking a step back, perhaps think of this in terms of "separator". The
>> default behavior is to insert "\n" as a separator between notes. If
>> you add a --separator option, then users could supply their own
>> separator, such as "----\n" or, in your case, "" to suppress the blank
>> line.
>
>(And then reiterated in a v4 email [6])

There is indeed this change in the process, I did not express it clearly in the
patch, sorry,  allow me to explain it:

Initially, I wanted to support separator insertion with --[no-]blankline. It was
intuitive and clear in logic. If it is specified as --blankline, newline would
be append, if it is --no-blankline, newline would not be append, and --blankline
would be the default behavior.

The problem with this is that "blankline" might not be a good name because it
doesn't seem to express the meaning of the separator or paragraph-break, and
since we're going to support separators, it might be more thorough to support a
custom separator, which is a better solution I think.

Returning to the issue of -separator = "", my thought is that I want
--separator="" to behave the same way as
--separator="<any-string-without-a-trailing-\n'>" when deals a string which does
not contains a trailing newline. This will eliminate one more implicit logic and
make behavior more consistent.

>Was the idea perhaps to eventually (separately) add a separate option
>which functions like `--each-message-is-line-not-paragraph`, like what
>was mentioned in [7]?

I think --no-separator maybe a better name, means that not any separator will be
append between two paragraphs even a newline.

Thanks.

