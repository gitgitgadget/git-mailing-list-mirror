Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9A2C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 12:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbjAJM1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 07:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbjAJM0e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 07:26:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D71640E
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 04:26:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o15so8635759wmr.4
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 04:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g7CS3xjyCC1lup2yZ4RWkpHO3SOCBZXOxqO6aPz6FAk=;
        b=nX08VjTjkrVxr0cjtuDqcMDfmlN/WAVPM46fidXug9xN4Bw8DlQrw+q/IeY/mxDDZK
         r8in/vzL3UWxiVcVlqEL5+ucW0EMZIhOyQ/uAFpOxbpMPRg8IOSO+DphWhl7vEIS4aWX
         qQr9sgYDqmQX/K6uNEu/OX58C5MG4W3mITJFqo1Wo1MY0Ht41PlK7AD5jMJZEIBBj4fW
         xoeUpOIugdc6GwaqQOyWw4yP4Jiggg3rdzpHhvkbUdwN63cjoP4Rr7l4ZyB/p1degkM9
         1har9vdaiJBA4ipMhFmiF+4n/sSq/iqNWlWgwTsaLb+e2s5eXEhFKqostKAeqC8qmsjo
         gIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g7CS3xjyCC1lup2yZ4RWkpHO3SOCBZXOxqO6aPz6FAk=;
        b=upVXBgtEb/2qSxcGk0ZdxTc94FWTaO4z/ttlkBcCBwoI7Ff84M9+ahxHFzDtzu+YXJ
         BIkX4xsXpUFM9/+ve6Mij0r+BuAqsVVHLpqI/ydLsYblj7NAmorvgnh6878sa/n5aZzX
         dvK0/CBj6Y6sQLDHyDm7xjdPg6LTOjeSKgKzbC18wp+16Hu+M0/mR5cWEZLAHdNVZVpo
         IJkMZEeTuwpBJYPzNYLRaBuuLAcIOBowkdM+uJdOn3FBlt8QdXWDv5po6gzFylT++9R7
         FOjJecpCM7ld1ZHKIoONJWCT/gTIq/BZHMMn7BIbVAWYqUQqjc6QbS6ghjna9fmsX6rW
         SygA==
X-Gm-Message-State: AFqh2kpczbZRP4YyNpJPUoUyCPZj+5QSUw8Edr0IWsfMX6UZYcUJlmhk
        oasXRQyDnLVox+JXWZDHz7Mv9cRLrmRMAQ==
X-Google-Smtp-Source: AMrXdXtZ83F9U4KqzKR+as10kAoEIhDKr6nWRjGO+RkPAAqsM9NqlnTYzWPR4P5baq3QJ3zUGy4RJQ==
X-Received: by 2002:a05:600c:3509:b0:3c6:e60f:3f6f with SMTP id h9-20020a05600c350900b003c6e60f3f6fmr48396775wmq.38.1673353591259;
        Tue, 10 Jan 2023 04:26:31 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003cfd4e6400csm15842456wmo.19.2023.01.10.04.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 04:26:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFDi1-000OHl-1t;
        Tue, 10 Jan 2023 13:26:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/5] treewide: always have a valid "index_state.repo"
 member
Date:   Tue, 10 Jan 2023 13:24:23 +0100
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <patch-5.5-b3b0e592101-20230110T060340Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <patch-5.5-b3b0e592101-20230110T060340Z-avarab@gmail.com>
Message-ID: <230110.86o7r6zibu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 10 2023, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> diff --git a/repository.c b/repository.c
> index 3427085fd6d..fdebc8c597c 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -28,6 +28,8 @@ void initialize_the_repository(void)
>  	the_repo.remote_state =3D remote_state_new();
>  	the_repo.parsed_objects =3D parsed_object_pool_new();
>=20=20
> +	the_index.repo =3D the_repository;
> +
>  	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
>  }

It's slightly odd to have initialize_the_repository() initialize this
other variable, I did consider adding a initialize_the_variables(), and
have that call an initialize_the_repository() and an
initialize_the_index(), but deemed it not worth it for now. Perhaps
something to revisit once we're initializing more variables here.

Arguably such a split doesn't even conceptually make sense, as we're now
declaring that "the_repository" isn't fully initalized unless the
corresponding "the_index.repo" is also set, i.e. this really is part of
"the_repository" initialization.
