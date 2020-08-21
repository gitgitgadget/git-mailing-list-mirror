Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C07C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 14:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3540320724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 14:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=myitcv.io header.i=@myitcv.io header.b="cFuUhThq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHUOD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgHUOD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 10:03:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4E0C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 07:03:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b11so964966lfe.10
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=dgR30vE2VI1nbqD6bDtYtOdPCu85Ji4Q78ZzX7/Hg/A=;
        b=cFuUhThqEX+Omvz+zkVgdaW6jqWsMOCcr0Dx9gLJg0uQ5DzKbl8GoO9AvePG6E32U2
         kEzRtJmJHZlMwPMv2tAjBV5SGkEmf7S4bXCcX5oI7YXySI22OZ7VftdU7FYwR0H7KRmo
         ANmokJ8u2+HeONPKAhHchPlctyeMMAv5G62gqKigvTqN3I9zb7hRLfXZSbPHYGeyAXpG
         Ox4BN5AbdG2ZzMK7apFN41rdiRpD2WBd63d5FiWBJEBBV7Bk211AOZmKKVaFSJ6ZASQ5
         4K6vmNqBtUQVE+VBfV+jD4JM3YfA+j6Q5TLbwpvZGaPhZy7L9fa8qXaLOCKD1etlJQua
         ltGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dgR30vE2VI1nbqD6bDtYtOdPCu85Ji4Q78ZzX7/Hg/A=;
        b=Qpxo+8hd4fsyga6/jnIhqSBMmCgHCS9EdtWvZrrcvYRaCVMBR27RttPvMkh0i25VOq
         mMxc4bxqoUzhllW1NZnayEcR9kI22HYsMzJn2e0AZ0UfRLm7dRvzx0X7vgemzS3oZj+3
         aDyuOInvtLhA88H98RDLfu5bWn65Sq31FvnSc1E//7ZLz29uh81eIMDHUQYXTF88fEpL
         Jb3soogev+StT+PX7rzEhTkAmqkV5aIs6yeKLrdJGh+s4HxNfYPtqe3KM6vDD7RQCtHl
         92UiMs5yCSseZYOcvO+IaiUu7NI0eG0m+9uZHfCMJT9Ei8BK1HAlOILlc6c/X5kKQj91
         sjdg==
X-Gm-Message-State: AOAM5318ekHyvB9WnbnXOofYwnzcc5Wi19Px1mV3dNExcx7y+ON7phE5
        SFescopyNwIg+6O+CR7Vd8A6CegdAlf0zMtb36qbvqH9h1Dbbw==
X-Google-Smtp-Source: ABdhPJxZuvmRMRnKFNiIzrNGlCmXHrhUiLo6liGil9xssOdGDKG6OLc36tw5WU1mQ9pksOJmaZjMkTB9VzHS8zKBG9k=
X-Received: by 2002:a05:6512:2010:: with SMTP id a16mr1498298lfb.196.1598018603383;
 Fri, 21 Aug 2020 07:03:23 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Jolly <paul@myitcv.io>
Date:   Fri, 21 Aug 2020 15:03:12 +0100
Message-ID: <CACoUkn7D52ox2MgUfS2uQtLa28twccfxnQnUteVV_yFfVLFQdQ@mail.gmail.com>
Subject: Bash completion does not offer bare name origin where remote head is set
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In some of my repositories I use either:

    git remote set-head origin -a

or the more explicit:

    git remote set-head origin main

to set the remote default branch. My understanding is that this then
allows me to use the name "origin" to refer to (in the second case)
"origin/main".

However, testing git version 2.28.0.308.g675a4aaf3b, bash completion
does not offer the name  "origin" as a valid completion.

For example if I type:

    git checkout ori

and hit <Tab>, the command completes to:

    git checkout origin/

(notice the trailing slash). Which means I then either need to hit
<Backspace> to remove the slash, or I have to remember the default
branch name of the remote. Either is a slight annoyance... which
multiplied many times a day becomes painful!

Ideally I would like the <Tab> completion to result in:

    git checkout origin

(notice no trailing slash), i.e to know that the bare name "origin" is
valid by itself.

With many repositories renaming their default branch from master to
main, git remote set-head has become essential. It would be ideal to
have completion help support this.

Many thanks,


Paul
