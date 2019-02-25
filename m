Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C70DD20248
	for <e@80x24.org>; Mon, 25 Feb 2019 08:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfBYImM (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 03:42:12 -0500
Received: from mail-yb1-f177.google.com ([209.85.219.177]:44365 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfBYImM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 03:42:12 -0500
Received: by mail-yb1-f177.google.com with SMTP id c3so1104585ybo.11
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 00:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WHkmCAeNLqxLFRiYIm71OXru3jq/JM4VPTblTROIY1w=;
        b=ktzqZp8+PqwVFexBuCaxzQXli4eU57Sx1EXb3UGfmwiLK4Tk9gqirp+qwXL4HdUxvu
         cZJ4Rn72WN9oomo3aLh9u83SujCNc/ASU27jxLK/BaWp94zkEO+f9LXTOmZqSgKAlDqv
         fMzHpEJQgWeMmAB+ixmcyJuotk9ZVykDccdAA6x1pPaJZwYqPVxNwVvLlYY3TKZyviHm
         OUXCTJCWkn4DEFL6ob9kwcLGgHQ/SAJcj4Pr6olXaCB9dOdeNR8yu/xygvRo6vefH8H6
         wRiFc/oArqhbaWkv288LRX9oJRWBqDWy0UOjT60qJCTZbpjnp5JNJwDHffYrbiyH7Rc/
         oLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WHkmCAeNLqxLFRiYIm71OXru3jq/JM4VPTblTROIY1w=;
        b=Mp/cFAaauYKYgt1e4+3AuU0y8ZActpJeVqvpkGmJTeqBISU4/VqdP0jFf7PAbZPmGm
         xl8ZIg+XV5zq5J92PJshAnRugmXp28ImWWGJHVAMUlARgLRL+Bj3BdYvD0oHYhScbyWv
         JZTVzIeJPdm51ec8VGTi/W8rR1cc5vzHUV4FTFYyEHWAOTNMHnZU7zoEkh+oGkk99Q4u
         vtaeBlfypA4964MkulBu6VD/cTYN+wY8NtL1sImflxkArP/h19AZQtn4fxjxW66Mc8Ry
         aIwjGDwUpaOhop6aad28fPp4F7Pr37dDVNTGwUrtrcRMd3MDpF91xcNYbNoPHBmocuWq
         OXRA==
X-Gm-Message-State: AHQUAuYPvzoByqmSWAJ2jHA1UYba/3GZEOMYiZjshJfCBvbokHfE1j4T
        ezYdbGdwMpPX1wBTFD70Hvhz8j7WKPXePsjDFnJ5q5Nwz10okQ==
X-Google-Smtp-Source: AHgI3Ia6lArkFsXwY/wj0vCpcifIrKKy24K10UeFXoCrZRljsZUWU6aTj3bsg8cE9jUwepsX39gmF1wBvkqR4MQkcic=
X-Received: by 2002:a25:505:: with SMTP id 5mr12181522ybf.267.1551084131315;
 Mon, 25 Feb 2019 00:42:11 -0800 (PST)
MIME-Version: 1.0
From:   Shane Carr <sffc@google.com>
Date:   Mon, 25 Feb 2019 00:42:00 -0800
Message-ID: <CABxsp=msDSGGFjn178ze-s3XR3UJU=NEkV1jzS9QN-zjZisMgg@mail.gmail.com>
Subject: Git Pull --ff-only should imply --no-rebase
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

I have the pull.rebase config enabled for my branch.  Sometimes I want
to pull and I know that the pull is going to be a fast-forward.
However, if I run

    git pull --ff-only   # (with pull.rebase config enabled)

I get the error

    error: Cannot pull with rebase: You have unstaged changes.

Instead, if my working directory is not clean, I have to do

    git pull --ff-only --no-rebase

Since --ff-only implies that there is going to be neither a merge nor
a rebase taking place, Git should not complain about unstaged changes
and should have the same behavior on --ff-only whether or not the
pull.rebase config is enabled.

Shane
