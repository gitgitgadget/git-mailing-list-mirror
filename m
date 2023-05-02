Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8550FC77B78
	for <git@archiver.kernel.org>; Tue,  2 May 2023 22:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjEBWUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 18:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBWUD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 18:20:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BA9E74
        for <git@vger.kernel.org>; Tue,  2 May 2023 15:20:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24e0c29733fso2400894a91.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683066001; x=1685658001;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7oeK79QZPFfddGQ9TUUlZ30y0txEtA2stFkivvA/7k=;
        b=lXV/NU0vB43S55563Xi9xoZDNCevIVa+iKrQN4mG9onXA4rLv8ck5LhGTeTF5wn2MO
         RGfB1mJuLJxLE/A8tN1PgWiiohnuPO9H2AJs/i6FXNMK2gzSVNGehASvzLg8mHQSzdld
         nPCVNboEWUxrizcYhUlTpNPOYeJy/8eUf9Mj+5eDcXIfBnJfRPT7UjVhcnmNCnT0sIzQ
         XU4oJic9gqrr3xU2bC9Tl5Y8p33/csm1neP0uf8jU+mR9LjAOWtYgEosd1w92Mhw3lTi
         AZ9491x7aJGNhDCVaRIBcAha6TzQdq5FfwNMwka5HDpRyLhxA8fDLGTtxtCoAWcV7eFk
         YTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683066001; x=1685658001;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b7oeK79QZPFfddGQ9TUUlZ30y0txEtA2stFkivvA/7k=;
        b=DmPXTDTl4EIQL19zItwLmc1ATo2zOxtjYjB5re39JNlIOHrfwagNfpHNlLyNF535qd
         jJf4VyDJ97w2sqrF+2vhaLa5va4Rx1YZm9sVi5XDQF9yBb3DUWARDlDU9ru+nIPSZf5N
         3V94KrKXzNLrLBc4lO/ANJIc5yGqdV3Kw/ZcJSez+hAusYWh9rUTi/3SJTNPH8E60+um
         TpLAezOn24QnNa0ENciS9f+c0wEA1IQvMiO0TkHwb59IjYrOa4I+ZxHqEihBwN/1I1/5
         buWVERXnBOwyXYygn/mHqfACQF09KitMq8RQWuZWQz8Tnl3U0pT7WYzogm+QyjqmzgDa
         fYIQ==
X-Gm-Message-State: AC+VfDxCfgPw6L2hOR11jV3HDH1fAgUS86sRvE88VKRVje/V1h2/GPee
        IndrfL0JBE9k1fvkLHrH/uWl2zGrfck=
X-Google-Smtp-Source: ACHHUZ5/FH9YlzmswRVxn/YQ1mlBLQfm1fWC1NuYf1zA8lsniEHYCiymICH8c5jGPDK2GcBl41SR5A==
X-Received: by 2002:a17:90b:3b51:b0:247:bd9b:c19c with SMTP id ot17-20020a17090b3b5100b00247bd9bc19cmr19168305pjb.44.1683066001205;
        Tue, 02 May 2023 15:20:01 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090a5d8900b002465ff5d829sm8214199pji.13.2023.05.02.15.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 15:20:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH 0/6] strbuf cleanups
References: <20230502211454.1673000-1-calvinwan@google.com>
Date:   Tue, 02 May 2023 15:20:00 -0700
In-Reply-To: <20230502211454.1673000-1-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 2 May 2023 21:14:48 +0000")
Message-ID: <xmqqttwuxtnz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Strbuf is a basic structure that should function as a low-level library
> due to how generic it is. Over time certain functions inside of
> strbuf.[ch] have been added with dependencies to higher level objects
> and functions. This series cleans up some of those higher level
> dependencies by moving the offending functions to the files they
> interact with. With the goal of eventually being able to stand up strbuf
> as a libary, this series also removes the use of environment variables
> from strbuf.

I touched a bit of the same in my review for 1/6, but the main
thrust of the series is that you want to make strbuf.[ch] mostly
about "string processing primitives".

Any meaningful features relate to more than one conceptual things,
e.g. pathname functions work on "paths" (that is one) and it may
store computed result in a "strbuf" (that is another).  We have
historically called them strbuf_do_something() and gave the pointer
to a strbuf that receives the result.  And this series wants to
reverse the course and want to see strbuf that is more pure.

That's fine.  The strbuf has become so successful a data structure,
its use has become as ubiquitous as a plain string or an integer in
our codebase.

But if we were moving in that direction, I have to wonder if some of
these functions also need to be renamed to lose their strbuf_
prefix.  A function that takes a pathname and creates a directory
there is not called string_mkdir() just because it takes a pathname
as a string.  A function that takes a string buffer and a path, and
reads the symbolic link content is not called string_readlink() just
because it learns the symlink target in a string buffer.  What their
parameters mean matters a lot more than what type these parameters
are represented as.

With some other topics in flight, merging this to 'seen' and merging
this to 'next' may require different merge fixes, but I'll manage.

Thanks.

