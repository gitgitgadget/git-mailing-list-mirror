Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F646C77B60
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 05:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjD3FQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 01:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjD3FQN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 01:16:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D4D19B1
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 22:16:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aad5245632so6022925ad.3
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 22:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682831771; x=1685423771;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yM7xj1oA+lYJOA90bdFYI7UZed95X8wK8rSK8LQVJ8=;
        b=HQ7v4vYooLieX0aYon1DBnUPKv8y8a9Sz2hNcvqWr2tD9Ed3rFNfnT0FE0a6d8jSIy
         bXueOAPWui4Q7wUc2zHNamSn3mOimS2wr5bH5sVLIymS1GrsAe0nwnvQ4smjyrZu/cdS
         CLiu1W3Y3pr52Ze153cRIUB8mSd8XeGQ5O6rNQxdlLSDUhH2iTBJDQ2CqrJZ3FUD7Yzf
         Qt4hXb3vt4/d9SC0+HuioETtQz6rx/KqVfQx9W1RO5QYr43bwBDwGjF3AGOZxUA/pXHE
         4V1u7pURWe27u92M9QLjuqTvuY1zj0UoVz9UMF5BxFifq1EpDlKqDXJ2PzU/02dXk2WV
         9ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682831771; x=1685423771;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1yM7xj1oA+lYJOA90bdFYI7UZed95X8wK8rSK8LQVJ8=;
        b=gigmhhTKCLho58ps5HkJXHjpWo1BzcRcwtLYojW9zGDsrTVGtqGxfEbDM+iqx1xnSS
         uIEUH0ir1uP7+sYrw+R81E1B0cAXcAA8F/P3O+2q8YQOADZScbegoFBnFQU3xWJGxuE2
         V1wU5N1bepBOzByvumIAIJjNAJ1yThtQk3sQUJ80l9YnunKZWn4CqlB1scCECV8Jl+Q4
         NVefsbvhfg3dbJAg5zcHBK40U9TEV6l1wCAYMlapJ0783wIrEed+MPh5kB3bFUtl9RRV
         fHmSic/sRZ3qXyRHeF6jJJMPBmY84s0aCguot6rUFhpwMKoxHV23Txa1O/0iW+/QFiau
         E+eA==
X-Gm-Message-State: AC+VfDzbQLzV9OwaiF576/Eyn4VoIvx9f5Swyp1p0IXvzXVBRqzlxu7I
        iLvGqzr2KAQFGftyWhGI4VQ=
X-Google-Smtp-Source: ACHHUZ4Kl5aZ1JKY71icvFuS2Fad/gokKdRxW5Bz5H0X8iWBbs0JrMFKrZ5Sln2tE4erLPUOgqR5ew==
X-Received: by 2002:a17:902:f54b:b0:1a6:45e5:a26a with SMTP id h11-20020a170902f54b00b001a645e5a26amr13243791plf.27.1682831770981;
        Sat, 29 Apr 2023 22:16:10 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902690800b001a1b66af22fsm15580075plk.62.2023.04.29.22.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 22:16:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com, tboegi@web.de
Subject: Re: [PATCH v2] docs: rewrite the documentation of the text and eol
 attributes
References: <20230421055641.550199-1-alexhenrie24@gmail.com>
        <20230428042221.871095-1-alexhenrie24@gmail.com>
        <xmqqsfcjevbz.fsf@gitster.g>
        <CAMMLpeQB1zdTEWd+=d0kaKwpzax093iLTuytZtvn0nTSJ2xT4A@mail.gmail.com>
Date:   Sat, 29 Apr 2023 22:16:10 -0700
In-Reply-To: <CAMMLpeQB1zdTEWd+=d0kaKwpzax093iLTuytZtvn0nTSJ2xT4A@mail.gmail.com>
        (Alex Henrie's message of "Sat, 29 Apr 2023 13:19:00 -0600")
Message-ID: <xmqqcz3m9ch1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> The new text may be slightly redundant, but it makes the
> important part crystal clear.

I tend to disagree and think it is a bit too redundant, but we do
not have to agree on everything---after all you are doing all the
work, and it is your motivation and your topic.

> Then again, maybe the fact that the `text` attribute does not
> normalize CR line endings is a bug in Git, and we shouldn't advertise
> it in the documentation as if it were intended behavior. What do you
> think?

Just not mentioning CRLF specifically would be sufficient.  When
(and if) somebody actually comes and complains, we can say "CR
delimited files are not considered text these days, we aren't doing
MacOS System 7" ;-).

> The phrase "if necessary" would be a bit confusing. What makes
> conversion on checkin "necessary"? The reader would wonder if it
> depends on the Git config and the platform like conversion on checkout
> does.
>
> Would you be OK with your proposed wording minus "if necessary"?

I added it only because it would not be necessary if the original
already uses LF line endings, in which you do not have to do any
converison.  As long as it is clear that no conversion happens in
such a case without saying, I am perfectly fine to drop it.

>> There are some exception handling in the code for odd cases like the
>> contents with mixed line endings, a path set to use LF but the file
>> actually has CRLF, etc.  While they are worth describing, I wonder
>> if they should be done in a separate paragraph.
>
> Probably best done in a separate patch after this rewrite is done.

What I meant was that that your "unless text=auto" and everything
after it was one of thoese exception handling that should be dealt
in a separate paragraph.  Leaving it as a follow-on work is fine.

> Wow, that was a LOT of feedback on a relatively short piece of text.
> Are you sure you don't want to rewrite the documentation yourself? ;-)

Absolutely not.  It is not my itch to update this document.

My itch is to make sure any change makes the resulting text better
than the previous one ;-).

Thanks.
