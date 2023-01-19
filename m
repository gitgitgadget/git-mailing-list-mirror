Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89473C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 16:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjASQdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 11:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjASQdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 11:33:16 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395C8CE43
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 08:32:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m3-20020a17090a414300b00229ef93c5b0so1601958pjg.2
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 08:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrwkOk4CBqbin5pKepHhzw/yzObcxHQh35Y5PaTj4v4=;
        b=kQfUvIEHXwfCWTZeMA2e3hEGrsu4VEfGiriSLal98AqasUOwkdkXQdZLYwdkDMZQt/
         2EYIxPhH4119wLS1gW/UgaLCegdQXEYi4VksY2OrldLTn/6fAVQhFkFdwSaXKVl3XX2b
         ZWQ7jnW+secfdB61cu16ZOHDSId1UQ9fteMsTdoJdJxJYemuf3G4leWSC3NG66qDujeI
         yPS7QsnaJZHw5DXsMOTowwzYjzNqCuQbpeEeoQWSASGTBmP/p88sAqhauWRvv7f6otXF
         XIxtXwRIiJv7O11C5tmjTGhdkaxXr3XmCH2fzsr9qgMrVE1IOAUTJyyVHLR5tBYT7LDa
         rfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrwkOk4CBqbin5pKepHhzw/yzObcxHQh35Y5PaTj4v4=;
        b=x2Symj69vR5dFVEXAgQW3tID8mJUFw4JISDbGxkWsuAhoUQaD0Bc8gNPW0wQjxqdh6
         fd9s6Y341ZzWbiV5Olv8f4iep2p90bShXEQM/JRSLPTWwjW6cYCx09DoaZItwXDEo0le
         WFHmNP52awFgpIerCIHe/Mp9iyXckyDxg+eSTpqTmEjlsTfX2bgHZGBC6QS98d1vWxXI
         kXW3Dd1E/v/vzFMFpirMnOs9QeyV2rs9wmvHobe0Z3JGaIfITRKrqdCZuEuVw9IEimZy
         X5sspd+KgBqqwNlosfAYwCB4ZYlHa1uUNnk4ol7QGw0QitZkt9eg/2nPpvu/DMd7tmOQ
         XBfg==
X-Gm-Message-State: AFqh2kpGD8LvUVjkAOIf7WrgPG2o1hFcK0hUlhe6pQPCGzLGSd5YSoHh
        gatV9Q7Mh2X6b1MtaG3uhhA=
X-Google-Smtp-Source: AMrXdXsCNuZ6T7jpyxOcOkEFpQG9ifcobBhxAABxakbTyNRG7LAyR4TdeOTmHdFiArndBldljRr42g==
X-Received: by 2002:a05:6a20:b71b:b0:af:6f28:7c42 with SMTP id fg27-20020a056a20b71b00b000af6f287c42mr11191969pzb.62.1674145974253;
        Thu, 19 Jan 2023 08:32:54 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id r33-20020a635161000000b0046f56534d9fsm20957298pgl.21.2023.01.19.08.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:32:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jacob Abel <jacobabel@nullpo.dev>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 3/4] worktree add: add --orphan flag
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221228061539.13740-1-jacobabel@nullpo.dev>
        <20230107045757.30037-1-jacobabel@nullpo.dev>
        <20230109173227.29264-1-jacobabel@nullpo.dev>
        <20230109173227.29264-4-jacobabel@nullpo.dev>
        <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>
        <20230114224715.ewec6sz5h3q3iijs@phi> <xmqqo7r0ijdv.fsf@gitster.g>
        <20230118221745.wovefwx6vhcm3zzk@phi>
        <230119.86zgaev8ko.gmgdl@evledraar.gmail.com>
Date:   Thu, 19 Jan 2023 08:32:53 -0800
In-Reply-To: <230119.86zgaev8ko.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 19 Jan 2023 16:32:32 +0100")
Message-ID: <xmqq1qnq32oa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I also think that UX suggestion is sensible, but if we do that we
> shouldn't just apply that to "git worktree", but also change the the
> corresponding "git switch" UX, on which this new "git worktree --orphan"
> is modeled.

But the thing is that "worktree --orphan" that wants to implicitly
infer the name of the branch out of the basename of the worktree
cannot be sensibly modeled after "switch" or "checkout" that do not
have such a dwimmery.

In any case, fixing UI mistakes after the fact is always painful
once it is in the released version. When we know there is a new UI
mistake in an unreleased version, it is sensible to grab the rare
opportunity that we can avoid such a costly fixes later.

So, I am not quite convinced by what you said, at least not yet.

Thanks.
