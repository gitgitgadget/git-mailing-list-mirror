Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE7C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 20:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjECUpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 16:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECUpV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 16:45:21 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E58D768E
        for <git@vger.kernel.org>; Wed,  3 May 2023 13:45:20 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso4939747a12.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683146720; x=1685738720;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIq4NivP/RQF6q6XRNRAb/JuJ1qIdcpUqYUhSFvGtLk=;
        b=QFtbnXKgpbLnBWQR6P0ZO74Dao9CMftKFoaGNRDWPiWInhAIfadzq3JJYRe+70lfyV
         sQQVvflxtgu3kXA3c1SrT7Aqm1YuCuGFvTbNV5F6K/ZjZraymXbcVVw/aipOxfR3u7EE
         GwnhfkpHqrthx3pgmdulVAJDdwQuh0r7Tn7FQZcqVIredTNrYNFsyYne8Mf5eI5MqAdM
         7bXTzi64Ya7E88gFQE8GyraLE5Nrunejt1zd9W0mHGJwge5Sbn7A+inSoPg7tRj5StpS
         TD4cPHFrPZKHtamNLKrjacw+7nUhvzWkg2OIW0m4WRVH4U7/V2CKl/gF5+BKi5wgNmSM
         h0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683146720; x=1685738720;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dIq4NivP/RQF6q6XRNRAb/JuJ1qIdcpUqYUhSFvGtLk=;
        b=Wh3+Rja2++/lDGjxspYCLynYA3uQiA02ABvfVwxDTkog1+TRK6C9UORNEu/wkbutLu
         f2LTTK5iQ7ru+VNboam+FjfKmVMclh7G89bCgPyHVrX6jRmNQsIRCwIp5SuAV0ElJfpx
         PNGb/P8XJ9wDX5rmg1loQHnmZZr03twyKCgQiiRnMOWf6DcEyCMSy2+mz9EfTzOBtiOI
         u08DKopOK7Bp79t0p4RMTmSDNOUiniKJE0D7WkGAngdIm8p4qbMbn9OLFZilnM+OYcVU
         6DuallWWIt610pnI0Drgqhzl26vvc0J77gCG/nz927HdLGcT4t+EiDHG1Ft63AvvjNx0
         Oabw==
X-Gm-Message-State: AC+VfDybWBPW5+DiQyG115+tnGeEWpikjlPmhEck/hfzeXaZXHtheszy
        DSTAwV3f/bOiqMiVIUOwZ5A=
X-Google-Smtp-Source: ACHHUZ78UXMxKjPTfguyNtMtYshwtRlkVKru7jicFYyt2dXujzMECRU5qx3NSTwv1YRvVuqOW0tD6A==
X-Received: by 2002:a05:6a20:7291:b0:ef:1d4e:cf3e with SMTP id o17-20020a056a20729100b000ef1d4ecf3emr28917914pzk.50.1683146719707;
        Wed, 03 May 2023 13:45:19 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id q22-20020a63e956000000b005033e653a17sm20682508pgj.85.2023.05.03.13.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 13:45:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Ushey <kevinushey@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git grep -E doesn't accept \b word boundaries?
References: <CAJXgQP1j6JYbtikMuWGFn44+FVb3PfmuwiFrxDGLQAYgr92Wfw@mail.gmail.com>
        <xmqq1qjxqkbo.fsf@gitster.g>
        <CAJXgQP2Rvye6U64_Nv9a0VbTJF=WsT741J42gfQmP9vz74u0ww@mail.gmail.com>
Date:   Wed, 03 May 2023 13:45:18 -0700
In-Reply-To: <CAJXgQP2Rvye6U64_Nv9a0VbTJF=WsT741J42gfQmP9vz74u0ww@mail.gmail.com>
        (Kevin Ushey's message of "Wed, 3 May 2023 13:32:15 -0700")
Message-ID: <xmqqr0rxp2jl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Ushey <kevinushey@gmail.com> writes:

> Thanks for the quick response! I wonder if this issue could be macOS-specific?

Ah, yes, I somehow thought you mentioned Ubuntu and totally blocked
that macOS issue out of my mind, but I do recall that it has been
reported that build with macOS native regexp library is broken a few
times recently on this list.

    https://lore.kernel.org/git/?q=macOS+regexp

finds this thread, which unfortunately was mistitled to make them
sound as if they were about "-P", but the issue in the thread was
about extended regexp.

  https://lore.kernel.org/git/03fd7ddb-8241-1a0a-3e82-d8083e4ce0f7@web.de/

