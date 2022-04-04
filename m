Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB7C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 06:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377404AbiDDGSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 02:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbiDDGSh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 02:18:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6885236338
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 23:16:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ot30so7751885ejb.12
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 23:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TqDDVJy5boCsQXWKBUM60BVX6Kwt5mQJFopDAiOooc0=;
        b=fhcwcgbHWdtARETueEV2LJMx/Xhemts27UNmXr+9Jeqv0VjGioHkGHGyDN7XrgWpoU
         yneqkUfg17D2Knuaztkg5kp1wkX5quR34Sw2WStsc3B7b2JFpF9VYB7orF/VZW8WzSux
         UI9nJ2amavFIwZ1VlmPf2HiJ8jXVjz+2othsHQQK4JwR2sJueuzbXnKIMCG6Zp0Hvat2
         flZvLri8Vo9tDq7iYVzHTzpvbz2GskL868QJ4ZR1wkfURamK3TU+orSFVnZTsOc55hNm
         E728T68b5NvhuJ9JpPM6e/wKNy/iyOowHwOts9soZ+SeiK/mFMuE9CRdly1wEIIuEfZh
         2OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TqDDVJy5boCsQXWKBUM60BVX6Kwt5mQJFopDAiOooc0=;
        b=cgFCO1sa2gfna7clExsL4eqcBSGV97BHx4xadkpkAXHYiw34Op7w/XHvBkjp/PY5cU
         fplGDU8U6yHuXkfGR8fYrG4pz9b6AB4cFce15bvVWmRBpCgt6RZ2kLnugJLm66zpAplB
         27PbxLvmv5Qf18Txf8n2AdrjTa4h+/nImEt9GCRWeF5N8g4s4phdRvlRDd45FpjxetLH
         RPibfw+U6MjpqbrF8QGi694BAhrV7lDSuJvgFhL1zjPl9jbvSdVyhzBvOZddG4HcPRl4
         5ghgKHPB0lQ22gUd5JvyYmEnlmmkQieiB0laPx5Cz/1iIeHyPFu+gzVztNUE7Z/guUwY
         PG1w==
X-Gm-Message-State: AOAM530FSYsY6CaXaQHD49CWNzIgmAnaZNFH3XaeU7/fH/B6e+rCuPPk
        eoQ8fpGfzElxokW9ysoOFvsXest3Ad0=
X-Google-Smtp-Source: ABdhPJzqAoOBIUzmtPsbAdqI8moBm6iFGWCPDyUUag9IWnsfAo5bE0NweqlIBnIw2Ta1bVPjQYuYOA==
X-Received: by 2002:a17:907:b590:b0:6c1:c061:d945 with SMTP id qx16-20020a170907b59000b006c1c061d945mr9390511ejc.768.1649052998772;
        Sun, 03 Apr 2022 23:16:38 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm4848620edt.80.2022.04.03.23.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 23:16:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbG0z-002JUy-Lt;
        Mon, 04 Apr 2022 08:16:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, whydoubt@gmail.com,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] blame: report correct number of lines in progress when
 using ranges
Date:   Mon, 04 Apr 2022 08:15:52 +0200
References: <20220403165038.52803-1-eantoranz@gmail.com>
 <xmqq5ynpu6uv.fsf@gitster.g>
 <CAOc6etac3tQdOzY1bF7qBVOJ_ndns-KOSum8w-Jie06Ynz_cWw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAOc6etac3tQdOzY1bF7qBVOJ_ndns-KOSum8w-Jie06Ynz_cWw@mail.gmail.com>
Message-ID: <220404.86y20ljrui.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 04 2022, Edmundo Carmona Antoranz wrote:

> On Mon, Apr 4, 2022 at 12:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Wow.  I am reasonably sure that this was broken since the
>> introduction of the progress meter to "git blame".  Thanks for
>> finding and fixing.
>
> As the person who originally wrote said support, I feel like I
> am just nurturing it. :-D
>
>>
>> Can we have a test, too, or is that too cumbersome to add for some
>> reason?
>
> Correct me if I'm wrong but it could be a little tricky because "progress
> display" shows up only if it happens to "lose" a race. Progress is
> skipped altogether if blame process goes too fast. Even if you run
> blame on a file with a lot of history, if box is fast enough and info is
> cached, it will fail to display progress. So, all in all, it would be like
> trying to unit test output coming out of a race condition.
>
> Let me know what you think.

You can make it always show up by using GIT_PROGRESS_DELAY=0, grep for
it in existing tests, skimming the code that coupled with --progress
should guarantee that it shows up.
