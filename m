Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B37C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 08:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjAII4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 03:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbjAIIzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 03:55:42 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E8715FC4
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 00:48:02 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso8672331pjo.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 00:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxC73VkXSZOde+Y0AMb/eSnzVRro8TGkzbR7paIqWdQ=;
        b=psI0AmEvYnuyRXF/qbTegQo8rDhU7bYDBm0gnLoJqF9l8jbIjN0FaHqYqJEc4w88aq
         ++TI731SZ4b7VC1NX4hKq1Flh604dziUCvj5XqBTX5SdAXMXG2STJbQ17hcd1Gv+9fb8
         BgDobEOE/m7PBV+tjPujOzt7jg25R0NuuXT/h4Yxuv0Byg70/N8HfACCye2K+jiP762C
         v5ta4j9zIZIRaxSzOD6EXzxUOXNVPUUI8dRnLQtC2uNWHjJIPgrSKsfT6GNWmy42I0AR
         GWUJo9xS5Dc4EgppP2jeMlOo1cdPD6BNAnMBnCMxWufWHidyRkA424FA/whTyquLYAL1
         y8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QxC73VkXSZOde+Y0AMb/eSnzVRro8TGkzbR7paIqWdQ=;
        b=FpdTvFwyi22m8EZii0dSMDsBjH7X4nVnyvIee9+siVt0IXijtxzssW5omJnLNLR+Co
         xm0cWsZFI9a6P+5iozb3NckZ3wiVJeKndni+HyWExKp6350bRENPCQtN69E0euy2EbVt
         3fOdP3PkGGpmqH1NaJDWEmrBZ2YuKPwHoJ7j6CfNz6L+zVH0C0WTG5sD8RIT+umJ2CcB
         PTZIMYzJnS7PGKDwT7Kp4XHDR7MX6u8y8egunVKN+uQjLPXsr71J2vUDuuDSFuA8orbR
         Og5LxICMMdUmPnr8wWzQ/8J3fgRD/BALExevQ3SEZ9Dz5GfVhGX3tqR6smUkNjXzoZvr
         7ZjQ==
X-Gm-Message-State: AFqh2kqiJVduqgRj5h9dhnZwdTVuZZyj9xUhYJKXo11oR+r71KSN0R75
        +hEgKA5CVqtXAUuwYDaJ5OM=
X-Google-Smtp-Source: AMrXdXt4GZK01xR7NgzztxIxuoRwahRaKwvfYVQ3Ko684OygmEyr2+qKL2+eFxLu3yEAXHiC1a8yTA==
X-Received: by 2002:a17:903:2d0:b0:192:b5b3:7ff5 with SMTP id s16-20020a17090302d000b00192b5b37ff5mr38028164plk.50.1673254081661;
        Mon, 09 Jan 2023 00:48:01 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l17-20020a170903245100b001890cbd1ff1sm5536045pls.149.2023.01.09.00.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:48:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com, plavarre@purestorage.com
Subject: Re: [PATCH] date.c: allow ISO 8601 reduced precision times
References: <20221216033638.2582956-1-phil.hord@gmail.com>
        <xmqq359gnfhe.fsf@gitster.g>
        <CABURp0pWwfWO3msZ4U=_i3zkEDOq6+CUVT9Tb7KCjeBRK34Miw@mail.gmail.com>
        <CABURp0pqQFiM4+L0sRADTt-jmAsHcMMWLR6xa4NbqrziZjmdOQ@mail.gmail.com>
Date:   Mon, 09 Jan 2023 17:48:01 +0900
In-Reply-To: <CABURp0pqQFiM4+L0sRADTt-jmAsHcMMWLR6xa4NbqrziZjmdOQ@mail.gmail.com>
        (Phil Hord's message of "Sun, 8 Jan 2023 22:41:50 -0800")
Message-ID: <xmqqbkn8um9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> Do you have any suggestions about how I can better alleviate your
> concerns?  I don't think there are real regressions here and I tried
> to explain why.

Other than "including it in a released version and waiting for
people to scream", I do not think there is.  The "next" branch was
meant to be a test ground for these new features by letting
volunteer users to use it in their everyday development, and the
hope was that we can catch regressions by cooking risky topics
longer than usual in there, but we haven't been very successful, I
have to say.

Thanks.  Let's queue it and see what happens.

