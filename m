Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B998CC433EF
	for <git@archiver.kernel.org>; Sun, 29 May 2022 17:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiE2R1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 May 2022 13:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2R1q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 May 2022 13:27:46 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBFD42A0D
        for <git@vger.kernel.org>; Sun, 29 May 2022 10:27:45 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id l204so5016995ybf.10
        for <git@vger.kernel.org>; Sun, 29 May 2022 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=5eM7qYdApuLm/+wUzQpo3CLrYzNrLfiwI8BKjfzJo6U=;
        b=QQj+XqbSmJ5EfbxYBf9RFAT/Rf58PFspxu3guP8F2eTakRnnAYVtjsZl4Kdl5Uh5lj
         U2TvhAO19J4Ny76aa39T6Mha8iuj8wb7FD/uH4KU93OpCS1YSXAdbWN8HeHqJIGPORpZ
         etLPREzXMXvdgmGUCMZWxLF1at3I+tij6Ei12gQxAtkd0h+ZduyBRSAZP759DZ+Y5Bso
         rHcw8gsAoRnf7B6x1Mfocp3Nt3FKHSC8O+pSeBFpB8dGMgzHogpI0A2tJLyKQul4BzFk
         L8r+W6Zk/sxkEkqh2IyvPcgOLn+Z+OEJPa5khJYeZpJBeRcEXJhJxxzwicb4tuxMsHL/
         HgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=5eM7qYdApuLm/+wUzQpo3CLrYzNrLfiwI8BKjfzJo6U=;
        b=iUxzUzUStuY3DjEeZiNv9Tj4xz+oIxOiixtSelQBx6154Nx447QvV8q8UQEgL+wx3D
         UEcGruKgoFPlXWHchsnLZSapihZSvl+V/6SAMDQcisw1gMFTpiXr16hsF3sz73I3lazN
         Q41d4XeGdnS9fwS/Vl+WO50f1SSDBnkdwnmD+qsBMFczjMh28VJJ119DYX8lk8X7yxsG
         A972esHOb8e0H35p8otwOuArF2+hxUS4NhNCXSgd31/yHZCXRwcHdYugnUEpAjmTQAjV
         HPI4fKFyaXyiCVGtLGxW2rjpKqOBEqhQzSwRTRDtsItjy70dBD2RQJuglKFactiDBmU2
         gV9w==
X-Gm-Message-State: AOAM533KE0W5bg0VKzZItEwamhIpxCPqdaUAYBzvddP1qgiMaijcUHyI
        Z5bZL79qB/2wQrWHtTDzl8gKNumPpmBfJ4TGphb/B2J5E5U=
X-Google-Smtp-Source: ABdhPJyjpukZhEoEryaXUniKwnoq+16YwkekoR5BJ6nFYthwyXHHQdjMWbHNbhXweHhdm8QjrDSSyEoJYS0DZIQBva4=
X-Received: by 2002:a05:6902:1242:b0:64f:9d9c:eaab with SMTP id
 t2-20020a056902124200b0064f9d9ceaabmr38707917ybu.346.1653845264931; Sun, 29
 May 2022 10:27:44 -0700 (PDT)
MIME-Version: 1.0
Sender: rcdailey@gmail.com
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Sun, 29 May 2022 12:27:33 -0500
X-Google-Sender-Auth: _tKRD1uQXXV3GSZJOQ8miU8kUTk
Message-ID: <CAHd499D81VN=aGsM6kaNLF2ZMg-Zg10U=qU-j7gQ7uXnqqfdqg@mail.gmail.com>
Subject: Excluding paths with wildcard not working with add -p
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I run the command:

    git add -p -- ':^*.cs'

I get an error:

fatal: empty string is not a valid pathspec. please use . instead if
you meant to match all paths
Cannot close git diff-index --cached --numstat --summary HEAD --
:(exclude,prefix:0)*.cs  () at C:/Program
Files/Git/mingw64/libexec/git-core\git-add--interactive line 242.

However, it works if I remove `-p`. Also observed this works too:

    git add -p -- ':*.cs'

So it looks like we have a corner case where I can't do a patch add
while excluding files. Is this intentional?
