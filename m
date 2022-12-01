Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9055CC4332F
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 23:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiLAXBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 18:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiLAXBW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 18:01:22 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7896BCCED0
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 15:00:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso6674616pjt.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 15:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSok/IOim6V8m9NT0ST8lAqXeUrHMR0zGC+Fj3+3gug=;
        b=pVxWjjdZKIqNrPaF12VyeBURiadXDDjOHYdwOu9rarFxjYnO7EC+OZzsOTpkgsUgxg
         Z2wLiQsNYP7Yqc2edQ2o3g6pukt5KRojSH0cR54wnLBPvy5+L/m4sQ5wuUx9ttZZwKwS
         AKDvqjCnz8aWCkBG/CyQW8mugH9U2emS4l7Rybr1jrZIrz1YJHj+Is9io37lupEle7R7
         av+1ETOEUTaRswc7EwEQjqHEDfg1qcjxEEJyQMmO3d+gJgYoLv71K7yU42D033OnC0uy
         4OwNEtRmB3mpqTOS0YnM6hbbjicmI1oIXj8OTMqqeC4GVt39CJCixeGBB3H95PZuYOc5
         X38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSok/IOim6V8m9NT0ST8lAqXeUrHMR0zGC+Fj3+3gug=;
        b=QvCdg0pYPMSpKw0GyLNwdi2bZRpGeRLWEzGpiNxObPjEBN9CW3Y0m15fS8YDFxFl+A
         19QH5nMl8Q+oEJqcoeQVYjLyK6docXFwXC1qmTvNj1vsrzZu+yEnkJnJBKkFbb6J36uc
         07DYJZTiUIAWTBQj+pZQeM+SSo/N2KuSwJZ3znsUPBkdTPI2BwVfpOZinP0LFm++L2l0
         jSd5CBY14LuC7/141OiTs7VlvaWGpEc49Tx0ysOkPgrh7QuKs5lgBLEaKUVgXWgYPV+6
         vBzUkWLh+5wGAlkSbh1Z42q7AVsoxklaQ9BEEu2s/jivTrmxdcfJx7l/PskatObhXVzk
         eU2Q==
X-Gm-Message-State: ANoB5plZl6d5ox4dA1jgYpUjg5sjq+t+qigeDa0BrEdErUq8D9b30zpx
        Ygh1Mi9bVyrK31jaPCmLYCA=
X-Google-Smtp-Source: AA0mqf6uHoK/EqTFadHzjP96onWVuFIt8nUYR9WC4hOfoJg9RjKUUXMPsvdu046tv3/x4joCjuwPFQ==
X-Received: by 2002:a17:902:db05:b0:189:65c4:ac2a with SMTP id m5-20020a170902db0500b0018965c4ac2amr34835254plx.82.1669935602874;
        Thu, 01 Dec 2022 15:00:02 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i92-20020a17090a3de500b00218ec4ff0d4sm5440082pjc.6.2022.12.01.15.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:00:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
        <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
Date:   Fri, 02 Dec 2022 08:00:01 +0900
In-Reply-To: <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 1 Dec
 2022 17:39:28 +0100")
Message-ID: <xmqq5yeuspam.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>> Junio please drop this series when you rebuild next as it breaks
>> manually running individual test scripts when building with Visual
>> Studio.
>
> I think the issue you've spotted is easily fixed on top. See below.

Smells more like papering over than fixed, but let's see how folks
who need cmake/ctest feel about it.

Let's mark the series never to graduate to 'master' for now,
optionally revert it out of 'next'.

    Phillip, you asked about rebuilding 'next', which would not
    happen until 2.39.0 final---did you mean reverting the topic out
    of 'next'?  Do you need 'next' without this topic, not just
    'master'?

I'll then wait for something both camps (you and folks on Visual
Studio?) can agree on to requeue.

Thanks.
