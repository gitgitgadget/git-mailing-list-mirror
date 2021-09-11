Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18E7C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 02:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E23B610C9
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 02:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhIKCy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 22:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKCy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 22:54:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1827C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 19:53:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t6so3841134edi.9
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 19:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=O8xiCle+Ghktg7Or7houIzyac4Tjb89gAlqGFeJI62k=;
        b=Z0/nceO0sDZzXzkVEg6hHx4YPEUK6byE46KAwsaz4NTP/HoOVamDryb1X72YRQYUyf
         CCnJRi+LpoM/+XrpbL/HAsNRH8BQeiPhhxbp1gEJFokyVFyN7aZ4KN6O2qvE6Qhl5GjL
         2nI66pCIdI3hated1exY5iF5h8M7z5P64VgbWJ7qywUaAqfQrdlRnai5rTJqFu1zCIgc
         caVubZSv+C5yvOIWpPa8us7OzbD6tiGbeJ1WbfScDFpYANgyWSmBr2AQ2XiFwg0fGam4
         4Fbt1xP/V8/z/9XtvGc79BqtubDn0sPfzjo1NIzrtcVJjG6AWPacIOOHL4ot6tHVpGPl
         fTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=O8xiCle+Ghktg7Or7houIzyac4Tjb89gAlqGFeJI62k=;
        b=GyQ3eWZTPY2Uf98xp7j6XDWhLqRiMeINnfsNrDVhxYldsMzOqgsGgDf3swkchnQN5J
         ozWYv+HgkHRKt1X7VK4dENZRicY+ABJ2FYHOORZzD16dBKgG+XLmAIVw/CXocbFDdlYN
         O9ax7dMaZ2qy/cPZnK8c5JF5+6NoDamtKsYKElKdJGxqPuYOv5+2kJi99XBrxuw+jLUQ
         KhYjMpY8xjjbcMfsyUdkoRGRbkjHFbOF0uwOCRHyHj7+kalNzlt7yQZ+vtn/8LIw45sZ
         eab1KyTPHXki+O0M3ZLWgDhRgHc631UtCvq29+KQid5SwZZAFWuSyoOQGoYBjuVKsDTe
         XG4Q==
X-Gm-Message-State: AOAM5329AZkKCfn+a8c/KwSxMZp/kNm/eN//CH8P4mRKWx3BQw7fUzqZ
        tiY8+o4zeD0zVJiWr/oaArg=
X-Google-Smtp-Source: ABdhPJymox1buaiVwGc94gzW3LBjjlf7LBryeTe3zFHr8mDJbDp5sQkjngXE0xLhNPub/oKdYksDLA==
X-Received: by 2002:a50:d713:: with SMTP id t19mr1131978edi.2.1631328825127;
        Fri, 10 Sep 2021 19:53:45 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm1sm160020ejb.38.2021.09.10.19.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 19:53:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/6] git.c: add a NEED_UNIX_SOCKETS option for built-ins
Date:   Sat, 11 Sep 2021 04:50:54 +0200
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
 <patch-v2-2.6-d6c44402715-20210910T153147Z-avarab@gmail.com>
 <xmqqr1dwotmn.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqr1dwotmn.fsf@gitster.g>
Message-ID: <87mtojaklj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the implementation of b5dd96b70ac (make credential helpers
>> builtins, 2020-08-13) to declare in the "struct cmd_struct" that
>> NO_UNIX_SOCKETS can't be set.
>
> It may happen to be that two credential-cache program are both
> related to the same CPP macro NO_UNIX_SOCKETS, but I think the
> pattern you are tackling with this topic is that a fallback
> definition of a function that is designed to always die when invoked
> misuses the parse-options API.  I do not want to see you invent a
> new bit in cmd_struct for each and every conditional that lets us
> define such a die-only fallback implementation.
>
> I may be missing something obvious, but can't the following suffice,
> and if not, why?

I think this is covered if you go on to read the rest of the commit
message, i.e. yes we could, but the trade-off is making the test and
users that might want to use --list-cmds=3Dbuiltins hardcode these two as
special cases under the relevant prereq.

Hence doing this in the main git.c dispatch mechanism, if we can't ever
do anything useful with these it seems best to mark them as such at
compile-time in that dispatch mechanism.
