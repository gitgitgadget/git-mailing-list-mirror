Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC53C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 19:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjDXTxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 15:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjDXTxO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 15:53:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE92C40E0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 12:52:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso4196657b3a.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682365930; x=1684957930;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXPxdTeqewj+WjOW6JRas2jmrBJkZQ3MOTzA559Rdqw=;
        b=ISjukZMAkTH+9P7YL4xUhP+sNXRFHfpUcmxxwBlEtpio90eiLCQ2a+xX/gpCUm3yLF
         yWCjdLXO8SsoRCcLYc8+sA5vT8/7ib5PNIkwMSsK9i1U6jBdYGkQgdhLSV1VcAv/uqfI
         RoXeIfLIoULPoSjl597p2SFlTrp3uFvuo1pxws6WneJjzGSGl9K8+HkmjZqBCxy8EEIT
         6BzqLXYahsJzWqWLowo+DYKbwvCfwLZFnrNomqTvs0Luq6Yf0DYQGLttRKq24Rlf9i13
         bvkqpb/iUaP8biu5oY7j07IUlNS2vKvWp1hhPWpttseghVJzdQ/F6axyrKkL6FN7WgaO
         tu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682365930; x=1684957930;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FXPxdTeqewj+WjOW6JRas2jmrBJkZQ3MOTzA559Rdqw=;
        b=NKxLEQo+P93wX/WyVR7FlULjZaGtbzoFW60Yk6YjctVMfkMQocpGpkD/F5aIuZPZgr
         CCnz6mkopwIhxFObzzTJOE2cojhe9RJp3PyuwZoDY9eF5wz3i3IHgDYLLkBNCi+ZJVK/
         RvOqp9FfWDLeVqIowLtc0f6LUPxd070CxuCPVYu5dx7kYU5FmZ8dO4VY8aN8I5z7qBa9
         Do2wTR8s/54Z5cvK0z8cofVz2dMpUB8HMJ7P8Xg+MIoUOyyOrtLAJMjuNlJ9r5cQGzF4
         u0/yAwcZpnoKi0AH/3v2ddhvmXGy7wTRzex9QA8GtkYYtpo5KZXCQd2Gfy8jgcfMHx27
         M00g==
X-Gm-Message-State: AAQBX9foigLeB0uUzRI5Eaf1hJePPEixerJbQ/+RidgNVYk3nslSSvMx
        wDME9/SjEPfcw5qaCxPDO8w=
X-Google-Smtp-Source: AKy350YUV0SJ9G///2FgvAa8kchXyjsNPELpDIsgjNb0qe6UvsmWb3RsqqTf+q3MuD4WvJvFiYc4Gg==
X-Received: by 2002:a05:6a00:1496:b0:63d:4407:b6c with SMTP id v22-20020a056a00149600b0063d44070b6cmr21257063pfu.7.1682365930158;
        Mon, 24 Apr 2023 12:52:10 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id i189-20020a62c1c6000000b005a8b28c644esm7788434pfg.4.2023.04.24.12.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 12:52:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 13/22] hash-ll.h: split out of hash.h to remove
 dependency on repository.h
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
        <d95f97f5e90da40b285aa8fd678efcff0ae11033.1682194651.git.gitgitgadget@gmail.com>
Date:   Mon, 24 Apr 2023 12:52:08 -0700
In-Reply-To: <d95f97f5e90da40b285aa8fd678efcff0ae11033.1682194651.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 22 Apr 2023
        20:17:20 +0000")
Message-ID: <xmqqwn21cb2v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This allows hash.h and object.h to be fairly small, minimal headers.  It
> also exposes a lot of hidden dependencies on both path.h (which was
> brought in by repository.h) and repository.h (which was previously
> implicitly brought in by object.h), so also adjust other files to be
> more explicit about what they depend upon.

Yeah, <hash.h> becomes pleasantly small.

Will queue.
