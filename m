Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DB5C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 18:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCMSCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 14:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCMSCe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 14:02:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C372579B11
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 11:02:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso480634pjf.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678730553;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7rvsRPkwJK8s2dsN9Mi41XAi/fF3Otzt996LMOLY1k=;
        b=pMEWjdkXUYwTgzfke2lWWtXYTEPe2zBwESj1eMExFFPdV4DRhhdmJIFQYdst4GyV3Q
         ZMxtGLp628+F3TYoekmkGlnsRQ7CO2mFbdDSXpzKzf39WzzIABUjdKwMpWByCq+frxDe
         Yt4H58DM28w9hL7e1M5M0gazNeP3TB6bXCioj8JVLPKu5OZcj5aqEdwaKj0O2Vmax7r3
         BbigvuXaZz9y0c116QnOQuKe3iVrYsk0EQdcDw3harZMnbp5uP+ZnXyp76lzNoF+9E2U
         VJ0WQQHt7K5biYf8p3JPRC8f6xRi1AruvmS1NG1CsNU2qt/YL4q14+pT+pD2u9wWhMyE
         TnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678730553;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i7rvsRPkwJK8s2dsN9Mi41XAi/fF3Otzt996LMOLY1k=;
        b=8M+EJFiUA2xizIP4f0evcq69XySOR2KVYkSvIbviYvfbDnGixJdJQHO4/w1Pv73Bzi
         +fSTIsRrZYgAQXsZXq/kjNIdbpbfBteSG1JaPYrrHV3pSwxmum57VKdzBlAbzcCViKOs
         bW+szUw/bhISDqkX9arjfiGg65+w5sIOawlI+IyUpioO4eDeEvleLLe2CLjXWubgkU7u
         S0dVWRARmaPBHAfWcthRT5Um3hFZvB1jdM+z3+IyXNqwMSH6qaG/SiJHmtyYBB7IZhi9
         6qnn4m6W3EFjdzStGpjKowE/A233HjwbLAt8bcSMGeRQ4/sV6CVC5QApuEb8duRv4zSS
         lc1A==
X-Gm-Message-State: AO0yUKWZegaxesPOTPXR6+LKx9ctO/2Q4sbpJvyGXj+2qsdZ7RmrFZ/t
        V82cR1EpmF/KAybZPYTl9ek=
X-Google-Smtp-Source: AK7set8ZIe0ULyUglSEz0rdIKXnYsFSeUWKErsulgJSsZDtHe1iaE+VcJXg/kHC1Nf9f9drsO6jUDg==
X-Received: by 2002:a17:902:6a83:b0:19e:866c:3547 with SMTP id n3-20020a1709026a8300b0019e866c3547mr30725430plk.65.1678730553076;
        Mon, 13 Mar 2023 11:02:33 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id jx18-20020a170903139200b0019a8468cbe7sm145754plb.224.2023.03.13.11.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 11:02:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hugo Sales via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hugo Sales <hugo@hsal.es>
Subject: Re: [PATCH] Add `restore.defaultLocation` option
References: <pull.1467.git.git.1678578153640.gitgitgadget@gmail.com>
        <xmqqfsa9y7t5.fsf@gitster.g>
Date:   Mon, 13 Mar 2023 11:02:32 -0700
In-Reply-To: <xmqqfsa9y7t5.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        12 Mar 2023 14:32:38 -0700")
Message-ID: <xmqqfsa8v8av.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Hugo Sales via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Hugo Sales <hugo@hsal.es>
>>
>> This options allows control over which of `--worktree` or `--staged` is
>> applied when `git restore` is invoked with neither
>
> We do not want to do this.  Tutorials and documents will be written
> assuming the official default, ...

Well, I think this change is no different from any other
configuration option and it may be OK.

My initial reaction primarily came from the fact that the choice
between the index and the working tree is so fundamental aspect of
the behaviour of the command that people who wrote their script
would be relying on it not to change.  But given that the command is
still marked as experimental, as long as the new behaviour is
clearly documented to warn those who care *not* to rely on the
default behaviour and tell them to instead always give explicitly
these "--worktree" and/or "--staged" options, it would be OK.

This actually is a more important tangent, but if you think the
command invites mistakes from users who forget to give "--staged",
it may indicate that the command is too overloaded, and the UI might
be improved by removing the feature from this command and instead
encouraging people to use "git reset" to futz with the contents of
the index.  I dunno.
