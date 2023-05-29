Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B3DC77B7A
	for <git@archiver.kernel.org>; Mon, 29 May 2023 14:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjE2OCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE2OCf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 10:02:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FB91BE
        for <git@vger.kernel.org>; Mon, 29 May 2023 07:02:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-256797b5664so719926a91.2
        for <git@vger.kernel.org>; Mon, 29 May 2023 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google; t=1685368922; x=1687960922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lkms7/KLeRKWAHFJtRrxscQD38mEH1TmGgQA6tVJjbM=;
        b=RgLLHZriBs/VvM6en/oekeHFxa+ThCzetxzb5wLPYJ+lRue4QoJVGIhe6aZ2oDCk+F
         MkaIMsTJmwGuCOsZ3lroQjCbR1POUIPHkKt6R6I3BDTZZRNK2gdZkpa8xyIH+laLjIvD
         HDa9pX5sk7oLSY2PDN9So1q4Mg1A4gDpJPGDQSXPwtfLG5k0W3rPeSmsvHvZZlAGwMCX
         HJpZBxM98HT5rluAkD8IYv2ue7OcaNdRTYhYQpwOFKEKkSElC3oUgK9UQyUQZ1CNEYJc
         aEC5XcDcaaB4QX7brR6uMz6iNK9pWtfIM1jWA3D92VcA991WT2ZM8qOXkq+Y+anIiZs/
         VgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368922; x=1687960922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkms7/KLeRKWAHFJtRrxscQD38mEH1TmGgQA6tVJjbM=;
        b=MupOBm/a7UQ0nRhucenlvmkQ+5vMQpmvqdY1FXmXTVtX6QzYrXA2j+wH+bl1ZHxCb0
         Rrg5ptp6YGOjK7mqD8Pe672HbehQCr7fIWlM1CHj8RZ9R5AatGgP2cFS/6F26n9Ywrq8
         i8jfajaQHjhFk1644r0Dyz6bjwoIiYBHaouJylEVVq1osKtFklDFTdbJpukp/Cg+6IR3
         ++oxxScLgFLrkdsfLrYd8bRIcQaADej/OhMA4AA6MQDYvlhsRqeur3RglcU8QLMFfI1w
         H24ZG5/Vwc85fLlvY7ZVoys9SoR0N5BGyKh6cw1yZKmelBwFZ1sMs3m9hNKZA8u3Vx9P
         Vl+A==
X-Gm-Message-State: AC+VfDx2ch4qRihk+dfIXLECopCrba2t0x3Fas6XZeqpYg3Rw50/2nZG
        OQMWRPw4cz69tXFFK7BHhGDtWAC/sJGmpNMQEeYVSRqZeFiOumtkiOQ=
X-Google-Smtp-Source: ACHHUZ7CahpgJfweEtzY48WnrxbFdtHrAP9D4FlvkO1Gbz9Ug0mCP+BKYg3wM6V997SluXA/AaDM/cgx/RxdSwk9oqQ=
X-Received: by 2002:a17:903:41c5:b0:1ad:edbd:8547 with SMTP id
 u5-20020a17090341c500b001adedbd8547mr12598106ple.15.1685368921997; Mon, 29
 May 2023 07:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
 <002901d99233$3d0c8b80$b725a280$@nexbridge.com>
In-Reply-To: <002901d99233$3d0c8b80$b725a280$@nexbridge.com>
From:   Paul Jolly <paul@myitcv.io>
Date:   Mon, 29 May 2023 15:01:50 +0100
Message-ID: <CACoUkn6wzoHph+BU3eYWqmf4ZWGji08Qhhjn+z4zrWJp1csPbQ@mail.gmail.com>
Subject: Re: Automatically re-running commands during an interactive rebase or
 post commit
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >Please can someone help nudge me in the right direction?
>
> I wonder whether setting up a clean/smudge filter might help. You might want to look into a clean filter that runs your code generator.

Thanks. I'm not clear that this will help, because the main problem is
that the rebase stops when trying to apply a later commit. In this
case, the previous commit will be "clean", but the commit the rebase
is trying to apply will conflict and the rebase process will stop

Reading elsewhere, I'm now looking into whether wrapping the default
mergetool will help provide the "hooks" I need.
