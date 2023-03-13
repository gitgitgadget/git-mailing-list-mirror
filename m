Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5269C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 19:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjCMTSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjCMTS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 15:18:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917367B49C
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 12:17:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id kb15so13098082pjb.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 12:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678735070;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6SC+2UXtJBkGc9nIjDrTPzQ9oGJowttVqVvj0CZWy4A=;
        b=aksVLiq4h1tFRUqrA0doIpxZp3n/vuo2+SXxep5bqwG99/V5XKV0JQ5fqtagBZ+cdU
         PS8lpYPve/9CdkaoFgmOmoH0JKE29ZOnAM0DDLinXe4fZw6kZxWsBcLkWDn4nlp+Crgq
         9nphEZMo1ftpI1awiMXdA+8brLmb8GQe63ToP4u64UCVf8Kxc3NWN0c++5mppRi2Ge5O
         qxaJuxnK4K3GtRRouY+wU/S17OFJHGcIF2pk3TSKcjWcHhYvLqoBTODlxuS+ibEUznNU
         F6xrpcd81McTZPYZk4G2MFb2WMUwVLrnNxaKlpzW5UQl9ENl5vyr1zZE4Wc2hBF7o35p
         VOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678735070;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SC+2UXtJBkGc9nIjDrTPzQ9oGJowttVqVvj0CZWy4A=;
        b=50EppSezmMYejFE62avAy8LfHkfTElDtRf+BREfD4mIr5UPA/Fqh8zcYVKiNoRY3Mg
         U10cEItC9NgSAFNqhtbe8Ix3cffIvqfC1FTPKEnCuNZRilB+NIb+v9sWJ5iOa84iRyda
         MDSygJpucIan9EzdaGTaPXKb7BX4C5P5uODBYCXuGNaPvwlBA6Z1EK+nBwz0PINTW3gg
         xpmgJbLVYKdSJPh9Tfot0mvf+nS5/FPcySL9khMQiiqlXKCsACzP8Fvxv5BJtIhB/pP6
         V0e9RQMp4OH+2pbLnz+IBfh5RWryK/aR4dNIGgxSpJjvXrLkyRkzUmej94/+Sm96Llrn
         L4kQ==
X-Gm-Message-State: AO0yUKWVmPLoNjWS+IC5eOGpHcgKYy4TSL2g/tO5e2xL1WCUPif+u6E5
        uhQ0EzTbWJMTkBFQDpnut9U=
X-Google-Smtp-Source: AK7set/jUSreJDuhLSKciisyKyoxxTwaNn7mtX51ae1+8Ck1p3ChP4AnYEt/SOHiaqnYwrDtlcOobw==
X-Received: by 2002:a05:6a20:840c:b0:cd:1e80:5840 with SMTP id c12-20020a056a20840c00b000cd1e805840mr47013685pzd.34.1678735069947;
        Mon, 13 Mar 2023 12:17:49 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x5-20020a62fb05000000b006242f4a8945sm67598pfm.182.2023.03.13.12.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:17:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, jonathanmy@google.com, fve231003@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3] index-pack: remove fetch_if_missing=0
References: <20230310183029.19429-1-five231003@gmail.com>
        <20230313181518.6322-1-five231003@gmail.com>
Date:   Mon, 13 Mar 2023 12:17:48 -0700
Message-ID: <xmqqmt4gtq8z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> A collision test is triggered in sha1_object(), whenever there is an
> object file in our repo. If our repo is a partial clone, then checking
> for this file existence does not lazy-fetch the object (if the object
> is missing and if there are one or more promisor remotes) when
> fetch_if_missing is set to 0.
> ...
> Hence, use has_object() to check for the existence of an object, which
> has the default behavior of not lazy-fetching in a partial clone. It is
> worth mentioning that this is the only place where there is potential for
> lazy-fetching and all other cases [2] are properly handled, making it safe
> to remove this global here.
>
> [1] See 8b4c0103a9 (sha1_file: support lazily fetching missing objects,
> 		   2017-12-08)

Thanks for this reference.

The way I read the "lazy fetching is by default not suppressed, and
this is a temporary measure" described in the log message is quite
opposite from where this patch wants to go, though.  

I think the commit envisioned the world where all the accesses to
the object layer are aware of the characteristics of a lazy clone
(e.g. has_object() reporting "we do not have that object locally
(yet)" is not an immediate sign of a repository corruption) and when
to lazily fetch and when to tolerate locally missing objects is
controlled more tightly, and to reach that world one step at a time,
introduced the global, so that for now everybody lazily fetches, but
the commands individual patches concentrates to "fix" can turn off
the "by default all missing objects are lazily fetched" so that they
can either allow certain objects to be locally missing, or fetch
them from promisor remotes when they need the contents of such
objects.  By fixing each commands one by one, eventually we would be
able to wean ourselves away from this "by default everything is
lazily fetched" global---in other words, in the ideal endgame, the
fetch_if_missing should be set to 0 everywhere.

So, if this patch was made in reaction to the "it was a temporary
measure" in 8b4c0103 (sha1_file: support lazily fetching missing
objects, 2017-12-08), I think it goes in the completely opposite
direction.  If the patch shared the cause with 8b4c0103 and wanted
to help realize the ideal world, it instead should have left this
command who can already work with fetch_if_missing=0 alone and fixed
somebody else who still depends on fetch_if_missing=1, I think.

Now it is a separate issue to argue if "everybody knows exactly when
to trigger lazy fetching and fetch_if_missing is set to false
everywhere" is really the ideal endgame.  I do not think "Future
patches will update some commands to either tolerate missing objects
or be more efficient in fetching them." proposed by the commit from
late 2017 has seen that much advance recently.

But for commands that need to deal with many missing objects,
enumerating the objects that are missing locally and need fetching
first and then requesting them in a batch should be vastly more
efficient than the default lazy fetch logic that lets the caller
request a single object, realize it is missing locally, make a
connection to fetch that single object and disconnect.  So I have to
suspect that ...

> This global was added as a temporary measure to suppress the fetching
> of missing objects [1] and can be removed once the remaining commands:
>  - fetch-pack
>  - fsck
>  - pack-objects
>  - prune
>  - rev-list
> can handle lazy-fetching without fetch_if_missing.

... this "can handle" may be a misguided direction to go in.  They
were taught not to lazy fetch because blindly lazy fetching was bad,
weren't they?
