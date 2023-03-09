Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B856C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 18:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCISf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 13:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCISf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 13:35:56 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E4F2F91
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 10:35:56 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p6so3022624plf.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 10:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678386955;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBNIjL1nb7M891GJaWH2ycd66UyB2S85XsTpTw6HRPw=;
        b=GXzKsLQ9jcqeFFryp/q5SQQJEbhnJ25xCbLmOy+ech+/4vTrHNN7Q0UU3qCVAURZww
         6Si3nJ4efaU9qnVh6oE1qJamRih02kLuAvSsMxu0ucHlKBT2f/Rfi9Y8c+O2VLFvN7qS
         LQpT3xWc+n/WdlJJus84kufLJRxal0XS7zzVn/xXaTtHp2WnwRVereXS4Eyqj/ER0l96
         eXhZUrJlLebd3NA6EHgvQDvwvI19mpGM/y5UN4QFKekn6yuwKMnaljUWSbFIFEyHa9xw
         16v3wW/5KCBs+voVbTVJcgGaAAaJPcjrtDa+aQo6eNEEVA/VVZN1VqOVaHUJnLFPWKmM
         HiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678386955;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CBNIjL1nb7M891GJaWH2ycd66UyB2S85XsTpTw6HRPw=;
        b=1mj2n9+ZXD/UA0Uisqi3uRqMKIHpAH5jn/79Q69kCLchCgvoR2Z33EHiOjaw+MEsv6
         6ki42AJsEEUkRuEAxK5/D+hVdjESIkXQSghlqg8LYU/hIBOEAyQTBv5eYUklmXWSas7W
         TFSr0QWG+dCk6EA3kU+arrpxgli8BstcOfNKVaZhIbrv/FMgjQ9Kr4EVASsepsPkor08
         Sqz+aALqmTjoAfw4/YQASP4CdBds138AdW2Q6Fphi3iK3j6UsoNbRyOweEU5tkSlrDL0
         0zXfyjvbCzX+ORtF8XR4homW/e3rJ0AEWGjjXUpftBlO7cGrPoLdK/S5Vg5C2lgUu0Ls
         mguQ==
X-Gm-Message-State: AO0yUKXgKdqxLs5nf2Xa80UuyPK7O+CUF4PGHZjXKTMTLZs72k4N+r6T
        Af1ovaLwbvFK5wgL/JlBfEB8blzsYgs=
X-Google-Smtp-Source: AK7set/rdAGhNGGQWQfZ3eE2muQ1UaF/18mx2SlspKgVuGdtSwn4r/wTgu7Y1rzesWBF4GFa5Ji2RA==
X-Received: by 2002:a05:6a20:4a22:b0:b8:a17c:75e4 with SMTP id fr34-20020a056a204a2200b000b8a17c75e4mr18188795pzb.48.1678386955452;
        Thu, 09 Mar 2023 10:35:55 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id y8-20020a655a08000000b00502e48db9aesm11169737pgs.53.2023.03.09.10.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 10:35:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Ilia Pozhilov <ilyapoz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Track git blame through two unrelated histories
References: <CAAo-ADZBBRxSROeAwrA9o30Etf3QQhLCaWQJtVsChVwT-AbgTg@mail.gmail.com>
Date:   Thu, 09 Mar 2023 10:35:54 -0800
In-Reply-To: <CAAo-ADZBBRxSROeAwrA9o30Etf3QQhLCaWQJtVsChVwT-AbgTg@mail.gmail.com>
        (Ilia Pozhilov's message of "Thu, 9 Mar 2023 13:05:07 +0200")
Message-ID: <xmqqwn3pai2d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ilia Pozhilov <ilyapoz@gmail.com> writes:

> So let's say I add two remotes and fetch all the commits, but they
> look like this:
>
> A->B-> .... . . . -> Z    history1
>
> 1 -> 2 -> ..... -> 0 history2
>
> and file contents in commits Z and 1 are exactly the same, but the
> commits themselves are completely unrelated for git.

You mean you want to pretend that history "2 -> ... -> 0" was built
on top of Z?  Here I am assuming that time flows from left to right
in the picture.

If so, you should be able to graft the histories together, perhaps?

Totally untested but something like 

	$ git replace --graft 1 Z

based on my reading of "git help replace" should allow you to
pretend that Z happened immediately before 1.

