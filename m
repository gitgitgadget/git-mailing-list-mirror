Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD5311F453
	for <e@80x24.org>; Wed, 31 Oct 2018 19:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbeKAEMn (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 00:12:43 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:44985 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKAEMn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 00:12:43 -0400
Received: by mail-lf1-f43.google.com with SMTP id m18-v6so12506116lfl.11
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 12:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wd1BCmg0yuk9O/Zoa17H8Y49xmWqpzyYLQVu/ckdmvg=;
        b=X04IhNetRbM2rU+Ayz8LAwFKJCKeSOS0gjHPqe/SwMqzklnUthbR5RRq7FyXFTFZFW
         ajebYI37FuquyS+Y8TBHytKESPTA2TRz3U0WBeShdm8G1cNGDGFdLF+IoY3HCi85CHAf
         5jHT1sD9/MY2PNKr1WnMXpBzSuzg8SujKwnBkuruEkqqQi6fDjX9CRFDX/uA0Vkm+/6w
         Anzaixm6ZW7/YTGBrp6gwKFkZKJnyl/XYqh8XF31g9uUELjbTEj5qoAi7vfJVAz7cyl7
         t2hpF68taB8rnk8mNPknorbJzNeiySu2ewgsZMKmzgbuunFjEmg6WPIcTQDor2W9SXtI
         /GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wd1BCmg0yuk9O/Zoa17H8Y49xmWqpzyYLQVu/ckdmvg=;
        b=GnOORV7F02wMLJfrRpBMyC9hgZaCwimy9i63tL2H9nrkJ0pVyWkI4oNwRUXrce/Qge
         lbzCFh4XKfohUfTXMIhEJ449BFJxRjmz+zxCxsU58FSnyherTKggOXPUxTUI3QNQv2IF
         886iO/H8mlmxNlLzVy0Tu796GdV5h7wM/XrBrUk78P56QemY/Pg3FhfDOYe5ydTN8MHj
         9C6YWMt5Zrh3HDhA5FomLBDrf7VYP2Tko9H+zuWY708XNISeSnwKbkH3WIXqNOlsY5Yd
         l6XZbSZNKbfXVWVCcQppm4CyryYgFjHlk0sdrThwB3Px/8pFd8+aIjLuWPG/4x/BEAmg
         eMYg==
X-Gm-Message-State: AGRZ1gKCOT+1amKHy+b+WnecEzNNdJQXBgTvHsuFS8R9vysy1bQbGmVu
        eQZV0po8jSxjHFY9WFJacyyqAyrUXd7uyLiox6UhjrZk
X-Google-Smtp-Source: AJdET5dKABcSFmMvc+fAVJtackYFd/GZ6+IfkZGCSyCHAoE3jKSiNEC/1JalsGVKaqUrM//vu3MAne49KldfRtXMFh0=
X-Received: by 2002:a19:c801:: with SMTP id y1mr2569215lff.53.1541013198613;
 Wed, 31 Oct 2018 12:13:18 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Wed, 31 Oct 2018 12:13:06 -0700
Message-ID: <CA+KyZp5Zv77idtpu9jtxDUyE9zPP8UN3LsQBG=M5yM2cnMFgVQ@mail.gmail.com>
Subject: using --force-with-lease after git rebase
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have been confused about the need for --force-with-lease after rebasing

Imagine I have a feature branch:

git checkout --no-track -b 'feature' 'origin/dev'
git push -u origin feature

I do some work, and then I rebase against origin/dev to keep up to
date with the integration branch.

git fetch origin/dev
git rebase origin/dev

then I try to push to the remote

git push origin feature

but that is rejected, I have to do:

git push --force-with-lease origin feature

why is that? Why do I need to force push my feature branch to the
remote tracking branch after rebasing against the integration branch?

-alex

related question:
https://stackoverflow.com/questions/52823692/git-push-force-with-lease-vs-f=
orce/53042745#53042745



--=20
Alexander D. Mills
=C2=A1=C2=A1=C2=A1 New cell phone number: (415)730-1805 !!!
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
