Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C73CC11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 13:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8C561DC2
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 13:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhF2Nt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 09:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233050AbhF2Nt0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jun 2021 09:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624974418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=X4aNXJGlmVHjV3OkMZfxLgohSIaX7tyFvyxcO9+zHsU=;
        b=gfZUs2v8S3zBchGX4oLyD4+OCcIUU7G0hZdX4S+G0XNw4u9c4XrMlpKRUiDAvLiiPF3QTA
        7C7ZfmX7EMZHmUKC7m4KN44zMDmZsCj3uQVlhqHsQmj8irzWZscPLql9jCaktgRgo7r5eY
        sHFy/l4a2Uig9jY7AWb+gziGZFPqEAE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-x_5XEw96P1idg1HYcedl0Q-1; Tue, 29 Jun 2021 09:46:57 -0400
X-MC-Unique: x_5XEw96P1idg1HYcedl0Q-1
Received: by mail-ed1-f70.google.com with SMTP id f20-20020a0564020054b0290395573bbc17so4342402edu.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 06:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=X4aNXJGlmVHjV3OkMZfxLgohSIaX7tyFvyxcO9+zHsU=;
        b=SA6g8Ncr3czyTBIHgr+6lBQk6/5si6a0PuP/yJsezZ13sBwlRam3pkgyhV+OBn0VfC
         vX+paxqwrSohywBuyTdIqvkWK+YCRQYyfKswLdffJBFU87XOETFe1wIza7xaKDsRVZ/C
         9jGxKLddJ+g09I+BY7n3erqk3luRCdRCsTDFgoOIok6x4g3vnKSv7NpYjU3kIdYsPjd1
         IsyDjnMm//EWzNKac3a3lQBNSCR30GycdA6xSfmmDvIapuz+1i8sCMSS6fJRvFHpwsA8
         RncQPVMF/kDw+SqWDu3p9pAZLooNcqDNSV9bn76RWybSFwuh9wPW0gSvO+BBGLWuP6to
         528w==
X-Gm-Message-State: AOAM530nmOL7GEuNSKELnC6zBEoDLekqPaEuRbfExIr/p7+OOGMq3xMX
        11hdeqSSpw6VBPkanVq/xWXbFj2JZgBMwHuX0eBBs5SMG8vXfI1DcSrYBcbQNs/VwMOBu+5ZYWR
        e1AwlS6D7nZpFkpnxd3oKhrjsl7+R
X-Received: by 2002:a17:906:c408:: with SMTP id u8mr3304463ejz.519.1624974415844;
        Tue, 29 Jun 2021 06:46:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKuaKfgpwADOR7QPIP8LNMVqHNv3F0xGvhYdNObgCWzQYfnPudU865962VbTmVZV7Jh4S3S0rnalJnA8krox4=
X-Received: by 2002:a17:906:c408:: with SMTP id u8mr3304453ejz.519.1624974415668;
 Tue, 29 Jun 2021 06:46:55 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Pohorelsky <opohorel@redhat.com>
Date:   Tue, 29 Jun 2021 15:46:44 +0200
Message-ID: <CA+B51BHBoDn+xFXOXWe0SvRzzuPo+YYj63f0dyafJELbBTgGbw@mail.gmail.com>
Subject: GIT_TERMINAL_PROMPT environment variable isn't honored properly
To:     git@vger.kernel.org
Cc:     peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, we've run into an issue when running git as part of an automated system=
.

When you set the GIT_TERMINAL_PROMPT environment variable as 0 you
expect git to die instead of trying to issue a prompt on the terminal.


$ GIT_TERMINAL_PROMPT=3D0
$ echo $GIT_TERMINAL_PROMPT
0
$ git clone https://github.com/some/non-existent-repo
Cloning into 'non-existent-repo'...
Username for 'https://github.com':


You get expected behaviour only when you set the GIT_TERMINAL_PROMPT
variable just before you run git clone.


$ GIT_TERMINAL_PROMPT=3D0 git clone https://github.com/some/non-existent-re=
po
Cloning into 'non-existent-repo'...
fatal: could not read Username for 'https://github.com': terminal
prompts disabled


I've tested this issue on Fedora 34 with git-2.32.0 and Ubuntu 20.10
with git-2.27.0 and I successfully reproduced this bug.
Sadly I didn't manage to figure out why this is happening, that's why
I'm only filling a bug.

This variable was introduced in commit
"e652c0eb5d772076f92245c7e076bf6aaf6af223" by Jeff King, that's why
I'm adding him to CC.


Best regards,
Ond=C5=99ej Poho=C5=99elsk=C3=BD

