Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D46AC4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 10:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF17223BF
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 10:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYOc7/X9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896553AbgJVK2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 06:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896550AbgJVK2v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 06:28:51 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C838C0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 03:28:50 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id r1so548407vsi.12
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dtAyJKwk1VhSdP0LhslXg1ikg+CMaExjp7bZDjUkLgY=;
        b=qYOc7/X9QUpe6umDg9C5y1kbaP81zcphtnam2DusuOKqtmUSLPo8SjmrT4x7VDCM+W
         lVAXregi10HngsGDOrd7iruUAZH16Vp1AlfrQIEeT6qqlvUWyKOwVXrtnVRXOIkL9H2/
         QV9zFfBQjvbrz9Zp9ZaEdrHmJC/i5rI6tg9vNVO3b13LAFZLhS8v4bOglNBXXoW2E+NW
         mXu+/1t9K8AAZ5PFy3rh6AWOSrWUh6JABZzC4gClOC0+Wzt4ucO5p9wHbJTYvdWNcSbO
         npe1279XNaqdHLh6uepfoQrWPFsjl3k58vIo1OJgtVdZ+yFxTKyFzur9lXr63muGEbq8
         Pp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dtAyJKwk1VhSdP0LhslXg1ikg+CMaExjp7bZDjUkLgY=;
        b=b5rq8zpSZ/7fREpo1F2n6e8zkyJ0qYQDMf9o78ILk7xlJdwSRrq+7slRGIrzGqpPWM
         PDp91Rh0jQ6REn12jAguOorlS3+4BDkyuxje5oxav1czJOyVAYWjNTkb4huJ0fxLedt9
         cSUxYu9WS6eJwfXLMhvCwrSerfxqyzRepa/3CI/k50YLWe2odbEyKILFpAKV1AKZZ3Ny
         EEfg0tRc3kqHYqd6sJl3bv8kAYc1ZX7W3HzUCpYvZ6Wd/KwqSnyo1IIwXcLAoUgzs/xg
         n3aQLH4DD9K75x7pYXdCQFulgvb+OTmpcKXdri6aOV2j9cNfAYX/fk5sqVscOQzMNyd+
         rXEg==
X-Gm-Message-State: AOAM532FKnW1j9mr0EzmErsY3pC5dkxj1BtQiNS5OmvS0Ok4hA34dbRf
        LhJZ+BwsPOAvsZuAPfn3EH+/kqM7tz8xFR/EMVzbsSGEroibq4C8
X-Google-Smtp-Source: ABdhPJxRwp4gc+5u0VoMjItBotGiVmV3wU8+amORlWERxd8FEyTKXIjYYxUTPUJU/Lqogq23LvntfElsfbljOCm6VzA=
X-Received: by 2002:a67:ea12:: with SMTP id g18mr1063217vso.50.1603362529396;
 Thu, 22 Oct 2020 03:28:49 -0700 (PDT)
MIME-Version: 1.0
From:   Adrien Berchet <adrien.berchet@gmail.com>
Date:   Thu, 22 Oct 2020 12:28:13 +0200
Message-ID: <CAKuTeyftpz8mQiiy2S56pxmW0fzCENAQ8=gmaTE5a-Ef5g216g@mail.gmail.com>
Subject: [bug] Cloning SSH repo into /tmp
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I encountered a quite weird bug when I tried to clone a repository
into the /tmp folder (I just wanted to test something, so I was
working in /tmp).

I run the following command in /tmp :
    git clone ssh://[user]@[host]/project/[project_name]
and I got the following error:
    fatal: the protocol '/tmp/ssh' is not supported

I got the same result if a run the following command from /tmp directory:
    git clone ssh://[user]@[host]/project/[project_name] /tmp/project_name

Nevertheless, the command works in other directories. Even the second
command works when run from another directory (this command: git clone
ssh://[user]@[host]/project/[project_name] /tmp/project_name).

It is very specific and can easily be worked around so it is no big
deal but I preferred reporting this in case it hides something else.

Have a good day!
