Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB410C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 19:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjCMTTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjCMTTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 15:19:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A463E087
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 12:18:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso377711pjc.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678735098;
        h=mime-version:message-id:date:user-agent:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=s2wXNWHYPW5vX58WOARGwLB5nk2V1zpt+5WP81X3XL0=;
        b=CJtZxKkuGG9DgwK03nqcy7xaYYInzTNq5TZdtANevtq6rvQAzOrPQGtZg8P4B5IRLJ
         AXHhECQ14m+/3EzMaFoJB8ZIHfhmEvgt089zgOxBv6NCCn0+uReI9qw8t3W9s02QuGTR
         Xc+nJKn7sofAE3O8tIdBJ/WvupSKE/yQFk1Vc44ZAyApz26hEnEQN8hK2B4jNDWSceOj
         hhZ6cmEfWGfuFJHEGEZEffDkh+OzXa6jgpFUyG2PPPYfqdsMNhUwQXXOFxQPJ7S03R0G
         mnC1M1pOqXozygxqFXoq/3jTtYiiaEZ/62yt9/UYtTzw77skqxnrj1cxq7J/0ti+qKM/
         QImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678735098;
        h=mime-version:message-id:date:user-agent:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2wXNWHYPW5vX58WOARGwLB5nk2V1zpt+5WP81X3XL0=;
        b=wkgW19whwdqxqe87SVrrPl2zGvFUUT0PnQSGnFbNuMYOkhz12aQM6q+kIR/xL55FMi
         B5XGC+mw+4UrL80RgNROcheY5JECmUYEoXOhrXH9E7Bl+HTG/MxX8haAeS6TKCGVHDaQ
         Rd8RuluowsVSfeZcQYzRGS614umq2EGNuPzLoZLuHkHD6u02kVWogqnq50bSHUNxewFE
         VsQBQAdgd8NUhE2Tkmer/Yojytw0dMLWuxasqpUvuwQNdHpTLtKmsFrjeLhrb2bjtInr
         qGZ89cQDGDr4VjDiRON6ghqHQDaNhYCt3iihwAL13sFailoeieade7QUEXDs/HS/RsIY
         OMEg==
X-Gm-Message-State: AO0yUKX/+O1W8DBINtl4r5olzmEvUq/VSTiXv5w74n3tkMMWl+CJFVyX
        uTWY2c5dbBRkmEPNSON4UD0=
X-Google-Smtp-Source: AK7set+SRT2S7SGO4zGo+nrNAjKFCvatnPZtTdPiooEOn4sq8f3AfHEqG5yReYGjzjP21/FPghpixw==
X-Received: by 2002:a17:903:514:b0:19e:68e4:859c with SMTP id jn20-20020a170903051400b0019e68e4859cmr29093406plb.36.1678735098070;
        Mon, 13 Mar 2023 12:18:18 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b0019251e959b1sm195820pld.262.2023.03.13.12.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:18:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, jonathanmy@google.com, fve231003@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3] index-pack: remove fetch_if_missing=0
References: <20230310183029.19429-1-five231003@gmail.com>
        <20230313181518.6322-1-five231003@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Mon, 13 Mar 2023 12:18:17 -0700
Message-ID: <xmqqilf4tq86.fsf@gitster.g>
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

Thanks for the reference.

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
