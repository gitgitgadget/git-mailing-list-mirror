Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB25C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 17:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBERbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 12:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBERbm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 12:31:42 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08031CF40
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 09:31:41 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 5so2815869pgd.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 09:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrG21/bPfs6ffdbFSwOy4luxkUE4oJWFoY46VamfKsY=;
        b=pdKEMvtRhEI9W9Ithv2hhWyMikymjqr+ooKwawF5ltJeQbPNQRW6x5VSLXbYs3uAqo
         UIsNE1rTuhta2sdM7zqK205D3RrmT26Ft0d1MslgaDmyTp890YYkjWs1S82yijmM62KG
         lkPpzyW6MjHa1TsrX0ATTaR8UStaj+kR+X0BAMHPFMvanrWKr7F7gxS9k3pz4TVyA/Ml
         O06XD/Cu7Wh5z1RC8jCLR+KQNHi+ZEylwuYPp4yb1PyCmdcGyH9ldMBhKnBqeiyxzym7
         5Rr2ri8lpI/TQmILmp4G9CLHEzBMQiRL3kXJtdEwTkn2CzvJfOhz8G7Q7JI1UEx5SxWQ
         zvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrG21/bPfs6ffdbFSwOy4luxkUE4oJWFoY46VamfKsY=;
        b=vn8lqmCW+dSqD/TBcIBa3ca9wbqye6etcxbE4ztd0rw0p+JVPSTae5y/01xwi0tay9
         5RKDaZOtpqGs7NX7ZrD6kCcH2kbXZ2kQB/wVSs4NuXzIts+nBgbQ2gW1v4ks6d9HYyXT
         DZNn+DErs7VgZcbdvb0TJeOK9+X78u9XU/5q1Nfkg0xdXZhm2qOG1QBv6IYwR4IqQGrS
         qrw5n7vnfBYkk1r6wisIbd8SowMmp0Szi/JFjXzTwLQNXvCI7oETnInAdKrQDyVKovGy
         vxilXaa/SQiXDX/CvTl34rG3yswfoBtJCA3mbhtzknv7k+qRL7pQ+atGOmoV9S9b2vDQ
         zi2g==
X-Gm-Message-State: AO0yUKWzy6SqLxPUQ7Ksq1UIyJ6D0WubiPyBSTbq7ncER0LG9OYOTHki
        nqs+0aPAdQa8w86AUhPTpdDbSu/hifCwSg==
X-Google-Smtp-Source: AK7set/GB8cku70PlurqS4/Hrp8kzY0fk5JC5kX3gXpvx+GX0vXwv/sKZKkYsytooN1ExWzq9I9vog==
X-Received: by 2002:aa7:96ac:0:b0:58d:9ad4:adaa with SMTP id g12-20020aa796ac000000b0058d9ad4adaamr16161250pfk.17.1675618301242;
        Sun, 05 Feb 2023 09:31:41 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.146.128])
        by smtp.gmail.com with ESMTPSA id c10-20020a624e0a000000b0058e12372079sm5357500pfb.29.2023.02.05.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 09:31:40 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
Cc:     five231003@gmail.com, git@vger.kernel.org
Subject: Re: [GSoC][PATCH] merge: use reverse_commit_list() for list reversal
Date:   Sun,  5 Feb 2023 23:01:34 +0530
Message-Id: <20230205173134.159285-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABPp-BHnXy+Hpv4y83znMxDGOTCZQfYhnDon=ehBDGOxAnW1vQ@mail.gmail.com--to=newren@gmail.com>
References: <CABPp-BHnXy+Hpv4y83znMxDGOTCZQfYhnDon=ehBDGOxAnW1vQ@mail.gmail.com--to=newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 3 Feb 2023 at 23:32, Elijah Newren <newren@gmail.com> wrote:

> Anyway, the point of the GSoC microprojects are to make sure you are
> familiar with how to format and submit patches to the mailing list and
> respond; having the code you contribute in a microproject be accepted
> is not required, just a bonus.  And you clearly managed to send the
> patch to the list, had a correctly formatted commit message (short
> summary with area and correct lack of capitalization, good
> descriptions, signed-off-by), got the additional notes for reviewers
> (very helpful!) in the correct spot, etc., so I still see this as a
> successful microproject for you.

I still need to get used to the codebase a bit, but the process
itself is fun. I also realized how helpful these notes and discussions
are. Thanks.
