Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF67C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4653E20781
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393368AbgFWVYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:24:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51513 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389861AbgFWVYs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:24:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so210848wmg.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 14:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkkDu33xdY5xiD/JTqe6DWVdrvngX3lBTFzPk4Lemio=;
        b=t+0sdbFKUwewgiPoCj6GLulaiBNfKXkVJggKwxb8SCkzTUu8kV96fRH+kRwfjJObD2
         QZKLxkmn++WJNj7Jqd27pOf5/lenxqbNEAZ8MQffqdlGcJoGxlqxsNyB0sijoMNnilJj
         ROBiG+7OHaIklRW4dwIfU3D2fXQOT44On3M9De0iibneZlf4dYFR8hpMrUjBz5tFgm0+
         hcKDi8uFB5d9vm6LYj7lchpi35kR0pOVnwwIR5aLUbLQL0KOAFoEIIsGSFzhj4vkPJsK
         4ha95xoCMfyJ7Uff3bsw8V1pfpzabHg3PbBZq9PbPKbtK0OIrzdxYAw/+arxeMezyICZ
         ku0A==
X-Gm-Message-State: AOAM532DRxGjfbkIXRb3u4xT70bxxXTjj9HPHqZ2UzV7/S2gOsmiXRH1
        wOxKrrt8WsIpbJNQOLAT537zH0NI0DUPuxqt22Rynkjg
X-Google-Smtp-Source: ABdhPJzkdT+AVjObRutIrEWDnx2aOzNwFJFGEWyQ/+qYHJtm4wsTCsTN8Q5pv4djYe/BGutQeR4S9ylhICH1E0CjnrA=
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr19457695wml.177.1592947485895;
 Tue, 23 Jun 2020 14:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200623205659.14297-1-mforney@mforney.org>
In-Reply-To: <20200623205659.14297-1-mforney@mforney.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Jun 2020 17:24:34 -0400
Message-ID: <CAPig+cSDxTjLbFWGMZuGuCDcZ05fnaJR0q-TA9DpKTki2M7MyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] revision: use repository from rev_info when parsing commits
To:     Michael Forney <mforney@mforney.org>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 5:02 PM Michael Forney <mforney@mforney.org> wrote:
> This is needed when repo_init_revisions() is called with a repository
> that is not the_repository to ensure appropriate repository is used
> in repo_parse_commit_internal(). If the wrong repository is used,
> a fatal error is the commit-graph machinery occurs:

s/is/in/

>   fatal: invalid commit position. commit-graph is likely corrupt
>
> Since revision.c was the only user of the parse_commit_gently
> compatibility define, remove it from commit.h.
>
> Signed-off-by: Michael Forney <mforney@mforney.org>
