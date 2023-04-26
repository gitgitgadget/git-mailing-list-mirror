Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A85C77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 21:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbjDZVOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 17:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjDZVOn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 17:14:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545D63AB1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:14:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a98ac97d47so26210085ad.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682543678; x=1685135678;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbH437p7yrHov+nitN/yui+WTgJlAH5uhgQZopB7+DQ=;
        b=RcJrALn7pieh3C8dZDjFwGT4l7DH9cMZfkeX5lb2uQx/BTwNWOPZjjk0sIxR7b4B6j
         aGMpHKaZCwMxC905wlDMEW152454uxZ6hbmt0B94OMI3Su3+0JyJ61euS29N9CcKLn9v
         NIXft8o4FQxIFpoYju3EIy2NTKSSJQm3jj6VOdTbXzx/cG4NAclIM6O1T1paXf0ew6LV
         0uU6hgc+BWFXcNLhDZ7NvbYR4hbW6rLgGx/cMdI3Gj6q+CPLxLNTdk/KzwsSsvYzvbr3
         qDFJBQ55Sgmwdy7Jr4XgXVxrt8GtZ5mIQeGMiAEeS9Tpi7P2nq2xKi8iZFJEePU+8MDA
         1wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682543678; x=1685135678;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xbH437p7yrHov+nitN/yui+WTgJlAH5uhgQZopB7+DQ=;
        b=R75xZBje5aIcz3vX0UA3UKCVcd8H9bSRnjYDVgVU6LmeAZgpAx+4AQEwJdUqbhAI03
         a7FxXfHR2VVjD7ihwIxaH98SuKztAAm9wBVYNkWs83yd1nuoqFM3hpyNSodEtUCgngH+
         fxDWHTg78TW1Obiqm5yKZ91SYmZ0KvfOhNyQw9HI8mNWDUaU1o54rMucfxb+TGubRomF
         pkwKEqtfUOCX6UQVpwA66QcSBfvYRc4xywg0f5trlxBKZJUSFW2zphs9nlf8qNjDsKLV
         bQDZVkXGXk7GTMw77QJxECtuwbNFnyXxvuFu3NKRBJwgamSOhzTXH54SAW13Q7Szjovf
         pCZA==
X-Gm-Message-State: AAQBX9e4i5u0AJo2lQQGTDfk/IXjSiItfGHi7PNTuBiAQaxPP7/EpA2U
        h98p2VWbVQyEZeMe/wQ9XINkf499g8A=
X-Google-Smtp-Source: AKy350aU2NixZN0M0lct3QTfgJYsJJn35KGF4Ga9OHzfPu33RzyHs+GkcWatumzcvpxRQKFL3cCl7g==
X-Received: by 2002:a17:903:22c9:b0:1a6:81f8:63c5 with SMTP id y9-20020a17090322c900b001a681f863c5mr27858772plg.12.1682543678244;
        Wed, 26 Apr 2023 14:14:38 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001a682a195basm10402445plb.28.2023.04.26.14.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 14:14:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH 1/2] http: advertise capabilities when cloning empty repos
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
        <20230426205324.326501-1-sandals@crustytoothpaste.net>
        <20230426205324.326501-2-sandals@crustytoothpaste.net>
Date:   Wed, 26 Apr 2023 14:14:37 -0700
In-Reply-To: <20230426205324.326501-2-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 26 Apr 2023 20:53:23 +0000")
Message-ID: <xmqqo7naqrb6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> From: "brian m. carlson" <bk2204@github.com>
>
> When cloning an empty repository, the HTTP protocol version 0 currently
> offers nothing but the header and flush packets for the /info/refs
> endpoint. This means that no capabilities are provided, so the client
> side doesn't know what capabilities are present.
>
> However, this does pose a problem when working with SHA-256
> repositories, since we use the capabilities to know the remote side's
> object format (hash algorithm).  It used to be possible to set the
> correct algorithm with `GIT_DEFAULT_HASH` (which is what the Git LFS
> testsuite did), but this no longer works as of 8b214c2e9d ("clone:

"this no longer works as of" -> "this was a mistake and was fixed by".

> propagate object-format when cloning from void", 2023-04-05), since
> there we always read the hash algorithm from the remote.  If there is no
> hash algorithm provided, we default to SHA-1 for backwards
> compatibility.

Other than that, looks good to me.

Thanks.  Will queue.
