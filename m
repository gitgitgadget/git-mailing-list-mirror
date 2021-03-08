Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E7C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 13:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D9F651CC
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 13:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCHNMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 08:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCHNMS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 08:12:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A21C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 05:12:17 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jt13so20344018ejb.0
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 05:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=qgfaXNd5jkDp1390s8Pkt/vQ/fCb1zB7q09f5yOWTZU=;
        b=jhMHyCkVqkhfTSATmFv02CUAXO6q/dcpa5CXEXmKBEWsb2oaNomGslaH7tgO5G55Sv
         C5gfPFxVvuJ/w9oF7GIKwC2ZF01myVcm2sEn7w1evtNVSfIUlppxxxdj37GB+2MHdeec
         zyJrShHiWTYt9c3bpeIOigu6H4EyIvV7acvOgP1wTRDxTYq16umNi098m+DPQizVlVDQ
         SEhTVXMbhGtxrGpvno0XYoofhV0VKTO4iFdmpvzvrSRanyT1SgrFKhRc0Dj8pgImXymy
         84CY/kewBsI5/NG3zW+dlNy8cVgaNBRujvzKHovy43SzR08yA1n8VgCSwAArG0gkMroG
         TlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=qgfaXNd5jkDp1390s8Pkt/vQ/fCb1zB7q09f5yOWTZU=;
        b=cV4epZrIQz4I0Z376GsQNg+UOYnFhSjZoqXzRQPiF96cNOZktMeqT0S0oA3lGyacwk
         SUwgrsggXjHESWz3YSDhSAo4+/diY0+avBw9H/IWtuLrUgff/UbMUQ9PWU/U8TacdrNo
         884/gg+IPzyfyHUr0kdLUNlFzTzGG84j5grEYxwt6QtLlPcLErLPuc6uIEOYAOWCFD6q
         3twUDmCX4K4MvwfXa2Rc+w7wZG97F97OXgeVD2/6WMUGvZMj/MYa8f96/aq6hlfjT5i2
         CPlYfPGo1zMKqRZdes+AKLUP1pkNZDVaDy+hOnP+KI78ZtHz8UkfWbhmW6hOyzGdnOgS
         OWMw==
X-Gm-Message-State: AOAM531iBF6M0OEGdseBIOQ7cuWdFE+wXAE4CQIgbBh0dC9Z9ybSPtwb
        S/Tn/Jb/4ksKsAW70EghxX0b4dlHxn104Q==
X-Google-Smtp-Source: ABdhPJzEmmQr2D6GkbS/sUmjEZ8CtbVU3Num7YZ5E4H2Q3R8MvFfp2vo35C11uNATRulFXcz+SUawA==
X-Received: by 2002:a17:906:7fc4:: with SMTP id r4mr14708129ejs.81.1615209136343;
        Mon, 08 Mar 2021 05:12:16 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b4sm7679851edh.40.2021.03.08.05.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:12:15 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 11/11] merge-recursive: add a bunch of FIXME comments
 documenting known bugs
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <0409118d4ff76a8dc0285c436f89478176752955.1614905738.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <0409118d4ff76a8dc0285c436f89478176752955.1614905738.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 14:12:15 +0100
Message-ID: <87sg55iyc0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> The plan is to just delete merge-recursive, but not until everyone is
> comfortable with merge-ort as a replacement.  Given that I haven't
> switched all callers of merge-recursive over yet (e.g. git-am still uses
> merge-recursive), maybe there's some value documenting known bugs in the
> algorithm in case we end up keeping it or someone wants to dig it up in
> the future.

Yes, I think that's very useful.
