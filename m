Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B71C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 18:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136F420774
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 18:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="FuaHg3WH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHLSvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgHLSvf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 14:51:35 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793A1C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 11:51:35 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id o2so735076vkn.9
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=SdLdZ6OBNnZZVYa7mbaeilCgvz1rv/nOIPZ9uhrjzvk=;
        b=FuaHg3WHqbOQYPU5U7LXbmuLhH7oAsUP+0Sl/aR6VXMIa/U9/uhiYbqbBIzZHfJsbV
         gjbZX3ke2gtCpYuisW7Ot574iUBqHTJIPaso4QiVYtn3j7TDBlcVN9Sm9W9FtyLj9s7m
         xmU2ptUaiC3dZGxajXN508bWxmxitQkhoy+ZHe+H3gGoGWTPZG7u3Uh9d7fwFAgn7qpb
         To3mx99U9GCC7WXOUDqB3UqsZQfaLpLyRY0FrmZ7y3V755CLkQqCKOw4Ro6YDSLvrlK1
         nffrq+Bn7lO8XECewD5wYGappYEmfCDE1thPTeeQlkW3Pxs2iZxjx6Ki2e7DNhIKREIZ
         +olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SdLdZ6OBNnZZVYa7mbaeilCgvz1rv/nOIPZ9uhrjzvk=;
        b=A4j+fcLJSAAgd99+o9q1nw903kUqz/w4PzUuSaYzgfnBBSxMdbRZF4PniZHvynpCpZ
         ETAyHPQ04rzWhEjdun+2ZyPuDzIZeP9d3sXixmMMRTpPHdmXuh7n46qJ1jmKDmiffK4O
         OV47L+QdwvMFHiAdyY7/IOgzvvp0iMhHVoGfQu3SXnaDDHAs1AbyPAIPrVjJBFzlmvJ6
         XAmRxf1dr0ZD9kmAqjGh9BQKcCV81AGvfPAIVcVfRy6DjIj2tuuFX2jyK7dJ4FuWOt1F
         AmGn2pnGfBnsx5RneJy7UykXjvdKqU/VYbVU20psmJHFRcXMZGUDEkPUhJwWbEIELlBg
         9hgQ==
X-Gm-Message-State: AOAM531G0c4OCAdPWMUr5qDKwp8J8Yh4aiToT+DtDD/OMxtdEE7DXzNC
        xcK65M0uOshcrWldEbM8ivXHj/XYBPk1MjzjNrPQW92ZUCE=
X-Google-Smtp-Source: ABdhPJxYobIlw9GLKXiOId6MYwd0U/5JWtnKsQA7Vzgwp0ppmUuIh3wFku4KAN6TpiWLu00a5odPaZhBxCVx0oKY8Ng=
X-Received: by 2002:ac5:c925:: with SMTP id u5mr723603vkl.68.1597258293804;
 Wed, 12 Aug 2020 11:51:33 -0700 (PDT)
MIME-Version: 1.0
From:   Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>
Date:   Wed, 12 Aug 2020 21:51:23 +0300
Message-ID: <CAFvH=vsWyX79j-9pyC5gpxGu8rRxYyrXwywHjh-_T2opHjT8Xg@mail.gmail.com>
Subject: Possible bug with git restore
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I see some strange behavior of the "git restore" command. Here is a
bug report template filled out:

*********************************************************************
Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

    I tried to restore a couple of files from an earlier commit
running the restore command with a wildcard:

    git restore -s HEAD~ -- */filename.*

    In my work tree those are .cpp and .hpp files stored in different folders.

What did you expect to happen? (Expected behavior)

    Both files are restored to what they were in HEAD~.

What happened instead? (Actual behavior)

    Both files were deleted (and got (delete) status).

What's different between what you expected and what actually happened?

    Files became deleted for no apparent reason instead of restoring
to expected revision.

Anything else you want to add:

    Running this command without wildcards for each file separately
works as expected.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.27.0.windows.1
cpu: x86_64
built from commit: 907ab1011dce9112700498e034b974ba60f8b407
sizeof-long: 4
sizeof-size_t: 8
uname: Windows 10.0 18363
compiler info: gnuc: 10.1
libc info: no libc information available


[Enabled Hooks]
post-commit
post-checkout
post-merge
pre-push
***************************************************************
Regards,
Sergii Shkarnikov
