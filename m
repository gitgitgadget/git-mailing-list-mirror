Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4786DC77B7F
	for <git@archiver.kernel.org>; Sat, 20 May 2023 10:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjETKmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjETKmI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 06:42:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7797128
        for <git@vger.kernel.org>; Sat, 20 May 2023 03:42:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae763f9a94so15940485ad.3
        for <git@vger.kernel.org>; Sat, 20 May 2023 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684579326; x=1687171326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAROgZxYMRX9ENLzALGRuYN6ZsUBG4cUpFnrmDEtTVM=;
        b=SEtW6J7vHTUsi1OeRMz33fKhqxLEIxJZxzFK191K+wuJd1fJOd6GMT5pxCi9LbPVAK
         5iO5X7X6BmH4lbIVI0I8L7hRFak+jo0EoLVd4dSqZE1b3RdAQLH0RW8IHHhFKuRr/jk6
         zSU5ZTUzT4Tulyj3lDBhcVbwRvzso/LGoRicXHd5AxRuQQAg/vi+uL4Q2PToSrYKsvFf
         rdwwQ256bXH2bN7mJRYAykwSo9hxzHeI1bCVkaCZ0b9YSbKzrEEiqsPCrggZApCfQLSl
         Q2mJSMvPHJ1U6KPk7PELQphZ8zCLDkZuYAJNL2x26cSTbnb3Pd/x8KObSldO5tcokVzb
         +Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684579326; x=1687171326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAROgZxYMRX9ENLzALGRuYN6ZsUBG4cUpFnrmDEtTVM=;
        b=blSPTcwtef54uFGWBMcBFvWKhn2qQOojeaI6ZNrUJWT1HoTb31bsmrzUiYKVqqf9uL
         4wUHHuWNeyItDR5FnMK6NoShWnET9TBRL3WGdbJJVzrZVtFc70T9E7fYs8iIpDqDV6aP
         AMwGo4eg7mqdevAGvW6AU51gp4eN3f/zmJHQf3GcduI9ubZfNags/fbxYiIzxOXNGUeU
         bezVAvIwYOYJPTGKRxMlwpFsLQTinRZIkC/hGBLXqWahsCe8S5JcFd7geMbqjk4P4vd8
         kF+uW5N4iQgVC+ixaX4fiiU6fog+AFqVbXThIMi//djmQCq7OZUy841mkX6FSpogesO3
         3N6w==
X-Gm-Message-State: AC+VfDx7oSC9WO/Sz1T3CbXaJ4ri3wF/Ik8zxa2/pk6U/+M8/Rc2ydjq
        yvOxNGJA4c8V14EfPZhZXv/a5YAwd9I7UOcEAAY=
X-Google-Smtp-Source: ACHHUZ4/a+j9/ErccfaEYJB8J7ZTpziCBxWqbv6QFwzgTF2ZDWoY5fqOwz8gEiNQBqLxuZT6o3EV6Q==
X-Received: by 2002:a17:903:2343:b0:1ad:bb89:16f4 with SMTP id c3-20020a170903234300b001adbb8916f4mr6263911plh.50.1684579325889;
        Sat, 20 May 2023 03:42:05 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.54])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902bf4c00b001ac7ab3e7ecsm1175891pls.210.2023.05.20.03.42.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2023 03:42:05 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     code@khaugsbakk.name
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v10 4/6] notes.c: introduce '[--[no-]separator|--separator=<paragraph-break>]' option
Date:   Sat, 20 May 2023 18:41:59 +0800
Message-ID: <20230520104159.53670-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.356.g67a1c1d0
In-Reply-To: <51690df7-1788-469f-aabe-84fc7a576951@app.fastmail.com>
References: <51690df7-1788-469f-aabe-84fc7a576951@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> > From: Teng Long <dyroneteng@gmail.com>
> >
> > When adding new notes or appending to an existing notes, we will
> > insert a blank line between the paragraphs, like:
> 
> I was wondering why it acts this way. So of minor historical note (may
> be obvious to everyone else): it was in order to mirror how `git commit
> -m` works. From commit d9246d4303f (Teach "-m <msg>" and "-F <file>" to
> "git notes edit", 2009-10-09):

Yes, I noticed it too, but I'm not sure whether there exists the same
requirement in `git commit -m <message> -F <file> ...`, `git commit` is
usually a more frequently used subcommand, firstly introduced it to
`git notes` maybe is a good idea, but I'm not going to touch `git commit`
yet, unless we find someone who has a strong need.

Thanks.
