Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D56AC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 18:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377395AbiBDSKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 13:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377394AbiBDSKM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 13:10:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03AAC061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 10:10:11 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w62-20020a25c741000000b0061ad4f39f40so6721526ybe.21
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3ULCAzgnJni7dQPbIkPXdNAwrzLWmqRDac7Dm035Ohk=;
        b=KHJO6NcyBlM6ioST9OW3kFYy8VBucL+2KO6swXkx2kcVJ/zRD5szDjSYzkKg3LObnk
         PtFVjgvO9ZIJMzq7Ip4rD5gYQwIQWoDey+2ISWNAJ8lzDccm6uEyPNCbfGLv+sORjwJx
         TK0ldQEWKswzAtp5dYjEV58pFUyasKw4EWHzoJvPFkoZmNHN+MelMryV4fQec/QFpu8p
         B0rdJKGiknFPHX7T1YYhWYEs01JoFv4QWrowOp4yOCIkeAqH9aoHpKOuEWPw5g2Txcuv
         YpVu5GijJRg/DYKwVJd18lIwdHu0qGdeAvQuppK/gz+N1VqCXiADhG9XEPjgeeAas69j
         RR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3ULCAzgnJni7dQPbIkPXdNAwrzLWmqRDac7Dm035Ohk=;
        b=wQuxPrMcWJBO3+s4pLZwvzam5qGwJLqfiYXNai60rvx7rkAAi0wdveQ5wO7Td/30kI
         uG60dfnKbo6JE2CMCp5oPc0q8C6cCFmtTpp9kUm2D3nphQw5q0v3/nrGH7m2lKZJ6vVZ
         TlWSdRmhbZYUNlM19Zn8DDs/aU/CJxQ4094TPpI4l5y+z3sz3gtKw+1G+y52Wu4GjX8I
         +35X7PVDFykU6WcXpW29zyNTBSIs3auaYVlmtVz6hIMW8MaHxjmcczJIAWKJHljQM65e
         fb6cLpvj4pN4YQ4AqhjF6sknd5Xz6uYkvjEzHXa50crWAen/fIjIfEfhLeY4CnAQjFpT
         1b8g==
X-Gm-Message-State: AOAM533klB/2G7FjPrRNmyabYUpKb7BltdniENTyGTCkMUpRGOhBzvqe
        hEWRWFF2fPbws0xfkhtp2FlXppOGERvhAQ==
X-Google-Smtp-Source: ABdhPJwwoibx/8YraIzI9Cyx/uQ56MP9WSTWxUeoCFRIHlvXjhmSNNEPiy87wsZ5uyyT/bRFwCW+Kg9DBllwhA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:ad48:: with SMTP id
 l8mr75514ywk.480.1643998211194; Fri, 04 Feb 2022 10:10:11 -0800 (PST)
Date:   Fri, 04 Feb 2022 10:10:09 -0800
In-Reply-To: <xmqqmtj6obft.fsf@gitster.g>
Message-Id: <kl6ltudezeny.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220124204442.39353-1-chooglen@google.com> <20220129000446.99261-1-chooglen@google.com>
 <20220129000446.99261-6-chooglen@google.com> <kl6lwnibzbb6.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqmtj6obft.fsf@gitster.g>
Subject: Re: [PATCH v8 5/6] branch: add --recurse-submodules option for branch creation
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
> As long as the log message of this new thing does not have to be
> retained, I can squash it in for you.
>
> And in this case, we can lose the message below---it just talks
> about a mistake in the version that was submitted, and will become
> irrelevant once the change is squashed in.
>

Yes, the intention was to lose the message.

Thanks so much for being accommodating :)
