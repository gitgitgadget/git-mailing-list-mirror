Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8827CC71153
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 18:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjIJSrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 14:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIJSrb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 14:47:31 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E68318F
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 11:47:26 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58fb8963617so36394197b3.3
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 11:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694371645; x=1694976445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhahWWwGcMI1ta1UhbnrMGaMUxxfPQqzCxOlFsDV5zg=;
        b=WirfJoGLEkWVwFWqgF0IzCtUvXBhOMvd9qjiWOe1sH4ijplbYIhbvgFCM52Gq4BEK9
         CPwvcV3Tcyzu3OWLrFczKq65bZQO100cMJtlELwhSnwI4fLEBBej4RS2DIRcGSwT3SVG
         J88/7oRjuPR4/9DUR91IwhKujonTVVmc7UvPD+OGk0jxVPAndFwNkb5wpK3V+rxoTkgq
         p6TL3QR+zt8bErudMHbg6g6/k/1jjeZznlVq11HIueTsdKOlTiILw2GesC+n2m9KwGDL
         Lfth2erHcMbWPJwSc+dmbLf2fb41ZuoRq9GVEskAL8DNUdxs3oaYal1X7XZiFRaQ2ql+
         lO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694371645; x=1694976445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhahWWwGcMI1ta1UhbnrMGaMUxxfPQqzCxOlFsDV5zg=;
        b=VzmhirLjA06NL9YCqv2K5Q9eB0isheuaBlooFXCpRoxQtI6sAF0iZsj8U0Jr+2SkCN
         tSZiaTQQmlhj4dY7feOEMcEsggnqU8Un122poIRNcjrfwIcGc1VOsVWGt6r9DXnjqcxw
         Uyd/GIQsSUQlM9kHta/qFgEzSTFO2fxCsI0V8cUb5tw93yGSOpD+qF+eQ+fhcK41UKQ+
         P15nAP6c81oQc+Lt8aATgsada5sl6/ni7GvRKOqi99BDhgS+wNkKd/DQwSFOulCNOJ6U
         r3NbMW7ZjNV4sTw5RqP/y2sILOciy0ud82AVg8im9nmjBUvmI71J35aC03u918BqVJbO
         byIw==
X-Gm-Message-State: AOJu0YyftgXQJiQj8s4DYW++N62fniIz65Fw6EpHceFeBZWyU5hrq1XC
        rMgSbccrJedbC77dZPMTPtyyOg==
X-Google-Smtp-Source: AGHT+IEG4egA4BHGu9ZOX47N6rmPb/N8N+KelSGerbxh0JKBWyKGHtA7DVmA6fAhinac+oJixrh+XA==
X-Received: by 2002:a81:83cc:0:b0:59b:5231:50d7 with SMTP id t195-20020a8183cc000000b0059b523150d7mr7772858ywf.10.1694371645525;
        Sun, 10 Sep 2023 11:47:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a80-20020a0dd853000000b0058451c12076sm1539592ywe.14.2023.09.10.11.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 11:47:25 -0700 (PDT)
Date:   Sun, 10 Sep 2023 14:47:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Max Amelchenko <maxamel2002@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] git clone command leaves orphaned ssh process
Message-ID: <ZP4PO+HkbsbuKact@nand.local>
References: <CAN47KsV0E+XC2F+TVKXnnJnkATRp7eM7=-ZJFyZcoTz9SJmcHQ@mail.gmail.com>
 <ZP2DaQMA_aFvjQiR@debian.me>
 <CAN47KsUe=qicr4wZWd33EV+cciUr8ztP2veoOkcw0JBtvsBGjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN47KsUe=qicr4wZWd33EV+cciUr8ztP2veoOkcw0JBtvsBGjw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2023 at 12:47:14PM +0300, Max Amelchenko wrote:
> Output of second ps aux command (after running git clone):
>
> bash-4.2# ps aux
>
> USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
>
> root         1  0.0  0.0 715708  5144 pts/0    Ssl+ 09:43   0:00
> /usr/local/bin/aws-lambda-rie /var/runtime/bootstrap
>
> root        14  0.0  0.0 114096  3088 pts/1    Ss   09:43   0:00 bash
>
> root       167  0.5  0.0      0     0 pts/1    Z    09:46   0:00 [ssh] <defunct>
>
> root       168  0.0  0.0 118296  3408 pts/1    R+   09:46   0:00 ps aux
>
> See the added ssh defunct process.

Hmm... I wasn't quite able to reproduce this locally. Below
`git.compile` points to a Git executable built from the v2.40.1 tag
corresponding to your bug report:

    $ host='ssh://*****@*****lab-prod.server.sim.cloud/terraform/modules/aws-eks'
    $ git.compile clone "$host" /tmp/x
    Cloning into '/tmp/x'...
    ssh: Could not resolve hostname *****lab-prod.server.sim.cloud: Name or service not known
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.

and then:

    $ ps aux | grep defunct
    ttaylorr 3688844  0.0  0.0   6340  2180 pts/1    S+   14:45   0:00 grep --color defunct

Thanks,
Taylor
