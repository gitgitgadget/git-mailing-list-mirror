Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7639DC433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353301AbhLXR0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLXR0r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:26:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFCBC061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:26:46 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y22so35635420edq.2
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=HDi6T0Zn6lWtW47b8SiQ8r8rULmip8z6ZQtCtaTGXpw=;
        b=BEt/hF+uR5KBQMJvftKkxxoQluCWYFdXQCBdnHLtwzbQ1g1X6LEXwP2wS8mVHepHTj
         VQptcGgj1WJ19HYV0OJ4tkmmf9OC6C5jgGFup+5C1A1roopMald0te1uPzYnCyEctGwE
         DnEr1iCAQS2oabofXqHD8Ou6H2IdPor76bnpIYkpeSOxedDJ9bj2NNjHqZpOuGcWZobf
         Ac8ApR6eH7LSaQUtiCaH1krARJTF+IGE8WQ/ckcjV6+yWGxJKASoypqKPyPvCEJZPt9L
         2Ib2LGqjwcpZkfOo11PsshVwAClgYlfqAnvXmz2qgQcCL9nvUXNykNJ3QZiDlPkGRYIJ
         q68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=HDi6T0Zn6lWtW47b8SiQ8r8rULmip8z6ZQtCtaTGXpw=;
        b=xFBcNbxq+mLTua7McVvqIp0PPzbNDkaqfmYVzfmgWqElMgzNgZIYH4jZuXP6C+xLOI
         F3v1acFDLL54ERgp9rDNPqiRTWn0flTz2SX6xNe0EEvZxWWzTIBWPQ8/lIKAEIGkNwEv
         TuLTCllImoO3dRYXVeYe67sdf9zEffVzTDb1f4uy979M5XqMsKBj4gcIpVXxujmoRixI
         xKUzL6H3QhR5uGizNOwX9pqlQXWaetgZd1vsHcqry5XM7MjdueW6FAwmFx4KpBrHiqbz
         VvIpfksKXILBmxjtZOf6YZlzoEjBEEgYjpkriY1KicLFZMIzYTfHQhaPTYXb1A4h2tgj
         E1Pw==
X-Gm-Message-State: AOAM533sOy5UY0Rt7gMJPed6eWVDSayMROopMbTIgsrkScbgaumamXgM
        mmrDdyKO4Fr6X3wrJL/Gnyc=
X-Google-Smtp-Source: ABdhPJxieS1cZcSMvd1EJSRpF3YU/RKY7WbafpOUjrvDkRzMmDuNtYyx3to7bVV3sZrMV0uG+1yaDw==
X-Received: by 2002:aa7:c6c8:: with SMTP id b8mr6617394eds.164.1640366805527;
        Fri, 24 Dec 2021 09:26:45 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id u14sm3203309edv.92.2021.12.24.09.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:26:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n0oL6-0003JZ-FK;
        Fri, 24 Dec 2021 18:26:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
Date:   Fri, 24 Dec 2021 18:26:05 +0100
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
 <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
 <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
 <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
 <xmqq1r27xfi4.fsf@gitster.g> <211221.861r26u4b9.gmgdl@evledraar.gmail.com>
 <xmqqr1a6so6c.fsf@gitster.g> <211221.86o85asmd1.gmgdl@evledraar.gmail.com>
 <xmqqee66sbsa.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqee66sbsa.fsf@gitster.g>
Message-ID: <211224.86ilvdhq23.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> It seems as though you're saying that any fixes or changes in this area
>> would be incomplete without moving us towards the most pedantic and
>> minimalist interpretation possible when doing a "git init", is that
>> right?
>
> Not at all.  Belt and suspenders is a good way forward.  I am just
> saying that on-demand creation is more important than the other one.

So you do agree that we should create .git/info whatever the template
says (as this series does), or not?
