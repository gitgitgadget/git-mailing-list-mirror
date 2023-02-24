Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30863C64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 22:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBXW7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 17:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBXW7U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 17:59:20 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEF363DD8
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 14:59:19 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id ko13so995094plb.13
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2BhaPQmfeMVNlD/73b07MYkpSbEhwJIMNgjDj8VzWk=;
        b=LZMld6LjHK7gN1dVQLG4FWW7k5D2pj8HC6vFOZ3Sg1xEtv+clfdeDjXBtEPJDxXN4k
         IVEJuRDl3/CYlAAYN//XsN25ijq+SZhD7UfcJITt4w9VmHE8PJ6AnumCoG/TSEpDLbDQ
         ly+xrLigrg7Bvej3aDV8puynr1e3fkKlyYg/DQMbbgI9gB75GHNbhRCGfaLj0J1/0AWy
         JbadmLQm5u7KpMBW/zqRsL8QRaXvcbZiwLNvXL5SmoQl8+VemW+c6cFkvyg5as4StoC5
         x23mYUIsAuUJWZRVC5AukBNckP+Tgou+pZGfqqSfFu9cgDCE4oaP1QoHk0rk1dfj3c7g
         psMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W2BhaPQmfeMVNlD/73b07MYkpSbEhwJIMNgjDj8VzWk=;
        b=2sKnKJW/Nms4P82+zqQ1iwftSXnhSz0bm3LKSPsWxKhkyJhBREfyE/4Psmk0HK9zW8
         iNIO8uk+MVGD7BdxKalxlhMcU7NMUnd12xJW/TXQQSZ1oe/myujKV1U4AusRBZQT8wh6
         ab9h9TVpusAvbUgVtBhFOoH/1bhC11dAjHii6b/I12+M3mQQwdFWltju0YAxpZarxrid
         s5me3+ngf8mGO2ZLThnzNLTRNiQAeR6E8ylnSLn7M2qmaz5otxcfsqOqGCwfRxQTTgNG
         7wCc/5zC2za/VvINYuggWWvnXQtQJomQWgd5RhVCjGd5rNs+6W7xIOKldvQAGXpPDnd5
         Tv1A==
X-Gm-Message-State: AO0yUKWGf3z0/6m/gaFW5472pfxPN2hyaLAejgJqO64AbiYwW5tVibnB
        Idho/K2lvIexYKY22Hy122Q=
X-Google-Smtp-Source: AK7set8QZDeQl8mMjS9Mi8+DiEIbC7LtLLCZqkG6CTO7S8fgsDlcxiWeKQrcklz6SUAWJm3MFWizMQ==
X-Received: by 2002:a17:902:e5c4:b0:19a:95ab:6b37 with SMTP id u4-20020a170902e5c400b0019a95ab6b37mr19893624plf.66.1677279558552;
        Fri, 24 Feb 2023 14:59:18 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b0019a70a42b0asm23188pln.169.2023.02.24.14.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 14:59:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
        <Y+/v15TyCbSYzlVg@tapette.crustytoothpaste.net>
        <CAJoAoZmMQ-ROdCp0=4oaFa836-PqxwYntnRSBSzzJc5chp16eQ@mail.gmail.com>
        <Y/ACqlhtLMjfgJFQ@tapette.crustytoothpaste.net>
        <CAJoAoZkMR9Acy7thVs-_e=Fz8wwjoDGDKb46wmwn8yxk0ODGow@mail.gmail.com>
        <Y/ZuR9zs3peUfO0g@coredump.intra.peff.net>
        <CAJoAoZknYizS4peYgR4Zy5KUMEpFUbj5eREZoC_K5vUDXnAhng@mail.gmail.com>
Date:   Fri, 24 Feb 2023 14:59:17 -0800
In-Reply-To: <CAJoAoZknYizS4peYgR4Zy5KUMEpFUbj5eREZoC_K5vUDXnAhng@mail.gmail.com>
        (Emily Shaffer's message of "Fri, 24 Feb 2023 12:31:16 -0800")
Message-ID: <xmqqbkliwtyy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

> Is there a reason not to use this kind of struct and provide
> library-specific error code enums, though, I wonder? You're right that
> parsing the error string is really bad for the caller, for anything
> besides just logging it. But it seems somewhat reasonable to expect
> that any call from config library returning an integer error code is
> referring to enum config_errors...

In addition to what Peff already said, I think the harder part of it
is to parametralize the errors in a machine readable way.  A part of
a library may say (with an enum) that it is returning "Ref cannot be
read" error, with a parameter that says "The ref that caused this
error was 'refs/heads/next'" which makes "Ref cannot be read" error
has one parameter.  "Ref cannot be renamed" may have two (old and
new name).  Other errors from some library functions may not even be
of type "string".

Coming up with the enums to cover the error conditions (which Peff
covered well) is already a lot of work.  Making sure each of them
take sufficient parameters to describe the error usefully adds more
on top.  And the code to pass these variable number of parameters of
variable types would be, eh, fun---it would be error prone without
compiler help.

