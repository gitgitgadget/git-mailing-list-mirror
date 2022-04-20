Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F1C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 17:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381313AbiDTR7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiDTR7E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 13:59:04 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4F6443C3
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:56:17 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id g21so2664119iom.13
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXQjLB/BuAGP//hE5tXX8u1voJlz+btryCcOScJHtas=;
        b=pIP7jMOykO6z0n0m/LYBjKlInKlcX8AdHCOvs3n+ysf4llZYgH5Z2x1rchLuffBA1p
         xIqgvirDpg+z1Fc4x5q+4wsGoYYg4YxsIyeiB178ieVWo4pFIjQinvJUakbG0WGXfHHN
         UEGawXUH91lJ/bJK++n1Unj516jWn41A+OXvhip16jXwiiAzES9L4TKZgI6fHRZizvUf
         sOnWvD6dOrt1roDnoDsX9FDCopUZ3W4+uilrfPmD4NiaJPNo4qdmVbfRnvWKZwwJSwv2
         IS9RK9rLZ18NaTmlafjaY7mTKSIZDonjZaEHJ/hNAZEzUr4S6mteSYIKb1Hm+qBV5mqI
         ouFA==
X-Gm-Message-State: AOAM5325HxRVFRKB5WiEhxFdlAAxDGOvKfvrronfyJsyp82hc8HIJH7o
        SObgjcQz3jdLjl05ZSvTlVI578kQFnELE2td2LrTEnBtedg=
X-Google-Smtp-Source: ABdhPJxYnBCjw/60oj2mFLONTJjTJOCWlxCVHQ6itzGnpk4K8WHZGbXAx+WoogU3NzgqNiTO0fk4NbmMm8U8ayo5jL4=
X-Received: by 2002:a5d:88c7:0:b0:649:7b59:949c with SMTP id
 i7-20020a5d88c7000000b006497b59949cmr9740363iol.181.1650477376934; Wed, 20
 Apr 2022 10:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCZ4U-9KYGK0jwnL1GyOYW-CMjV_Eo--g85CbexsV=aQnn7aw@mail.gmail.com>
 <CA+JQ7M8+FR+_t+Fafoggz47bT0joAZFEkjhjf72teZgdNEoNZQ@mail.gmail.com> <xmqq8rrzr6dp.fsf@gitster.g>
In-Reply-To: <xmqq8rrzr6dp.fsf@gitster.g>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 20 Apr 2022 19:55:39 +0200
Message-ID: <CA+JQ7M9o+kZUgLkCq7aauCUwzZy6OzwKpyGQ1DxQyaL2jkJBSg@mail.gmail.com>
Subject: Re: help request: unable to merge UTF-16-LE "text" file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Long <kevinlong206@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2022 at 7:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> For that to work, it is likely that you'd need to convert not just
> the tips of two branches getting merged, but also the merge base
> commit, so that all three trees involved in the 3-way merge are in
> the same text encoding.

Hmm.. Right, the common ancestor would still be the old encoding :/

On Wed, Apr 20, 2022 at 7:38 PM Kevin Long <kevinlong206@gmail.com> wrote:
>
> Thanks, I actually did try that without success. I'm wondering if
> there is an "ancestor" object that is still binary or something, deep
> rooted in the tree.

Yes, as Junio correctly pointed out.

> Converting it once and for all to utf-8 would be great, as that will
> work fine with Visual Studio.  Not sure why the original committer
> chose UTF-16.

Visual Studio probably saved it as utf-16le with BOM :(

> I have tried several "working-tree-encoding" settings in
> .gitattributes in my local working directory, to no avail yet:
>
> *.sln working-tree-encoding=UTF-16-LE eol=CRLF, results in:
> error: failed to encode 'FacilityMaster.sln' from UTF-16-LE to UTF-8
> warning: Cannot merge binary files: FacilityMaster.sln (HEAD vs. master)

Could the issue be that it should be UTF-16LE (without hyphen)?
