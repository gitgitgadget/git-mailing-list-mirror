Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2C7C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 23:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiG2Xuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 19:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiG2Xuv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 19:50:51 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C750A84ED5
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 16:50:49 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3246910dac3so13036747b3.12
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 16:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RSK3k5N7suOtbAphFELPelaqF44q9JMjJDbbDYOb004=;
        b=E2/+ZVylwQbDfutiHRYxGBRcMYc0Sn/vui5b7kYgO9JoeFSTAU3odzHqEhmsZ0WNjh
         VQNerc+Y+793/bRpntQ5xLKRjDKtQN4mduaXKIAf130hK755dsJZm2NJBcBShV0ASe0L
         ibEdN2plUWLS9Q/rKE8cRO06BSfPSRfotMnSjHNzo3qeiIB8dCLXnYW5Xq1S7SPNFXVW
         lwK7UOTABfTQtDbR+THk7loxK93Yicafw5RT4Nj8OsLF/M+FkzP5f+ls432yLL8X5mYy
         Ajt0vJx0cK65dynez7eML6DHYqKCdZ27oADSRF902pBDiNFUrULfgr8EqOuR1OcOef7H
         4+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RSK3k5N7suOtbAphFELPelaqF44q9JMjJDbbDYOb004=;
        b=TMdvGWFODSoyI42p01sal6u77q7arAHIozH8UpATj/YDCYHwfCGyP006y6tZnuQnMB
         FSZwt+amVJZfHyxkX0jjYUmy6aA+GgjyhfOeUE6sSi4M+EXDZ3fggQcYEHlhxqkHxkBj
         /DMA3pg5Tp/UbZLD1CnhvLSIDQwpurfgfey5nntcgPJGS/+0WXgKzxmYCHfaql2LPy+3
         xMJopo6aZEstR32JkU7sbeK+9kyrF488UJCylWX+WljSaNsXWLci/1cft+gZPTFf3rf5
         xKJ9SDNAracfV4P6CmPvfkYxhCbum4+M1et+oE8JxqrxdoGzpz1wJUFLYQFQSWWzzv7i
         SHTQ==
X-Gm-Message-State: ACgBeo0FwO6hMNlZ8k7KFx9SWblDoOHjHQKXVlOGZWk6C6BpG9QOo0MX
        R9jH9veCwxO4fGTfGUoG/ptocx2z2ItOSPiFiPzFctxKP2IEkA==
X-Google-Smtp-Source: AA6agR5myBl8gbhK5WQ11HQHvlHqrUIMpjf9wO9Aw2enbxEVUi9GjwgNshxgoeV6KiG/wMa+EsHUU7BzXJLIQzMYFGg=
X-Received: by 2002:a0d:fac1:0:b0:31f:6322:a342 with SMTP id
 k184-20020a0dfac1000000b0031f6322a342mr5191498ywf.222.1659138648781; Fri, 29
 Jul 2022 16:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
In-Reply-To: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Fri, 29 Jul 2022 16:50:38 -0700
Message-ID: <CAJoAoZmsuwYCA8XGziEA-qwghg9h22Af98JQE1AuHHBRfQgrDA@mail.gmail.com>
Subject: Re: Question: What's the best way to implement directory permission
 control in git?
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 27, 2022 at 1:56 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> if there is a monorepo such as
> git@github.com:derrickstolee/sparse-checkout-example.git
>
> There are many files and directories:
>
> client/
>     android/
>     electron/
>     iOS/
> service/
>     common/
>     identity/
>     list/
>     photos/
> web/
>     browser/
>     editor/
>     friends/
> boostrap.sh
> LICENSE.md
> README.md
>
> Now we can use partial-clone + sparse-checkout to reduce
> the network overhead, and reduce disk storage space size, that's good.
>
> But I also need a ACL to control what directory or file people can fetch/push.
> e.g. I don't want a client fetch the code in "service" or "web".
>
> Now if the user client use "git log -p" or "git sparse-checkout add service"...
> or other git command, git which will  download them by
> "git fetch --filter=blob:none --stdin <oid>" automatically.
>
> This means that the git client and server interact with git objects
> (and don't care about path) we cannot simply ban someone download
> a "path" on the server side.
>
> What should I do? You may recommend me to use submodule,
> but due to its complexity, I don't really want to use it :-(

As a quick note, there is some effort on making submodules less
complex, at least from the user perspective. My team and I have been
actively working on improvements in that area for the past year or so.
Please feel free to read and examine the design doc[1] to see if the
future looks brighter in that direction than you thought - or, even
better, if there's something missing from that design that would be
compelling in allowing you to use submodules to solve your use case.

As for differing ACLs within a single repository... Google has had
some attempts at it and has only found pain, at least where Git is
involved. As others have mentioned elsewhere downthread, it doesn't
really match Git's data model.

Gerrit has tried to support something sort of similar to this -
per-branch read permissions. They were really painful! So much so that
our Gerrit team is actively discouraging their use, and in the process
of deprecating them. It turns out that on the server side, calculating
permissions for which commit should be visible is very expensive,
because you are not just saying "is commit abcdef on
forbidden-branch?" but rather are saying "is commit abcdef on
forbidden-branch *and not on any branches $user is allowed to see*?"
The same calculation woes would be true of per-object or per-tree
permissions, because Git will treat 'everyone/can/see/.linter.config'
and 'very/secret/dir/.linter.config' as a single object with a single
ID if the contents of each '.linter.config' are identical. It is still
very expensive for the server to decide whether or not it's okay to
send a certain object. Part of the reason the branch ACL calculation
is so painful is that we have some repositories with many many
branches (100,000+); if you're using a very large monorepo you will
probably find similarly expensive and complex calculations even in a
single repository.

Generally, this isn't something I'd like to see Git support - I think
it would by necessity be kludgey and has some very pointy edge cases
for the user (what if I'm trying to merge from another branch and
there is a conflict in very/secret/dir/, but I'm not allowed to see
it?). But of course Git is open source, and my opinion is only one of
many; I just wanted to share some past pain that we've had in this
area.

 - Emily

1: https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/
