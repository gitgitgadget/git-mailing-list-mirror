Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0854C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbiAZNqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241290AbiAZNqh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:46:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0806AC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:46:37 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c24so66879662edy.4
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GLSNPzgdHf99/BySzlY6p8FJ62MjxdeR8vjF4iyDFD0=;
        b=RxfxFRE/dyDOVs0snWVYOfFNaF7sF1Nxv1p1A4taMD2knw1TAP4vfMfFpJ4ZRTV5If
         0ZnAGgIwkS74Lb8oLChl58otrxcDaAwPRc8IuDDk6P/qwzqmYOZ7w1qWG12DqN0Oa3gv
         r47E4H1N+WbujoJkgyxBfi2Rlx+WO8ALV6wIZGEbD+aJams/VeRy3QwweK/J/NUE5QZU
         U6mQQQrfB5nwpsp5z0rpHc4ikJ9vjyUHAduuPFNIDcL6C+0auzOzupwT9GA31MMEKWfI
         wnYAES+gh3e7YNbIAxv8We7gHplzEuEMJnQ47y0p9LSRmgomOijOQ+3uRp5tIASiPhV0
         3mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GLSNPzgdHf99/BySzlY6p8FJ62MjxdeR8vjF4iyDFD0=;
        b=AtrJWcyuz3zDtZBpT1MLaIYdOFL0LWF7ZW8+trY7l4AZhkvvvUqUo0Fxd+fevGMLwl
         eJ1vpu9fJ5osHUHhwwEYupWCPWPh3D7kIXjgyiVvKKGgrXczGyMvp9/oN+5P9tERBecB
         DfYyBI8G2F4h2lOM1txzTID0P0BtrjFJcnA7sAcBTrcWPShlw1cuaeNGptKO/RSlSBdO
         GA1CQhZYFetuSBHtnwYMjnznrAfUHPnJqXwU8f1V2VYWI7qpiduR3j9wiJ6w4YgONLPO
         dY88xEvM50/YDjnhUMJ46ZvBgxXzmd4ajsT4NiZY3VD1oZcfkmXYAc4tZ5V35EutvhCT
         FukQ==
X-Gm-Message-State: AOAM53042eZl1k4ntDc51V8SejMvvgm0Csz0P2w86GHM8f9BbD0IxL0d
        8SJf2N/oCfbUmDu48JdWY15Toy6YLBQ=
X-Google-Smtp-Source: ABdhPJz9BLHaaQtpVrFNS0BI36GKFi73qlIEHcWdxsskCNofOiPnWRTNjEQLXoAntC4uddjrMNs4Zg==
X-Received: by 2002:a05:6402:405:: with SMTP id q5mr25015886edv.372.1643204795294;
        Wed, 26 Jan 2022 05:46:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o23sm7419613ejn.22.2022.01.26.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:46:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCid7-003888-LO;
        Wed, 26 Jan 2022 14:46:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git stash push' isn't atomic when Ctrl-C is pressed
Date:   Wed, 26 Jan 2022 14:41:50 +0100
References: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
Message-ID: <220126.86bkzyfw3q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 25 2022, Yuri wrote:

> Ctrl-C was pressed in the middle. git creates the stash record and
> didn't update the files.
>
>
> Expected behavior: Ctrl-C should cleanly roll back the operation.

Yes, you're right. It really should be fixed.

It's a known issue with builtin/stash.c being written in C, but really
only still being a faithful conversion of the code we had in a
git-stash.sh shellscript until relatively recently.

(No fault of those doing the conversion, that's always the logical first
step).

So it modifies various refs, reflogs etc., but does so mostly via
shelling out to other git commands, whereas it really should be moved to
using the ref transaction API.

Ig you or anyone else is interested in would be a most welcome project
to work on...
